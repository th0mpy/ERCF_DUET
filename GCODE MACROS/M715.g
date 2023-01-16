;M715.g (S1) to engage 

if param.S == 1
	M280 P10 S90
	set global.selector_engaged = 1
else 
	M280 P10 S0
	set global.selector_engaged = 0