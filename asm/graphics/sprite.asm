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

update_sprite_item_selected:
    pushreg

    ; find the item index in the placable items array
    LDX selected
    JSR find_item_index

    ; calculate sprite y position
    CPX #$06
    BCC @find_y_1row
    CPX #$0C
    BCC @find_y_2row
    @find_y_3row:
    LDA #$0F
    JMP @update_y
    @find_y_2row:
    LDA #$17
    JMP @update_y
    @find_y_1row:
    LDA #$1F

    ; update y position
    @update_y:
    STA spr_selected_left_y
    STA spr_selected_middle_y
    STA spr_selected_right_y

    ; calculate sprite x position
    TXA
    @find_x_loop:
        CMP #$06
        BCC @find_x_loop_end
        SEC
        SBC #$06
        JMP @find_x_loop
    @find_x_loop_end:
    ASL
    ASL
    ASL
    ASL
    ASL
    CLC
    ADC #$09

    ; update x position
    STA spr_selected_left_x
    CLC
    ADC #$08
    STA spr_selected_middle_x
    CLC
    ADC #$08
    STA spr_selected_right_x

    ; update sprite and attributes
    LDA #SPR::SELECTED
    STA spr_selected_left
    STA spr_selected_middle
    STA spr_selected_right
    LDA #%00100000
    STA spr_selected_left_atr
    STA spr_selected_middle_atr
    STA spr_selected_right_atr

    pullreg
    RTS