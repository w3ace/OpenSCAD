/*
 * Base Tiles - hexagon Dungeon Tiles
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

// Supports add a thin line that should tie down the first layer of the columns for
// the Cutouts

supports = 1; //[0:1]

// Hex Sizes

baseheight=0;  	// Produces a 4mm tile 
cle = 33;					// 33mm per side for Gloomhaven Tiles
hexheight=38.11;	// Calculated Size of Gloomhaven Tile height for postiioning on hex plates
hexangle = 60;
//import("Water Tile Top Take 1.stl");


texheight = 1;
texsize = 8;
xtiles = 9;
ytiles = 9;
wobble = 1.8;

row = [
	for(j=[0:xtiles]) 
			for (i=[0:ytiles])
				for(c=[0:1])
					hexpoint(j,i,texheight,texsize,wobble,c)
		];


intersection () {
	hull() {
							translate([0,0,(baseheight+.6)/2])
								hexagon(cle=cle-1,h=baseheight+.6);
							translate([0,0,(baseheight+1.6)/2])
								hexagon(cle=cle-4,h=baseheight+1.6);
							}
	translate([-20,-40,0])
		rotate([0,0,20])
			union() {
				for(j=[0:(xtiles-2)])
				 for(i=[1:(ytiles-2)])
					polyFromGrid(row,j,i,wobble);
			}
}

function hexpoint (j=0,i=0,height=1,size=1,wobble=0,c=0) = 
	(c==0)  
		? [hexx(j,i,size)-(size/2)+rands(0,wobble,1)[0],hexy(j,i,size)+rands(0,wobble,1)[0]+(size/2*tan(hexangle/2))] 
		: [hexx(j,i,size)+rands(0,wobble,1)[0],hexy(j,i,size)+rands(0,wobble,1)[0]+(size/2*sec(hexangle/2))];

function hexx (j=0,i=0,size=1) =
	(j%2==0) ? i*size : (size/2)+i*size;

function hexy (j=0,i=0,size=1) = j*size*sin(hexangle);

function hexcenter (j=0,i=0,height=1,size=1,wobble=0) = 
	[(j%2==0) ? i*size+rands(0,wobble,1)[0]:(size/2)+i*size+rands(0,wobble,1)[0],
			j*size*sin(hexangle)+rands(0,wobble,1)[0],0];


module polyFromGrid (hexpts,x,y,wobble) {

	linear_extrude(height=rands(.4,.4+wobble,1)[0])
	polygon ( 		points = [ 
		hexpts[x*(xtiles+1)*2+y*2-((x%2==0)?1:-1)],
		hexpts[x*(xtiles+1)*2+y*2-((x%2==0)?0:0)],
		hexpts[x*(xtiles+1)*2+y*2-((x%2==0)?-1:1)],
			hexpts[(x+1)*(xtiles+1)*2+y*2-((x%2==0)?0:0)],
			hexpts[(x+1)*(xtiles+1)*2+y*2-((x%2==0)?1:-1)],
			hexpts[(x+1)*(xtiles+1)*2+y*2-((x%2==0)?2:-2)]
			]);

}

function sec(x)=1/cos(x);
function cot(x)=1/tan(x);

module hexagon(cle,h)
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

