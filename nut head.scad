
headBottom=0;
headHeight = 80;
headWidth = 100;

bitWidth = 70;
bitSides = 6;
bitDepth = 60;

translate([0,0,headBottom])
difference() {
    cylinder( h=headHeight, r=headWidth, $fn=360 );
    
    translate([0,0,headHeight-bitDepth])
    cylinder( h=bitDepth, r=bitWidth, $fn=bitSides );
}