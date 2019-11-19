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



$fn=30;

num_shelves = 4;
xht = 1.9;
yht = 2.2;
spare_shelf = 1.3;


// SHELF WIDTH, HEIGHT, AND THICKNESS should be based on known paint brands
// VALLEJO : 
// shelf_size = 62;
// shelf_width = 44;
// shelf_depth = 28;
// large_holes = 30;
// small_holes = 9;



shelf_size = 62;
large_holes = 27;
small_holes = 9;
num_holes = 6;

shelf_width=33;
shelf_depth=28;

shelf_thickness = 4;
slop = .2;


/*
shelf_angle = 35;
shelf_size = 29;
large_holes = 15;
small_holes = 4.5;
num_holes = 6;

shelf_width=22;
shelf_depth=14;

shelf_thickness = 2;
slop = .2;
*/

	hyp=hypotenuse(shelf_width,shelf_depth);
	shelf_length=num_holes*large_holes*1.1+large_holes*.7;

	echo (shelf_length);

//first_plate();


import ("../Buttons/flattened sheep.stl", convexity=3);

	// UPRIGHT
	//translate([0,1,0])
	//rotate([0,0,90-atan(xht/yht)])
//		make_shelf_upright (num_shelves,shelf_width,shelf_depth,shelf_thickness);


module first_plate ()
{
	hyp=hypotenuse(shelf_width,shelf_depth);

	// MIDDLE SHELF
	translate([sin(atan(xht/yht))*(hyp*(num_shelves+spare_shelf))+shelf_size+1,0,0])

		rotate([0,0,90])
				make_shelf(num_holes,large_holes,small_holes,shelf_thickness,
					shelf_size,shelf_width,slop,hyp,type="middle");

	// UPRIGHT
	translate([0,1,0])
	rotate([0,0,90-atan(xht/yht)])
		make_shelf_upright (num_shelves,shelf_width,shelf_depth,shelf_thickness);

  // UPRIGHT
	translate([0,0,shelf_thickness])
	rotate([180,0,90-atan(xht/yht)])
		make_shelf_upright (num_shelves,shelf_width,shelf_depth,shelf_thickness);
}

module second_plate ()
{

	hyp=hypotenuse(shelf_width,shelf_depth);

	for(i=[1:3])
		translate([(shelf_size+1)*i,0,0])
			rotate([0,0,90])
				linear_extrude(height=shelf_thickness)
					make_shelf(num_holes,large_holes,small_holes,shelf_thickness,
						shelf_size,shelf_width,slop,hyp);

}

function hypotenuse (l1,l2) = sqrt(l1*l1+l2*l2);

module make_shelf (num_holes,large_holes,small_holes,shelf_thickness,shelf_size,shelf_width,slop,hyp,type="middle")
{

	shelf_length=num_holes*large_holes*1.1+large_holes*.7;


	union() 
	{
		if(type=="top")
	  	translate([0,shelf_width,0]) 
				rotate([90,0,0])
					difference () {
						union () {
							linear_extrude(height=shelf_thickness)
								square([shelf_length,shelf_width]);
							translate([0,shelf_width,shelf_thickness])	
								rotate([0,90,0])
									cylinder(shelf_length,r=shelf_thickness);
						}
						translate([shelf_width-shelf_thickness,-shelf_depth*.8,0])
							square(size=[shelf_thickness,shelf_depth*.4]);
					}

		linear_extrude(height=shelf_thickness)
			difference()
			{
				if(type=="bottom")
				{
					square([shelf_length,shelf_size-small_holes-2]);
				} else {
					square([shelf_length,shelf_size]);
				}
				for(i=[1:num_holes])
				{
					if(type != "top")
						translate ([(i-.2)*large_holes*1.1,2+(large_holes/2),0])
							circle (d=large_holes);
					if(type != "bottom")
						translate ([(i-.2)*large_holes*1.1,(shelf_width-large_holes)+(large_holes*1.5)+(small_holes/2),0])
							circle (d=small_holes);
				}
			
				// SLOTS FOR UPRIGHTS
				translate([shelf_thickness-slop,shelf_width+(shelf_depth*.2)+slop,0])
					square([shelf_thickness+slop*2,shelf_size-shelf_width+(slop*2)]);
				translate([shelf_length-shelf_thickness*2-slop,shelf_width+(shelf_depth*.2)+slop,0])
					square([shelf_thickness+slop*2,shelf_size-shelf_width+(slop*2)]);

				// SLOTS FOR NOTCHES
				translate([shelf_thickness-slop,hyp*.4-slop])
					square(size=[shelf_thickness+slop*4,hyp*.2+slop*4]);
				translate([shelf_length-shelf_thickness*2-slop,hyp*.4-slop])
					square(size=[shelf_thickness+slop*4,hyp*.2+slop*4]);
			}
	}
}

module make_shelf_upright (num_shelves,shelf_width,shelf_depth,shelf_thickness)
{

	hyp = hypotenuse(shelf_width,shelf_depth);
	total_hyp = hyp*(num_shelves+spare_shelf);

	linear_extrude(height=shelf_thickness)
		difference()
		{

			// MAIN TRIANGLE

			polygon(points=[[0,0],[total_hyp,0],[hyp*yht,hyp*xht]]);

			// SHELF CUTOUTS 
			translate([-hyp*.8,0,0])	
			for(i=[1:num_shelves])
			{
				color("Red")
				translate([hypotenuse(shelf_width,shelf_depth)*i,0,0])
					rotate([0,0,90-atan(shelf_width/shelf_depth	)])
						difference ()
						{					
							union() {
								// Shelf Rectangle Cutout
								translate([0,-shelf_depth,0])
									square(size=[shelf_width,shelf_depth]);
								// Shelf uprigth cutouts
								translate([shelf_depth,-shelf_thickness,0])
									square(size=[shelf_depth*.4,shelf_thickness]);
							}
						// Notches to attach shelves
						translate([hyp*.4,-shelf_thickness,0])
							square(size=[hyp*.2,shelf_thickness]);
						
						// Extra Notch for top shelf
						if (i==1){
							translate([shelf_width-shelf_thickness,-shelf_depth*.8,0])
								square(size=[shelf_thickness,shelf_depth*.4]);
						}
					}
			}

			for(j=[1:num_shelves-1])
				translate([hyp*(.4+j),shelf_depth*.85,0])
					rotate([0,0,atan(xht/yht)])
						scale([(num_shelves-j)*1.2,1])
							translate([(num_shelves-j-1)*(xht)+xht*1.4,(num_shelves-j-1),0])
								circle(d=shelf_depth*.7);

			// ROWS OF CIRCLE CUTOUTS
			// 
			//
/*		for(j=[1:num_shelves-1])
				for(i=[1:num_shelves-j])
					translate([hyp*i+hyp*((j-.3)*.5),hyp*(.55+(j-1)*.3),0])
						if(i==num_shelves-j)
						{
							translate([3,3])
							rotate([0,0,124.7])
								scale([1,2])
									circle(d=hyp*.4);
						} else {
								circle(d=hyp*.4);
						}

*/


/*
				for(i=[1:num_shelves-2])
					translate([hyp*i+hyp,hyp*.85,0])
						circle(d=hyp*.4);
				
				for(i=[1:num_shelves-3])
					translate([hyp*i+hyp*1.5,hyp*1.1,0])
						circle(d=hyp*.4);
*/
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