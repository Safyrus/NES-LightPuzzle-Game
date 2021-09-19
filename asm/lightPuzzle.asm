;****************
; Author: Safyrus
;****************

; TODO:
; - DrawMetaTile
; - DrawLevel

; Header of the file (not part of the cartridge, used by the emulator)
.segment "HEADER"
    .byte "NES", $1A; 0-3: Header
    .byte $01       ;   4: PRG ROM
    .byte $01       ;   5: CHR ROM
    .byte $00       ;   6: Flags 6
    .byte $00       ;   7: Flags 7
    .byte $00       ;   8: Flags 8
    .byte $00       ;   9: Flags 9
    .byte $00       ;  10: Flags 10
    .byte $00,$00,$00,$00,$00   ; Padding


.include "constants.asm"
.include "memory.asm"


; Code data 
.segment "CODE"

.include "vector/reset.asm"
.include "vector/vblank.asm"
.include "vector/irq.asm"

.include "main.asm"

.include "subroutine.asm"
.include "control.asm"
.include "game/init.asm"
.include "graphics/background.asm"
.include "graphics/palette.asm"
.include "graphics/sprite.asm"
.include "audio/init.asm"
.include "audio/subroutine.asm"

.include "data/data.asm"
.include "data/level.asm"
.include "data/levelMeta.asm"
.include "data/metaTile.asm"


; 6502 vectors
.segment "VECTORS"
    .word VBLANK    ; fffa nmi/vblank
    .word RESET     ; fffc reset
    .word IRQ       ; fffe irq/brk


; CHR ROM data 
.segment "CHARS"
.incbin "lightPuzzle.chr"
