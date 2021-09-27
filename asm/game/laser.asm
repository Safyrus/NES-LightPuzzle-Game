.include "game/laser/action.asm"
.include "game/laser/add.asm"
.include "game/laser/move.asm"

; X = laser index
get_next_laser_pos:
    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011

    CMP #$00    ; is it going up ?
    BEQ @up
    CMP #$01    ; is it going down ?
    BEQ @down
    CMP #$02    ; is it going left ?
    BEQ @left
    JMP @right  ; then it is going right

    @up:
        LDA laserArray_pos, X
        CMP #$10
        BCC @pos_error
        SBC #$10
        JMP @end

    @down:
        LDA laserArray_pos, X
        CMP #$E0
        BCS @pos_error
        ADC #$10
        JMP @end

    @left:
        LDA laserArray_pos, X
        AND #%00001111
        CMP #$00
        BEQ @pos_error
        LDA laserArray_pos, X
        SEC
        SBC #$01
        JMP @end

    @right:
        LDA laserArray_pos, X
        AND #%00001111
        CMP #$0F
        BEQ @pos_error
        LDA laserArray_pos, X
        CLC
        ADC #$01
        JMP @end

    @pos_error:
        LDA POS_OUTOFMAP

    @end:
    RTS


