;M710.g Load filament into selector

set global.pulse_count = 0
var last_count = global.pulse_count

;engage servo
M280 P10 S90

;disassociate the monitor
M591 D1 S0 P0

; set trigger
M950 J2 C"124.io1.in"
M581 T2 P2

M400

while var.last_count == global.pulse_count
	if global.selector_loaded == 0
		set var.last_count = global.pulse_count
		G1 E0:10
		M400
		if var.last_count != global.pulse_count
			M118 S"Load Finished" L2
			set global.selector_loaded = 1
			break
		if iterations = 20
			M118 S"Load Failed - Paused" L1
			M25
			break
	else
		M118 S"Load already done" L2
		break


;unset trigger
M581 T2 P-1
M950 J2 C"nil"

;set filament monitor
M591 D1 P7 C"^124.io1.in" S1 A1 L1.331

;Disengage servo
M280 P10 S0
