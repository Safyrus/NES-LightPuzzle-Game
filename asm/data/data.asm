
; text
txt_menu: .byte $26, $1E, $27, $2E, $FF
txt_game_title: .byte $25, $22, $20, $21, $2D, $00, $29, $2E, $33, $33, $25, $1E, $00, $20, $1A, $26, $1E, $FF
txt_version: .byte $2F, $10, $34, $11, $34, $14, $FF
txt_win: .byte $30, $22, $27, $FF
txt_loose: .byte $25, $28, $28, $2C, $1E, $FF
txt_ui_1: .byte $00, $10, $37, $08, $00, $10, $37, $09, $00, $10, $37, $0E, $00, $10, $37, $0F, $00, $10, $37, $0A, $00, $10, $37, $0C, $FF
txt_ui_2: .byte $00, $10, $37, $0D, $00, $10, $37, $0B, $00, $10, $37, $36, $00, $10, $37, $36, $00, $10, $37, $36, $00, $10, $37, $36, $FF
txt_ui_3: .byte $00, $10, $37, $36, $00, $10, $37, $36, $00, $10, $37, $36, $00, $10, $37, $36, $FF
txt_goal: .byte $04, $20, $28, $1A, $25, $FF
txt_btn_move_1: .byte $03, $FF
txt_btn_move_2: .byte $05, $00, $06, $00, $26, $28, $2F, $1E, $FF
txt_btn_move_3: .byte $04, $FF
txt_btn_start: .byte $39, $3A, $00, $00, $29, $25, $1A, $32, $FF
txt_btn_a_1: .byte $01, $00, $29, $25, $1A, $1C, $1E, $FF
txt_btn_a_2: .byte $2D, $2E, $2B, $27, $FF
txt_btn_b: .byte $02, $00, $2B, $1E, $26, $28, $2F, $1E, $FF
txt_btn_select: .byte $3B, $3C, $00, $2C, $30, $22, $2D, $1C, $21, $FF
txt_start: .byte $2C, $2D, $1A, $2B, $2D, $FF
txt_resume: .byte $2B, $1E, $2C, $2E, $26, $1E, $FF
txt_selectlevel: .byte $2C, $1E, $25, $1E, $1C, $2D, $00, $25, $1E, $2F, $1E, $25, $00, $05, $00, $00, $06, $FF


; selectable metatiles
select_tiles:
.byte MTILE::WALL, MTILE::MIRROR_1, MTILE::EMIT_UP_ON, MTILE::RECEIVE_DOWN
.byte MTILE::MIRRORC_DR, MTILE::SPLITTER_H, MTILE::MERGER_H, MTILE::DOOR_H
.byte MTILE::VOID, MTILE::VOID, MTILE::VOID, MTILE::VOID
.byte MTILE::VOID, MTILE::VOID, MTILE::VOID, MTILE::VOID


; NTSC period table generated by mktables.py
period_table_lo:
    .byte $f1,$7f,$13,$ad,$4d,$f3,$9d,$4c,$00,$b8,$74,$34
    .byte $f8,$bf,$89,$56,$26,$f9,$ce,$a6,$80,$5c,$3a,$1a
    .byte $fb,$df,$c4,$ab,$93,$7c,$67,$52,$3f,$2d,$1c,$0c
    .byte $fd,$ef,$e1,$d5,$c9,$bd,$b3,$a9,$9f,$96,$8e,$86
    .byte $7e,$77,$70,$6a,$64,$5e,$59,$54,$4f,$4b,$46,$42
    .byte $3f,$3b,$38,$34,$31,$2f,$2c,$29,$27,$25,$23,$21
    .byte $1f,$1d,$1b,$1a,$18,$17,$15,$14

period_table_hi:
    .byte $07,$07,$07,$06,$06,$05,$05,$05,$05,$04,$04,$04
    .byte $03,$03,$03,$03,$03,$02,$02,$02,$02,$02,$02,$02
    .byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00