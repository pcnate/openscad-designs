

module cubishThing( size=[20,20,20], radius=5, center=true, tip=true ) {
    
    // Get adapted sizes
    x=size[0]/2; // X offset
    y=size[1]/2; // Y offset
    z=size[2]/2; // Z offset

    
    if( center ) {
        // sides
        for(i=[-1,1]) {
            for(j=[-1,1]) {
                // z axis
                translate( [ size[0]/2*i, size[1]/2*j, 0-size[2]/2 ] )
                cylinder(r=radius,h=size[2]);
                
                // y axis
                translate( [ size[0]/2*i, size[1]/2, size[2]/2*j ] )
                rotate([90,0,0])
                cylinder(r=radius,h=size[1]);

                // x axis
                translate( [ 0-size[0]/2, size[1]/2*i, size[2]/2*j ] )
                rotate([0,90,0])
                cylinder(r=radius,h=size[0]);

                // rounded corners
                for(k=[-1,1]) {

                    translate( [ size[0]/2*i, size[1]/2*j, size[2]/2*k ] )
                    intersection() {
                        rotate([0,0,0])
                        cylinder(r=radius,h=radius*2,center=true);
                        
                        rotate([90,0,0])
                        cylinder(r=radius,h=radius*2,center=true);
                        
                        rotate([0,90,0])
                        cylinder(r=radius,h=radius*2,center=true);
                        
                        // remove tip
                        if( tip ) {
                            sphere(r=radius*1.02);
                        }
                    }
                }
            }
            
        }
    }
    
    if( !center ) {
        translate([ x+radius, y+radius, z+radius ])
        cubishThing( size=size, radius=radius, center=true, tip=tip );
    }
}

cubishThing( size=[30,30,30], radius=6, center=false );
