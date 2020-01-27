$fn=40;


length_id=92;
width = 70;
height=35;
thickness=2.1;

length = length_id+thickness*2;

rotate([90,0,0])
	boxwall(0,0,length,height,5);


translate([0,width+thickness,0])
	rotate([90,0,0])
		boxwall(0,0,length,height,5);

boxwall(0,0,length,width,8);

rotate([90,0,90])
boxwall(0,0,width,height,5);

translate([length-thickness,0,0])
rotate([90,0,90])
boxwall(0,0,width,height,5);

module boxwall (x,y,x1,y1,edge=5)
{

	linear_extrude (height=thickness)
		difference () {
			polygon( points=[[x,y],[x1,y],[x1,y1],[x,y1]]);
			hazard_cutout_2d(x+edge,y+edge,x1-edge,y1-edge);
		}
}




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
