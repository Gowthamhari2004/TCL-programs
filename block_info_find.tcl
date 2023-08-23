##################GET STANDERD CELL COUNT##################
set std_cells [sizeof_collection [get_flat_cells ]]
puts "std_cell count is $std_cells"


###################get physical cell count################
set all_cells [sizeof_collection [get_flat_cells -all ]]
puts "all_cell counts is $all_cells"

set phy_cells [expr $all_cells - $std_cells]
puts "physical_cells $phy_cells"



##############################################################