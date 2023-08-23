 step 1 : Find area (A) of Voltage area with utilization 0.8 

set area 0 
foreach_in_collection a [get_flat_cells *I_RISC_CORE*] {
set ca [get_attribute [get_flat_cells $a] area] 
set area [expr $area + $ca] 
} 

# VA = totol_area_cells / utilization 
set VA [expr $area / 0.8]
puts "Voltage area with uti 0.8 is $VA"   
 
# step 2 :  Measure height(h) from GUI 
set b [get_attribute [get_flat_cells I_RISC_CORE/I_REG_FILE/REG_FILE_B_RAM] height]
set H [expr $b + 30] 
puts "height of VA is $H" 

#step 3:  Find width of voltage area (W)
set W [expr $VA / $H ]  
puts "width of VA is $W" 
 
# llx lly - (5 5) 
# urx - W 
# ury - H 
# To get urx and ury on site rows
#
# step 4: 
# urx -( W/0.152 =round(m) , (round(m) * 0.152) + 5)
# ury - ( h/1.672 = round(m) , (round(m) * 1.672 ) + 5) 
set llx 5
set lly 5
set urx [expr (( ceil ($W / 0.152)) * 0.152 ) + 5 ]
puts $urx
set ury [expr (( ceil ($H / 1.672)) * 1.672 ) + 5 ]
puts $ury

# Step 5 : 
# llxn = llx + 5.016
# llyn = lly + 5.016
# urxn = urx + 5.016
# uryn = ury + 5.016 
set llxn [expr $llx + 5.016]
set llyn [expr $lly + 5.016]
set urxn [expr $urx + 5.016]
set uryn [expr $ury + 5.016]

set va_bbox "{$llxn $llyn} {$urxn $uryn}" 
puts $va_bbox

# step 6 : create Voltage area 
# VA coordinates -  { (llxn llyn )  (urxn uryn)}  guard_band {5.016 5.016}

# create_volatage_area -power_domain PD_RISC_CORE -regon {{10.016 10.016} {412.208 187.248}} -guard_band {{5.016 5.016}} 
create_voltage_area -power_domains PD_RISC_CORE -region $va_bbox -guard_band {{5.016 5.016}}