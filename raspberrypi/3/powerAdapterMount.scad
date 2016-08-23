
powerAdapterWidth = 22;
powerAdapterHeight = 35;
powerAdapterLength = 42;

screwHeadHeight = 3;
screwHeadDiameter = 8;
screwHoleDiameter = 4;

mountThickness = 6;
mountWallThickness = 0.5;


%translate([0,0,powerAdapterHeight/2 + mountThickness])
cube([powerAdapterWidth,powerAdapterLength,powerAdapterHeight], center = true);

linear_extrude( mountThickness - screwHeadHeight )
difference() {
  square(size=[powerAdapterWidth + mountWallThickness,powerAdapterLength + mountWallThickness], center=true);
  circle(d=screwHoleDiameter, center = true, $fn = 30);
}

translate([0,0,mountThickness - screwHeadHeight])
linear_extrude( screwHeadHeight )
difference() {
  square(size=[powerAdapterWidth + mountWallThickness,powerAdapterLength + mountWallThickness], center=true);
  circle(d=screwHeadDiameter, center = true, $fn = 30);
}

translate([0,0,mountThickness])
linear_extrude( powerAdapterHeight )
difference() {
  square(size=[powerAdapterWidth + mountWallThickness,powerAdapterLength + mountWallThickness], center=true);
  union() {
    square(size=[powerAdapterWidth,powerAdapterLength], center=true);
    square(size=[powerAdapterWidth-5,powerAdapterLength+1], center=true);
  }
}

/*translate([0,0, mountThickness + powerAdapterHeight ])*/
/*linear_extrude( mountWallThickness )*/
/*square(size=[powerAdapterWidth + mountWallThickness,powerAdapterLength + mountWallThickness], center=true);*/
