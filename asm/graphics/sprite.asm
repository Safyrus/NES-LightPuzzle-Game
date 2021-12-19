update_cursor_sprite:
    PHA

    LDA curs_x
    STA spr_curs_ul_x
    STA spr_curs_dl_x
    CLC
    ADC #$08
    STA spr_curs_ur_x
    STA spr_curs_dr_x

    LDA curs_y
    STA spr_curs_ul_y
    STA spr_curs_ur_y
    CLC
    ADC #$08
    STA spr_curs_dl_y
    STA spr_curs_dr_y

    LDA #%00000000
    STA spr_curs_ul_atr
    LDA #%01000000
    STA spr_curs_ur_atr
    LDA #%10000000
    STA spr_curs_dl_atr
    LDA #%11000000
    STA spr_curs_dr_atr

    LDA curs_anim_timer
    CLC
    ADC #$01
    STA curs_anim_timer
    AND #%00010000
    BEQ @curs2
    @curs1:
        LDA #SPR::CURS1
        JMP @next
    @curs2:
        LDA #SPR::CURS2
    @next:
    STA spr_curs_ul
    STA spr_curs_ur
    STA spr_curs_dl
    STA spr_curs_dr

    PLA
    RTS