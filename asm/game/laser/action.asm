; X = laser index
; Y = laser position
laser_action_move:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_ground:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    TXA
    TAY
    JSR laser_draw_ground

    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_stop:
    PHA

    LDA laserArray_state, X
    ORA #%00000100
    STA laserArray_state, X

    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_laserhor:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position
    TXA
    TAY
    JSR laser_draw_crosshor

    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_laserver:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position
    TXA
    TAY
    JSR laser_draw_crossver

    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_1:
    pushreg

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror1

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_2:
    pushreg

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror2

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_ul:
    pushreg

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror_ul

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_ur:
    pushreg

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror_ur

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_dl:
    pushreg

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror_dl

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_dr:
    pushreg

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror_dr

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_cross1:
    pushreg

    JSR move_laser_mirror1

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_cross2:
    pushreg

    JSR move_laser_mirror1

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_receive_up:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going down
    AND #%00000011
    CMP #$01
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_up

    @end:
    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_receive_down:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going up
    AND #%00000011
    CMP #$00
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_down

    @end:
    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_receive_left:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going right
    AND #%00000011
    CMP #$03
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_left

    @end:
    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_receive_right:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going left
    AND #%00000011
    CMP #$02
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_right

    @end:
    pullreg
    RTS
