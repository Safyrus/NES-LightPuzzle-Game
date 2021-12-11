; X = laser index
; Y = laser position
laser_action_move:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_ground:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    TXA
    TAY
    JSR laser_draw_ground

    pullreg
    RTS


; X = laser index
laser_action_stop:
    PHA

    LDA laserArray_state, X
    ORA #%00000100
    STA laserArray_state, X

    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_laserhor:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position
    TXA
    TAY
    JSR laser_draw_crosshor

    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_laserver:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position
    TXA
    TAY
    JSR laser_draw_crossver

    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_1:
    pushreg

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror1

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_2:
    pushreg

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror2

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_ul:
    pushreg

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror_ul

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_ur:
    pushreg

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror_ur

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_dl:
    pushreg

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror_dl

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_dr:
    pushreg

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror_dr

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_cross1:
    pushreg

    JSR move_laser_mirror1

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_cross2:
    pushreg

    JSR move_laser_mirror1

    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_receive_up:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going down
    AND #%00000011
    CMP #$01
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_up

    @end:
    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_receive_down:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going up
    AND #%00000011
    CMP #$00
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_down

    @end:
    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_receive_left:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going right
    AND #%00000011
    CMP #$03
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_left

    @end:
    pullreg
    RTS

; X = laser index
; Y = laser position
laser_action_receive_right:
    pushreg

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going left
    AND #%00000011
    CMP #$02
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_right

    @end:
    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_ul:
    pushreg

    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$01    ; is it going down ?
    BEQ @yes
    CMP #$03    ; is it going right ?
    BEQ @yes

    @nop:
    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_ur:
    pushreg

    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$01    ; is it going down ?
    BEQ @yes
    CMP #$02    ; is it going left ?
    BEQ @yes

    @nop:
    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_dl:
    pushreg

    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$00    ; is it going up ?
    BEQ @yes
    CMP #$03    ; is it going right ?
    BEQ @yes

    @nop:
    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_dr:
    PHA

    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$00    ; is it going up ?
    BEQ @yes
    CMP #$02    ; is it going left ?
    BEQ @yes

    @nop:
    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_splitter_h:
    PHA

    ; check if laser is going verticaly
    LDA laserArray_state, X
    AND #%00000010
    BNE @end

    ; add 2 laser going left and right
    JSR add_laser_left
    JSR add_laser_right
    ; set splitter to ON
    LDA #MTILE::SPLITTER_H_ON
    STA level, Y

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_splitter_v:
    PHA

    ; check if laser is going horizontaly
    LDA laserArray_state, X
    AND #%00000010
    BEQ @end

    ; add 2 laser going up and down
    JSR add_laser_up
    JSR add_laser_down
    ; set splitter to ON
    LDA #MTILE::SPLITTER_V_ON
    STA level, Y

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_merger_h:
    pushreg

    ; check if laser is going verticaly
    LDA laserArray_state, X
    AND #%00000010
    BNE @end

    ; set merger to a "1 laser state"
    LDA laserArray_state, X
    BEQ @up
    @down:
    LDA #MTILE::MERGER_H_T
    JMP @update
    @up:
    LDA #MTILE::MERGER_H_B
    @update:
    STA level, Y

    @end:
    JSR laser_action_stop
    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_merger_v:
    PHA

    ; check if laser is going horizontaly
    LDA laserArray_state, X
    AND #%00000010
    BEQ @end

    ; set merger to a "1 laser state"
    LDA laserArray_state, X
    CMP #$02
    BEQ @left
    @right:
    LDA #MTILE::MERGER_V_L
    JMP @update
    @left:
    LDA #MTILE::MERGER_V_R
    @update:
    STA level, Y

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_merger_ht:
    PHA

    ; check if laser is going up
    LDA laserArray_state, X
    CMP #$00
    BNE @end

    ; set merger to ON
    LDA #MTILE::MERGER_H_ON
    STA level, Y
    ; add 2 laser going left and right
    JSR add_laser_left
    JSR add_laser_right

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_merger_hb:
    PHA

    ; check if laser is going down
    LDA laserArray_state, X
    CMP #$01
    BNE @end

    ; set merger to ON
    LDA #MTILE::MERGER_H_ON
    STA level, Y
    ; add 2 laser going left and right
    JSR add_laser_left
    JSR add_laser_right

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_merger_vl:
    PHA

    ; check if laser is going left
    LDA laserArray_state, X
    CMP #$02
    BNE @end

    ; set merger to ON
    LDA #MTILE::MERGER_H_ON
    STA level, Y
    ; add 2 laser going up and down
    JSR add_laser_up
    JSR add_laser_down

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_merger_vr:
    PHA

    ; check if laser is going right
    LDA laserArray_state, X
    CMP #$03
    BNE @end

    ; set merger to ON
    LDA #MTILE::MERGER_H_ON
    STA level, Y
    ; add 2 laser going up and down
    JSR add_laser_up
    JSR add_laser_down

    @end:
    JSR laser_action_stop
    PLA
    RTS
