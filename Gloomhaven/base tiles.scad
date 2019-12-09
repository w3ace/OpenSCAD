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



// basehex(3.8,[0,60,120,180,240,300],"cracks");

twoRow(1, 3.8, texture="cracks");
//threeRowEqual(2, 3.8, texture="cracks");

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


module threeRowEqual(size,baseheight=3.8,texture="") {

	union() {

		// First Row is has 'size' hexes
		for(i=[1:size-1]) {
			translate([cle*i-(cle/2),0,0])
				if(i==1) {
					basehex(baseheight,[180,240,300],texture);
				} else {
					basehex(baseheight,[240,300],texture);
				}
		}
		translate([cle*size-(cle/2),0,0])
			basehex(baseheight,[0,240,300],texture);				

		// Middle row is one larger than 'size'
		for(i=[1:size-1]) {
			translate([cle*i,hexheight*.75,0])
				if(i==0) {
					basehex(baseheight,[180],texture);
				} else {
					basehex(baseheight,[],texture);
				}
		}
		translate([cle*size,hexheight*.75,0])
			basehex(baseheight,[0,60,300],texture);			

		// Last row is 'size'
		for(i=[1:size-1]) {
			translate([cle*i-(cle/2),(hexheight*1.5),0])
				if(i==1) {
					basehex(baseheight,[60,120,180],texture);
				} else {
					basehex(baseheight,[60,120],texture);
				}
		}
		translate([cle*size-(cle/2),(hexheight*1.5),0])
			basehex(baseheight,[0,60,120],texture);				
	}
}

//
// threeRowHex() This module will produce three rows of hexes with the middle row being one larger 
// 						than the first and last  
//    size - the number of hexes in the smaller row - Larger row will have one more.
//		baseheight - height of the tile without the texture.
//		texture - reference to an STL file that needs to conform to requirements to be 
//							placed on top of each hex.


module threeRowHex(size,baseheight=3.8,texture="") {

	union() {

		// First Row is has 'size' hexes
		for(i=[1:size-1]) {
			translate([cle*i-(cle/2),0,0])
				if(i==1) {
					basehex(baseheight,[180,240,300],texture);
				} else {
					basehex(baseheight,[240,300],texture);
				}
		}
		translate([cle*size-(cle/2),0,0])
			basehex(baseheight,[0,240,300],texture);				

		// Middle row is one larger than 'size'
		for(i=[0:size-1]) {
			translate([cle*i,hexheight*.75,0])
				if(i==0) {
					basehex(baseheight,[120,180,240],texture);
				} else {
					basehex(baseheight,[],texture);
				}
		}
		translate([cle*size,hexheight*.75,0])
			basehex(baseheight,[0,60,300],texture);			

		// Last row is 'size'
		for(i=[1:size-1]) {
			translate([cle*i-(cle/2),(hexheight*1.5),0])
				if(i==1) {
					basehex(baseheight,[60,120,180],texture);
				} else {
					basehex(baseheight,[60,120],texture);
				}
		}
		translate([cle*size-(cle/2),(hexheight*1.5),0])
			basehex(baseheight,[0,60,120],texture);				
	}
}


//
// twoRow() This module will produce two rows of offset hexes.  
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
		if(size > 2)	{		
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
		translate([cle*size-(cle/2),(hexheight*.75),0])
			basehex(baseheight,[0,60,120,180],texture);		 
	}
}

//
// oneRow() This module will produce one row of Hexes
//    size - the number of hexes in the smaller row - Larger row will have one more.
//		baseheight - height of the tile without the texture.
//		texture - reference to an STL file that needs to conform to requirements to be 
//							placed on top of each hex.


module oneRow(size,baseheight=3.8,texture="") {

	union() {
		for(i=[0:size-1]) {
			translate([cle*i,0,0])
				if(i==0) {
					basehex(baseheight,[60,120,180,240,300],texture);
				} else {
					basehex(baseheight,[60,120,240,300],texture);
				}
		}
		translate([cle*size,0,0])
			basehex(baseheight,[0,60,120,240,300],texture);		
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

	 difference () {
		union() {
			hull() {
				translate([0,0,(baseheight/2)])
					Hexagon(cle=cle-.6,h=baseheight);
				translate([0,0,baseheight/2+.4])
					Hexagon(cle=cle,h=baseheight-.8);
				} 
			
			// Apply Texture or smooth terrain
			if( texture != "" && texture != "cracks") {
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
		connector_cutouts(10,connectors);
		if( texture == "cracks") {
			minkowski() {
				r1 = rands(0,5,1);
					rotate([0,0,(r1[0]*60)])
						translate([-20,-20,baseheight])
							crack_maker(0,0,3,2.5,40,40,1,0);
						cube(size=.5);
				}
		} else {
			if( texture != "") {
				translate ([-20,-20,baseheight+1.2])
					scale ([.5,.5,.5])
				       import (texture, convexity=10);
			}
		}
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


module BaseTerrainMaker (baseheight=2.8, connectors=[0:60:300], texture="") {

	cle = 33;

		union() {
			hull() {
				translate([0,0,(baseheight+.4)/2])
					Hexagon(cle=cle-1,h=baseheight+.4);
				translate([0,0,(baseheight+1)/2])
					Hexagon(cle=cle-4,h=baseheight+1);
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

module crack_maker (x=0,y=0,x_len=3,y_len=3,x_total_length=30,y_total_length=30,crack_width=.5,i=0) {

    x1 = rands((x_len>0 ? x : x+x_len),
                (x_len>0 ? x+x_len : x),1);
    y1 = rands((y_len>0 ? y : y+y_len),
                (y_len>0 ? y+y_len : y),1);

    branch = rands(1,100,1);
   if(branch[0]<5 && i==0) { 
              crack_maker (x,y,x_len,-y_len,x_total_length,y_total_length,crack_width,1);
    }
    if(branch[0]>95 && i==0) { 
              crack_maker (x,y,-x_len,y_len,x_total_length,y_total_length,crack_width,1);
    }

    linear_extrude(1)
        polygon(points=[[x,y],[x,y-crack_width],[x1[0],y1[0]-crack_width],[x1[0],y1[0]]]);

    if(x1[0] < x_total_length && y1[0] < y_total_length && y1[0] > 0 && x1[0]> 0) {
  
         crack_maker(x1[0],y1[0],x_len,y_len,x_total_length,y_total_length,crack_width,i);
     }
}
