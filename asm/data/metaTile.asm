metaTileArrayLo:
    .byte <metaTile_00
    .byte <metaTile_01
metaTileArrayHi:
    .byte >metaTile_00
    .byte >metaTile_01


metaTile_00: .byte $5D, $00, $00, $5C
metaTile_01: .byte $50, $50, $40, $50
