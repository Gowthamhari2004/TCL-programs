 Co-ordinate 802.8 125.38
set x 802.8
set y 125.38

# get the pitch of M5 layer 
set pi [get_attribute [get_layers M5] pitch]

# find spacing between ports 
set sp [expr 6 * $pi] 
set i 0
foreach_in_collection po [all_outputs] { 
	set yn [expr $y + ($i * $sp)] 
	incr i 
	set co "$x $yn" 
	set_individual_pin_constraints -ports $po -allowed_layers M5 -location $co 
}
place_pins -ports [all_outputs]
