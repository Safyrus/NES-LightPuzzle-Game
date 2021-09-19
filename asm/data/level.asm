; level size 14*12 meta tiles
; Mtile:
; 00 = Ground
; 01 = Wall
; FF = array of Mtiles

levelArrayLo:
    .byte <level_01
    .byte <level_02
levelArrayHi:
    .byte >level_01
    .byte >level_02


level_01:
    .byte $FF, (14*3+4), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (14*3+4), $01

level_02:
    .byte $FF, (14*2+4), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (6), $00, $FF, (8), $01
    .byte $FF, (14*2+4), $01
