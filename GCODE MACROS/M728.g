;M728.g home selector

if global.selector_loaded == 0
	M574 V1 S1 P"124.io3.in"
	G1 H1 V-150 F10000
	G1 V5
	G1 H1 V-10 F1000
	G1 V0.8
	G92 V0
else
	echo "Error, retract filament from selector before homing"
