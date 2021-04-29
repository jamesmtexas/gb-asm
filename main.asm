INCLUDE "hardware.inc"

SECTION "Header", ROM0[$100]

EntryPoint:
	di
	jp Start

REPT $150 - $104
	db 0
ENDR

SECTION "Game code", ROM0
Start:
	ld c, 8 ; b = target position
	ld b, 1 ; c = iterator

	ld a, c
	cp 1
	jr z, End1
	cp 0
	jr z, End0

	ld d, 1 ; current
	ld e, 0 ; prev

Loop:
	
	ld h, e ; prevprev = prev
	ld e, d ; prev = current

	ld a, 0
	add a, h ; we can easily overflow here...max 255
	add a, e
	ld d, a

	inc b
	ld a, b
	cp c
	jr c, Loop
End:
	jr Lockup

End1:
	ld d, 1
	jp Lockup
End0:
	ld d, 0
	jp Lockup

Lockup:
	jr Lockup
