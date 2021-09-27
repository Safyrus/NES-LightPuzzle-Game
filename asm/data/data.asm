
; text
txt_null: .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
txt_menu: .byte $26, $1E, $27, $2E
txt_pressplay: .byte $29, $2B, $1E, $2C, $2C, $00, $2D, $28, $00, $29, $25, $1A, $32
txt_win: .byte $30, $22, $27
txt_loose: .byte $25, $28, $28, $2C, $1E


; NTSC period table generated by mktables.py
periodTableLo:
    .byte $f1,$7f,$13,$ad,$4d,$f3,$9d,$4c,$00,$b8,$74,$34
    .byte $f8,$bf,$89,$56,$26,$f9,$ce,$a6,$80,$5c,$3a,$1a
    .byte $fb,$df,$c4,$ab,$93,$7c,$67,$52,$3f,$2d,$1c,$0c
    .byte $fd,$ef,$e1,$d5,$c9,$bd,$b3,$a9,$9f,$96,$8e,$86
    .byte $7e,$77,$70,$6a,$64,$5e,$59,$54,$4f,$4b,$46,$42
    .byte $3f,$3b,$38,$34,$31,$2f,$2c,$29,$27,$25,$23,$21
    .byte $1f,$1d,$1b,$1a,$18,$17,$15,$14

periodTableHi:
    .byte $07,$07,$07,$06,$06,$05,$05,$05,$05,$04,$04,$04
    .byte $03,$03,$03,$03,$03,$02,$02,$02,$02,$02,$02,$02
    .byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00