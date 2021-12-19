; Y = laser index
laser_draw_ground:
    pushreg

    LDA laser_array_pos, Y   ; get the laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDA laser_array_state, Y  ; check if the laser is vertical or horizontal
    AND #%00000010          ; and set the correct Mtile index
    BEQ @hor
    LDX #MTILE::LASER_VER
    JMP @draw
    @hor:
    LDX #MTILE::LASER_HOR
    
    @draw:                  ; draw the laser
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    pullreg
    RTS


; Y = laser index
laser_draw_crosshor:
    pushreg

    LDA laser_array_pos, Y   ; get the laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDA laser_array_state, Y  ; check if the laser is horizontal
    AND #%00000010          ; and draw the CROSS mtile if needed
    BEQ @end

    LDX #MTILE::LASER_CROSS
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_crossver:
    pushreg

    LDA laser_array_pos, Y   ; get the laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDA laser_array_state, Y  ; check if the laser is vertical
    AND #%00000010          ; and draw the CROSS mtile if needed
    BNE @end

    LDX #MTILE::LASER_CROSS
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_mirror2:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDA laser_array_state, Y
    AND #%00000001
    STA tmp
    LDA laser_array_state, Y
    AND #%00000010
    LSR A

    EOR tmp
    BEQ @mirror_UR
    LDX #MTILE::MIRROR_DL
    JMP @draw
    @mirror_UR:
    LDX #MTILE::MIRROR_UR

    @draw:
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    pullreg
    RTS


; Y = laser index
laser_draw_mirror1:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDA laser_array_state, Y  ; check the laser direction
    AND #%00000001          ; and if it is going up or left
    BEQ @mirror_ul          ; then select the MIRROR_UL mtile
    LDX #MTILE::MIRROR_DR   ; else take the MIRROR_DR mtile
    JMP @draw
    @mirror_ul:
    LDX #MTILE::MIRROR_UL

    @draw:
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    pullreg
    RTS


; Y = laser index
laser_draw_mirror_ul:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDA laser_array_state, Y  ; check the laser direction
    AND #%00000001          ; and if it is going down or right
    BEQ @end                ; then draw the MIRROR_CROSS2 mtile
    LDX #MTILE::MIRROR_CROSS2
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_mirror_ur:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDA laser_array_state, Y
    AND #%00000001
    STA tmp
    LDA laser_array_state, Y
    AND #%00000010
    LSR A

    EOR tmp
    BEQ @end
    LDX #MTILE::MIRROR_CROSS1
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_mirror_dl:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDA laser_array_state, Y
    AND #%00000001
    STA tmp
    LDA laser_array_state, Y
    AND #%00000010
    LSR A

    EOR tmp
    BNE @end
    LDX #MTILE::MIRROR_CROSS1
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_mirror_dr:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDA laser_array_state, Y  ; check the laser direction
    AND #%00000001          ; and if it is going up or left
    BNE @end                ; then draw the MIRROR_CROSS1 mtile
    LDX #MTILE::MIRROR_CROSS2
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_receive_up:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDX #MTILE::RECEIVE_UP_ON
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    pullreg
    RTS


; Y = laser index
laser_draw_receive_down:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDX #MTILE::RECEIVE_DOWN_ON
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    pullreg
    RTS


; Y = laser index
laser_draw_receive_left:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDX #MTILE::RECEIVE_LEFT_ON
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    pullreg
    RTS


; Y = laser index
laser_draw_receive_right:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDX #MTILE::RECEIVE_RIGHT_ON
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    TYA
    TAX
    LDY #$02
    JSR change_attribute

    pullreg
    RTS


; Y = laser index
laser_draw_door_h_on:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDX #MTILE::DOOR_H_ON
    JSR update_bg_metatile

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_door_v_on:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDX #MTILE::DOOR_V_ON
    JSR update_bg_metatile

    @end:
    pullreg
    RTS
    RTS


; Y = laser index
laser_draw_cross_h:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDX #MTILE::CROSS_H
    JSR update_bg_metatile
    JSR laser_draw_activate

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_cross_v:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDX #MTILE::CROSS_V
    JSR update_bg_metatile
    JSR laser_draw_activate

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_cross_on:
    pushreg

    LDA laser_array_pos, Y   ; get laser position in nametable
    TAX
    JSR get_metatile_nametable_adr

    LDA data_adr_h           ; set the laser position to vram_adr
    STA vram_adr_h
    LDA data_adr_l
    STA vram_adr_l

    LDX #MTILE::CROSS_ON
    JSR update_bg_metatile

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_activate:
    pushreg

    LDA laser_array_pos, Y
    TAX
    LDY #$02
    JSR change_attribute

    @end:
    pullreg
    RTS
