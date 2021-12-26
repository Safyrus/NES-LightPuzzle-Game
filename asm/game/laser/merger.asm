; X = laser index
; Y = laser position
laser_action_merger_h:
    pushreg

    ; check if laser is going verticaly
    LDA laser_array_state, X
    AND #%00000010
    BNE @end

    ; set merger to a "1 laser state"
    LDA laser_array_state, X
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
    LDA laser_array_state, X
    AND #%00000010
    BEQ @end

    ; set merger to a "1 laser state"
    LDA laser_array_state, X
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
    LDA laser_array_state, X
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
    LDA laser_array_state, X
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
    LDA laser_array_state, X
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
    LDA laser_array_state, X
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
