;M705.g filament presence check

set global.pulse_count = 0
var last_count = global.pulse_count
var initial_unload = false

;engage servo
M280 P10 S90

;disassociate the monitor
M591 D1 S0 P0

; set trigger
M950 J2 C"124.io1.in"
M581 T2 P2

M400

G1 E0:-2
M400

if var.last_count != global.pulse_count
	echo "Loaded" ; we have movement
	G1 E0:2
	M400
	set global.selector_loaded = 1
else
	echo "Not loaded" ; we don't have movement
	G1 E0:2
	M400
	set global.selector_loaded = 0

;unset trigger
M581 T2 P-1
M950 J2 C"nil"

;Disengage servo
M280 P10 S0
M400

;set filament monitor
M591 D1 P7 C"^124.io1.in" S1 A1 L1.331



