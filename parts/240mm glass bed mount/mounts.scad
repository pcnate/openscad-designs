bedThickness = 4;
bedDiameter = 239;

heaterThickness = 1.75;
heaterDiameter = 220;
heaterHeight = 22;


module bed( height, lowerHeight = 0 ) {
  // heater
  color( "red" )
  translate([ 0, 0, heaterThickness/2 ])
  cylinder( h = heaterThickness, r = heaterDiameter/2, center = true, $fn = 360 );

  // glass bed
  color( "lightgray")
  translate([ 0, 0, heaterThickness + ( height/2 ) ])
  cylinder( h = height, r = bedDiameter/2, center = true, $fn = 360 );

  // clear space below heater
  echo ( lowerHeight )
  if ( lowerHeight > 0 ) {
    translate([ 0, 0, heaterThickness + ( height/2 ) - lowerHeight ])
    cylinder( h = height, r = (heaterDiameter/2)-5, center = true, $fn = 360 );
  }
}


module extruded_bar( width, height, gap ) {

  difference() {
    square([ width, height ], center = true );

    union() {
      circle( 2, $fn = 360 );
      for ( i = [ 0:3 ] ) {
        tran_x = i % 2 ? height/2 : width/2;
        rot = i * 90;
        rotate([ 0, 0, rot ])
        translate([ tran_x - gap/2, 0, 0])
        union() {
          translate([ -1, 7, 0 ])
          circle( 2, $fn = 360 );
          translate([ -1.5, 0, 0 ])
          square([ 4, gap + 3 ], center = true);
          translate([ -1.5, 0, 0 ])
          square([ 8, gap ], center = true);
        }
      }
    }
  }
}


module bed_mount() {
  // color("orange")
  // translate([0,-171,20])
  // cube([ 10,50,2]);
  difference() {
    union() { // bed mount
      color("green")
      translate([ 0, -91, 20 ])
      linear_extrude( bedThickness + heaterThickness + 3.25 )
      square( [185, 60 ], center = true );
    }
    union() {
      union() {
        translate([ -18, -110, 18.5 ])
        cube([ 25, 30, 10 ], center = true );
        translate([ -18, -100, 20 ])
        cube([ 25, 20, 10 ], center = true );
      }
      translate([0,0,10])
      union() {
        for( s = [ 1, -1 ]) {
          translate([ s * 46.2, -116, 3.25 ])
          union() { // screw hole
            translate([ 0, 0, 11.5 ])
            cylinder( h = 4.5, d = 7, $fn = 360 );
            cylinder( h = 11.5, d = 4, $fn = 360 );
          }
        }
      }
      translate([ 0, 0, heaterHeight ]) bed( 10, 10 );
      for ( x = [ -1, 1 ] ) { // trim the edge to match the extruded bar
        translate([ x * 92.5, -105.75, 25 ])
        rotate( -30 * x )
        cube([ 50, 100, bedThickness + heaterThickness + 15 ], center = true );
      }
    }
  }
}


if ( $preview ) {
  for ( h = [ 0,621,661 ]) {
    translate([ 0, 0, h ])
    for ( i = [ 0:2 ] ) {
      rotate([ 0, 0, i * 120 ])
      translate([ -120, 98, 10 ])
      rotate([ 0, 90, 0 ])
      linear_extrude( 240 )
      extruded_bar( 20, 20, 4.2 );
    }
  }

  for( i = [0:2] ) {
    rotate([ 0, 0, i * 120 ])
    translate([ 0, -161, 0 ])
    linear_extrude( 681 )
    extruded_bar( 20, 20, 4.2 );
  }

  translate([ 0, 0, heaterHeight ]) bed( bedThickness );


  for( i = [0:2] ) {
    rotate([ 0, 0, i * 120 ]) bed_mount();
  }

  rotate([0,0,90])
  translate([-168,-67.68/2,0])
  color("orange")
  cube([ 10, 67.68, 10 ]);
} else {
  translate([ 0, 110, -20 ]) bed_mount();
}
