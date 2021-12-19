init_apu:
    ; Init $4000-4013
    LDY #$13
@loop:
    LDA @regs,y
    STA APU,y
    DEY
    BPL @loop

    ; We have to skip over $4014 (OAMDMA)
    LDA #$0F
    STA APU_CTRL
    LDA #$40
    STA APU_FRAME

    RTS
@regs:
    .byte $30,$08,$00,$00
    .byte $30,$08,$00,$00
    .byte $80,$00,$00,$00
    .byte $30,$00,$00,$00
    .byte $00,$00,$00,$00