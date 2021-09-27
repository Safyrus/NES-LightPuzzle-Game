update_cursor_sprite:
    PHA

    LDA cursX
    STA sprCursUL_x
    STA sprCursDL_x
    CLC
    ADC #$08
    STA sprCursUR_x
    STA sprCursDR_x

    LDA cursY
    STA sprCursUL_y
    STA sprCursUR_y
    CLC
    ADC #$08
    STA sprCursDL_y
    STA sprCursDR_y

    LDA #%00000000
    STA sprCursUL_atr
    LDA #%01000000
    STA sprCursUR_atr
    LDA #%10000000
    STA sprCursDL_atr
    LDA #%11000000
    STA sprCursDR_atr

    LDA cursAnimTimer
    CLC
    ADC #$01
    STA cursAnimTimer
    AND #%00010000
    BEQ @curs2
    @curs1:
        LDA #SPR::CURS1
        JMP @next
    @curs2:
        LDA #SPR::CURS2
    @next:
    STA sprCursUL
    STA sprCursUR
    STA sprCursDL
    STA sprCursDR

    PLA
    RTS