dnl Device attributes
define({AVR}, 1)
define({SELFPRGEN}, 0)
define({SIGNATURE_0},           0x1e)
define({SIGNATURE_1},           0x95)
define({SIGNATURE_2},           0x0f)
define({RAMSTART},              0x100)
define({RAMEND},                0x8ff)
define({FLASHEND},              0x7fff)
define({SPM_PAGESIZE},          0x80)
define({E2END},                 0x3ff)
define({E2PAGESIZE},            4)
define({XRAMSIZE},              0)
define({FUSE_MEMORY_SIZE},      3)
define({EFUSE_DEFAULT},         0xff)
define({LOCKBITS_DEFAULT},      0xff)

dnl IRQ vectors
define({RESET_vect_num},        0)
define({INT0_vect_num},         1)
define({INT1_vect_num},         2)
define({PCINT0_vect_num},       3)
define({PCINT1_vect_num},       4)
define({PCINT2_vect_num},       5)
define({WDT_vect_num},          6)
define({TIMER2_COMPA_vect_num}, 7)
define({TIMER2_COMPB_vect_num}, 8)
define({TIMER2_OVF_vect_num},   9)
define({TIMER1_CAPT_vect_num},  10)
define({TIMER1_COMPA_vect_num}, 11)
define({TIMER1_COMPB_vect_num}, 12)
define({TIMER1_OVF_vect_num},   13)
define({TIMER0_COMPA_vect_num}, 14)
define({TIMER0_COMPB_vect_num}, 15)
define({TIMER0_OVF_vect_num},   16)
define({SPI_STC_vect_num},      17)
define({USART_RX_vect_num},     18)
define({USART_UDRE_vect_num},   19)
define({USART_TX_vect_num},     20)
define({ADC_vect_num},          21)
define({EE_READY_vect_num},     22)
define({ANALOG_COMP_vect_num},  23)
define({TWI_vect_num},          24)
define({SPM_READY_vect_num},    25)

dnl I/O registers, as memory offset
define({PINB},                  0x23)
define({DDRB},                  0x24)
define({PORTB},                 0x25)
define({PINC},                  0x26)
define({DDRC},                  0x27)
define({PORTC},                 0x28)
define({PIND},                  0x29)
define({DDRD},                  0x2a)
define({PORTD},                 0x2b)
dnl 0x2c..0x34 reserved
define({TIFR0},                 0x35)
define({TIFR1},                 0x36)
define({TIFR2},                 0x37)
dnl 0x38..0x3a reserved
define({PCIFR},                 0x3b)
define({EIFR},                  0x3c)
define({EIMSK},                 0x3d)
define({GPIOR0},                0x3e)
define({EECR},                  0x3f)
define({EEDR},                  0x40)
define({EEAR},                  0x41)
define({EEARL},                 0x41)
define({EEARH},                 0x42)
define({GTCCR},                 0x43)
define({TCCR0A},                0x44)
define({TCCR0B},                0x45)
define({TCNT0},                 0x46)
define({OCR0A},                 0x47)
define({OCR0B},                 0x48)
dnl 0x49 reserved
define({GPIOR1},                0x4a)
define({GPIOR2},                0x4b)
define({SPCR0},                 0x4c)
define({SPSR0},                 0x4d)
define({SPDR0},                 0x4e)
dnl 0x4f reserved
define({ACSR},                  0x50)
define({DWDR},                  0x51)
dnl 0x52 reserved
define({SMCR},                  0x53)
define({MCUSR},                 0x54)
define({MCUCR},                 0x55)
dnl 0x56 reserved
define({SPMCSR},                0x57)
dnl 0x58..0x5c reserved
define({SP},                    0x5d)
define({SPL},                   0x5d)
define({SPH},                   0x5e)
define({SREG},                  0x5f)
define({WDTCSR},                0x60)
define({CLKPR},                 0x61)
dnl 0x62..0x63 reserved
define({PRR},                   0x64)
dnl 0x65 reserved
define({OSCCAL},                0x66)
dnl 0x67 reserved
define({PCICR},                 0x68)
define({EICRA},                 0x69)
dnl 0x6a reserved
define({PCMSK0},                0x6b)
define({PCMSK1},                0x6c)
define({PCMSK2},                0x6d)
define({TIMSK0},                0x6e)
define({TIMSK1},                0x6f)
define({TIMSK2},                0x70)
dnl 0x71..0x77 reserved
define({ADC},                   0x78)
define({ADCL},                  0x78)
define({ADCH},                  0x79)
define({ADCSRA},                0x7a)
define({ADCSRB},                0x7b)
define({ADMUX},                 0x7c)
dnl 0x7d reserved
define({DIDR0},                 0x7e)
define({DIDR1},                 0x7f)
define({TCCR1A},                0x80)
define({TCCR1B},                0x81)
define({TCCR1C},                0x82)
dnl 0x83 reserved
define({TCNT1},                 0x84)
define({TCNT1L},                0x84)
define({TCNT1H},                0x85)
define({ICR1},                  0x86)
define({ICR1L},                 0x86)
define({ICR1H},                 0x87)
define({OCR1A},                 0x88)
define({OCR1AL},                0x88)
define({OCR1AH},                0x89)
define({OCR1B},                 0x8a)
define({OCR1BL},                0x8a)
define({OCR1BH},                0x8b)
dnl 0x8c..0xaf reserved
define({TCCR2A},                0xb0)
define({TCCR2B},                0xb1)
define({TCNT2},                 0xb2)
define({OCR2A},                 0xb3)
define({OCR2B},                 0xb4)
dnl 0xb5 reserved
define({ASSR},                  0xb6)
dnl 0xb7 reserved
define({TWBR},                  0xb8)
define({TWSR},                  0xb9)
define({TWAR},                  0xba)
define({TWDR},                  0xbb)
define({TWCR},                  0xbc)
define({TWAMR},                 0xbd)
dnl 0xbe..0xbf reserved
define({UCSR0A},                0xc0)
define({UCSR0B},                0xc1)
define({UCSR0C},                0xc2)
dnl 0xc3 reserved
define({UBRR0},                 0xc4)
define({UBRR0L},                0xc4)
define({UBRR0H},                0xc5)
define({UDR0},                  0xc6)

