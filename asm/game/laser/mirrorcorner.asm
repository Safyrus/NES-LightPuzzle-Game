; X = laser index
; Y = laser position
laser_action_mirror_corner_ul:
    PHA
    TYA
    PHA

    LDA laser_array_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$01    ; is it going down ?
    BEQ @yes
    CMP #$03    ; is it going right ?
    BEQ @yes

    @nop:
    LDA laser_array_state, X ; stop the laser
    ORA #%00000100
    STA laser_array_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_ur:
    PHA
    TYA
    PHA

    LDA laser_array_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$01    ; is it going down ?
    BEQ @yes
    CMP #$02    ; is it going left ?
    BEQ @yes

    @nop:
    LDA laser_array_state, X ; stop the laser
    ORA #%00000100
    STA laser_array_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_dl:
    PHA
    TYA
    PHA

    LDA laser_array_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$00    ; is it going up ?
    BEQ @yes
    CMP #$03    ; is it going right ?
    BEQ @yes

    @nop:
    LDA laser_array_state, X ; stop the laser
    ORA #%00000100
    STA laser_array_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_dr:
    PHA
    TYA
    PHA

    LDA laser_array_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$00    ; is it going up ?
    BEQ @yes
    CMP #$02    ; is it going left ?
    BEQ @yes

    @nop:
    LDA laser_array_state, X ; stop the laser
    ORA #%00000100
    STA laser_array_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    PLA
    TAY
    PLA
    RTS
