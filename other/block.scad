//the duplo itself
// parameters are: 
// width: 1 =standard 4x4 duplo with.
// length: 1= standard 4x4 duplo length
// height: 1= minimal duplo height
// nibbles: true or false
 
 
module duplo(width,length,height,nibbles) 
{
	//size definitions
 
	ns = 8.4;  //nibble start offset
	no = 6.53; //nibbleoffset
	nbo = 16; // nibble bottom offset
 
	duplowidth = 31.66;
	duplolength=31.66;
	duploheight=9.6;
	duplowall = 1.55;	
 
 
	//the cube
	difference() {
		cube([width*duplowidth,length*duplolength,height*duploheight],true);
		translate([0,0,-duplowall]) 	
			cube([width*duplowidth - 2*duplowall,length*duplolength-2*duplowall,height*duploheight],true);
	}
 
	//nibbles on top
         if  (nibbles)
     	   {
	    	for(j=[1:length])
		{
			for (i = [1:width])
			{
				translate([i*ns+(i-1)*no,j*ns+(j-1)*no,6.9+(height-1)*duploheight/2]) duplonibble();
				translate([i*-ns+(i-1)*-no,j*ns+(j-1)*no,6.9+(height-1)*duploheight/2]) duplonibble();
				translate([i*ns+(i-1)*no,j*-ns+(j-1)*-no,6.9+(height-1)*duploheight/2]) duplonibble();
				translate([i*-ns+(i-1)*-no,j*-ns+(j-1)*-no,6.9+(height-1)*duploheight/2]) duplonibble();
			}
		}
	        }
 
	//nibble bottom
	for(j=[1:length])
	{
		for (i = [1:width])
		{
			translate([(i-1)*nbo,(j-1)*nbo,0]) duplobottomnibble(height*duploheight);
			translate([(i-1)*-nbo,(j-1)*-nbo,0]) duplobottomnibble(height*duploheight);
			translate([(i-1)*-nbo,(j-1)*nbo,0]) duplobottomnibble(height*duploheight);
			translate([(i-1)*nbo,(j-1)*-nbo,0]) duplobottomnibble(height*duploheight);
		}
	}
	//little walls inside[http://www.thingiverse.com/Domonoky Domonoky]
	difference() 
	{
		union()
	 	{
			for(j=[1:length])
			{	
				for (i = [1:width])
				{
					translate([0,j*ns+(j-1)*no,0 ]) cube([width*duplowidth,1.35,height*duploheight],true);
					translate([0,j*-ns+(j-1)*-no,0 ]) cube([width*duplowidth,1.35,height*duploheight],true);
					translate([i*ns+(i-1)*no,0,0 ]) cube([1.35,length*duplolength,,height*duploheight],true);
					translate([i*-ns+(i-1)*-no,0,0 ]) cube([1.35,length*duplolength,height*duploheight],true);
				}
			}
		}
		cube([width*duplowidth - 4*duplowall,length*duplolength-4*duplowall,height*duploheight+2],true);
	}
}
 
 
module duplonibble()
{
	difference() {
		cylinder(r=4.7,h=4.5,center=true,$fs = 0.01);
		cylinder(r=3.4,h=5.5,center=true,$fs = 0.01);
	}
}
 
module duplobottomnibble(height)
{
	difference() {
		cylinder(r=6.6,h=height,center=true,$fs = 0.01);
		cylinder(r=5.3,h=height+1,center=true,$fs = 0.01);
	}
 
}

translate([0,40,0])duplo(2,1,1,true);

duplo(1,1,3,true);
 
