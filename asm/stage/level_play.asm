stage_level_play:
    LDA buttons_1
    AND #%00100000
    BEQ @start
        LDA buttons_1_timer   ;check if buttons are unlock
        BNE @start
        
        JSR change_to_level_load

    @start:
    LDX level_frame_counter      ; Check if frame_counter is zero
    CPX #$00                    ; if it is, then do a step
    BEQ @step

    DEX                         ; Decrease frame_counter
    STX level_frame_counter      ; and wait for another frame
    JMP @end

    ; do a step
    @step:
        ; update all lasers
        LDX level_laser_done_counter  ; laser index
        @laser_loop:
            LDA laser_array_state, X ; check if the laser has stop
            AND #%00000100
            BNE @laser_loop_inc

            @laser_find_action:
            ; /!\ TODO: Check for out of map position and if it is then state = PLAY_ERROR and error = LASER_OUTOFMAP

            JSR get_next_laser_pos ; get the next position of the laser into A
            TAY             ; and transfere it to Y
            LDA level, Y    ; get tile type at the next laser position
            AND #%11000000  ; check if it is out of range of the switch table
            BEQ @laser_find_action_switch
            JMP laser_action_stop
            @laser_find_action_switch:
            ; push X
            TXA
            PHA
            ; get tile type at the next laser position
            LDA level, Y
            AND #%00111111  ; modulo 64
            TAX             ; into X
            ; get the address of the laser action function from the switch table
            LDA @switch_table_l, X
            STA data_adr_l
            LDA @switch_table_h, X
            STA data_adr_h
            ; pull X
            PLA
            TAX
            ; call the laser action function
            JSR @switch_call

            ; increase the laser index and loop
            @laser_loop_inc:
            ; increase laser done counter
            LDY level_laser_done_counter
            INY
            STY level_laser_done_counter

            ; check if all laser had been updated
            CPY level_laser_count
            BEQ @laser_loop_end

            ; else check if we don't exeed the max laser per frame
            INX
            TXA
            AND #MAXLASERPERFRAME
            BEQ @laser_loop_end_maxframe
            JMP @laser_loop

        @laser_loop_end:
        LDA #$00                    ; reset laser done counter
        STA level_laser_done_counter
        LDA level_max_frame          ; reset level_max_frame
        STA level_frame_counter
        JMP @step_done
        @laser_loop_end_maxframe:
        JMP @end

    @step_done:

    ;
    LDY #$00
    @check_victory_loop:
        LDA level, Y
        CMP #MTILE::RECEIVE_UP
        BEQ @check_laser_stop
        CMP #MTILE::RECEIVE_DOWN
        BEQ @check_laser_stop
        CMP #MTILE::RECEIVE_LEFT
        BEQ @check_laser_stop
        CMP #MTILE::RECEIVE_RIGHT
        BEQ @check_laser_stop

        INY
        CPY #$F0
        BNE @check_victory_loop
    @check_victory_end:

    ; 
    LDY #$00
    @check_loose_loop:
        LDA level, Y
        CMP #MTILE::CROSS_H
        BEQ @stage_loose
        CMP #MTILE::CROSS_V
        BEQ @stage_loose
        CMP #MTILE::CROSS_ON
        BEQ @stage_loose

        INY
        CPY #$F0
        BNE @check_loose_loop
    @check_loose_end:
    JMP @stage_win


    ; check if all lasers has stop
    @check_laser_stop:
    LDX #$00
    @check_laser_stop_loop:
        LDA laser_array_state, X
        AND #%00000100
        BNE @check_laser_stop_loop_inc
        JMP @end

        @check_laser_stop_loop_inc:
        INX
        CPX level_laser_count
        BNE @check_laser_stop_loop
    @check_laser_stop_end:
    JMP @stage_loose

    @stage_loose:
        LDA #$21
        STA vram_adr_h
        LDA #$68
        STA vram_adr_l

        LDA #>txt_loose
        STA data_adr_h
        LDA #<txt_loose
        STA data_adr_l

        LDX #$05
        JSR update_bg_data

        LDA #STG::LEVEL_LOOSE  ; go to the loose stage
        STA game_stage

        JMP @end
    
    @stage_win:
        LDA #$21
        STA vram_adr_h
        LDA #$68
        STA vram_adr_l

        LDA #>txt_win
        STA data_adr_h
        LDA #<txt_win
        STA data_adr_l

        LDX #$03
        JSR update_bg_data

        LDA #STG::LEVEL_WIN  ; go to the win stage
        STA game_stage

        JMP @end
    
    @switch_call:
        JMP (data_adr)

    @switch_table_l:
        .byte <laser_action_move
        .byte <laser_action_stop
        .byte <laser_action_ground
        .byte <laser_action_stop
        .byte <laser_action_glass
        .byte <laser_action_laserhor
        .byte <laser_action_laserver
        .byte <laser_action_move
        .byte <laser_action_cross
        .byte <laser_action_cross_h
        .byte <laser_action_cross_v
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop

        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_receive_up
        .byte <laser_action_receive_down
        .byte <laser_action_receive_left
        .byte <laser_action_receive_right
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop

        .byte <laser_action_mirror_1
        .byte <laser_action_mirror_2
        .byte <laser_action_mirror_cross1
        .byte <laser_action_mirror_cross2
        .byte <laser_action_mirror_ul
        .byte <laser_action_mirror_ur
        .byte <laser_action_mirror_dl
        .byte <laser_action_mirror_dr
        .byte <laser_action_mirror_corner_ul
        .byte <laser_action_mirror_corner_ur
        .byte <laser_action_mirror_corner_dl
        .byte <laser_action_mirror_corner_dr
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_stop

        .byte <laser_action_door_h
        .byte <laser_action_door_v
        .byte <laser_action_door_h_on
        .byte <laser_action_door_v_on
        .byte <laser_action_splitter_h
        .byte <laser_action_splitter_v
        .byte <laser_action_stop
        .byte <laser_action_stop
        .byte <laser_action_merger_h
        .byte <laser_action_merger_v
        .byte <laser_action_merger_ht
        .byte <laser_action_merger_vl
        .byte <laser_action_merger_hb
        .byte <laser_action_merger_vr
        .byte <laser_action_stop
        .byte <laser_action_stop

    @switch_table_h:
        .byte >laser_action_move
        .byte >laser_action_stop
        .byte >laser_action_ground
        .byte >laser_action_stop
        .byte >laser_action_glass
        .byte >laser_action_laserhor
        .byte >laser_action_laserver
        .byte >laser_action_move
        .byte >laser_action_cross
        .byte >laser_action_cross_h
        .byte >laser_action_cross_v
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop

        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_receive_up
        .byte >laser_action_receive_down
        .byte >laser_action_receive_left
        .byte >laser_action_receive_right
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop

        .byte >laser_action_mirror_1
        .byte >laser_action_mirror_2
        .byte >laser_action_mirror_cross1
        .byte >laser_action_mirror_cross2
        .byte >laser_action_mirror_ul
        .byte >laser_action_mirror_ur
        .byte >laser_action_mirror_dl
        .byte >laser_action_mirror_dr
        .byte >laser_action_mirror_corner_ul
        .byte >laser_action_mirror_corner_ur
        .byte >laser_action_mirror_corner_dl
        .byte >laser_action_mirror_corner_dr
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_stop

        .byte >laser_action_door_h
        .byte >laser_action_door_v
        .byte >laser_action_door_h_on
        .byte >laser_action_door_v_on
        .byte >laser_action_splitter_h
        .byte >laser_action_splitter_v
        .byte >laser_action_stop
        .byte >laser_action_stop
        .byte >laser_action_merger_h
        .byte >laser_action_merger_v
        .byte >laser_action_merger_ht
        .byte >laser_action_merger_vl
        .byte >laser_action_merger_hb
        .byte >laser_action_merger_vr
        .byte >laser_action_stop
        .byte >laser_action_stop

    @end:
    RTS     ; Return
