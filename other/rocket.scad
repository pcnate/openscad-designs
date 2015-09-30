
module fin() {
    inside=4;
        
    translate([0,-2,0])
    difference() {
        difference() {
            difference() {
                translate([inside+3,0,-3])rotate([0,-25,0])cube([12,4,45]);
                translate([inside-25,-5,0])cube([20,10,50]);
            };
            
            // fin end
            translate([inside+5,-3,0])rotate([0,30,0])cube([10,10,20]);
        }
        translate([inside-5,-3,-10])cube([20,10,10]);
    }
    
}

// center

difference()
{
    // build body
    union() {
        // nozzle
        translate([0,0,0]) cylinder( 15, r1= 4, r2=10, center=false );

        // body
        translate([0,0,15])cylinder( 40, r1=10, r2=10, center=false);

        // cone
        translate([0,0,55])cylinder(  7, r1=10, r2= 9, center=false );
        translate([0,0,62])cylinder(  8, r1= 9, r2= 7, center=false );
        translate([0,0,70])cylinder( 20, r1= 7, r2= 0, center=false );

    }

    // center hole
    union() {
            translate([ 0,0,10]) cylinder( 60, r1= 4, r2= 4, center=false ); 
            translate([ 0,0, 0]) cylinder( 10, r1= 2, r2= 4, center=false ); 
            translate([ 0,0,70]) cylinder( 10, r1= 4, r2= 0, center=false ); 
    }

}

// fins
fins=3;
for(i=[0:fins-1])
    rotate([0,0,i*(360/fins)]) translate([10,0,0]) fin();

