######################################### INSERT BUFFER #####################################################
# Read mcv.txt line by line and extract violated net 
catch {remove_buffers $buffer_list} 

set buffer_list ""
set fh_read [open ./outputs/reports/mtv.txt r] 
set i 0

while {[gets $fh_read line] >= 0} {
	# Filter lines which is having violated net_name 
	if {([llength $line]== 5) || ([llength $line]== 1) } {
		# Extract violated net 
		set net_name [lindex $line 0]  

		# Extract driver pin name 
		catch {set dp [get_pins -filter "direction == out" [all_connected $net_name -leaf ] ]}

		# Insert buffer to driver pin 
		catch {set bn [insert_buffer $dp NBUFFX16_HVT]}

		# All buffer names save in buffer list variable 
		catch {lappend buffer_list $bn }
		
		# If buffer is inserted at {0 0} 
		# get driver cell name 
		catch {set dcn [get_cells -of_object [get_pins -filter "direction == out" [all_connected $net_name -leaf ] ]]}

		# get lower left coordinate of a driver cell 
		catch {set co [get_attribute [get_cells $dcn] bbox_ll]}

		# Move buffer near to driver 
		catch {move_objects [get_cells $bn] -to $co}	
		puts "Iteration $i completed"  
		incr i 
	}
} 

# Legalize placement of all inserted buffers 
legalize_placement -incremental
update_timing -full 