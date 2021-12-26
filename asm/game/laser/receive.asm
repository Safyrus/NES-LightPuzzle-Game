; X = laser index
; Y = laser position
laser_action_receive_up:
    PHA
    TYA
    PHA

    TYA
    STA laser_array_pos, X   ; set new laser position

    LDA laser_array_state, X ; stop the laser
    ORA #%00000100
    STA laser_array_state, X

    LDA laser_array_state, X ; check if the laser is going down
    AND #%00000011
    CMP #$01
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_up

    @end:
    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_receive_down:
    PHA
    TYA
    PHA

    TYA
    STA laser_array_pos, X   ; set new laser position

    LDA laser_array_state, X ; stop the laser
    ORA #%00000100
    STA laser_array_state, X

    LDA laser_array_state, X ; check if the laser is going up
    AND #%00000011
    CMP #$00
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_down

    @end:
    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_receive_left:
    PHA
    TYA
    PHA

    TYA
    STA laser_array_pos, X   ; set new laser position

    LDA laser_array_state, X ; stop the laser
    ORA #%00000100
    STA laser_array_state, X

    LDA laser_array_state, X ; check if the laser is going right
    AND #%00000011
    CMP #$03
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_left

    @end:
    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_receive_right:
    PHA
    TYA
    PHA

    TYA
    STA laser_array_pos, X   ; set new laser position

    LDA laser_array_state, X ; stop the laser
    ORA #%00000100
    STA laser_array_state, X

    LDA laser_array_state, X ; check if the laser is going left
    AND #%00000011
    CMP #$02
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_right

    @end:
    PLA
    TAY
    PLA
    RTS
