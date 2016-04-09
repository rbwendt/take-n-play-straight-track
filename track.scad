module center_rails(offset, rail_width, length, depth) {
    translate([offset,0,1]) {
        cube([rail_width, length, depth], center=true);
    }

    translate([-offset,0,1]) {
        cube([rail_width, length, depth], center=true);
    }
}

module side_rails(width_offset, height_offset, width, length, height) {
    translate([width_offset, 0, height_offset]) {
        cube([width, length, height], center=true);
    }

    translate([-width_offset, 0, height_offset]) {
        cube([width, length, height], center=true);
    }
}

module male_socket(l, d) {
    male_circle_connector_offset = 4.2;
    offset = (l / 2) + male_circle_connector_offset;
    male_cube_offset = l / 2 + 1;
    male_cube_width = 3.1;

    r = 2.2;

    translate([0, offset, 0]) {
        cylinder(r = r, h = d - 1, center=true);
    }
    translate([0, offset, (d - 0.5) / 2]) {
        cylinder(r1 = r, r2 = r-1, h = 0.5, center=true);
    }
    translate([0, offset, -(d - 0.5) / 2]) {
        cylinder(r2 = r, r1 = r-1, h = 0.5, center=true);
    }
    
    translate([0, male_cube_offset, 0]) {
        cube([male_cube_width, cube_length, d - 1], center=true);
    }
    translate([0, male_cube_offset + 2, (d - 1)/2]) {
        rotate(a=90, v=[1,0,0]) {
            scale([1, 0.27, 1]) {
                cylinder(d = male_cube_width, h = cube_length );
            }
        }
    }
    translate([0, male_cube_offset + 2, -(d - 1)/2]) {
        rotate(a=90, v=[1,0,0]) {
            scale([1, 0.27, 1]) {
                cylinder(d = male_cube_width, h = cube_length );
            }
        }
    }
}

module female_socket(l) {
    circle_connector_offset = 4;
    round_bevel_offset = 4;
    female_cube_width = 3.9;
    // this was 2.7 and it almost fit.
    r = 3;
    cylinder_offset = -((l / 2) - circle_connector_offset);
    female_cube_offset = -(l / 2) + 1.4;
    
    translate([0, cylinder_offset, -round_bevel_offset+1]) {
        cylinder(r1 = r * 1.2, r2 = r, h = 1, center=true);
    }
    translate([0, cylinder_offset, round_bevel_offset-1]) {
        cylinder(r2 = r * 1.2, r1 = r, h = 1, center=true);
    }
    translate([0, cylinder_offset, 0]) {
        cylinder(r = r, h = depth+ 0.15, center=true);
    }

    translate([0, female_cube_offset, 0]) {
        cube([female_cube_width, cube_length, depth+0.1], center=true);
    }
    translate([0, female_cube_offset - 1.7, 0]) {
        rotate(a=45, v=[0, 0, 1]) {
            cube([female_cube_width, cube_length, depth+0.1], center=true);
        }
    }
}



$fn = 20;
length = 100;
width = 38.1;
depth = 6;

center_rail_depth = depth + 1;
center_rail_width = 1.5;

center_rail_offset = 4;

side_rail_height = 8;
side_rail_width = 2;
side_rail_offset = (width - side_rail_width) / 2;
side_rail_height_offset = 2;

cube_length = 4;


difference() {
    cube([width, length, depth], center=true);
    female_socket(length);
}


male_socket(length, depth);
center_rails(center_rail_offset, center_rail_width, length, center_rail_depth);
side_rails(side_rail_offset, side_rail_height_offset, side_rail_width, length, side_rail_height);