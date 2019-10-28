/*
 * Christmas Tree Generator
 * By Craig Wood
 *
 * Copyright 2017 Dan Kirshner - dan_kirshner@yahoo.com
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

branch(size=80, x=40, y=40);
branch(size=40, x=100, y=40);


/* Variance for the branch polygons */

function variance (size) = rands(-size,size,1)[0]/10;

/* Module to create a horizontal branch */

module branch (size=80, x=0, y=0)
{
	p = rands(7,11,1)[0];

	/* Put branch in proper location */
	translate ([x,y,0])
	{
		difference() 
		{
			// Random number of branches
			for(i=[360/p:390/p:390]) 
			{

				rotate([0,0,i])
				linear_extrude (height=2)
				{
				polygon(points=[
				 				[-(size/5)+variance(size/2),(size/5)+variance(size/2)],	
								[(size/5)+variance(size/2),-(size/5)+variance(size/2)],
				 	  		[(size/3)+variance(size/4),(size/3)+variance(size/4)]
						]);
				}
			}

			// Trunk Slot
			rotate ([0,0,rands(1,90,1)[0]])
			translate([0,0,1])
			union ()
			{
				cube([2.4,size/4,2],true);
				rotate([0,0,90])
					cube([2.4,size/4,2],true);				
			}

		}

	}


}

