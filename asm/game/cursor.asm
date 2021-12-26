move_cursor:
    PHA
    
    LDA buttons_1_timer   ;check if buttons are unlock
    BNE @end

    LDA buttons_1    ; check what direction was pressed
    LSR
    BCS @right
    LSR
    BCS @left
    LSR
    BCS @down
    LSR
    BCS @up
    JMP @end

    @right:
        LDA curs_x
        AND #%11110000
        CMP #$F0
        BEQ @end
        CLC
        ADC #$10
        STA curs_x
        JMP @end

    @left:
        LDA curs_x
        AND #%11110000
        BEQ @end
        SEC
        SBC #$10
        STA curs_x
        JMP @end

    @down:
        LDA curs_y
        AND #%11110000
        CMP #$E0
        BEQ @end
        CLC
        ADC #$10
        STA curs_y
        JMP @end

    @up:
        LDA curs_y
        AND #%11110000
        BEQ @end
        SEC
        SBC #$10
        STA curs_y
        JMP @end

    @end:
    PLA
    RTS

; 
place_at_cursor:
    pushreg

    LDA buttons_1_timer   ; check if buttons are unlock
    BNE @end

    LDA buttons_1    ; check if A was pressed
    AND #%10000000
    BEQ @end

    LDA curs_x       ; compute the cursor pos in the level
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC curs_y
    TAX

    LDA level, X        ; check if the tile we want to place on
    CMP #MTILE::GROUND  ; is of type GROUND
    BNE @end

    LDA level_edit, X   ; and check if we have not already
    CMP #MTILE::VOID    ; place something here
    BNE @end

    LDY selected                            ; and check if we have enough
    LDA level_selectable_object_count, Y    ; of this object
    BEQ @end

    ; decrement the number of this object
    LDA level_selectable_object_count, Y
    SEC
    SBC #$01
    STA level_selectable_object_count, Y

    JSR update_ui_count

    ; place the mtile
    LDA level_selectable_object_type, Y
    TAY
    STA level_edit, X

    ; draw the new mtile
    JSR get_metatile_nametable_adr
    LDA data_adr_l
    STA vram_adr_l
    LDA data_adr_h
    STA vram_adr_h
    TYA
    TAX
    JSR update_bg_metatile
    
    @end:
    pullreg
    RTS


; 
remove_at_cursor:
    pushreg

    LDA buttons_1_timer   ; check if buttons are unlock
    BNE @end

    LDA buttons_1        ; check if B was pressed
    AND #%01000000
    BEQ @end

    LDA curs_x   ; compute the cursor pos in the level
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC curs_y
    TAX

    LDA level_edit, X   ; check if a mtile was place here
    BEQ @end

    ; find the index of the object
    LDY #$00
    @loop:
        CMP level_selectable_object_type, Y
        BEQ @remove

        INY
        CPY #$10
        BNE @loop
    JMP @end

    @remove:
    ; increment the number of this object
    LDA level_selectable_object_count, Y
    CLC
    ADC #$01
    STA level_selectable_object_count, Y

    JSR update_ui_count

    LDA #$00            ; update level edit
    STA level_edit, X

    ; draw the default mtile of the level
    TXA
    TAY
    JSR get_metatile_nametable_adr
    LDA data_adr_l
    STA vram_adr_l
    LDA data_adr_h
    STA vram_adr_h
    TYA
    TAX
    LDA level, X
    TAX
    JSR update_bg_metatile

    @end:
    pullreg
    RTS


change_at_cursor:
    pushreg

    LDA buttons_1_timer   ; check if buttons are unlock
    BEQ @check_button
    JMP @end

    @check_button:
    LDA buttons_1    ; check if A was pressed
    AND #%10000000
    BNE @get_curs_pos
    JMP @end

    @get_curs_pos:
    LDA curs_x       ; compute the cursor pos in the level
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC curs_y
    TAX

    ; push X
    PHA

    LDA level_edit, X
    LDX #$00
    @newtile_loop:
        CMP @tile_table, X
        BEQ @newtile_loop_end
        ; loop
        INX
        CPX #$0C
        BNE @newtile_loop
    ; pull X
    PLA
    JMP @end

    @newtile_loop_end:    
    LDY @newtile_table, X
    ; pull X
    PLA
    TAX
    TYA
    STA level_edit, X

    ; draw the new mtile
    JSR get_metatile_nametable_adr
    LDA data_adr_l
    STA vram_adr_l
    LDA data_adr_h
    STA vram_adr_h
    TYA
    TAX
    JSR update_bg_metatile
    JMP @end

    @tile_table:
        .byte MTILE::MIRROR_1
        .byte MTILE::MIRROR_2
        .byte MTILE::MIRRORC_UL
        .byte MTILE::MIRRORC_UR
        .byte MTILE::MIRRORC_DL
        .byte MTILE::MIRRORC_DR
        .byte MTILE::SPLITTER_H
        .byte MTILE::SPLITTER_V
        .byte MTILE::MERGER_H
        .byte MTILE::MERGER_V
        .byte MTILE::DOOR_H
        .byte MTILE::DOOR_V
    @newtile_table:
        .byte MTILE::MIRROR_2
        .byte MTILE::MIRROR_1
        .byte MTILE::MIRRORC_UR
        .byte MTILE::MIRRORC_DR
        .byte MTILE::MIRRORC_UL
        .byte MTILE::MIRRORC_DL
        .byte MTILE::SPLITTER_V
        .byte MTILE::SPLITTER_H
        .byte MTILE::MERGER_V
        .byte MTILE::MERGER_H
        .byte MTILE::DOOR_V
        .byte MTILE::DOOR_H

    @end:
    pullreg
    RTS
