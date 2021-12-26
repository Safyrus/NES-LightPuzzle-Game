; Y = laser index
laser_draw_mirror2:
    pushreg

    JSR laser_pos_to_vram_adr

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
    JSR laser_draw_activate

    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    pullreg
    RTS


; Y = laser index
laser_draw_mirror1:
    pushreg

    JSR laser_pos_to_vram_adr

    LDA laser_array_state, Y  ; check the laser direction
    AND #%00000001          ; and if it is going up or left
    BEQ @mirror_ul          ; then select the MIRROR_UL mtile
    LDX #MTILE::MIRROR_DR   ; else take the MIRROR_DR mtile
    JMP @draw
    @mirror_ul:
    LDX #MTILE::MIRROR_UL

    @draw:
    JSR laser_draw_activate

    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    pullreg
    RTS


; Y = laser index
laser_draw_mirror_ul:
    pushreg

    JSR laser_pos_to_vram_adr

    LDA laser_array_state, Y  ; check the laser direction
    AND #%00000001          ; and if it is going down or right
    BEQ @end                ; then draw the MIRROR_CROSS2 mtile
    LDX #MTILE::MIRROR_CROSS2
    JSR laser_draw_activate
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_mirror_ur:
    pushreg

    JSR laser_pos_to_vram_adr

    LDA laser_array_state, Y
    AND #%00000001
    STA tmp
    LDA laser_array_state, Y
    AND #%00000010
    LSR A

    EOR tmp
    BEQ @end
    LDX #MTILE::MIRROR_CROSS1
    JSR laser_draw_activate
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_mirror_dl:
    pushreg

    JSR laser_pos_to_vram_adr

    LDA laser_array_state, Y
    AND #%00000001
    STA tmp
    LDA laser_array_state, Y
    AND #%00000010
    LSR A

    EOR tmp
    BNE @end
    LDX #MTILE::MIRROR_CROSS1
    JSR laser_draw_activate
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_mirror_dr:
    pushreg

    JSR laser_pos_to_vram_adr

    LDA laser_array_state, Y  ; check the laser direction
    AND #%00000001          ; and if it is going up or left
    BNE @end                ; then draw the MIRROR_CROSS1 mtile
    LDX #MTILE::MIRROR_CROSS2
    JSR laser_draw_activate
    JSR update_bg_metatile
    LDA laser_array_pos, Y
    TAY
    TXA
    STA level, Y

    @end:
    pullreg
    RTS
