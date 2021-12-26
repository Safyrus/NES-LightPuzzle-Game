; Y = laser index
laser_draw_cross_h:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::CROSS_H
    JSR update_bg_metatile
    JSR laser_draw_activate

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_cross_v:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::CROSS_V
    JSR update_bg_metatile
    JSR laser_draw_activate

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_cross_on:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::CROSS_ON
    JSR update_bg_metatile

    @end:
    pullreg
    RTS
