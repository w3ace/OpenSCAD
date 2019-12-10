/*
 * Base Tiles - Hexagon Dungeon Tiles
 * By Craig Wood
 *
 *    ▄▄▄█████▓ ██░ ██  ██▓ ███▄    █    ▓█████▄  █    ██  ███▄    █   ▄████ ▓█████  ▒█████   ███▄    █ 
 *    ▓  ██▒ ▓▒▓██░ ██▒▓██▒ ██ ▀█   █    ▒██▀ ██▌ ██  ▓██▒ ██ ▀█   █  ██▒ ▀█▒▓█   ▀ ▒██▒  ██▒ ██ ▀█   █ 
 *    ▒ ▓██░ ▒░▒██▀▀██░▒██▒▓██  ▀█ ██▒   ░██   █▌▓██  ▒██░▓██  ▀█ ██▒▒██░▄▄▄░▒███   ▒██░  ██▒▓██  ▀█ ██▒
 *    ░ ▓██▓ ░ ░▓█ ░██ ░██░▓██▒  ▐▌██▒   ░▓█▄   ▌▓▓█  ░██░▓██▒  ▐▌██▒░▓█  ██▓▒▓█  ▄ ▒██   ██░▓██▒  ▐▌██▒
 *      ▒██▒ ░ ░▓█▒░██▓░██░▒██░   ▓██░   ░▒████▓ ▒▒█████▓ ▒██░   ▓██░░▒▓███▀▒░▒████▒░ ████▓▒░▒██░   ▓██░
 *      ▒ ░░    ▒ ░░▒░▒░▓  ░ ▒░   ▒ ▒     ▒▒▓  ▒ ░▒▓▒ ▒ ▒ ░ ▒░   ▒ ▒  ░▒   ▒ ░░ ▒░ ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒ 
 *        ░     ▒ ░▒░ ░ ▒ ░░ ░░   ░ ▒░    ░ ▒  ▒ ░░▒░ ░ ░ ░ ░░   ░ ▒░  ░   ░  ░ ░  ░  ░ ▒ ▒░ ░ ░░   ░ ▒░
 *      ░       ░  ░░ ░ ▒ ░   ░   ░ ░     ░ ░  ░  ░░░ ░ ░    ░   ░ ░ ░ ░   ░    ░   ░ ░ ░ ▒     ░   ░ ░ 
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

//  ██╗ ███╗   ██╗ ██╗ ████████╗     ██╗  ██╗ 
//  ██║ ████╗  ██║ ██║ ╚══██╔══╝    ██╔╝  ╚██╗
//  ██║ ██╔██╗ ██║ ██║    ██║       ██║    ██║
//  ██║ ██║╚██╗██║ ██║    ██║       ██║    ██║
//  ██║ ██║ ╚████║ ██║    ██║       ╚██╗  ██╔╝
//  ╚═╝ ╚═╝  ╚═══╝ ╚═╝    ╚═╝        ╚═╝  ╚═╝ 
//                                       

$fn = 25 ;			// OpenSCAD Resolution

// These need to stay in sync from hex tile to connector !! 
// Use slop to try and adjust one or the other

connector_center = 3.4;
connector_diameter = 2.6;

supports = 1;

// Hex Sizes

baseheight=2.4;  	// Produces a 4mm tile 
cle = 33;					// 33mm per side for Gloomhaven Tiles
hexheight=38.11;	// Calculated Size of Gloomhaven Tile height for postiioning on hex plates


//color("Red")
//	connector(slop=1);

	//basehex(baseheight,[0,60,120,180,240,300],"cracks");
//	oneRow (2,baseheight,"cracks");
	twoRow (2,baseheight,"cracks");
	//threeRow (3,baseheight,"cracks",0);


//  ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
//  ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
//  █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
//  ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
//  ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
//  ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
//                                                                            


function invector (value,vector,i=0) = 
	(value==vector[i] ? 1 : (i==len(vector) ? 0 : 0 + invector(value,vector,i+1))); 

function cot(x)=1/tan(x);



//  ██╗  ██╗███████╗██╗  ██╗    ██████╗ ██╗      █████╗ ████████╗███████╗███████╗
//  ██║  ██║██╔════╝╚██╗██╔╝    ██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝██╔════╝
//  ███████║█████╗   ╚███╔╝     ██████╔╝██║     ███████║   ██║   █████╗  ███████╗
//  ██╔══██║██╔══╝   ██╔██╗     ██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝  ╚════██║
//  ██║  ██║███████╗██╔╝ ██╗    ██║     ███████╗██║  ██║   ██║   ███████╗███████║
//  ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝
//                                                                               

//
// oneRow() This module will produce one row of Hexes
//
//    size - the number of hexes in the smaller row - Larger row will have one more.
//		baseheight - height of the tile without the texture.
//		texture - reference to an STL file that needs to conform to requirements to be 
//							placed on top of each hex.

module oneRow(size,baseheight=3.8,texture="") {


	if(size>1) {
		union() {
			for(i=[0:size-2]) {
				translate([cle*i,0,0])
					if(i==0) {
						basehex(baseheight,[60,120,180,240,300],texture);
					} else {
						basehex(baseheight,[60,120,240,300],texture);
					}
			}
			translate([cle*(size-1),0,0])
				basehex(baseheight,[0,60,120,240,300],texture);		
		}
	}
}

//
// twoRow() This module will produce two rows of offset hexes.  
//
//    size - the number of hexes in the smaller row - Larger row will have one more.
//		baseheight - height of the tile without the texture.
//		texture - reference to an STL file that needs to conform to requirements to be 
//							placed on top of each hex.

module twoRow(size=2,baseheight=3.8,texture="") {

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
		if(size > 1)	{		
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
		}	else {
			translate([cle*size-(cle/2),(hexheight*.75),0])
				basehex(baseheight,[0,60,120,180],texture);		 
		}
	}
}

//
// threeRow() This module will produce three rows of hexes 
//
//    size - the number of hexes in the smaller row - Larger row will have one more.
//		baseheight - height of the tile without the texture.
//		texture - reference to an STL file that needs to conform to requirements to be 
//							placed on top of each hex.
//		midrow - [0:1] This determines the starting position of the middle row. 

module threeRow(size,baseheight=3.8,texture="",midrow=0) {

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
		for(i=[midrow:size-1]) {
			translate([cle*i,hexheight*.75,0])
				if(i==0) {
					basehex(baseheight,(midrow==0) ? [120,180,240] : [180],texture);
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


//  ██████╗  █████╗ ███████╗███████╗    ██╗  ██╗███████╗██╗  ██╗
//  ██╔══██╗██╔══██╗██╔════╝██╔════╝    ██║  ██║██╔════╝╚██╗██╔╝
//  ██████╔╝███████║███████╗█████╗      ███████║█████╗   ╚███╔╝ 
//  ██╔══██╗██╔══██║╚════██║██╔══╝      ██╔══██║██╔══╝   ██╔██╗ 
//  ██████╔╝██║  ██║███████║███████╗    ██║  ██║███████╗██╔╝ ██╗
//  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
//                                                              


module basehex (baseheight=2.8, connectors=[0:60:300], texture="") {

	cle = 33;

	union () {
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
						translate([0,0,(baseheight+.6)/2])
							Hexagon(cle=cle-1,h=baseheight+.6);
						translate([0,0,(baseheight+1.6)/2])
							Hexagon(cle=cle-4,h=baseheight+1.6);


					}
				}



			}
			connector_cutouts(10,connectors);
			if( texture == "cracks") {
				minkowski() {
					r1 = rands(0,5,1);
						rotate([0,0,(r1[0]*60)])
							translate([-20,-20,baseheight+.6])
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


		// First Layer Tie Downs

		if (supports == 1) {
			linear_extrude(.2)
				difference() {
					circle(r=11);
					circle(r=10.4);
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
}


//   ██████╗ ██████╗ ███╗   ██╗███╗   ██╗███████╗ ██████╗████████╗ ██████╗ ██████╗ ███████╗
//  ██╔════╝██╔═══██╗████╗  ██║████╗  ██║██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝
//  ██║     ██║   ██║██╔██╗ ██║██╔██╗ ██║█████╗  ██║        ██║   ██║   ██║██████╔╝███████╗
//  ██║     ██║   ██║██║╚██╗██║██║╚██╗██║██╔══╝  ██║        ██║   ██║   ██║██╔══██╗╚════██║
//  ╚██████╗╚██████╔╝██║ ╚████║██║ ╚████║███████╗╚██████╗   ██║   ╚██████╔╝██║  ██║███████║
//   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝
//                                                                                         

//
// module connector()
//
//



module connector(center=3.4,diameter=3,slop=0.6) {

	height = 1.8;
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
				linear_extrude(height+.2)
					translate ([-10+(center*2+shaft_length)*i,-10,0])
						square(size=20);
			}
		}

		// Shaft Here
		union () {
			linear_extrude(height-slop/2)
				translate([center,(-diameter+slop)/2,0])
					square([shaft_length,diameter-slop/2-.4]);
				}
	}	
}

//  Cutouts

module connector_cutouts (size,connectors) {

	diameter = 3;
	center = 3.4;

		// Loop through the size sides of the Hexagon and if it is a parameterized
		// connector location than build the cutout, otherwise use a dimple

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
								linear_extrude(1.8)
									translate([diameter,-1.6,0])
										square([4,3.2]);
						}

			} else {

				// Dimple instead of connector
				rotate([0,0,i])
					translate([10,0,0])
						scale([1.8,1.8,.4])
							sphere (r = baseheight-.5);
			}
		}

		// Center Dimple
		translate([0,0,0])
			scale([1.8,1.8,.4])
				sphere (r = baseheight-.5);
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



//  ████████╗███████╗██████╗ ██████╗  █████╗ ██╗███╗   ██╗
//  ╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██║████╗  ██║
//     ██║   █████╗  ██████╔╝██████╔╝███████║██║██╔██╗ ██║
//     ██║   ██╔══╝  ██╔══██╗██╔══██╗██╔══██║██║██║╚██╗██║
//     ██║   ███████╗██║  ██║██║  ██║██║  ██║██║██║ ╚████║
//     ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝
//                                                        

// Module crack_maker creates random channels in the top of a hex. This is recursive and only allows 
//		one level of branching

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

