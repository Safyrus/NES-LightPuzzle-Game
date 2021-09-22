; Y = laser index
laserDraw_ground:
    pushreg

    LDA laserArray_pos, Y   ; get the laser position in nametable
    TAX
    JSR getMTileNametableAdr

    LDA dataAdr_h           ; set the laser position to vramAdr
    STA vramAdr_h
    LDA dataAdr_l
    STA vramAdr_l

    LDA laserArray_state, Y  ; check if the laser is vertical or horizontal
    AND #%00000010          ; and set the correct Mtile index
    BEQ @hor
    LDX #MTILE::LASER_VER
    JMP @draw
    @hor:
    LDX #MTILE::LASER_HOR
    
    @draw:                  ; draw the laser
    JSR updateBgMTile
    LDA laserArray_pos, Y
    TAY
    TXA
    STA level, Y

    pullreg
    RTS


; Y = laser index
laserDraw_crosshor:
    pushreg

    LDA laserArray_pos, Y   ; get the laser position in nametable
    TAX
    JSR getMTileNametableAdr

    LDA dataAdr_h           ; set the laser position to vramAdr
    STA vramAdr_h
    LDA dataAdr_l
    STA vramAdr_l

    LDA laserArray_state, Y  ; check if the laser is horizontal
    AND #%00000010          ; and draw the CROSS mtile if needed
    BEQ @end

    LDX #MTILE::LASER_CROSS
    JSR updateBgMTile
    LDA laserArray_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS


; Y = laser index
laserDraw_crossver:
    pushreg

    LDA laserArray_pos, Y   ; get the laser position in nametable
    TAX
    JSR getMTileNametableAdr

    LDA dataAdr_h           ; set the laser position to vramAdr
    STA vramAdr_h
    LDA dataAdr_l
    STA vramAdr_l

    LDA laserArray_state, Y  ; check if the laser is vertical
    AND #%00000010          ; and draw the CROSS mtile if needed
    BNE @end

    LDX #MTILE::LASER_CROSS
    JSR updateBgMTile
    LDA laserArray_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS


; Y = laser index
laserDraw_mirror2:
    pushreg

    LDA laserArray_pos, Y   ; get laser position in nametable
    TAX
    JSR getMTileNametableAdr

    LDA dataAdr_h           ; set the laser position to vramAdr
    STA vramAdr_h
    LDA dataAdr_l
    STA vramAdr_l

    LDA laserArray_state, Y
    AND #%00000001
    STA tmp
    LDA laserArray_state, Y
    AND #%00000010
    LSR A

    EOR tmp
    BEQ @mirror_UR
    LDX #MTILE::MIRROR_DL
    JMP @draw
    @mirror_UR:
    LDX #MTILE::MIRROR_UR

    @draw:
    JSR updateBgMTile
    LDA laserArray_pos, Y
    TAY
    TXA
    STA level, Y

    pullreg
    RTS


; Y = laser index
laserDraw_mirror1:
    pushreg

    LDA laserArray_pos, Y   ; get laser position in nametable
    TAX
    JSR getMTileNametableAdr

    LDA dataAdr_h           ; set the laser position to vramAdr
    STA vramAdr_h
    LDA dataAdr_l
    STA vramAdr_l

    LDA laserArray_state, Y  ; check the laser direction
    AND #%00000001          ; and if it is going up or left
    BEQ @mirror_ul          ; then select the MIRROR_UL mtile
    LDX #MTILE::MIRROR_DR   ; else take the MIRROR_DR mtile
    JMP @draw
    @mirror_ul:
    LDX #MTILE::MIRROR_UL

    @draw:
    JSR updateBgMTile
    LDA laserArray_pos, Y
    TAY
    TXA
    STA level, Y

    pullreg
    RTS


; Y = laser index
laserDraw_mirror_ul:
    pushreg

    LDA laserArray_pos, Y   ; get laser position in nametable
    TAX
    JSR getMTileNametableAdr

    LDA dataAdr_h           ; set the laser position to vramAdr
    STA vramAdr_h
    LDA dataAdr_l
    STA vramAdr_l

    LDA laserArray_state, Y  ; check the laser direction
    AND #%00000001          ; and if it is going down or right
    BEQ @end                ; then draw the MIRROR_CROSS2 mtile
    LDX #MTILE::MIRROR_CROSS2
    JSR updateBgMTile
    LDA laserArray_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS


; Y = laser index
laserDraw_mirror_ur:
    pushreg

    LDA laserArray_pos, Y   ; get laser position in nametable
    TAX
    JSR getMTileNametableAdr

    LDA dataAdr_h           ; set the laser position to vramAdr
    STA vramAdr_h
    LDA dataAdr_l
    STA vramAdr_l

    LDA laserArray_state, Y
    AND #%00000001
    STA tmp
    LDA laserArray_state, Y
    AND #%00000010
    LSR A

    EOR tmp
    BEQ @end
    LDX #MTILE::MIRROR_CROSS1
    JSR updateBgMTile
    LDA laserArray_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS


; Y = laser index
laserDraw_mirror_dl:
    pushreg

    LDA laserArray_pos, Y   ; get laser position in nametable
    TAX
    JSR getMTileNametableAdr

    LDA dataAdr_h           ; set the laser position to vramAdr
    STA vramAdr_h
    LDA dataAdr_l
    STA vramAdr_l

    LDA laserArray_state, Y
    AND #%00000001
    STA tmp
    LDA laserArray_state, Y
    AND #%00000010
    LSR A

    EOR tmp
    BNE @end
    LDX #MTILE::MIRROR_CROSS1
    JSR updateBgMTile
    LDA laserArray_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS


; Y = laser index
laserDraw_mirror_dr:
    pushreg

    LDA laserArray_pos, Y   ; get laser position in nametable
    TAX
    JSR getMTileNametableAdr

    LDA dataAdr_h           ; set the laser position to vramAdr
    STA vramAdr_h
    LDA dataAdr_l
    STA vramAdr_l

    LDA laserArray_state, Y  ; check the laser direction
    AND #%00000001          ; and if it is going up or left
    BNE @end                ; then draw the MIRROR_CROSS1 mtile
    LDX #MTILE::MIRROR_CROSS2
    JSR updateBgMTile
    LDA laserArray_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS
