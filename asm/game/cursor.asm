move_cursor:
    PHA
    
    LDA buttons1Timer   ;check if buttons are unlock
    BNE @end

    LDA buttons1    ; check what direction was pressed
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
        LDA cursX
        AND #%11110000
        CMP #$F0
        BEQ @end
        CLC
        ADC #$10
        STA cursX
        JMP @end

    @left:
        LDA cursX
        AND #%11110000
        BEQ @end
        SEC
        SBC #$10
        STA cursX
        JMP @end

    @down:
        LDA cursY
        AND #%11110000
        CMP #$E0
        BEQ @end
        CLC
        ADC #$10
        STA cursY
        JMP @end

    @up:
        LDA cursY
        AND #%11110000
        BEQ @end
        SEC
        SBC #$10
        STA cursY
        JMP @end

    @end:
    PLA
    RTS

; 
place_at_cursor:
    pushreg

    LDA buttons1Timer   ; check if buttons are unlock
    BNE @end

    LDA buttons1    ; check if A was pressed
    AND #%10000000
    BEQ @end

    LDA cursX       ; compute the cursor pos in the level
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC cursY
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
    JSR get_metaTile_nametable_adr
    LDA dataAdr_l
    STA vramAdr_l
    LDA dataAdr_h
    STA vramAdr_h
    TYA
    TAX
    JSR update_bg_metaTile
    
    @end:
    pullreg
    RTS


; 
remove_at_cursor:
    pushreg

    LDA buttons1Timer   ; check if buttons are unlock
    BNE @end

    LDA buttons1        ; check if B was pressed
    AND #%01000000
    BEQ @end

    LDA cursX   ; compute the cursor pos in the level
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC cursY
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
    JSR get_metaTile_nametable_adr
    LDA dataAdr_l
    STA vramAdr_l
    LDA dataAdr_h
    STA vramAdr_h
    TYA
    TAX
    LDA level, X
    TAX
    JSR update_bg_metaTile

    @end:
    pullreg
    RTS


change_at_cursor:
    pushreg

    LDA buttons1Timer   ; check if buttons are unlock
    BEQ @check_button
    JMP @end

    @check_button:
    LDA buttons1    ; check if A was pressed
    AND #%10000000
    BNE @get_curs_pos
    JMP @end

    @get_curs_pos:
    LDA cursX       ; compute the cursor pos in the level
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC cursY
    TAX

    LDA level_edit, X
    CMP #MTILE::MIRROR_1
    BEQ @do_mirror_1
    CMP #MTILE::MIRROR_2
    BEQ @do_mirror_2
    CMP #MTILE::MIRRORC_UL
    BEQ @do_mirrorc_ul
    CMP #MTILE::MIRRORC_UR
    BEQ @do_mirrorc_ur
    CMP #MTILE::MIRRORC_DL
    BEQ @do_mirrorc_dl
    CMP #MTILE::MIRRORC_DR
    BEQ @do_mirrorc_dr
    CMP #MTILE::SPLITTER_H
    BEQ @do_splitter_h
    CMP #MTILE::SPLITTER_V
    BEQ @do_splitter_v
    CMP #MTILE::MERGER_H
    BEQ @do_merger_h
    CMP #MTILE::MERGER_V
    BEQ @do_merger_v
    JMP @end

    @do_mirror_1:
        LDA #MTILE::MIRROR_2
        STA level_edit, X
        TAY
        JMP @draw
    @do_mirror_2:
        LDA #MTILE::MIRROR_1
        STA level_edit, X
        TAY
        JMP @draw
    @do_mirrorc_ul:
        LDA #MTILE::MIRRORC_UR
        STA level_edit, X
        TAY
        JMP @draw
    @do_mirrorc_ur:
        LDA #MTILE::MIRRORC_DR
        STA level_edit, X
        TAY
        JMP @draw
    @do_mirrorc_dl:
        LDA #MTILE::MIRRORC_UL
        STA level_edit, X
        TAY
        JMP @draw
    @do_mirrorc_dr:
        LDA #MTILE::MIRRORC_DL
        STA level_edit, X
        TAY
        JMP @draw
    @do_splitter_h:
        LDA #MTILE::SPLITTER_V
        STA level_edit, X
        TAY
        JMP @draw
    @do_splitter_v:
        LDA #MTILE::SPLITTER_H
        STA level_edit, X
        TAY
        JMP @draw
    @do_merger_h:
        LDA #MTILE::MERGER_V
        STA level_edit, X
        TAY
        JMP @draw
    @do_merger_v:
        LDA #MTILE::MERGER_H
        STA level_edit, X
        TAY
        JMP @draw

    @draw:
        ; draw the new mtile
        JSR get_metaTile_nametable_adr
        LDA dataAdr_l
        STA vramAdr_l
        LDA dataAdr_h
        STA vramAdr_h
        TYA
        TAX
        JSR update_bg_metaTile

    @end:
    pullreg
    RTS
