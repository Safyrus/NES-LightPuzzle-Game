; Array
metaTileArrayLo:
    .byte <metaTile_00
    .byte <metaTile_01
    .byte <metaTile_02
    .byte <metaTile_03
    .byte <metaTile_04
    .byte <metaTile_05
    .byte <metaTile_06
    .byte <metaTile_07
    .byte <metaTile_08
    .byte <metaTile_09
    .byte <metaTile_0A
    .byte <metaTile_0B
    .byte <metaTile_0C
    .byte <metaTile_0D
    .byte <metaTile_0E
    .byte <metaTile_0F

    .byte <metaTile_10
    .byte <metaTile_11
    .byte <metaTile_12
    .byte <metaTile_13
    .byte <metaTile_14
    .byte <metaTile_15
    .byte <metaTile_16
    .byte <metaTile_17
    .byte <metaTile_18
    .byte <metaTile_19
    .byte <metaTile_1A
    .byte <metaTile_1B
    .byte <metaTile_1C
    .byte <metaTile_1D
    .byte <metaTile_1E
    .byte <metaTile_1F

    .byte <metaTile_20
    .byte <metaTile_21
    .byte <metaTile_22
    .byte <metaTile_23
    .byte <metaTile_24
    .byte <metaTile_25
    .byte <metaTile_26
    .byte <metaTile_27
    .byte <metaTile_28
    .byte <metaTile_29
    .byte <metaTile_2A
    .byte <metaTile_2B
    .byte <metaTile_2C
    .byte <metaTile_2D
    .byte <metaTile_2E
    .byte <metaTile_2F

metaTileArrayHi:
    .byte >metaTile_00
    .byte >metaTile_01
    .byte >metaTile_02
    .byte >metaTile_03
    .byte >metaTile_04
    .byte >metaTile_05
    .byte >metaTile_06
    .byte >metaTile_07
    .byte >metaTile_08
    .byte >metaTile_09
    .byte >metaTile_0A
    .byte >metaTile_0B
    .byte >metaTile_0C
    .byte >metaTile_0D
    .byte >metaTile_0E
    .byte >metaTile_0F

    .byte >metaTile_10
    .byte >metaTile_11
    .byte >metaTile_12
    .byte >metaTile_13
    .byte >metaTile_14
    .byte >metaTile_15
    .byte >metaTile_16
    .byte >metaTile_17
    .byte >metaTile_18
    .byte >metaTile_19
    .byte >metaTile_1A
    .byte >metaTile_1B
    .byte >metaTile_1C
    .byte >metaTile_1D
    .byte >metaTile_1E
    .byte >metaTile_1F

    .byte >metaTile_20
    .byte >metaTile_21
    .byte >metaTile_22
    .byte >metaTile_23
    .byte >metaTile_24
    .byte >metaTile_25
    .byte >metaTile_26
    .byte >metaTile_27
    .byte >metaTile_28
    .byte >metaTile_29
    .byte >metaTile_2A
    .byte >metaTile_2B
    .byte >metaTile_2C
    .byte >metaTile_2D
    .byte >metaTile_2E
    .byte >metaTile_2F



; Data
metaTile_00: .byte $00, $00, $00, $00   ; VOID
metaTile_01: .byte $50, $50, $40, $50   ; WALL
metaTile_02: .byte $5D, $00, $00, $5C   ; GROUND
metaTile_03: .byte $53, $53, $00, $00   ; UI_TOP
metaTile_04: .byte $42, $43, $44, $45   ; EMIT_UP
metaTile_05: .byte $54, $55, $42, $43   ; EMIT_DOWN
metaTile_06: .byte $47, $52, $57, $53   ; EMIT_LEFT
metaTile_07: .byte $52, $46, $53, $56   ; EMIT_RIGHT
metaTile_08: .byte $42, $43, $48, $49   ; RECEIVE_UP
metaTile_09: .byte $58, $59, $42, $43   ; RECEIVE_DOWN
metaTile_0A: .byte $4B, $52, $5B, $53   ; RECEIVE_LEFT
metaTile_0B: .byte $52, $4A, $53, $5A   ; RECEIVE_RIGHT
metaTile_0C: .byte $42, $43, $42, $43   ; LASER_HOR
metaTile_0D: .byte $52, $52, $53, $53   ; LASER_VER
metaTile_0E: .byte $60, $61, $70, $71   ; LASER_CROSS
metaTile_0F: .byte $05, $05, $05, $05   ; LOCK

metaTile_10: .byte $60, $67, $74, $7F   ; MIRROR_UL
metaTile_11: .byte $66, $61, $7E, $75   ; MIRROR_UR
metaTile_12: .byte $64, $6F, $70, $77   ; MIRROR_DL
metaTile_13: .byte $6E, $65, $76, $71   ; MIRROR_DR
metaTile_14: .byte $62, $61, $70, $73   ; MIRROR_CROSS1
metaTile_15: .byte $60, $63, $72, $71   ; MIRROR_CROSS2
metaTile_16: .byte $60, $6D, $7A, $79   ; MIRRORC_UL
metaTile_17: .byte $6C, $61, $78, $7B   ; MIRRORC_UR
metaTile_18: .byte $6A, $69, $70, $7D   ; MIRRORC_DL
metaTile_19: .byte $68, $6B, $7C, $71   ; MIRRORC_DR
metaTile_1A: .byte $00, $00, $00, $00
metaTile_1B: .byte $00, $00, $00, $00
metaTile_1C: .byte $00, $00, $00, $00
metaTile_1D: .byte $00, $00, $00, $00
metaTile_1E: .byte $00, $00, $00, $00
metaTile_1F: .byte $00, $00, $00, $00

metaTile_20: .byte $80, $81, $90, $91   ; DOOR_H
metaTile_21: .byte $82, $83, $92, $93   ; DOOR_V
metaTile_22: .byte $84, $85, $94, $95   ; DOORL_H
metaTile_23: .byte $86, $87, $96, $97   ; DOORL_V
metaTile_24: .byte $88, $89, $98, $99   ; SPLITTER_H
metaTile_25: .byte $8A, $8B, $9A, $9B   ; SPLITTER_V
metaTile_26: .byte $8C, $8D, $9C, $9D   ; MERGER_H
metaTile_27: .byte $8E, $8F, $9E, $9F   ; MERGER_V
metaTile_28: .byte $A0, $A1, $B0, $B1   ; TIMEWALL_OFF
metaTile_29: .byte $A2, $A3, $B2, $B3   ; TIMEWALL_ON
metaTile_2A: .byte $00, $00, $00, $00
metaTile_2B: .byte $00, $00, $00, $00
metaTile_2C: .byte $00, $00, $00, $00
metaTile_2D: .byte $00, $00, $00, $00
metaTile_2E: .byte $00, $00, $00, $00
metaTile_2F: .byte $00, $00, $00, $00
