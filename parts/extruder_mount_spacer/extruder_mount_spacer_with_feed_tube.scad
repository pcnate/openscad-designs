// create a spacer for the new brass extruder assembly

// 15x70x3
length = 70;
hole_space=55;
hole_size=5;

feedBottomLength = 5;

feedVerticalHeight = 25;
feedVerticalLength = 6;
verticalYpos = -1*(feedBottomLength+feedVerticalLength+length/2);

// bottom section with holes
difference() {
    translate([-7.5,-1*(length/2),0])cube([15,length,3]);

    union() {
        translate([0, 1*(length/2-((length-hole_space)/2)),0])cylinder(d=hole_size,h=4,center=false);
        translate([0,-1*(length/2-((length-hole_space)/2)),0])cylinder(d=hole_size,h=4,center=false);
    }
}

// extra spacer
translate([-7.5,-1*(feedBottomLength+length/2),0])
cube([15,feedBottomLength,3]);

// vertical bar of feeder
translate([-7.5,verticalYpos,0])
cube([15,feedVerticalLength,feedVerticalHeight]);

// rounded part with hole
translate([0,verticalYpos,feedVerticalHeight])
translate([0,0,15/2])
rotate([-90,0,0])
difference() {
    union() {
        cylinder(r=15/2,h=feedVerticalLength+4);
        //translate([-7.5,0,0])
        //cube([15,15/2,feedVerticalLength]);

        intersection() {
            cylinder(r2=15/2,r1=30/2,h=feedVerticalLength+4);
            translate([-7.5,0,0])
            cube([15,15,feedVerticalLength+4]);
        }
    }
    union() {
        cylinder(r=5/2,h=feedVerticalLength+4-3);
        cylinder(r=2,h=feedVerticalLength+4);
    }
}
