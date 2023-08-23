# Co-ordinate 802.8 125.38
set x 234.8
set y 802.5

# get the pitch of M5 layer 
set pi [get_attribute [get_layers M6] pitch]

# find spacing between ports 
set sp [expr 6 * $pi] 
set i 0
foreach_in_collection po [get_ports *clk*] { 
	set xn [expr $x + ($i * $sp)] 
	incr i 
	set co "$xn $y" 
	set_individual_pin_constraints -ports $po -allowed_layers M6 -location $co 
}
place_pins -ports [get_ports *clk*]
