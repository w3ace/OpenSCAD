/*
 * Christmas Tree Generator
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

height=60;
thickness=3;
slop=.4;

bottom_trunk(height=height, thickness=thickness, slop=slop);
top_trunk(height=height, thickness=thickness, slop=slop);
branch(height=height*.90, vertices=7, x=height*1.35, y=height*.9, thickness=thickness, slop=slop);
branch(height=height*.75, vertices=7, x=height*.7, y=height*2.3, thickness=thickness, slop=slop);
branch(height=height*.6, vertices=6, x=height*1.2, y=height*1.65, thickness=thickness, slop=slop);
branch(height=height*.5, vertices=6, x=height*.65, y=height*1.7, thickness=thickness, slop=slop);
branch(height=height*.4, vertices=5, x=height*1.25, y=height*2.15, thickness=thickness, slop=slop);

// Variance for the branch polygons 

function variance (height) = rands(-height,height,1)[0]/10;

// Make trunk pieces

module bottom_trunk (height=66, thickness=2, slop=.4)
{
	x = height/2;
	y = height/2;


	difference()
	{
		linear_extrude (height=thickness)
		{
			polygon(points=[
				[x,y],
				[x+height/3,y],
				[x+height/6,y+height]
			]);
		}
		translate([x+height/6,y+height*3/4,thickness/2])
			cube([thickness+slop/2,height/2,thickness],true);
	}
}
	// Trunk with Bottom Slot

module top_trunk (height=66, thickness=2,slop=.4)
{

	x = height*1.6;
	y = height*1.6;

	difference()
	{
		linear_extrude (height=thickness)
		{
			polygon(points=[
				[x,y],
				[x-height/6,y+height],
				[x+height/6,y+height]
			]);
		}
		translate([x,y+height*3/4,thickness/2])
			cube([thickness+slop/2,height/2,thickness],true);
	}
}

// Module to create a horizontal branch

module branch (height=80, vertices=7, x=0, y=0, thickness=2,slop=.4)
{
	p = rands(vertices,vertices+4,1)[0];

	// Put branch in proper location 
	translate ([x,y,0])
	{
		difference() 
		{
			// Random number of branches
			for(i=[360/p:375/p:390]) 
			{
				rotate([0,0,i])
				difference()
				{
					linear_extrude (height=thickness)
						{
						polygon(points=[
						 	[-(height/5)+variance(height/1.5),(height/5)+variance(height/1.5)],	
							[(height/5)+variance(height/1.5),-(height/5)+variance(height/1.5)],
						 	[(height/3)+variance(height/4),(height/3)+variance(height/4)]
						]);
						} 

					// Clip the corners of the Triangle if the get too divergent... no idea why I need this rotate.
					rotate([0,0,315])
						union()
							{
								translate([-height/2.8,height/8.5,thickness/2])
								cube([height/3,height/2.5,thickness],true);
								translate([height/2.8,height/8.5,thickness/2])
								cube([height/3,height/2.5,thickness],true);
							}
				}
			}

			// Trunk Slot
			rotate ([0,0,rands(1,90,1)[0]])
			translate([0,0,thickness/2])
			union ()
			{
				cube([thickness+slop,height/3.1,thickness],true);
				rotate([0,0,90])
					cube([thickness+slop,height/3.1,thickness],true);				
			}
		}
	}
}