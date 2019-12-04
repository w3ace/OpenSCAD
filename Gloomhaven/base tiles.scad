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


$fn = 25 ;			// OpenSCAD Resolution


// These need to stay in sync from hex tile to connector !! 
// Use slop to try and adjust one or the other

connector_center = 3.4;
connector_diameter = 2.6;



baseheight=3.6;
cle = 33;
hexheight=38.11;




// TwoRow(2,5.2,"");
intersection() {
basehex(baseheight=3.8,connectors=[0,60,120,180,240,300],texture="");
translate([-20,20,-3])
	scale([40,40,18])
	import("Wooden Planks.stl", convexity=10);
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

module TwoRow(size,baseheight=3.8,texture="") {

	union() {
		for(i=[0:size-1]) {
			translate([cle*i,0,0])
				if(i==0) {
					basehex(baseheight=3.8,connectors=[120,180,240,300],texture="");
				} else {
					basehex(baseheight=3.8,connectors=[240,300],texture="");
				}
		}
		translate([cle*size,0,0])
			basehex(baseheight=3.8,connectors=[0,60,240,300],texture="");			
		for(i=[1:size-1]) {
			translate([cle*i-(cle/2),(hexheight*.75),0])
				if(i==1) {
					basehex(baseheight=3.8,connectors=[60,120,180],texture="");
				} else {
					basehex(baseheight=3.8,connectors=[60,120],texture="");
				}
		}
		translate([cle*size-(cle/2),(hexheight*.75),0])
			basehex(baseheight=3.8,connectors=[0,60,120],texture="");				
		 
	}
}

//
// module connector()
//
//


module connector(center=3.4,diameter=3) {

	height = 1.8;
	shaft_length = 6;
	slop = 0.4;

					union () {
						for(i=[0:1]) {
						intersection () {
							translate([(center*2+shaft_length)*i,0,1])
							rotate_extrude(convexity=10)
								translate ([center,0,0])
									circle (d=diameter-slop);
								linear_extrude(height)
									translate ([-10+(center*2+shaft_length)*i,-10,0])
										square(size=20);
									}
								}

						linear_extrude(1.8)
							translate([center,(-diameter+slop)/2,0])
								square([shaft_length,diameter-slop]);
					}	
}

module basehex (baseheight=2.8, connectors=[0:60:300], texture="") {

	cle = 33;
//	baseheight = 2.8;

	difference () {
		union() {
/*			hull() {
				translate([0,0,(baseheight/2)])
					Hexagon(cle=cle-.6,h=baseheight);
				translate([0,0,baseheight/2+.4])
					Hexagon(cle=cle,h=baseheight-.8);
				} */
			hull() {
				translate([0,0,(baseheight+.4)/2])
					Hexagon(cle=cle-1,h=baseheight+.4);
				translate([0,0,(baseheight+1)/2])
					Hexagon(cle=cle-4,h=baseheight+1);
			} 
		}
	//	connector_cutouts(10,connectors);
	//	if( texture != "") {
//			translate ([-20,-20,baseheight+1.2])
	//			scale ([.5,.5,.5])
	//		       import (texture, convexity=10);
	//	}
	} 
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