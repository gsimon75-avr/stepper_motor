changequote({, })
dnl include(foreach.m4)
dnl foreach(x, (item_1, item_2, ..., item_n), stmt)
dnl   parenthesized list, simple version
divert({-1})
define({foreach}, {pushdef({$1})_foreach($@)popdef({$1})})
define({_arg1}, {$1})
define({_foreach}, {ifelse({$2}, {()}, {},
  {define({$1}, _arg1$2)$3{}$0({$1}, (shift$2), {$3})})})
divert{}dnl


dnl include(quote.m4)
dnl quote(args) - convert args to single-quoted string
define({quote}, {ifelse({$#}, {0}, {}, {{$*}})})


dnl define functions around normal instructions
foreach({op}, (
{adc}, {add}, {adiw}, {and}, {andi}, {asr}, {bclr}, {bld}, {brbc}, {brbs}, {brcc}, {brcs}, {break}, {breq}, {brge}, {brhc},
{brhs}, {brid}, {brie}, {brlo}, {brlt}, {brmi}, {brne}, {brpl}, {brsh}, {brtc}, {brts}, {brvc}, {brvs}, {bset}, {bst}, {call},
{cbr}, {clc}, {clh}, {cli}, {cln}, {clr}, {cls}, {clt}, {clv}, {clz}, {com}, {cp}, {cpc}, {cpi}, {cpse}, {dec}, {des},
{eicall}, {eijmp}, {elpm}, {eor}, {fmul}, {fmuls}, {fmulsu}, {icall}, {ijmp}, {inc}, {jmp}, {lac}, {las}, {lat}, {ld},
{ldd}, {ldi}, {lds}, {lpm}, {lsl}, {lsr}, {mov}, {movw}, {mul}, {muls}, {mulsu}, {neg}, {nop}, {or}, {ori}, {pop},
{push}, {rcall}, {ret}, {reti}, {rjmp}, {rol}, {ror}, {sbc}, {sbci},{sbiw}, {sbr}, {sbrc}, {sbrs},
{sec}, {seh}, {sei}, {sen}, {ser}, {ses}, {set}, {sev}, {sez}, {sleep}, {spm}, {st}, {std}, {sts}, {sub}, {subi}, {swap},
{tst}, {wdr}, {xch}), {define(op, {{$0} $@})})

dnl When addressing an I/O register with 'IO' instructions, subtract 0x20 from the address
define({sbi}, {{sbi}} {($1) - 0x20, $2})
define({cbi}, {{cbi}} {($1) - 0x20, $2})
define({sbic}, {{sbic}} {($1) - 0x20, $2})
define({sbis}, {{sbis}} {($1) - 0x20, $2})
define({in}, {{in}} {$1, ($2) - 0x20})
define({out}, {{out}} {($1) - 0x20, $2})

dnl custom pseudo-instructions
dnl NOTE: CF is set in reverse!!!
define({addi}, {subi $1, -($2)})
define({addiw}, {subi $1, low(-($3)) 
	sbci $2, high(-($3))})
define({ldiw}, {ldi $2, high($3)
	ldi($1, low($3)})

dnl 2-clks nop
define({nop2}, rjmp PC+1)

define({pusha},{push(r31)
    push(r30)
    push(r29)
    push(r28)
    push(r27)
    push(r26)
    push(r25)
    push(r24)
    push(r23)
    push(r22)
    push(r21)
    push(r20)
    push(r19)
    push(r18)
    push(r17)
    push(r16)
    push(r15)
    push(r14)
    push(r13)
    push(r12)
    push(r11)
    push(r10)
    push(r9)
    push(r8)
    push(r7)
    push(r6)
    push(r5)
    push(r4)
    push(r3)
    push(r2)
    push(r1)})

define({popa}, {pop(r1)
    pop(r2)
    pop(r3)
    pop(r4)
    pop(r5)
    pop(r6)
    pop(r7)
    pop(r8)
    pop(r9)
    pop(r10)
    pop(r11)
    pop(r12)
    pop(r13)
    pop(r14)
    pop(r15)
    pop(r16)
    pop(r17)
    pop(r18)
    pop(r19)
    pop(r20)
    pop(r21)
    pop(r22)
    pop(r23)
    pop(r24)
    pop(r25)
    pop(r26)
    pop(r27)
    pop(r28)
    pop(r29)
    pop(r30)
    pop(r31)})

dnl named registers
define({XL}, r26)
define({XH}, r27)
define({YL}, r28)
define({YH}, r29)
define({ZL}, r30)
define({ZH}, r31)


dnl data directives
dnl define sized object
dnl   DSIZE(.byte, alpha)
dnl   DSIZE(.byte, beta, 0x11, 0x22, 0x33)
define({EVALLIST}, {ifelse({$#}, {1}, {eval($1)}, {eval($1), $0(shift($@))})})

dnl repetition for data defs
dnl  DUP(3)
dnl  DUP(5, 0x20)
dnl  DUP(3, 0x11, 0x22)
dnl  DUP(2, DUP(5, 0x11), DUP(3, 0xff))
dnl define({DUP}, {ifelse({$#}, {1}, {$0($1,0)}, {ifelse($1, {1}, {$2}, {$2{, }$0(decr($1), {$2})})})})
define({DUP}, {ifelse({$#}, {1}, {$0($1,0)}, {ifelse($1, {1}, {shift($@)}, {shift($@){, }$0(decr($1), shift($@))})})})

dnl local identifiers
define({LOC}, {ifdef({_FUNCTION_}, {{L_}}{_FUNCTION_}{{_}})$1})

dnl function definition (with nesting and local identifiers!)
define({FUNCTION}, {pushdef({_FUNCTION_}, ifdef({_FUNCTION_}, _FUNCTION_{_})$1)_FUNCTION_:})
define({ENDFUNC}, {popdef({_FUNCTION_})})

dnl TEST

dnl DB(LOC(alma), DUP(2, 0x03, DUP(3, "qwer")))
dnl LOC(global_scope):
dnl FUNCTION(level_one)
dnl   DB(LOC(within_l1_top), 0x11)
dnl   FUNCTION(level_two)
dnl     LOC(within_l2):
dnl   ENDFUNC
dnl   LOC(within_l1_bottom):
dnl ENDFUNC

define({MAX}, {pushdef({_minmaxarg},ifelse($#,1,$1,{$0(shift($@))}))ifelse(eval(_minmaxarg<$1),0,_minmaxarg,$1)popdef({_minmaxarg})})
define({MIN}, {pushdef({_minmaxarg},ifelse($#,1,$1,{$0(shift($@))}))ifelse(eval(_minmaxarg>$1),0,_minmaxarg,$1)popdef({_minmaxarg})})
define({MSB8},{ifelse(eval($1 >= 128),1,7,eval($1 >= 64),1,6,eval($1 >= 32),1,5,eval($1 >= 16),1,4,eval($1 >= 8),1,3,eval($1 >= 4),1,2,eval($1 >= 2),1,1,eval($1 >= 1),1,0,-1)})
define({LO8}, {(($1) & 0xff)})
define({HI8}, {((($1) >> 8) & 0xff)})

define({_BV}, {ifelse({$#}, 1, eval(1 << ($1)), {eval((1 << ($1)) + $0(shift($@)))})})

.DEVICE MCU

changecom({;})

dnl vim: set sw=4 ts=4 ft=asm noet:
