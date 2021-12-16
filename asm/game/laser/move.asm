move_laser_mirror1:
    PHA

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
    PLA
    RTS


move_laser_mirror2:
    PHA

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
    PLA
    RTS


; Y = position where to reactivate lasers
move_laser_restart:
    PHA
    TXA
    PHA

    LDX #$00
    STX counter ; reset return value
    @loop:
        LDA laserArray_pos, X
        STA tmp
        CPY tmp
        BNE @loop_cmp

        LDA laserArray_state, X
        AND #%0001000
        BEQ @loop_cmp

        LDA laserArray_state, X
        AND #%11110011 ; desactivate restart + stop flags
        STA laserArray_state, X

        TXA
        PHA
        LDX counter
        INX
        STX counter
        PLA
        TAX

        @loop_cmp:
        INX
        CPX #LASER_MAX
        BNE @loop

    @end:
    PLA
    TAX
    PLA
    RTS
