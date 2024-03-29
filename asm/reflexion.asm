;****************
; Author: Safyrus
;****************

; TODO:
; # FIX #
; - fix POS_OUTOFMAP
; - fix LASER_TOOMANY (add_laser and other functions)
; # LEVELS #
; - a LOT more levels
; - use differents palettes in levels
; # UI #
; - level selection menu
; # CONTROL #
; - better level play input mapping
; - better menu input mapping
; # OTHER #
; - add option (tick speed)
; - find code to refactor to take less space
; - fix typos
; - better comments


; Header of the file (not part of the cartridge, used by the emulator)
.segment "HEADER"
    .byte "NES", $1A; 0-3: Header
    .byte $01       ;   4: PRG ROM
    .byte $01       ;   5: CHR ROM
    .byte $01       ;   6: Flags 6
    .byte $00       ;   7: Flags 7
    .byte $00       ;   8: Flags 8
    .byte $00       ;   9: Flags 9
    .byte $00       ;  10: Flags 10
    .byte $00,$00,$00,$00,$00   ; Padding


.include "constants.asm"
.include "memory.asm"
.include "macro.asm"


; Code data 
.segment "CODE"

.include "vector/reset.asm"
.include "vector/vblank.asm"
.include "vector/irq.asm"

.include "main.asm"

.include "misc/subroutine.asm"

.include "game/control.asm"
.include "game/cursor.asm"
.include "game/laser.asm"
.include "game/level.asm"

.include "graphics/background.asm"
.include "graphics/bgUpdate.asm"
.include "graphics/palette.asm"
.include "graphics/sprite.asm"
.include "graphics/laser.asm"

data:
.include "data/data.asm"
.include "data/palette.asm"
.include "data/level.asm"
.include "data/metatile.asm"


; 6502 vectors
.segment "VECTORS"
    .word VBLANK    ; fffa nmi/vblank
    .word RESET     ; fffc reset
    .word IRQ       ; fffe irq/brk


; CHR ROM data 
.segment "CHARS"
.incbin "Reflexion.chr"
