include<ISO_metric_screw_thread.scad>;
$fn=50;

ballrad=7;//7
threadod=20;//20
threadlen=10;
shaftrad=3.5;
shaftrad2=5.5;//5
taperlen=3;//min 3
shaftlen=20;//min 10?

nut(threadod=20,threadlen=8,ballrad=7);

ball_and_socket (ballrad=7, threadod=20, threadlen=8, shaftrad=2.5, shaftrad2=5.5, taperlen=3, shaftlen=20);

module ball_and_socket (ballrad, threadod, threadlen, shaftrad, shaftrad2, taperlen, shaftlen)
{
    difference()
    {
        union()
        {
            // Socket End
            difference() 
            {
                metric_thread (diameter=threadod, pitch=3, length=threadlen, thread_size=2, groove=true);
                translate([0,0,-2])
                    sphere(r=ballrad*1.02); //+++++MAIN SOCKET SIZE
            }
            // Lower Shaft Taper
            translate([0,0,threadlen])
                cylinder(r1=threadod/2-2,r2=shaftrad2,h=taperlen);
            // Shaft
            translate([0,0,threadlen+taperlen])
                cylinder(r1=shaftrad2,r2=shaftrad,h=shaftlen);
            // Ball
            difference()
            {
                translate([0,0,threadlen+taperlen+shaftlen+ballrad/2])
                    sphere(r=ballrad);      //++++++++++++++MAIN BALL SIZE
                translate([0,0,threadlen+taperlen+shaftlen-2])
                    cylinder(r=0,r2=ballrad/2,h=ballrad*2);
                translate([-10,-10,threadlen+taperlen+shaftlen+ballrad*1.25])
                    cube([20,20,4]);
            }
        }
        // Hollow Inside
        translate([0,0,ballrad*0.86-2])
            cylinder(r1=shaftrad2-1.6,r2=shaftrad-1.6,h=taperlen+shaftlen+ballrad*2);

                translate([0,0,threadlen+taperlen+shaftlen+ballrad/2])
                    sphere(r=ballrad-2);      //++++++++++++++MAIN BALL SIZE
                        }
}




module nut (threadod,threadlen,ballrad)
{
    translate([threadod*0,0,16]) //nut
    {
        difference()
        {
            cylinder(r=threadod/2*1.4, h=threadlen+ballrad*0.8);
            for(i=[0:10:360])
            {
                rotate([0,0,i])
                    translate([threadod/2*1.38,0,-.1])
                        rotate([0,0,55])
                            cube([2.7,2.7,threadlen+ballrad+.1]);
            }
            translate([0,0,2.0]) 
                metric_thread (diameter=threadod*1.05, pitch=3, length=threadlen+ballrad*0.7, thread_size=1.9, groove=true, internal=true);
            translate([0,0,-.1])
                cylinder(r1=ballrad*1.05,r2=ballrad*1.05, h=3.2);
            
            
        }
    }

translate([0,0,16]) //inserts
{
    difference()
    {
        cylinder(r=threadod/2-1.1, h=ballrad*0.45);
        translate([0,0,+ballrad*.65])sphere(r=ballrad);
        translate([0,0,-.1])cylinder(r=shaftrad*1.3, h=threadlen+.12);        
        translate([-.75,-threadod*1.1/2,-.1])cube([1.5,threadod*0.94,ballrad]);  
    }   
}

}
