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
spare_shelf = 1.8;

// SHELF WIDTH, HEIGHT, AND THICKNESS should be based on known paint brands
// VALLEJO : 

shelf_size = 70;
large_holes = 27;
small_holes = 12;
num_holes = 2;

shelf_width=33;
shelf_depth=29;

shelf_thickness = 4;
slop = .2;



// Test Shelf 
/*

shelf_size = 31;
large_holes = 13.5;
small_holes = 4.5;
num_holes = 2;

shelf_width=16.5;
shelf_depth=19;

shelf_thickness = 3;
slop = .2;

*/
	xht = 1+((num_shelves+spare_shelf)*.15);
	yht = shelf_width/shelf_depth*xht;
	hyp=hypotenuse(shelf_width,shelf_depth);
	shelf_length=num_holes*large_holes*1.1+large_holes*.7;
	back_length=hypotenuse(hyp*xht,hyp*yht);
	shelf_modifier = num_shelves+spare_shelf;
	total_hyp = hyp*shelf_modifier;
	bottom_length=hypotenuse(hyp*xht,total_hyp-hyp*yht);


//hazard_cutout_2d(100,50,300,500);

				make_shelf(num_holes,large_holes,small_holes,shelf_thickness,
					shelf_size,shelf_width,slop,hyp,type="top");
		/*		translate([0,70,0])
				make_shelf(num_holes,large_holes,small_holes,shelf_thickness,
					shelf_size,shelf_width,slop,hyp,type="bottom");
				translate([0,130,0])
				make_shelf(num_holes,large_holes,small_holes,shelf_thickness,
					shelf_size,shelf_width,slop,hyp,type="middle"); */

//	translate([50,50,0])
//	rotate([0,0,90-atan(xht/yht)])
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

module hazard_cutout_2d (x,y,x1,y1)
{


	intersection () {

		polygon( points=[[x,y],[x1,y],[x1,y1],[x,y1]]);

			union() {

				stripe_width=(y1-y)/5;
				for(i=[-4:((x1-x)/stripe_width)+4]) {
					if(i % 2) {

					//	echo(i);
							polygon(points = [[x+(i+3)*stripe_width,y],[x+(i+4)*stripe_width,y],
								[x+i*stripe_width,y1],[x+(i-1)*stripe_width,y1]]);


				//		echo (x+(i-1)*stripe_width,y,x+i*stripe_width,y1);
					}
				}
			}
		}
}

module make_shelf (num_holes,large_holes,small_holes,shelf_thickness,shelf_size,shelf_width,slop,hyp,type="middle")
{

	shelf_length=num_holes*large_holes*1.1+large_holes*.7+shelf_thickness*2;


	union() 
	{
		if(type=="top")
			// Top Shelf is dramatically different
	  		translate([0,shelf_width,0]) 
				rotate([90,0,0])
					difference () {
						union () {
							linear_extrude(height=shelf_thickness)
								difference() {
									square([shelf_length,shelf_depth*1.3]);
									hazard_cutout_2d(shelf_thickness*3,shelf_thickness*2,shelf_length-shelf_thickness*3,shelf_width);
								}
								translate([0,shelf_depth*1.3,shelf_thickness*.75])	
									rotate([0,90,0])
										cylinder(shelf_length,r=shelf_thickness*.5);
								translate([0,shelf_depth*1.3,shelf_thickness*.75])	
									rotate([90,0,0]) {
										cylinder(shelf_depth*1.3,r=shelf_thickness*.5);
										sphere(r=shelf_thickness*.5);
									}
								translate([shelf_length,shelf_depth*1.3,shelf_thickness*.75])	
									rotate([90,0,0]) {
										cylinder(shelf_depth*1.3,r=shelf_thickness*.5);									
										sphere(r=shelf_thickness*.5);
									}
						}
						color("Green")
						translate([shelf_thickness-slop,shelf_depth*.65-slop,0])
							linear_extrude(height=shelf_thickness)
								square(size=[shelf_thickness+slop*2,shelf_depth*.15+slop*2]);
						translate([shelf_length-slop-shelf_thickness*2,shelf_depth*.65-slop,0])
							linear_extrude(height=shelf_thickness)
								square(size=[shelf_thickness+slop*2,shelf_depth*.15+slop*2]);
					}

		linear_extrude(height=shelf_thickness)
			difference()
			{
				if(type=="bottom")
				{
					square([shelf_length,shelf_size-small_holes-2]);
				} else {
					if (type=="top")
					{
						difference() {
							square([shelf_length,shelf_size]);
							hazard_cutout_2d(shelf_thickness*3, shelf_thickness , shelf_length-shelf_thickness*3,large_holes);
				}


					} else {
					square([shelf_length,shelf_size]);
				}
				}

				for(i=[1:num_holes])
				{
					if(type != "top")
						translate ([(i-.2)*large_holes*1.1+shelf_thickness,2+(large_holes/2),0])
							circle (d=large_holes);
					if(type != "bottom")
						translate ([(i-.2)*large_holes*1.1+shelf_thickness,(shelf_width-large_holes)+(large_holes*1.5)+(small_holes/2),0])
							circle (d=small_holes);
				}
			
				// SLOTS FOR UPRIGHTS
				translate([shelf_thickness-slop,shelf_width*1.25-slop*4,0])
					square([shelf_thickness+slop*2,shelf_size-shelf_width+(slop*4)]);
				translate([shelf_length-shelf_thickness*2-slop,shelf_width*1.25-slop*4,0])
					square([shelf_thickness+slop*2,shelf_size-shelf_width+(slop*4)]);

				// SLOTS FOR NOTCHES
				translate([shelf_thickness-slop,hyp*.1-slop])
					square(size=[shelf_thickness+slop*4,hyp*.2+slop*4]);
				translate([shelf_length-shelf_thickness*2-slop,hyp*.1-slop])
					square(size=[shelf_thickness+slop*4,hyp*.2+slop*4]);
			}
	}
}

module make_shelf_upright (num_shelves,shelf_width,shelf_depth,shelf_thickness)
{

	hyp = hypotenuse(shelf_width,shelf_depth);


	linear_extrude(height=shelf_thickness)
		difference()
		{
			// MAIN TRIANGLE

			polygon(points=[[0,0],[total_hyp,0],[hyp*yht,hyp*xht]]);


			//CUT OFF THE BOTTOM POINT
			translate([hypotenuse(shelf_width,shelf_depth)*(num_shelves-.5),0,0])	
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
								color("Red")
								translate([shelf_width,-shelf_thickness,0])
									square(size=[shelf_width*.25,shelf_thickness]);
//								translate([shelf_width*1.2,-shelf_depth*.85,0])	
//									square(size=[shelf_width*(num_shelves-i),shelf_depth*.6]);
								if(i != num_shelves)
								polygon(points=[
									[shelf_width*1.2,-shelf_depth*.25],
									[shelf_width*1.2,-shelf_depth*.85],
									[back_length-(back_length*((i-(.625+(num_shelves*.055)))/(num_shelves+spare_shelf))),-shelf_depth*.85],
									[back_length-(back_length*((i-.55)/(num_shelves+spare_shelf))),-shelf_depth*.25]]);
							}

						// Notches to attach shelves
						translate([hyp*.1,-shelf_thickness,0])
							square(size=[hyp*.2,shelf_thickness]);
						
						// Extra Notch for top shelf
						if (i==1){
							translate([shelf_width-shelf_thickness,-shelf_depth*.8,0])
								square(size=[shelf_thickness,shelf_depth*.15]);
						}
					}
			}

		
		}
}