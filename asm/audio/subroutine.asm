; X = note index
play_note:
    LDA #%10011111
    STA APU_PULSE1_CTRL

    LDA period_table_lo, X
    STA APU_PULSE1_TIME_LOW
    LDA period_table_hi, X
    CLC
    ADC #%11111000
    STA APU_PULSE1_TIME_HIGH

    RTS