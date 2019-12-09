/*
 * Base Tiles - Hexagon Dungeon Tiles
 * By Craig Wood
 *
 * Copyright 2019 Craig Wood - http://github.com/w3ace
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

 */


$fn = 15;			// OpenSCAD Resolution


// These need to stay in sync from hex tile to connector !! 
// Use slop to try and adjust one or the other

connector_center = 3.4;
connector_diameter = 2.6;




baseheight=3.6;
cle = 33;
hexheight=38.11;

color("Red")
connector(slop=1);

//	translate ([10,0,0])
	//	ball_connector();
	//
	//		basehex(baseheight,[0,60,120,180,240,300],"");


//twoRow(2, 3.8, texture="4 plank dutchmogul terrain.stl");

//woodPlankMaker();

module woodPlankMaker() {
 
	scale([1/cle,1/cle,1/cle])
	translate([0,0,-3.5])
	intersection() {
		BaseTerrainMaker(baseheight=3.8,connectors=[0,60,120,180,240,300],texture="");
		rotate ([0,0,90])
			translate ([-18.9,22,3.5])
				scale([1.5,1.9,1.5])
				import("4 Wood Planks Dutchmogul.stl", convexity=10);
	}
}

// Module for a base tile that is a row of 4 hexes and a row of 5 hexes
function sumv(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));

function invector (value,vector,i=0) = 
	(value==vector[i] ? 1 : (i==len(vector) ? 0 : 0 + invector(value,vector,i+1))); 

//
// TwoRow() This module will produce two rows of offset hexes.  
//    size - the number of hexes in the smaller row - Larger row will have one more.
//		baseheight - height of the tile without the texture.
//		texture - reference to an STL file that needs to conform to requirements to be 
//							placed on top of each hex.


module twoRow(size,baseheight=3.8,texture="") {

	union() {
		for(i=[0:size-1]) {
			translate([cle*i,0,0])
				if(i==0) {
					basehex(baseheight,[120,180,240,300],texture);
				} else {
					basehex(baseheight,[240,300],texture);
				}
		}
		translate([cle*size,0,0])
			basehex(baseheight,[0,60,240,300],texture);			
		for(i=[1:size-1]) {
			translate([cle*i-(cle/2),(hexheight*.75),0])
				if(i==1) {
					basehex(baseheight,[60,120,180],texture);
				} else {
					basehex(baseheight,[60,120],texture);
				}
		}
		translate([cle*size-(cle/2),(hexheight*.75),0])
			basehex(baseheight,[0,60,120],texture);				

	}
}

//
// module connector()
//
//


module ball_connector(center=3.4,diameter=3,slop=0.6,baseheight=3.8,cle=33) {

	shaft_height = 1.8;
	shaft_length = 6+slop/2;
	sphere_x_y = cle/4;  // TODO: this needs to key of CLE for scaling
	union () {

		// Two squashed donuts
		for(i=[0:1]) {
			intersection () {
				translate([(center*2+shaft_length)*i,0,1.6])
					scale([sphere_x_y,sphere_x_y,baseheight*1.2])
						sphere(d=1);
				linear_extrude(baseheight)
					translate ([-10+(center*2+shaft_length)*i,-10,0])
						square(size=20);
			}
		}

		// Shaft Here
		linear_extrude(shaft_height)
			translate([center-1.4,(-diameter+slop)/2,0])
				square([shaft_length*1.4,diameter-slop/2-.4]);
	}	
}


module connector(center=3.4,diameter=3,slop=0.6) {

	height = 2;
	shaft_length = 6+slop/2;


	union () {

		// Two squashed donuts
		for(i=[0:1]) {
			intersection () {
				translate([(center*2+shaft_length)*i,0,1])
					scale([1,1,slop])
					rotate_extrude(convexity=10)
						translate ([center,0,0])
							circle (d=diameter-slop);
				linear_extrude(height)
					translate ([-10+(center*2+shaft_length)*i,-10,0])
						square(size=20);
			}
		}

		// Shart Here
		linear_extrude(height-slop/2)
				translate([center,(-diameter+slop)/2,0])
					square([shaft_length,diameter-slop/2-.4]);
	}	
}

