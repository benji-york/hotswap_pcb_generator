include <parameters.scad>
include <utils.scad>

use <switch.scad>
use <mcu.scad>
use <trrs.scad>
use <standoff.scad>
use <plate.scad>

module backplate(switch_layout, mcu_layout, trrs_layout, plate_layout, standoff_layout) {
    difference() {
        union() {
            if (housing_type == "sandwich") {
                plate_base(switch_layout, mcu_layout, trrs_layout, plate_layout, backplate_thickness);
            } else if (housing_type == "plate_case") {
                plate_base(switch_layout, mcu_layout, trrs_layout, plate_layout, backplate_thickness, -case_wall_thickness-0.2);
                translate([0,0,(backplate_case_flange-backplate_thickness)/2])
                    plate_base(switch_layout, mcu_layout, trrs_layout, plate_layout, backplate_case_flange);
            }
            layout_pattern(standoff_layout) {
                backplate_standoff($extra_data);
            }
        }
        layout_pattern(standoff_layout) {
            backplate_standoff_hole($extra_data);
        }
    }
}

backplate(switch_layout_final, mcu_layout_final, trrs_layout_final, plate_layout_final, standoff_layout_final);