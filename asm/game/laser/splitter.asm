; X = laser index
; Y = laser position
laser_action_splitter_h:
    PHA

    ; check if laser is going verticaly
    LDA laser_array_state, X
    AND #%00000010
    BNE @end

    ; add 2 laser going left and right
    JSR add_laser_left
    JSR add_laser_right
    ; set splitter to ON
    LDA #MTILE::SPLITTER_H_ON
    STA level, Y

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_splitter_v:
    PHA

    ; check if laser is going horizontaly
    LDA laser_array_state, X
    AND #%00000010
    BEQ @end

    ; add 2 laser going up and down
    JSR add_laser_up
    JSR add_laser_down
    ; set splitter to ON
    LDA #MTILE::SPLITTER_V_ON
    STA level, Y

    @end:
    JSR laser_action_stop
    PLA
    RTS
