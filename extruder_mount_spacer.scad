// create a spacer for the new brass extruder assembly

// 15x70x3
length = 70;
hole_space=55;
hole_size=5;

difference() {
    translate([-7.5,-1*(length/2),0])cube([15,length,3]);

    union() {
        translate([0, 1*(length/2-((length-hole_space)/2)),0])cylinder(d=hole_size,h=4,center=false);
        translate([0,-1*(length/2-((length-hole_space)/2)),0])cylinder(d=hole_size,h=4,center=false);
    }
}

