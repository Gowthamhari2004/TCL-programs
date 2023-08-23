set fh_read [open ./outputs/reports/mtv.txt r] 
set i 0
set j 0
set lcn ""
set ds ""
set vt "" 

while {[gets $fh_read line] >= 0} {
		# Filter lines which is having violated net_name 
	if {([llength $line]== 5) || ([llength $line]== 1) } {
		# Extract violated net 
		incr j
		puts "iteration $j"
		set net_name [lindex $line 0]  

		# Extract driver pin name 
catch {set dp [get_object_name [get_cells -of_object [get_pins -filter "direction == out" [all_connected $net_name -leaf ]]] ]}

		catch {set rn [get_attribute [get_cells $dp] ref_name]}
 
		# 0 --> 1

		# NANDX 2 _HVT 
		# 16
		catch {regexp -nocase {(.+X)([0-9]+)(_.+)} $rn temp lcn ds vt }
		 
		# 0 --> 1
		# 1 --> 2	
		# 2 --> 4
		# 4 --> 8
		# 8 --> 16 
		# 16 --> 32
		catch { 
		if {$ds == 0} {
		   set ds 1
		} elseif {$ds == 1} {
		   set ds 2
		} else {
		  set ds [expr $ds * 2] 
		} 
		} 
	 

		catch {set new_cell $lcn$ds$vt } 
		set flag [catch {size_cell  $dp $new_cell} ] 
			# Flag is 0  size cell is succeded 
			# Flag is not zero size cell is not succeded 
		catch {set nrn [get_attribute [get_cells $dp] ref_name]} 
			
			if {$flag == 0}  { 
			incr i
			catch {puts "old cell ref_name  is $rn of $dp" }
			catch {puts "new cell ref_name  is $nrn of $dp"}
			} 
} 
}  

puts "no of cells upsized $i"
legalize_placement -incremental 