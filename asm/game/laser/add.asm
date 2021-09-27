; Y = pos
add_laser_up:
    pushreg

    LDX level_LaserCount    ; put a laser
    TYA                     ; at Y
    STA laserArray_pos, X   ;
    LDA #$00                ; and going up
    STA laserArray_state, X ;
    INX                     ;
    STX level_LaserCount    ;

    pullreg
    RTS


; Y = pos
add_laser_down:
    pushreg

    LDX level_LaserCount    ; put a laser
    TYA                     ; at Y
    STA laserArray_pos, X   ;
    LDA #$01                ; and going down
    STA laserArray_state, X ;
    INX                     ;
    STX level_LaserCount    ;

    pullreg
    RTS


; Y = pos
add_laser_left:
    pushreg

    LDX level_LaserCount    ; put a laser
    TYA                     ; at Y
    STA laserArray_pos, X   ;
    LDA #$02                ; and going left
    STA laserArray_state, X ;
    INX                     ;
    STX level_LaserCount    ;

    pullreg
    RTS


; Y = pos
add_laser_right:
    pushreg

    LDX level_LaserCount    ; put a laser
    TYA                     ; at Y
    STA laserArray_pos, X   ;
    LDA #$03                ; and going right
    STA laserArray_state, X ;
    INX                     ;
    STX level_LaserCount    ;

    pullreg
    RTS
