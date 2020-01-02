
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

length = 65;
height = 30;
channel = 5.4;
wallwidth = 3;
supportwidth = 2;

width = channel+wallwidth*2;

cham = 3;


corner_bracket ();


module corner_bracket () {

	difference () {
		// Rotated Corner Bracket
		translate([0,0,-16])
			rotate([45,325,0])
				union () {
					difference () {
						minkowski () {
							frame();
							sphere(d=cham);
						}
						channels();
					}
					supports();
				}
		// Plane Cut Cube to Crop Corner
		translate([0,0,-20])
			cube([60,60,40],center=true);
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
	translate([length/2,0,0])
		rotate([0,270,0])
			cube([length,width,height],center=false);		
		rotate([0,270,270])
			cube([length,width,height],center=false);	
}


module channels () { 

	translate([wallwidth,wallwidth,wallwidth])
		cube([length,channel,length]);
	translate([width,0,0])
		rotate([0,0,90])
			translate([wallwidth,wallwidth,wallwidth])
				cube([length,channel,length]);
	translate([0,0,width])
		rotate([270,0,0])		
			translate([wallwidth,wallwidth,wallwidth])
				cube([length,channel,length]);
	rotate([90,0,90])		
		translate([wallwidth,wallwidth,wallwidth])
			cube([length,channel,length]);
}


module supports () {

	translate([9,0,supportwidth*.7])
		rotate([-45,0,0])
			cube([length-9+cham/2,supportwidth,15]);
	translate([supportwidth*.70,0])
		rotate([45,0,90])	
			translate([9,0,0])
			cube([length-9+cham/2,supportwidth,15]);
	translate([0,supportwidth*.7,0])
		rotate([225,270,0])	
			translate([9,0,0])
			cube([length-9+cham/2,supportwidth,15]);
}
