
boxPostsDistanceX = 92;
boxPostsDistanceY = 92;

raspberrypiStandOffHeight = 5;

standOffBoardHeight = 3;

innerCornerRadius = 4;
outerCornerRadius = 10;

outerOffset = 6;

piModel = 3;
showBolts = 0;
showPi = 0;
piModelOffsetZ = 0;

function getPiOffsetX() = piModel==0
  ? boxPostsDistanceX/2 - raspberrypiHoleX/2 - 26.75
  : boxPostsDistanceX/2 - raspberrypiHoleX/2 - 1.75;

function getPiOffsetY() = piModel==0
  ? boxPostsDistanceY/2 - raspberrypiHoleY/2 - 22
  : boxPostsDistanceY/2 - raspberrypiHoleY/2 - 7;

removeCrossSupportsInMiddle = piModel==0 ? 0 : 1;

raspberrypiHoleX = 58;
raspberrypiHoleY = piModel==0 ? 23 : 49;

piOffsetX = getPiOffsetX();
piOffsetY = getPiOffsetY();

// display a raspberry pi stl file if you download and import it yourself
// https://www.thingiverse.com/thing:2023897/files
// get the zero by downloading the scad, configure it and export the stl
if ( showPi==1 ) {
  if ( piModel==0 ) {
    color("limegreen")
    rotate([0,0,180])
    translate([(piOffsetX*-1),(piOffsetY),raspberrypiStandOffHeight + standOffBoardHeight+piModelOffsetZ])
    import( "/home/pcnate/Downloads/raspberrypi0.stl", convexity=3);
  } else {
    color("limegreen")
    rotate([0,0,180])
    translate([-5.25,14.5,raspberrypiStandOffHeight + standOffBoardHeight+piModelOffsetZ])
    import( "/home/pcnate/Downloads/raspberrypi.stl", convexity=3);
  }
}

linear_extrude( standOffBoardHeight )
difference() {

  union() {
    /* support board wings */
    for( a = [0,1] ) {
      boxPostsDistance = a==1 ? boxPostsDistanceY : boxPostsDistanceX;
      rotate([0,0,a*90])
      /*square( [ boxPostsDistance + 8 , 10 ], center = true );*/
      hull() {
        translate([ -boxPostsDistance/2 - 2.5,  3.33, 0 ])circle( d = 3.33, center = true, $fn = 30 );
        translate([  boxPostsDistance/2 + 2.5,  3.33, 0 ])circle( d = 3.33, center = true, $fn = 30 );
        translate([ -boxPostsDistance/2 - 2.5, -3.33, 0 ])circle( d = 3.33, center = true, $fn = 30 );
        translate([  boxPostsDistance/2 + 2.5, -3.33, 0 ])circle( d = 3.33, center = true, $fn = 30 );
      }
    }

    difference() {

      hull() {
        for( a = [-1,1] ) {
          boxPostsDistance = a==1 ? boxPostsDistanceY : boxPostsDistanceX;
          for( b = [-1,1] ) {
            translate([piOffsetX, -piOffsetY, 0])
            translate( [ a * -raspberrypiHoleX/2 + a * -outerOffset, b * -raspberrypiHoleY/2 + b * -outerOffset, 0 ] )
            translate( [ a * outerCornerRadius/2, b * outerCornerRadius/2, 0 ] )
            circle( d = outerCornerRadius, center = true, $fn = 20 );
          }
        }
      }

      hull() {
        for( a = [-1,1] ) {
          boxPostsDistance = a==1 ? boxPostsDistanceY : boxPostsDistanceX;
          for( b = [-1,1] ) {
            translate([piOffsetX, -piOffsetY, 0])
            translate( [ ( a * ( raspberrypiHoleX/2 - innerCornerRadius-2.5 ) ), ( b * ( raspberrypiHoleY/2 - innerCornerRadius-2.5 ) ), 0 ] )
            circle( r = innerCornerRadius, center = true, $fn = 20 );
          }
        }
      }

    }

  }

  union() {

    /*support board wing holes */
    for( a = [0,1] ) {
      boxPostsDistance = a==1 ? boxPostsDistanceY : boxPostsDistanceX;
      rotate([0,0,a*90]) {
        translate([ ( boxPostsDistance / 2 ), 0, 0 ])
        circle( d = 4.5, $fn = 20 );
        translate([ ( - boxPostsDistance / 2 ), 0, 0 ])
        circle( d = 4.5, $fn = 20 );
      }
    }

    /* lower board holes */
    for( a = [-1,1] ) {
      for( b = [-1,1] ) {
        translate([piOffsetX, -piOffsetY, 0])
        translate([ a * raspberrypiHoleX/2 , b * raspberrypiHoleY/2 , 0 ])
        circle( d = 3.9, $fn = 20 );
      }
    }

    if( removeCrossSupportsInMiddle== 1 ) {
      /* central support board */
      hull() {
        for( a = [-1,1] ) {
          for( b = [-1,1] ) {
            translate([piOffsetX, -piOffsetY, 0])
            translate( [ ( a * ( raspberrypiHoleX/2 - innerCornerRadius-2.5 ) ), ( b * ( raspberrypiHoleY/2 - innerCornerRadius-2.5 ) ), 0 ] )
            circle( r = innerCornerRadius, center = true, $fn = 20 );
          }
        }
      }
    }

  }

}

