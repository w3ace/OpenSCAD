/*
 * Miniature Paint Shelves
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



num_shelves = 4;
//shelf_width = 44;
//shelf_depth = 28;

shelf_width=17;
shelf_depth=11;

shelf_thickness = 1;

/*	hyp = hypotenuse(shelf_width,shelf_depth);
	linear_extrude(height=shelf_thickness)
	translate([-hyp*.8,0,0])	
			for(i=[1:num_shelves])
			{
				color("Red")
				translate([hypotenuse(shelf_width,shelf_depth)*i,0,0])
					rotate([0,0,90-atan(shelf_width/shelf_depth	)])
						difference ()
						{					
						translate([0,-shelf_depth,0])
							square(size=[shelf_width,shelf_depth]);
						translate([hyp*.4,-shelf_thickness,0])	
							square(size=[hyp*.2,shelf_thickness]);
						}
			}

*/

make_shelf_upright (num_shelves,shelf_width,shelf_depth,shelf_thickness);


function hypotenuse (l1,l2) = sqrt(l1*l1+l2*l2);



module make_shelf_upright (num_shelves,shelf_width,shelf_depth,shelf_thickness)
{

	hyp = hypotenuse(shelf_width,shelf_depth);

	linear_extrude(height=shelf_thickness)
		difference()
		{

			// MAIN TRIANGLE
			polygon(points=[[0,0],[hyp*(num_shelves+1.2),0],[hyp*2.6,hyp*1.8]]);

			// SHELF CUTOUTS 
			translate([-hyp*.8,0,0])	
			for(i=[1:num_shelves])
			{
				color("Red")
				translate([hypotenuse(shelf_width,shelf_depth)*i,0,0])
					rotate([0,0,90-atan(shelf_width/shelf_depth	)])
						difference ()
						{					
						translate([0,-shelf_depth,0])
							square(size=[shelf_width,shelf_depth]);
						translate([hyp*.4,-shelf_thickness,0])	
							square(size=[hyp*.2,shelf_thickness]);
						}
			}

			// ROWS OF CIRCLE CUTOUTS
			for(i=[1:num_shelves-1])
				translate([hyp*i+hyp*.5,hyp*.55,0])
					circle(d=hyp*.4);

			for(i=[1:num_shelves-2])
				translate([hyp*i+hyp,hyp*.95,0])
					circle(d=hyp*.4);
			
			for(i=[1:num_shelves-3])
				translate([hyp*i+hyp*1.5,hyp*1.3,0])
					circle(d=hyp*.4);

			//CUT OFF THE BOTTOM POINT
			polygon(points=[[hyp*(num_shelves+.5),0],[hyp*(num_shelves+2),0],[(hyp*(num_shelves+.5)),hyp]]);		
		}
}
/*
union()
{
	for(i = [1:num_shelves])
	{	
		translate([(num_shelves-i)*shelf_width,(i-1)*shelf_depth])	
			scale([i-(i*.25),i])
				polygon(points=[[0,0],[shelf_width,0],[0,shelf_depth*3]]);


	}
}	

*/