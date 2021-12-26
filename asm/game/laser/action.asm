; X = laser index
; Y = laser position
laser_action_move:
    PHA

    TYA
    STA laser_array_pos, X   ; set new laser position

    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_ground:
    PHA
    TYA
    PHA

    TYA
    STA laser_array_pos, X   ; set new laser position

    TXA
    TAY
    JSR laser_draw_ground

    PLA
    TAY
    PLA
    RTS


; X = laser index
laser_action_stop:
    PHA

    LDA laser_array_state, X
    ORA #%00000100
    STA laser_array_state, X

    PLA
    RTS

; X = laser index
laser_action_stop_restart:
    PHA

    LDA laser_array_state, X
    ORA #%00001100
    STA laser_array_state, X

    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_laserhor:
    PHA
    TYA
    PHA

    TYA
    STA laser_array_pos, X   ; set new laser position
    TXA
    TAY
    JSR laser_draw_lasercross_hor

    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_laserver:
    PHA
    TYA
    PHA

    TYA
    STA laser_array_pos, X   ; set new laser position
    TXA
    TAY
    JSR laser_draw_lasercross_ver

    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_glass:
    PHA
    TYA
    PHA

    JSR laser_action_move
    TXA
    TAY
    JSR laser_draw_activate

    PLA
    TAY
    PLA
    RTS
