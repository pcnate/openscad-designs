
boxPostsDistance = 89;

raspberrypiHoleWidth = 58;
raspberrypiHoleHeight = 49;

raspberrypiStandOffHeight = 5;

standOffBoardHeight = 3;

cornerRadius = 8;

linear_extrude( standOffBoardHeight ) {

  /* support board wings */
  for( a = [-1,0,1] ) {
    for( b = [-1,0,1] ) {
      if( a != b && a != b*-1 ) {
        difference() {
          translate([ ( ( a * ( boxPostsDistance/4 + 17 ) ) ), ( ( b * ( boxPostsDistance/4 + 17 ) ) ),0])
          square( [ ( a != 0 ? boxPostsDistance/4 - 2 : 10 ) , ( b != 0 ? boxPostsDistance/4 - 2 : 10 )  ], center = true );

          translate([ a * ( boxPostsDistance / 2 ), b * ( boxPostsDistance / 2 ), 0 ])
          circle( d = 3.9, $fn = 20 );
        }
      }
    }
  }


  /* central support board */
  /*union() {*/
  difference() {

    square( [ raspberrypiHoleWidth+10, raspberrypiHoleHeight+10 ], center = true);

    union() {
      difference() {
        square( [ raspberrypiHoleWidth-5, raspberrypiHoleHeight-5 ], center = true);
        union() {
          for( a = [-1,1] ) {
            for( b = [-1,1] ) {

              union() {

                translate( [ ( a * ( raspberrypiHoleWidth/2 - cornerRadius-2.5 ) ), ( b * ( raspberrypiHoleHeight/2 - cornerRadius-2.5 ) ), 0 ] )

                difference() {
                  translate([ a * cornerRadius/2, b * cornerRadius/2,0])
                  square( [cornerRadius,cornerRadius], center = true );
                  circle( cornerRadius, center = true );
                }

              }

            }
          }

        }
      }

      for( a = [-1,1] ) {
        for( b = [-1,1] ) {
          translate([ a * raspberrypiHoleWidth/2 , b * raspberrypiHoleHeight/2 , 0 ])
          circle( d = 3.9, $fn = 20 );
        }
      }

    }

  }

}

/* loop through inverse and direct positions for the stand offs */
for( a = [-1,1] ) {
  for( b = [-1,1] ) {

    /* position the stand offs */
    translate([ a * raspberrypiHoleWidth/2 , b * raspberrypiHoleHeight/2 ,standOffBoardHeight ])
    linear_extrude( raspberrypiStandOffHeight )
    difference() {
      circle( d = 6.5, $fn = 20 );
      circle( d = 3.9, $fn = 20 );
    }

  }
}
