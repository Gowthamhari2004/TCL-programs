set fh_read [open "/home/gowthamp/projects1/PD/outputs/reports/macro_name.txt" r]

while {[gets $fh_read line] >=0} {
	#puts $line
	set name [lindex $line 0]
	set x [lindex $line 1]
	set y [lindex $line 2]
	set co "$x $y"
	#puts "name: $name x: $x y:$y"
	set_attribute [get_flat_cells $name] origin $co
}

puts "macro cells were placed in the given co-ordinates"