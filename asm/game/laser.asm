.include "game/laser/action.asm"
.include "game/laser/add.asm"
.include "game/laser/cross.asm"
.include "game/laser/door.asm"
.include "game/laser/merger.asm"
.include "game/laser/mirror.asm"
.include "game/laser/mirrorcorner.asm"
.include "game/laser/move.asm"
.include "game/laser/receive.asm"
.include "game/laser/splitter.asm"

; X = laser index
get_next_laser_pos:
    LDA laser_array_state, X  ; get direction of the laser
    AND #%00000011

    CMP #$00    ; is it going up ?
    BEQ @up
    CMP #$01    ; is it going down ?
    BEQ @down
    CMP #$02    ; is it going left ?
    BEQ @left
    JMP @right  ; then it is going right

    @up:
        LDA laser_array_pos, X
        CMP #$10
        BCC @pos_error
        SBC #$10
        JMP @end

    @down:
        LDA laser_array_pos, X
        CMP #$E0
        BCS @pos_error
        ADC #$10
        JMP @end

    @left:
        LDA laser_array_pos, X
        AND #%00001111
        CMP #$00
        BEQ @pos_error
        LDA laser_array_pos, X
        SEC
        SBC #$01
        JMP @end

    @right:
        LDA laser_array_pos, X
        AND #%00001111
        CMP #$0F
        BEQ @pos_error
        LDA laser_array_pos, X
        CLC
        ADC #$01
        JMP @end

    @pos_error:
        LDA POS_OUTOFMAP

    @end:
    RTS


