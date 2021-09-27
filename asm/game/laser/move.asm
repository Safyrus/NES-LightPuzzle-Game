move_laser_mirror1:
    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$00    ; is it going up ?
    BEQ @up
    CMP #$01    ; is it going down ?
    BEQ @down
    CMP #$02    ; is it going left ?
    BEQ @left
    JMP @right  ; then it is going right

    @up:
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000011
        STA laserArray_state, X
        JMP @end
    @down:
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000010
        STA laserArray_state, X
        JMP @end
    @left:
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000001
        STA laserArray_state, X
        JMP @end
    @right:
        LDA laserArray_state, X
        AND #%11111100
        STA laserArray_state, X

    @end:
    RTS


move_laser_mirror2:
    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$00    ; is it going up ?
    BEQ @up
    CMP #$01    ; is it going down ?
    BEQ @down
    CMP #$02    ; is it going left ?
    BEQ @left
    JMP @right  ; then it is going right

    @up:
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000010
        STA laserArray_state, X
        JMP @end
    @down:
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000011
        STA laserArray_state, X
        JMP @end
    @left:
        LDA laserArray_state, X
        AND #%11111100
        STA laserArray_state, X
        JMP @end
    @right:
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000001
        STA laserArray_state, X

    @end:
    RTS
