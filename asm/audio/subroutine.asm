; X = note index
play_note:
    LDA #%10011111
    STA APU_SQ1_VOL

    LDA period_table_lo, X
    STA APU_SQ1_LO
    LDA period_table_hi, X
    CLC
    ADC #%11111000
    STA APU_SQ1_HI

    RTS