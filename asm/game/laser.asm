; X = laser index
getNextLaserPos:
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


moveLaserMirror1:
    TYA
    STA laserArray_pos, X   ; set new laser position

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
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000011
        STA laserArray_state, X
        JMP @end
    @down:
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000010
        STA laserArray_state, X
        JMP @end
    @left:
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000001
        STA laserArray_state, X
        JMP @end
    @right:
        LDA laserArray_state, X
        AND #%11111100
        STA laserArray_state, X

    @end:
    RTS


moveLaserMirror2:
    TYA
    STA laserArray_pos, X   ; set new laser position

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
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000010
        STA laserArray_state, X
        JMP @end
    @down:
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000011
        STA laserArray_state, X
        JMP @end
    @left:
        LDA laserArray_state, X
        AND #%11111100
        STA laserArray_state, X
        JMP @end
    @right:
        LDA laserArray_state, X
        AND #%11111100
        ORA #%00000001
        STA laserArray_state, X

    @end:
    RTS


; X = laser index
; Y = laser position
laserAction_move:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    pullreg
    RTS


; X = laser index
; Y = laser position
laserAction_ground:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    TXA
    TAY
    JSR laserDraw_ground

    pullreg
    RTS


; X = laser index
; Y = laser position
laserAction_stop:
    PHA

    LDA laserArray_state, X
    ORA #%00000100
    STA laserArray_state, X

    PLA
    RTS

; X = laser index
; Y = laser position
laserAction_laserhor:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position
    TXA
    TAY
    JSR laserDraw_crosshor

    pullreg
    RTS


; X = laser index
; Y = laser position
laserAction_laserver:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position
    TXA
    TAY
    JSR laserDraw_crossver

    pullreg
    RTS


; X = laser index
; Y = laser position
laserAction_mirror_1:
    pushreg

    JSR moveLaserMirror1

    TXA
    TAY
    JSR laserDraw_mirror1

    pullreg
    RTS

; X = laser index
; Y = laser position
laserAction_mirror_2:
    pushreg

    JSR moveLaserMirror2

    TXA
    TAY
    JSR laserDraw_mirror2

    pullreg
    RTS

; X = laser index
; Y = laser position
laserAction_mirror_ul:
    pushreg

    JSR moveLaserMirror1

    TXA
    TAY
    JSR laserDraw_mirror_ul

    pullreg
    RTS

; X = laser index
; Y = laser position
laserAction_mirror_ur:
    pushreg

    JSR moveLaserMirror2

    TXA
    TAY
    JSR laserDraw_mirror_ur

    pullreg
    RTS

; X = laser index
; Y = laser position
laserAction_mirror_dl:
    pushreg

    JSR moveLaserMirror2

    TXA
    TAY
    JSR laserDraw_mirror_dl

    pullreg
    RTS

; X = laser index
; Y = laser position
laserAction_mirror_dr:
    pushreg

    JSR moveLaserMirror1

    TXA
    TAY
    JSR laserDraw_mirror_dr

    pullreg
    RTS

; X = laser index
; Y = laser position
laserAction_mirror_cross1:
    pushreg

    JSR moveLaserMirror1

    pullreg
    RTS

; X = laser index
; Y = laser position
laserAction_mirror_cross2:
    pushreg

    JSR moveLaserMirror1

    pullreg
    RTS
