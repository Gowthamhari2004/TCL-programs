# Proc to find core area for any utilization 
proc core_area_uti uti {

set area 0 

# a will take each cell during each iteration and executes foreach loop . 
foreach_in_collection a [get_flat_cells] { 
	set b [get_attribute [get_flat_cell $a] area ]
	set area [expr $area + $b] 
} 

puts "area of all cells in design is $area"

# Core_area = (Total_cell_area) /  Utilization
# Utilization is $uti

set core_area [expr $area / $uti] 
puts "Core area for utilization $uti is $core_area"

 } 


core_area_uti 0.8 