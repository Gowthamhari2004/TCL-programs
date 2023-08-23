set cell_list ""
set fh_read [open ./outputs/reports/hv_aro.txt r]
# set fh_read [open ./scripts/temp.txt r] 
set n 0  
set m 0 
set i 0
set flag 0 
set a 0 
set it 0 
while {[gets $fh_read line] >= 0} {
	if { [regexp {Startpoint} $line]} {
		incr it 
		set j 0
		puts "iteration $it" 
		set a 0 
	} 

	if { [regexp {clock network delay} $line]} {
		if {$j == 1} {
			continue 	
		} 
	set flag 1
	set j 1 
	continue 
	} 

	if {[regexp { data arrival time } $line]} {
	set flag 0
	}

	if {$flag == 1} {
		if {[lindex $line 2] == ""} { 
		continue 
		}  
		set ff [string index [lindex $line 0] end ] 
		if {$ff == "Q"} { 
		continue 
		}  
		if {[lindex $line 2] > $a} {
			set b [lindex $line 0]
			set a [lindex $line 2] 
		} 	 
	} 

	if {[regexp {slack} $line]} {
			set c [string range  $b 0 end-2]
			set check [lsearch $cell_list $c]
	 			if {$check == -1} { 
				lappend cell_list $c
				puts "cell_upizing $c" 
				set rn [get_attribute [get_cells $c] ref_name] 
	 			puts "initial_cell_ref_name  $rn" 
				regexp -nocase {(.+X)([0-9]+_)(.+)} $rn temp lcn ds vt 
					if {$vt == "HVT"} {
		   				set vt LVT
					} elseif {$vt == "RVT"} {
		   				set vt LVT 
					} else {
						puts "Already at LVT, Vt swapping not possible" 
		  				continue  
					} 
					set new_cell $lcn$ds$vt 
					set cf [catch {size_cell  $c $new_cell} ] 
						if {$cf  == 0} {
							incr m 
						} else {
						   incr n
						}  
					catch {set nrn [get_attribute [get_cells $c] ref_name]} 
					puts "new_cell_ref_name  $nrn" 
				} else {
				puts "already upsized $c" 
				} 
	 } 
} 

puts "number of cells vt swapped $m" 
puts "number of cells already at LVT $n" 
