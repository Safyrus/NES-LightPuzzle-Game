; X = level
load_level:
    pushreg

    ; get level address
    LDA level_array_hi, X
    STA data_adr_h
    LDA level_array_lo, X
    STA data_adr_l

    LDX #$00 ; tile_count
    @load_tiles:
        ; Check if Special Mtile
        LDY #$00
        LDA (data_adr), Y
        CMP #$FF
        BEQ @array

        @normal:
            STA level, X    ; store the tile into Level
            INX             ; Increase tile_count
            JSR inc_data_adr ; increase data_adr
            JMP @load_tiles_end

        @array:
            ; get length
            JSR inc_data_adr
            LDA (data_adr), Y
            STA counter ; counter for the loop
            ; increase data_adr to get the tile
            JSR inc_data_adr
            @array_loop:
                LDY #$00        ; get the tile
                LDA (data_adr), Y
                STA level, X    ; store the tile into Level

                INX             ; Increase tile_count
                LDY counter     ; decrease counter loop
                DEY
                STY counter
                CPY #$00
                BNE @array_loop

        @load_tiles_end:
        CPX #$F0
        BNE @load_tiles

    LDY #$00
    @load_data:
        LDA (data_adr), Y
        STA level, X
        INX

        INY
        CPY #$0A
        BNE @load_data

    JSR load_object
    JSR level_edit_load

    pullreg
    RTS


level_edit_load:
    PHA
    TXA
    PHA

    LDY #$00
    @loop:
        LDA level_edit, Y
        BEQ @loop_end ; no tile was place before

        LDX #$00
        @loop_tile_table:
            CMP tile_table, X
            BEQ @get_index

            INX
            CPX #TILE_TABLE_SIZE
            BNE @loop_tile_table

        @get_index:
        LDA select_tiles_index_table, X
        TAX
        LDA select_tiles, X
        TAX
        JSR find_item_selectable_index
        LDA level_selectable_object_count, X
        SEC
        SBC #$01
        STA level_selectable_object_count, X

        @loop_end:
        INY
        CPY #$F0
        BNE @loop

    @end:
    PLA
    TAX
    PLA
    RTS


level_place_lasers:
    pushreg

    LDA #$00
    STA level_laser_done_counter

    LDY #$00
    @loop:
        LDA level, Y
        CMP #MTILE::EMIT_UP_ON
        BEQ @up
        CMP #MTILE::EMIT_DOWN_ON
        BEQ @down
        CMP #MTILE::EMIT_LEFT_ON
        BEQ @left
        CMP #MTILE::EMIT_RIGHT_ON
        BEQ @right
        JMP @loop_end

        @up:
        JSR add_laser_up
        JMP @loop_end
        @down:
        JSR add_laser_down
        JMP @loop_end
        @left:
        JSR add_laser_left
        JMP @loop_end
        @right:
        JSR add_laser_right
        JMP @loop_end

        @loop_end:
        INY
        CPY #$F0
        BNE @loop

    pullreg
    RTS


level_place_edit:
    pushreg

    LDY #$00
    @loop:
        LDA level_edit, Y
        BEQ @loop_inc

        STA level, Y

        @loop_inc:
        INY
        CPY #$F0
        BNE @loop

    pullreg
    RTS


load_object:
    pushreg

    LDY #$00
    STY tmp
    @loop:
        @loop_1:
        LDA level_obj_cnt, Y
        AND #%11110000
        BEQ @loop_2
            LDA level_obj_cnt, Y
            LSR
            LSR
            LSR
            LSR
            LDX tmp
            STA level_selectable_object_count, X

            TYA
            ASL
            TAX

            LDA select_tiles, X
            LDX tmp
            STA level_selectable_object_type, X
            INX
            STX tmp

        @loop_2:
        LDA level_obj_cnt, Y
        AND #%00001111
        BEQ @loop_3
            LDA level_obj_cnt, Y
            AND #%00001111
            LDX tmp
            STA level_selectable_object_count, X

            TYA
            ASL
            TAX
            INX

            LDA select_tiles, X
            LDX tmp
            STA level_selectable_object_type, X
            INX
            STX tmp

        @loop_3:
        INY
        CPY #$08
        BNE @loop

    LDA tmp
    STA max_selected

    pullreg
    RTS


clear_level_edit:
    PHA
    TXA
    PHA

    LDX #$00
    LDA #$00
    @loop:
        STA level_edit, X
        INX
        CPX #$F0
        BNE @loop

    PLA
    TAX
    PLA
    RTS