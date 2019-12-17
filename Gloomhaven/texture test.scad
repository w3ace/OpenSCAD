/*
 * Texture Fun - hexagon Dungeon Tiles
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

$fn=15;


crack_width = 1;



x=20; y=20;
translate ([x,-y,0])
	water_arc (x,y,10,2,90);
translate([120,0])
rotate ([0,0,180])
	translate ([40,-y,0])
		water_arc (40,y,10,2,40);

/*		for (i = [5:10]) {
			x = rands(1,10,1)[0];
			y = rands(i*3-2,i*3+4,1)[0];
				elipse_arch(x,y);
		}
*/

module water_arc (x,y,angle,width,mx) {

	echo(x,y,angle,width,mx);
	if(angle < mx) {
	  rotate([0,0,angle])
			translate([x,y,0])
				rotate([0,0,180-atan(x/y)])
					scale([5,(width>3)?3:(width<-3)?-3:width,(width>3)?3:(width<-3)?-3:width])
						sphere(r=1);

		water_arc(x,y,angle+2,width+rands(0,1,1)[0]-.5,mx);
	}
}

module elipse_arch (x,y) {

	angle = rands(1,360,2);

	for(i=[angle[0]:3:angle[1]]) {

		ext = rands(1,4,1)[0]-2;

	  rotate([0,0,i])
			translate([x,y,0])
				rotate([0,0,cos(x/y)])
					scale([5,ext,ext])
						sphere(r=crack_width);
			}
}


module water_curve (x,y) {

	s = rands(1,20,1)[0];
	x1 = rands(1,5,1)[0];
	y1 = (rands(1,9,1)[0]-4.5)/3;

	if (x<37 ) {
		water_curve(x+x1,y+y1);
	}

	if(s<14) {
	translate([x,y,0])
		rotate_extrude(angle=90,convexity=1)
		rotate([1,1,atan(y1/x1)])
		scale ([sqrt((x1*x1)+(y1*y1))*.8,1,s/18])
			sphere(r=crack_width);
		}

}

module water_maker (x,y) {	

	s = rands(1,20,1)[0];
	x1 = rands(1,5,1)[0];
	y1 = (rands(1,9,1)[0]-4.5)/3;

	if (x<37 ) {
		water_maker(x+x1,y+y1);
	}

	if(s<14) {
	translate([x,y,0])
		rotate([1,1,atan(y1/x1)])
		scale ([sqrt((x1*x1)+(y1*y1))*.8,1,s/18])
			sphere(r=crack_width);
		}

}