module basehex (baseheight=2.8, connectors=[0:60:300], texture="") {

	cle = 33;

	 difference () {
		union() {
			hull() {
				translate([0,0,(baseheight/2)])
					Hexagon(cle=cle-.6,h=baseheight);
				translate([0,0,baseheight/2+.4])
					Hexagon(cle=cle,h=baseheight-.8);
				} 
			
			// Apply Texture or smooth terrain
			if( texture != "") {
				translate([0,0,baseheight])
					scale([cle,cle,cle])
				    	import (texture);
			} else {
				hull() {
					translate([0,0,(baseheight+.4)/2])
						Hexagon(cle=cle-1,h=baseheight+.4);
					translate([0,0,(baseheight+1)/2])
						Hexagon(cle=cle-4,h=baseheight+1);


				}
			}
		}
		ball_connector_cutouts(10,connectors);
		if( texture != "") {
			translate ([-20,-20,baseheight+1.2])
				scale ([.5,.5,.5])
			       import (texture, convexity=10);
		}
	} 
}


 module ball_connector_cutouts (size,connectors) {

	diameter = 3;	
	ball_xy = cle/3.4;
	ball_z = 4.2;

		for (i=[0:60:300]) {
			if(invector(i,connectors)) {
				rotate([0,0,i])
					translate ([size,0,0])
						union () {
							intersection () {
								translate([0,0,0.8])
									scale([ball_xy,ball_xy,ball_z])
										sphere (d=1);
									linear_extrude(baseheight+0.4)
										translate ([-10,-10,0])
											square(size=20);
							}
							linear_extrude(2.2)
								translate([diameter,-1.6,0])
									square([4,3.2]);
						}
			} else {
				// Dimple
				rotate([0,0,i])
					translate([10,0,0])
						scale([1.4,1.4,1])
							sphere (r = baseheight-.5);
			}

		}
		scale([1.4,1.4,1])
			sphere (r = baseheight-.5);
}


module connector_cutouts (size,connectors) {

	diameter = 3;
	center = 3.4;

		for (i=[0:60:300]) {
			if(invector(i,connectors)) {
				rotate([0,0,i])
					translate ([size,0,0])
						union () {
							intersection () {
								translate([0,0,1])
								rotate_extrude(convexity=10)
									translate ([center,0,0])
										circle (d=diameter);
									linear_extrude(2.6)
										translate ([-10,-10,0])
											square(size=20);
							}
							linear_extrude(2.2)
								translate([diameter,-1.6,0])
									square([4,3.2]);
						}
			} else {
				rotate([0,0,i])
					translate([10,0,0])
						scale([1.4,1.4,1])
							sphere (r = baseheight-.5);
			}

		}
						scale([1.4,1.4,1])
								sphere (r = baseheight-.5);
}

module BaseTerrainMaker (baseheight=2.8, connectors=[0:60:300], texture="") {

	cle = 33;

	difference () {
		union() {
			hull() {
				translate([0,0,(baseheight+.4)/2])
					Hexagon(cle=cle-1,h=baseheight+.4);
				translate([0,0,(baseheight+1)/2])
					Hexagon(cle=cle-4,h=baseheight+1);
			} 
		}
	} 
}


//------------------------------------------------------------
// Hexagone
// cle	écart, ex: clé de 12 alors cle=12
// h		hauteur
//------------------------------------------------------------
module Hexagon(cle,h)
{
	angle = 360/6;		// 6 pans
	cote = cle * cot(angle);

	union()
	{
		rotate([0,0,0])
			cube([cle,cote,h],center=true);
		rotate([0,0,angle])
			cube([cle,cote,h],center=true);
		rotate([0,0,2*angle])
			cube([cle,cote,h],center=true);
	}

// Vérification par un cercle de taille cle
//	#cylinder(r=cle/2,h=2*h,center=true);
//	%circle(r=cote,center=true);
//	#cube([cote,cote,1]);
}

//------------------------------------------------------------
// Fonction cotangente
// Permet d'avoir les bones dimensions
// utiliser $fn n'est pas bon
//------------------------------------------------------------
function cot(x)=1/tan(x);

//==EOF=======================================================