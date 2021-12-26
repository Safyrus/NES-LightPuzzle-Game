; X = laser index
; Y = laser position
laser_action_mirror_1:
    PHA
    TYA
    PHA

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror1

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_2:
    PHA
    TYA
    PHA

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror2

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_ul:
    PHA
    TYA
    PHA

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror_ul

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_ur:
    PHA
    TYA
    PHA

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror_ur

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_dl:
    PHA
    TYA
    PHA

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror_dl

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_dr:
    PHA
    TYA
    PHA

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror_dr

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_cross1:
    JMP move_laser_mirror1

; X = laser index
; Y = laser position
laser_action_mirror_cross2:
    JMP move_laser_mirror2
