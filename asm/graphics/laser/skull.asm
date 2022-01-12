; Y = laser index
laser_draw_skull_h:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::SKULL_H
    JSR update_bg_metatile
    JSR laser_draw_activate

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_skull_v:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::SKULL_V
    JSR update_bg_metatile
    JSR laser_draw_activate

    @end:
    pullreg
    RTS


; Y = laser index
laser_draw_skull_on:
    pushreg

    JSR laser_pos_to_vram_adr

    LDX #MTILE::SKULL_ON
    JSR update_bg_metatile

    @end:
    pullreg
    RTS