dnl TIFRn
define({ICF},       5)
define({OCFB},      2)
define({OCFA},      1)
define({TOV},       0)

dnl EECR
define({EEPM1},     5)
define({EEPM0},     4)
define({EERIE},     3)
define({EEMPE},     2)
define({EEPE},      1)
define({EERE},      0)

dnl GTCCR
define({TSM},       7)
define({PSRASY},    1)
define({PSRSYNC},   0)

dnl TCCRnA
define({WGM0},      0)
define({WGM1},      1)
define({COMA0},     6)
define({COMA1},     7)
define({COMB0},     4)
define({COMB1},     5)

dnl TCCRnB/C
define({ICNC},      7)
define({ICES},      6)
define({FOCA},      7)
define({FOCB},      6)
define({WGM3},      4)
define({WGM2},      3)

dnl SPCRn
define({SPIE},      7)
define({SPE},       6)
define({DORD},      5)
define({MSTR},      4)
define({CPOL},      3)
define({CPHA},      2)

dnl SPSRn
define({SPIF},      7)
define({WCOL},      6)
define({SPI2X},     0)

dnl ACSR
define({ACD},       7)
define({ACBG},      6)
define({ACO},       5)
define({ACI},       4)
define({ACIE},      3)
define({ACIC},      2)

dnl SMCR
define({SE},        0)

dnl MCUSR
define({WDRF},      3)
define({BORF},      2)
define({EXTRF},     1)
define({PORF},      0)

dnl MCUCR
define({BODS},      6)
define({BODSE},     5)
define({PUD},       4)
define({IVSEL},     1)
define({IVCE},      0)

dnl SPMCSR
define({SPMIE},     7)
define({RWWSB},     6)
define({SIGRD},     5)
define({RWWSRE},    4)
define({BLBSET},    3)
define({PGWRT},     2)
define({PGERS},     1)
define({SPMEN},     0)

dnl SREG
define({SREG_I},    7)
define({SREG_T},    6)
define({SREG_H},    5)
define({SREG_S},    4)
define({SREG_V},    3)
define({SREG_N},    2)
define({SREG_Z},    1)
define({SREG_C},    0)

dnl WDTCSR
define({WDIF},      7)
define({WDIE},      6)
define({WDCE},      4)
define({WDE},       3)

dnl CLKPR
define({CLKPCE},    7)

dnl PRR
define({PRTWI0},    7)
define({PRTIM2},    6)
define({PRTIM0},    5)
define({PRTIM1},    3)
define({PRSPI0},    2)
define({PRUSART0},  1)
define({PRADC},     0)

dnl TIMSKn
define({ICIE},      5)
define({OCIEB},     2)
define({OCIEA},     1)
define({TOIE},      0)

dnl ADCSRA
define({ADEN},      7)
define({ADSC},      6)
define({ADATE},     5)
define({ADIF},      4)
define({ADIE},      3)

dnl ADCSRB
define({ACME},      6)

dnl ADMUX
define({ADLAR},     5)

dnl ASSR
define({EXCLK},     6)
define({AS2},       5)
define({TCN2UB},    4)
define({OCR2AUB},   3)
define({OCR2BUB},   2)
define({TCR2AUB},   1)
define({TCR2BUB},   0)

dnl TWAR
define({TWGCE},     0)

dnl TWCR
define({TWINT},     7)
define({TWEA},      6)
define({TWSTA},     5)
define({TWSTO},     4)
define({TWWC},      3)
define({TWEN},      2)
define({TWIE},      0)

dnl UCSRnA
define({RXC},       7)
define({TXC},       6)
define({UDRE},      5)
define({FE},        4)
define({DOR},       3)
define({UPE},       2)
define({U2X},       1)
define({MPCM},      0)

dnl UCSRnB
define({RXCIE},     7)
define({TXCIE},     6)
define({UDRIE},     5)
define({RXEN},      4)
define({TXEN},      3)
define({UCSZ2},     2)
define({RXB8},      1)
define({TXB8},      0)

dnl UCSRnC
define({UMSEL1},    7)
define({UMSEL0},    6)
define({UPM1},      5)
define({UPM0},      4)
define({USBS},      3)
define({UCSZ1},     2)
define({UCSZ0},     1)
define({UDORD},     2)
define({UCPHA},     1)
define({UCPOL},     0)

dnl vim: set sw=4 ts=4 ft=asm et:
