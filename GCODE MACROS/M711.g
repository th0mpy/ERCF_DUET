;M711.g Load extruder
;Ensure selector is loaded (if false run check) todo

;Advance Extruder 1 1010mm
;Advance Both Extruder 0 and 1 43mm

;Disengage servo

;Advance Extruder 0 5mm

if global.selector_loaded == 0
	M226																	;No filament loaded pause print
else
	M715 S1																	;engage the servo
	M400
	echo {global.bowden_length}
	G1 E{0, global.bowden_length} F3000										;feed filament to the end of the bowden
	M400		
	G1 E{global.extruder_load_length, global.extruder_load_length} F2000	;move both extruders in tandem to load
	M400	
	M715 S0																	;disengage servo
	G1 E5
