
/* globals */
gWidth     =  8;

/* top piece */

tHoleSpace = 10;
tHoleSize  =  4;
tHeight    =  7;
tWidth     =  gWidth;
tOver      =  6;
tLength    = tHoleSpace + tWidth * (2/3);

//translate([0,-tOver,0])
rotate(a=90,v=[0,0,1])
rotate(a=90,v=[1,0,0])

difference() {
    
    // create bar
    cube([tLength,tWidth,tHeight]);
    
    // create hole
    translate([tHoleSpace,tWidth/2,0])
    cylinder(d=tHoleSize, h=tHeight);
}


/* end top piece */

/* vertical piece */

vOffset    =  8; 
vWidth     =  gWidth;
vBarHeight =  6;
padHeight  =  5;
vHoleSpace = 50;
vLength    = vHoleSpace + vWidth + vOffset;
vHoleSize  =  3;

// flip to side
translate([vLength,0,vWidth]) {
rotate(a=180,v=[0,0,1]) {
rotate(a=-90,v=[1,0,0]) {
    
    // subtract holes from bar
    difference() {
        
        // create bar
        union() {
            // main bar
            cube([vLength,vWidth,vBarHeight]);
            
            // top pad
            translate([0,0,vBarHeight])
            cube([vWidth,vWidth,padHeight]);
            
            // bottom pad
            translate([vLength-vWidth-vOffset,0,vBarHeight])
            cube([vWidth,vWidth,padHeight]);
        } // end create bar
        
        // create holes
        union() {
            // top hole
            translate([vWidth/2,vWidth/2,0])
            cylinder(d=vHoleSize,h=vBarHeight+padHeight);

            // bottom hole
            translate([vLength-(vWidth/2)-vOffset,vWidth/2,0])
            cylinder(d=vHoleSize,h=vBarHeight+padHeight);
        } // end holes
        
    } // end difference
    
} } // end rotate
}

/* end vertical piece */
