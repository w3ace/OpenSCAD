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

height=66;
thickness=4;

trunk(height=height, thickness=thickness);
branch(height=height*.90, x=height*1.25, y=height*.95, thickness=thickness);
branch(height=height*.75, x=height*.75, y=height*2.3, thickness=thickness);
branch(height=height*.6, x=height*1.2, y=height*1.7, thickness=thickness);
branch(height=height*.45, x=height*.7, y=height*1.65, thickness=thickness);
branch(height=height*.3, x=height*1.25, y=height*2.2, thickness=thickness);

// Variance for the branch polygons 

function variance (height) = rands(-height,height,1)[0]/10;

// Make trunk pieces

module trunk (height=66, thickness=2)
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
			cube([2.4,height/2,thickness],true);
	}
}

// Module to create a horizontal branch

module branch (height=80, x=0, y=0, thickness=2)
{
	p = rands(7,11,1)[0];

	// Put branch in proper location 
	translate ([x,y,0])
	{
		difference() 
		{
			// Random number of branches
			for(i=[360/p:390/p:390]) 
			{
				rotate([0,0,i])
				linear_extrude (height=thickness)
				{
				polygon(points=[
				 				[-(height/5)+variance(height/2),(height/5)+variance(height/2)],	
								[(height/5)+variance(height/2),-(height/5)+variance(height/2)],
				 	  		[(height/3)+variance(height/4),(height/3)+variance(height/4)]
						]);
				}
			}

			// Trunk Slot
			rotate ([0,0,rands(1,90,1)[0]])
			translate([0,0,thickness/2])
			union ()
			{
				cube([2.4,height/4,thickness],true);
				rotate([0,0,90])
					cube([2.4,height/4,thickness],true);				
			}
		}
	}
}

