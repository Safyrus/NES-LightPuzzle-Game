; X = laser index
; Y = laser position
laser_action_door_h:
    PHA
    TYA
    PHA

    ; check if laser is going verticaly
    LDA laser_array_state, X
    AND #%00000010
    BNE @stop

    JSR laser_action_move

    ; set door to ON
    LDA #MTILE::DOOR_H_ON
    STA level, Y

    ; restart lasers at the door
    JSR move_laser_restart

    LDA counter
    BEQ @draw_close
    @draw_open:
    ; draw the open door
    TXA
    TAY
    JSR laser_draw_door_h_on
    JSR laser_draw_activate
    JMP @end
    @draw_close:
    ; draw the close but active door
    TXA
    TAY
    JSR laser_draw_activate
    JMP @end

    @stop:
    JSR laser_action_move
    JSR laser_action_stop_restart
    @end:
    JSR laser_action_stop
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_door_v:
    PHA
    TYA
    PHA

    ; check if laser is going horizontaly
    LDA laser_array_state, X
    AND #%00000010
    BEQ @stop

    JSR laser_action_move

    ; set door to ON
    LDA #MTILE::DOOR_V_ON
    STA level, Y

    ; restart lasers at the door
    JSR move_laser_restart

    LDA counter
    BEQ @draw_close
    @draw_open:
    ; draw the open door
    TXA
    TAY
    JSR laser_draw_door_h_on
    JSR laser_draw_activate
    JMP @end
    @draw_close:
    ; draw the close but active door
    TXA
    TAY
    JSR laser_draw_activate
    JMP @end

    @stop:
    JSR laser_action_move
    JSR laser_action_stop_restart
    @end:
    JSR laser_action_stop
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_door_h_on:
    PHA
    TYA
    PHA

    ; check if laser is going horizontaly
    LDA laser_array_state, X
    AND #%00000010
    BEQ @stop

    JSR laser_action_move

    ; draw the open door
    TXA
    TAY
    JSR laser_draw_door_h_on
    JMP @end

    @stop:
    JSR laser_action_stop
    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_door_v_on:
    PHA
    TYA
    PHA

    ; check if laser is going verticaly
    LDA laser_array_state, X
    AND #%00000010
    BNE @stop

    JSR laser_action_move

    ; draw the open door
    TXA
    TAY
    JSR laser_draw_door_v_on
    JMP @end

    @stop:
    JSR laser_action_stop
    @end:
    PLA
    TAY
    PLA
    RTS
