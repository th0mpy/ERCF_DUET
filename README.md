ERCF on DUET

This is mostly just a placeholder, with some quick notes. 

I've setup several macros to do various things with ERCF in a native way in DUET. You can copy the gcode files into the system folder on your Duet controlled machine, and update a few config.g settings in order to define the new drive. 

I've only configured to 6 filament blocks so far, but more could easily be added. 

GCODE MACROS:
	M700.g		- USAGE: "M700 S(0-5) Move selector to the numbered filament block (locations defined in init.g)
	M705.g 		- USAGE: "M705" Check to see if filament is present in selector
	M710.g 		- USAGE: "M710" Load filament only into selector and check (not to be confused with loading filament to extruder)
	M711.g 		- USAGE: "M711" Load filament into extruder (Load selector first)
	M712.g 		- USAGE: "M712" Unload filament out of selector and check (not to be confused with unloading filament from extruder)
	M713.g		- USAGE: "M713" Unload filament out of extruder and back to selector. Must run M712 to fully remove the filament afterwards. 
	M715.g 		- USAGE: "M715 S(0|1)" Use S0 to disengage server and S1 to engage
	M728.g 		- USAGE: "M728" Home selector and select the 0 filament block
	init.g 		- USAGE: Define options for the ERCF (bowden length, selector positions, etc) add "M98 P"init.g" to your config.g to initialise the values


Additions for additional extruder drive to config.g this is my example.

; Drives
M569 P0.4 S0 D3                                                 ; A
M569 P0.3 S0 D3                                                 ; B

M569 P1.0 S0                                                    ; Extruder
M569 P124.1 S1 D3												; ERCF Drive - default address for canned board
M569 P124.0 S0 D3												; ERCF Selector - default address for canned board

M569 P0.5 S1 D3                                                 ; Z0
M569 P0.1 S1 D3                                                 ; Z1
M569 P0.2 S0 D3                                                 ; Z2
M569 P0.0 S0 D3                                                 ; Z3

M584 X0.3 Y0.4 Z0.5:0.1:0.2:0.0 E1.0:124.1 V124.0               ; set drive mapping (add additional extruder drive)
M350 X16 Y16 Z16 E16:16 V16 I1									; configure microstepping with interpolation
M92 X160.80 Y160.80 Z808.08 E699.8531:1110 V80                  ; set steps per mm
M566 X350.00 Y350.00 Z200.00 E300.00:300 V300                   ; set maximum instantaneous speed changes (mm/min)
M203 X20000.00 Y20000.00 Z20000.00 E4000.00:5000 V10000         ; set maximum speeds (mm/min)
M201 X2800.00 Y2800.00 Z300.00 E250.00:250.0 V2800              ; set accelerations (mm/s^2)
M906 X1800 Y1800 Z1800 E900:1000 V800 I30                       ; set motor currents (mA) and motor idle factor in per cent
M84 S30   

Modify tool to add second drive: 
M563 P0 D0:1 H1 F0                                                ; define tool 0

Add axis limits for V axis:
M208 X0 Y0 Z0 V0 S1												; set axis minima
M208 X345 Y354 Z355 V115 S0										; set axis maxima

Add these to the end of the config: 
M591 D1 P7 C"^124.io1.in" S1 A1 L1.331							; pulsed filament monitor in the ERCF
M950 S10 C"124.io0.out"											; ERCF servo