
/*
 * Base Tiles - Parameterized Corners
 *
 * By Craig Wood
 *
 * Copyright 2020 Craig Wood - http://github.com/w3ace
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in thehope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * See <http://www.gnu.org/licenses/>.
 *
*/

$fn=20;

length = 50;
height = 40;
channel = 5.4;
wallwidth = 1.4;
supportwidth = 2;
rotateconstant = 35.26;

width = channel+wallwidth*2;

cham = 3;

										
//		frame();			
corner_bracket ();

module corner_bracket () {


	translate([0,0,-18.5])
		rotate([45,-rotateconstant,0])
			translate([0,-2.565,0])
				difference () {

					// Rotated Corner Bracket
						translate([0,2.565,0])
							union () {
								difference () {
									minkowski () {
										difference() {
											frame();
											rotate([-rotateconstant,45,0])
												cube([80,80,40],center=true);
											translate([36,36,43])
												rotate([-rotateconstant,45,0])
													cube([100,100,40],center=true);
											}
										sphere(d=cham);
									}
									channels();
								}
								supports();
							}

					// Plane Cut Cube to Crop Corner
					rotate([-rotateconstant,45,0])
						cube([80,80,40],center=true);
				}
}


module frame () {
	cube([length,width,height],center=false);
	translate([width,0,0])
		rotate([0,0,90])
			cube([length,width,height],center=false);		
	translate([0,0,width])
		rotate([270,0,0])
			cube([length,width,height],center=false);		
	rotate([90,0,90])
		cube([length,width,height],center=false);	
	translate([0,width,0])
		rotate([0,270,180])
			cube([length,width,height],center=false);		
		rotate([0,270,270])
			cube([length,width,height],center=false);	
}


module channels () { 

	translate([wallwidth,wallwidth,wallwidth])
		cube([length+cham,channel,length+cham]);
	translate([width,0,0])
		rotate([0,0,90])
			translate([wallwidth,wallwidth,wallwidth])
				cube([length+cham,channel,length+cham]);
	translate([0,0,width])
		rotate([270,0,0])		
			translate([wallwidth,wallwidth,wallwidth])
				cube([length+cham,channel,length+cham]);
	rotate([90,0,90])		
		translate([wallwidth,wallwidth,wallwidth])
			cube([length+cham,channel,length+cham]);
}


module supports () {

	translate([9,0,supportwidth*.7])
		rotate([-45,0,0])
			cube([length-9+cham/2,supportwidth,width*1.5]);
	translate([supportwidth*.70,0])
		rotate([45,0,90])	
			translate([9,0,0])
			cube([length-9+cham/2,supportwidth,width*1.5]);
	translate([0,supportwidth*.7,0])
		rotate([225,270,0])	
			translate([9,0,0])
			cube([length-9+cham/2,supportwidth,width*1.5]);
}
