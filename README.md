# Stepper motor controller - with 'threads'

Threads on a microcontroller?! Yes, or more precisely, sort of :) ...


## The principle

Threading actually just means storing and restoring execution contexts (current IP, flags, preserved registers) to/from **a** stack, and **switching stacks** on some events.

Really, that's all!

When a timer interrupt hits, further interrupts are disabled, then the current IP is pushed to the stack, and the execution continues at the handler routine (`TIMER1_COMPA_vect`).

This routine usually *does something* and finally executes a `reti`, which re-enables the interrupts and pops the return address from the stack.

Now, what will happen if the body of the interrupt handler (that *does something* above) sets the stack pointer to another location? The final `reti` will pop the return address from that second stack (be that whatever value), and jumps there.

And if that address points to some other piece of code, that does something else, and then pushes its current IP to this second stack, and then sets the stack pointer back to where the interrupt handler found it, and finally does a `reti`, then ... it'll return to the original 'main' program that was interrupted by the timer.

Sure, there are problems when this 'other piece of code' changes the registers, so they must be saved on the stack and later restored from there as well.

This is what the `tim1_yield` function does.


### The interrupt handler

1. (default thread return address is implicitely pushed)
2. Push the registers and flags to the stack of the default ('idle') thread stack
3. Store the stack pointer to `sp[hl]_idle`
4. Restore the stack pointer from `sp[hl]_tim1`
5. Pop the flags and the registers from the stack of the 'tim1' thread
6. Jump (`ret`) to where that thread left off


### The thread routine

Does what it wants, and when it wants to wait for something, calls to `tim1_yield`


### `tim1_yield`

The counterpart of the interrupt handler:

1. ('tim1' thread return address is implicitely pushed)
2. Push the registers and flags to the stack of the 'tim1' thread stack
3. Store the stack pointer to `sp[hl]_tim1`
4. Restore the stack pointer from `sp[hl]_idle`
5. Pop the flags and the registers from the stack of the (default) 'idle' thread
6. Jump (`reti`) to where that thread left off


## What is it good for?

If you have some process that involves waiting for some conditions, normally you write a simple straightforward code:

* Do this
* Wait that
* Do that
* Loop to previous until something
* Etc.

Nice, readable, effective ... as long as this is all you want to do.

If there are **two** such processes, there comes trouble, because you can't just *wait* for something that one process needs, because you'd just freeze the other one meanwhile.


### The common solution

One solution is to implement *state machines*, that is, you have two variables that mark where, at what steps those processes are at the moment, and then you'll have an *event loop* like:

* Check at what step the 1st process is, what is it waiting for
* Did it occur? If so, then proceed to the *next* step of that process
* Check at what step the 2nd process is, what is it waiting for
* Did it occur? If so, then proceed to the *next* step of that process
* Repeat this forever

Nice, *not* readable, effective.

For being able to 'proceed to the *next* step', you must organise your processes as series of labeled steps, each one doing one thing that doesn't require waiting, and each finally setting the state variable to the next step and jumping back to the loop.

The loop must either check each step one by one, like a 'switch-case' structure, or you must have an array of labels and then do indirect jumps by the state variable as an index to it.

If you have loops in your processes... then the loop registers must be stored/restored to variables.

If your processes contain repeatable parts (a.k.a. 'functions'...) that need to wait for something, then you can't just use functions, because they can't set the *respective* next step, as they don't know from what step they are called.

Multi-level function calls? Shall we go into that? (Not recursion, just one-function-calls-another.)

The problem is that upon each **waiting** you must explicitely and manually save the current *context* (registers, loop counters, state) to variables, and then in the dispatcher loop you must manually restore that *context*, depending on the actual state.

If the case is trivial (eg. no registers to preserve, one-level state machine, no function calls in the process), it's no problem.

Otherwise this just blasts the code to fragments and if you miss syncing the save/restore code pairs, you'll have hard-to-find bugs.

Don't get me wrong, the code can/will be fast and small and effective, it's just hard to maintain and it's increasingly error-prone.


### The threading approach

Essentially, a thread switching does the same: it saves the state of the flow (that is, the current IP) and the registers to a designated area (a dedicated stack), and when the event happens, restores them.

One difference is that this saving and restoring is the same for all state transitions: `rcall(tim1_yield)`

The other difference is that this contains all the saving, switching, processing the other thread, switching back, restoring, so
we can just put it within a loop or a (nested) function, even in a recursive one.

We don't need to slice up a nice straightforward code into fragments, don't need to count/maintain the possible states, don't need to maintain the state saving/restoring, only insert these 'yield points' where appropriate.


### The cost of threading

"There ain't no thing as a free lunch."

This way we save/restore all the variables at all switching, even when we *know* that we don't change but one or two of them.

We need to dedicate a given amount of the RAM as a stack for the second 'thread', and we definitely won't use all of it.

Because if we actually need it, then probably we'll overflow it, and then we crash in the worst way. Sadly, there is no memory protection here.

So all that simplicity (or rather the encapsulation of the complexity) comes for quite a price.

Whether it's worth it or not, it depends on the situation: If the task of the 'thread' is too complex for a primitive state-machine, but
it's simple enough so we can safely predict its stack usage and we can afford the time overhead of the switching, then it's a good choice.


## The actual task: stepper motor controlling

First of all, *read [this](http://users.ece.utexas.edu/~valvano/Datasheets/Stepper_ST.pdf)*. It's by far the best description of stepper motors I've ever seen.

(If the link goes defunct, it's an Application Note from SGS Thomson (now STMicro): AN235/0788, the author is H.Sax, the year is 1995...)

We have a bipolar stepper motor and an L298 H-Bridge controller chip, so we can set the windings to high-Z state as well, so we have 2 x 3 wires: A, #A, EnableA, B, #B and EnableB, which maps nicely to the 6 bits of PC0..5.

All we have to do is to write the appropriate number sequence with the appropriate timing :D.

At `control_states:` you can find the sequences for the control schemes of simple rotating wave-drive, for full-step always-on, for half-step always-on and for half-step with high-Z at zero crossing.


### The control functions

There is a dedicated (at least in that thread) register `rPHASE`: the low 7 bits show the current index in the sequence, bit7 indicates the stepping direction.

The function `do_step` maintains this: performs one step in the sequence, and adjusts `rPHASE` accordingly.


The function `motor_thread` is where you'll see the strength of the threading approach:

* It takes 200 (motor-)steps up
* Then 200 steps down
* Then releases the coils for 200 step time
* Then again from the beginning

If you like challenges, sketch up a full-blown state machine for that. Then add a 50-step down + 100 step up in the middle. Then make the up-down sequence configurable from an array... 


## Conclusion

This is by far not robust enough to call it even stable, not even thinking on industrial reliability.

It's a PoC for two things: the stepper motor control methods and the threading approach on a microcontroller.


### TODO

Generic threading, as now it supports only one thread. Although, considering the overhead, it'll hardly be worth it, but as a PoC it'll be fun :).

Coil current feedback and thus automatic phase timing.

And yes, I know about [LB11870](https://www.onsemi.com/pub/Collateral/EN7256-D.PDF), but it's fun to try all the principles for myself and actually see them working :D.





