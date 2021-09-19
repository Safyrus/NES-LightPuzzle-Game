
levelMetaArrayLo:
    .byte <levelMeta_01
    .byte <levelMeta_02
levelMetaArrayHi:
    .byte >levelMeta_01
    .byte >levelMeta_02


levelMeta_01:
    .byte $01 ; level number
    .byte $02 ; mirror number

levelMeta_02:
    .byte $02 ; level number
    .byte $04 ; mirror number
