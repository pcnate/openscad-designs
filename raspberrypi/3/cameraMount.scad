cameraBoardFromBoxWall = 10;

mountDepth = 3;

headerX = 22;
headerY = 6;
headerZ = 3;

cameraBoardX = 25;
cameraBoardY = 24;
cameraBoardZ = 1;
cameraBoardHoleDiameter = 2;

/*cameraHole = 15;*/
cameraHole = 19;

cameraModuleOffsetY = 2.75;

cameraLensDiameter = 14;
cameraLensHeight = 20;

translate([0,0,( cameraBoardFromBoxWall  - 1 )])
mirror([0,0,1]) {

  translate([0,-cameraModuleOffsetY,0])
  %union() {
    linear_extrude( cameraBoardZ ) {
      difference() {
        square([cameraBoardX,cameraBoardY], center = true);

        union() {
          for( i = [-1,1]) {

            /* upper holes */
            translate([ ( cameraBoardX/2 - cameraBoardHoleDiameter/2 - 1 ) * i, ( cameraBoardY/2 - cameraBoardHoleDiameter/2 - 1 ) ])
            circle( d = cameraBoardHoleDiameter, center = true, $fn = 20 );

            /* lower holes */
            translate([ ( cameraBoardX/2 - cameraBoardHoleDiameter/2 - 1 ) * i, ( cameraBoardY/2 - cameraBoardHoleDiameter/2 - 7.5 ) * -1 ])
            circle( d = cameraBoardHoleDiameter, center = true, $fn = 20 );
          }
        }

      }
    }

    /* camera module */
    cameraLowerSquare = 4;
    translate([0,(-13.25/2 + cameraBoardY/2 - cameraModuleOffsetY),cameraBoardZ]) {

      /* lower camera module with screw mounts */
      linear_extrude( cameraLowerSquare )
      union() {
        square(13.25, center = true);
        hull() {
          for( i = [-1,1]) {
            translate([i*18/2,0,0])
            circle( d = 4, $fn = 20 );
          }
        }
      }

      /* round portion of upper camera module */
      translate([0,0,cameraLowerSquare]) {
        rotate_extrude( angle = 360, $fn = 40 ) {
          square([cameraLensDiameter/2,4]);
          translate([0,4,0])
          square([12/2,4]);
          translate([0,8,0])
          square([cameraLensDiameter/2,4]);
        }
      }

    }

    /* screw heads on bottom of camera board */
    translate([0,(-13.25/2 + cameraBoardY/2 - cameraModuleOffsetY),-1])
    linear_extrude( 1 )
    for( i = [-1,1]) {
      translate([i*18/2,0,0])
      circle( d = 3, $fn = 20 );
    }

    /* cable header */
    translate([0,-(cameraBoardY/2-headerY/2),cameraBoardZ+headerZ/2 ])
    cube([headerX,headerY,headerZ], center = true);

    /* box to mount to with camera sticking through */
    translate([0,cameraModuleOffsetY,cameraBoardFromBoxWall-1])
    linear_extrude( 3 ) {
      difference() {
        square(size=[cameraBoardX*2,cameraBoardY*2], center=true);
        circle(d=cameraHole, center = true, $fn = 20 );
      }
    }

  }

  mountWidth = 3;
  mountLength = 17.5;
  translate([0,-cameraModuleOffsetY,cameraBoardZ])
  union() {
    translate([0,cameraModuleOffsetY, ( cameraBoardFromBoxWall - cameraBoardZ - mountDepth - 1 )])
    linear_extrude( mountDepth ) {
      difference() {
        union() {
          /*square(size=[cameraBoardX*2,cameraBoardY + cameraModuleOffsetY*2], center=true);*/

          hull() {
            for( t = [-1,1]) {
              for( i = [-1,1]) {
                translate([i*20,( (cameraBoardY + 5)/2 - 5.5 )*t,0])
                circle( d = 10, $fn = 20, center = true );
              }
            }
          }

        }

        union() {
          circle(d=cameraHole, center = true, $fn = 40 );

          for( t = [-1,1]) {
            for( i = [-1,1]) {
              translate([i*20,( (cameraBoardY + 5)/2 - 5.5 )*t,0])
              circle( d = 4.5, $fn = 20, center = true );
            }
          }

        }
      }
    }

    linear_extrude( cameraBoardFromBoxWall - cameraBoardZ * 2 - mountDepth )
    union() {
      for( i = [-1,1] ) {
        translate([ i * ( cameraBoardX/2 - 1 + mountWidth/2),( cameraBoardY/2 - mountLength/2 ),0])
        square([mountWidth,mountLength - cameraBoardHoleDiameter*2 ], center=true);
      }

      union() {
        for( i = [-1,1]) {

          /* upper holes */
          translate([ ( cameraBoardX/2 - cameraBoardHoleDiameter/2 - 1 ) * i, ( cameraBoardY/2 - cameraBoardHoleDiameter/2 - 1 ) ]) {
            difference() {
              hull() {
                circle( d = cameraBoardHoleDiameter *2, center = true, $fn = 20 );
                translate([i*2,0,0])
                circle( d = cameraBoardHoleDiameter *2, center = true, $fn = 20 );
              }
              circle( d = cameraBoardHoleDiameter, center = true, $fn = 20 );
            }
          }

          /* lower holes */
          translate([ ( cameraBoardX/2 - cameraBoardHoleDiameter/2 - 1 ) * i, ( cameraBoardY/2 - cameraBoardHoleDiameter/2 - 7.5 ) * -1 ]) {
            difference() {
              hull() {
                circle( d = cameraBoardHoleDiameter *2, center = true, $fn = 20 );
                translate([i*2,0,0])
                circle( d = cameraBoardHoleDiameter *2, center = true, $fn = 20 );
              }
              circle( d = cameraBoardHoleDiameter, center = true, $fn = 20 );
            }
          }
        }
      }

    }
  }

} /* end mirror */
