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

baseheight=2.4;  	// Produces a 4mm tile 
cle = 33;					// 33mm per side for Gloomhaven Tiles
hexheight=38.11;	// Calculated Size of Gloomhaven Tile height for postiioning on hex plates

//import("Water Tile Top Take 1.stl");


innerhex = 8;
x_wobble = 1;
y_wobble = 1;

row = [
	for(j=[0:6])
	for (i=[0:6]) 
		[(j%2==0) ? i*innerhex+rands(0,x_wobble,1)[0]:(innerhex/2)+i*innerhex+rands(0,x_wobble,1)[0],
			j*cot(innerhex)+rands(0,y_wobble,1)[0],0]
	];
echo (row);

for(i=[0:48]) {
	translate (row[i]) {
		hexagon(8,2);
		translate([0,0,2])
			color("Red")
				sphere(0.5);
			}
}

for(i=[0:34]) {
	echo (row[i],row[i+14]);
	translate([row[i][0]+(row[i+14][0]-row[i][0])/3,
		row[i][1]+(row[i+14][1]-row[i][1])/3,2])
	color("Blue")
		sphere(0.5);
	translate([row[i][0]+(row[i+8][0]-row[i][0])/3,
		row[i][1]+(row[i+8][1]-row[i][1])/3,2])
	color("Green")
		sphere(0.5);
}


module random_hex () {
	innerhex = 8;

	intersection() {
		translate([16.5,16.5,3])
			hexagon(33,6);
		union () {
			translate([10,-10,0])	
			rotate([0,0,40])
			for (i=[0:6]) {
				for(j=[0:6]) {
					height = rands(0,1,1)[0];
						translate([(j%2==0)?i*innerhex:(innerhex/2)+i*innerhex,j*cot(innerhex),height/2])		
							wobble_hexagon(8,height,0.5);

				}
			}
		}
	}
}

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


module wobble_hexagon(cle,h,wobble)
{
	angle = 360/6;		// 6 pans
	cote = cle * cot(angle);

	scale([1+rands(0,wobble,1)[0],1,1])
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

