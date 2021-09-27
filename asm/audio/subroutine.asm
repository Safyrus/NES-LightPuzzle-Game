; X = note index
play_note:
    LDA #%10011111
    STA APU_PULSE1_CTRL

    LDA periodTableLo, X
    STA APU_PULSE1_TIME_LOW
    LDA periodTableHi, X
    CLC
    ADC #%11111000
    STA APU_PULSE1_TIME_HIGH

    RTS