; X = laser index
getNextLaserPos:
    LDA laserArray_meta, X  ; get direction of the laser
    AND #%00000011

    CMP #$00    ; is it going up ?
    BEQ @up
    CMP #$01    ; is it going down ?
    BEQ @down
    CMP #$02    ; is it going left ?
    BEQ @left
    JMP @right  ; then it is going right

    @up:
        LDA laserArray_pos, X
        CMP #$10
        BCC @pos_error
        SBC #$10
        JMP @end

    @down:
        LDA laserArray_pos, X
        CMP #$E0
        BCS @pos_error
        ADC #$10
        JMP @end

    @left:
        LDA laserArray_pos, X
        AND #%00001111
        CMP #$00
        BEQ @pos_error
        LDA laserArray_pos, X
        SEC
        SBC #$01
        JMP @end

    @right:
        LDA laserArray_pos, X
        AND #%00001111
        CMP #$0F
        BEQ @pos_error
        LDA laserArray_pos, X
        CLC
        ADC #$01
        JMP @end

    @pos_error:
        LDA POS_OUTOFMAP

    @end:
    RTS


; X = laser index
; Y = laser position
laserAction_move:
    PHA
    TXA
    PHA
    TYA
    PHA

    TYA
    STA laserArray_pos, X   ; set new laser position

    TXA
    TAY

    LDA laserArray_pos, X   ; get laser position in nametable
    TAX
    JSR getMTileNametableAdr

    LDA dataAdr_h   ; set the laser position to vramAdr
    STA vramAdr_h
    LDA dataAdr_l
    STA vramAdr_l

    LDA laserArray_meta, Y  ; check if laser is vertical or horizontal
    AND #%00000010          ; and set the correct Mtile index
    CMP #$00
    BEQ @hor
    LDX #MTILE::LASER_VER
    JMP @draw
    @hor:
    LDX #MTILE::LASER_HOR

    @draw:              ; draw the laser
    JSR updateBgMTile

    PLA
    TAY
    PLA
    TAX
    PLA
    RTS


; X = laser index
; Y = laser position
laserAction_stop:
    PHA

    LDA laserArray_meta, X
    ORA #%00000100
    STA laserArray_meta, X

    PLA
    RTS
