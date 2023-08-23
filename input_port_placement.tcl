# Co-ordinate {0 198.955} 
set x 0 
set y 198.956 

# get the pitch of M5 layer 
set pi [get_attribute [get_layers M5] pitch]

# find spacing between ports 
set sp [expr 6 * $pi] 
set i 0
foreach_in_collection po [remove_from_collection [all_inputs] [get_ports *clk*]] { 
	set yn [expr $y + ($i * $sp)]  
	set co "$x $yn" 
	set_individual_pin_constraints -ports $po -allowed_layers M5 -location $co
	incr i 
}
place_pins -ports [remove_from_collection [all_inputs] [get_ports *clk*]]

