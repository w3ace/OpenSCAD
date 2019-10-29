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
thickness=1.4;
slop=.4;

bottom_trunk(height=height, thickness=thickness, slop=slop);
top_trunk(height=height, thickness=thickness, slop=slop);
branch(height=height*.90, vertices=7, x=height*1.3, y=height*.8, thickness=thickness, slop=slop);
branch(height=height*.75, vertices=7, x=height*1.15, y=height*1.6, thickness=thickness, slop=slop);
branch(height=height*.6, vertices=6, x=height*1.1, y=height*2.3, thickness=thickness, slop=slop);
branch(height=height*.5, vertices=6, x=height*.6, y=height*2.05, thickness=thickness, slop=slop);
branch(height=height*.4, vertices=5, x=height*.55, y=height*1.55, thickness=thickness, slop=slop);

outer_frame(height=height);

// Variance for the branch polygons 

function variance (height) = rands(-height,height,1)[0]/10;

// Create Outside Frame

module outer_frame (height=66)
{

	width_multiplier = 1.25;
	height_multiplier = 2.05;
	arc_distance = height/5;
	frame_radius = 2;

	difference()
	{
		union()
		{

			translate([height/4,height/4+arc_distance,0])
				rotate([270,90,0])
					cylinder(r=frame_radius,h=height*height_multiplier);
			translate([height/4+arc_distance,height/4,0])
				rotate([0,90,0])
					cylinder(r=frame_radius,h=height*width_multiplier);
			translate([height/4+height*width_multiplier+arc_distance*2,height/4+arc_distance,0])
				rotate([270,90,0])
					cylinder(r=frame_radius,h=height*height_multiplier);
			translate([height/4+arc_distance,height/4+height*height_multiplier+arc_distance*2,0])
				rotate([0,90,0])
					cylinder(r=frame_radius,h=height*width_multiplier);

			translate([height/4+arc_distance,height/4+arc_distance,0])
				rotate ([0,0,180]) 
					rotate_extrude(angle=90, convexity=20)
		   			translate([arc_distance, 0]) 
		   					circle(frame_radius);
			translate([height/4+arc_distance+height*width_multiplier,height/4+arc_distance,0])
				rotate ([0,0,270]) 
					rotate_extrude(angle=90, convexity=20)
		   			translate([arc_distance, 0]) 
		   					circle(frame_radius);
			translate([height/4+arc_distance+height*width_multiplier,height/4+height*height_multiplier+arc_distance,0])
					rotate_extrude(angle=90, convexity=20)
		   			translate([arc_distance, 0]) 
		   					circle(frame_radius);
			translate([height/4+arc_distance,height/4+height*height_multiplier+arc_distance,0])
				rotate ([0,0,90]) 
					rotate_extrude(angle=90, convexity=20)
		   			translate([arc_distance, 0]) 
		   					circle(frame_radius);
		}
		translate([0,0,-frame_radius])
			cube([height/4+arc_distance+height*width_multiplier+arc_distance*2+frame_radius*2,
						height/4+height*height_multiplier+arc_distance+arc_distance*2+frame_radius*2,frame_radius]);
	}
}


// Make trunk pieces

module bottom_trunk (height=66, thickness=2, slop=.4)
{
	x = height/2.5;
	y = height/2.5;


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
			cube([thickness+slop/2+.2,height/2,thickness+.4],true);
	}
}
	// Trunk with Bottom Slot

module top_trunk (height=66, thickness=2,slop=.4)
{

	x = height*1.6;
	y = height*1.5;

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
			cube([thickness+slop,height/2+slop/2,thickness+.4],true);
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
								cube([height/3,height/2.5,thickness+.4],true);
								translate([height/2.8,height/8.5,thickness/2])
								cube([height/3,height/2.5,thickness+.4],true);
							}
				}
			}

			// Trunk Slot
			rotate ([0,0,rands(1,90,1)[0]])
			translate([0,0,thickness/2])
			union ()
			{
				cube([thickness+slop,height/3.1,thickness+.4],true);
				rotate([0,0,90])
					cube([thickness+slop,height/3.1,thickness+.4],true);				
			}
		}
	}
}