module bolt() {

  translate([0,0,-1])

  difference() {

    union() {
      intersection() {
        translate([0,0,standOffBoardHeight-3.4])
        sphere( d= 15, $fn=50 );

        translate([0,0,standOffBoardHeight+1])
        linear_extrude( 3 )
        circle( d = 8.15, $fn = 50 );
      }
    }

    union() {
      translate([0,0,6])
      cube([1,4,2], center = true);
      rotate([0,0,90])
      translate([0,0,6])
      cube([1,4,2], center = true);
    }

  }

  translate([0,0, ( standOffBoardHeight -8.75 ) ])
  linear_extrude( 8.75 )
  circle( d = 4.5, $fn = 20 );
}

if ( showBolts==1 ) {

  color("red")
  translate([0,0,-0])
  union() {
      /* lower board holes */
      union() {
        translate([ ( boxPostsDistanceX / 2 ), 0, 0 ])
        bolt();
        translate([ 0, ( boxPostsDistanceY / 2 ), 0 ])
        bolt();
        translate([ ( boxPostsDistanceX / -2 ), 0, 0 ])
        bolt();
        translate([ 0, ( boxPostsDistanceY / -2 ), 0 ])
        bolt();
      }

    }

  color("red")
  translate([0,0,-0])
  union() {
      for( a = [-1,1] ) {
        for( b = [-1,1] ) {
          translate([piOffsetX, -piOffsetY, 0])
          translate([ a * raspberrypiHoleX/2 , b * raspberrypiHoleY/2 , 0 ])
          linear_extrude( 9.4 )
          circle( d = 2.75, $fn = 20 );
        }
      }
      for( a = [-1,1] ) {
        for( b = [-1,1] ) {
          translate([piOffsetX, -piOffsetY, 9.4 ])
          translate([ a * raspberrypiHoleX/2 , b * raspberrypiHoleY/2 , 0 ])
          difference() {
            union() {
              linear_extrude( 3 )
              circle( d = 5.5, $fn = 20 );
            }
            translate([0,0,1.9])
            linear_extrude( 3 )
            circle( d = 3, $fn = 6 );
          }
        }
      }
  }
}

/* loop through inverse and direct positions for the stand offs */
for( a = [-1,1] ) {
  for( b = [-1,1] ) {

    /* position the stand offs */
    translate([piOffsetX, -piOffsetY, 0])
    translate([ a * raspberrypiHoleX/2 , b * raspberrypiHoleY/2 ,standOffBoardHeight ])
    linear_extrude( raspberrypiStandOffHeight )
    difference() {
      /*circle( d = 6.5, $fn = 20 );*/
      /*circle( d = 3.9, $fn = 20 );*/
      circle( d = 7, $fn = 50 );
      circle( d = 5, $fn = 50 );
    }

  }
}
