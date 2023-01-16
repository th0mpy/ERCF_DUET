;M700 S<selectornumber>

var tool = null
var ok = false

if exists( param.S )
	if param.S == 0
		set var.tool = global.selector_0
		set var.ok = true
	elif param.S == 1
		set var.tool = global.selector_1
		set var.ok = true
	elif param.S == 2
		set var.tool = global.selector_2
		set var.ok = true
	elif param.S == 3
		set var.tool = global.selector_3
		set var.ok = true
	elif param.S == 4
		set var.tool = global.selector_4
		set var.ok = true
	elif param.S == 5
		set var.tool = global.selector_5
		set var.ok = true
	else
		set var.ok = false
else
	set var.ok = false
	
if var.ok && move.axes[3].homed
	echo "Good to go"
	G1 V{var.tool} F4000
else
	echo "Double check your S parameter or home axis"



;G1 V{global}