//cross

module christianCross( x = 0, y = 0, z = 0, h = 0, w = 0, d = 0, type = "cube" ) {

    crossHeight = h == 0 ? 100 : h;

    crossWidth = w == 0 ? crossHeight*.67 : w;

    postWidths = d == 0 ? 5 : d;

    crossBeamHeight = crossHeight*(21.5/32);

    if( type == "cube" ) {
        // vertical poll
        translate([postWidths*-.5+x,postWidths*-.5+y,z])
            cube([postWidths,postWidths,crossHeight]);
            
        // cross beam
        translate([crossWidth*-.5+x,postWidths*-.5+y,crossBeamHeight+z])
            cube([crossWidth,postWidths,postWidths]);
            
    }

    if( type == "cylinder" ) {
        // vertical poll
        translate([x,y,z])
            cylinder( r = postWidths*.5, h = crossHeight, center = false );
            
        // cross beam
        translate([crossWidth*-.5+x,y,postWidths*.5+crossBeamHeight+z])
            rotate([0,90,0])
                cylinder( d = postWidths, h = crossWidth );
        
    }

}

x  = 80;
y1 = 50;
y2 =  0;
z  =  0;
h  = 80;
d  =  0;

christianCross( x = x* 1, y = y1, z = z, h = h, d = d, type = "cube");
christianCross( x = x*-1, y = y1, z = z, h = h, d = d, type = "cylinder" );


for( i = [0:100] ) {
    christianCross( x = 0, y = i*-30, z = i*10, h = 0, d = d, type="cube" );

}














