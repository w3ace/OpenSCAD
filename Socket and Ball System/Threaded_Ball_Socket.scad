/*
 * Copyright 2017 Craig Wood - w3ace@yahoo.com
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * See <http://www.gnu.org/licenses/>.
*/

include<ISO_metric_screw_thread.scad>; // Latest file can be found here: http://dkprojects.net/openscad-threads/

$fn=50;

ballrad=7;//7
threadod=20;//20
threadlen=10;
shaftrad=3;
shaftrad2=4;//5
taperlen=3;//min 3
shaftlen=20;//min 10?

nut(threadod=20,threadlen=8,ballrad=7,shaftlen=20);

ball_and_socket (ballrad=7, threadod=20, threadlen=8, shaftrad=2.5, shaftrad2=5, taperlen=3, shaftlen=20);

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
            translate([0,0,threadlen-.5])                
                for(i=[0:15:360]) 
                {
                    rotate([0,0,i]) 
                        translate([0,threadod/2-3.8,0])
                            rotate([54,0,0])
                                rotate([0,0,45])
                                    cube([2,2,8]);
                    
                }


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




module nut (threadod,threadlen,ballrad, shaftlen)
{
    translate([threadod*0,0,shaftlen*.48]) //nut
    {
        difference()
        {
            union() {
                cylinder(r=threadod/2*1.4, h=threadlen+ballrad*0.8);        // Main Cylinder
                translate([0,0,ballrad*.35])                                // Compression Cylinder
                    cylinder(r=threadod/2-1.1, h=ballrad*0.5);         
            }
            translate([0,0,+ballrad])                                    // Compression Sphere (Cutout)
                sphere(r=ballrad);     
            translate([0,0,ballrad*.8])                                     // Threads (Cutout)
                metric_thread (diameter=threadod*1.05, pitch=3, length=threadlen+ballrad*0.7, thread_size=1.9, groove=true, internal=true);
            translate([0,0,-.1])                                            // Bottom Taper 1
                cylinder(r1=ballrad*1.4,r2=ballrad*.9, h=2.4);

            for(i=[0:10:360])                                               // Grips Rotated around cylinder (Cutout)
            {
                rotate([0,0,i])
                    translate([threadod/2*1.38,0,-.1])
                        rotate([0,0,55])
                            cube([2.7,2.7,threadlen+ballrad+.1]);
            }

            difference()
            { 
                cylinder(r=threadod/2*1.8, h=5); 
                cylinder(r1=ballrad*.9,r2=ballrad*2, h=5);
            }
        }
    }

/*    translate([0,0,18]) //inserts
    {
        difference()
        {
            cylinder(r=threadod/2-1.1, h=ballrad*0.5);
            translate([0,0,+ballrad*.65])sphere(r=ballrad);
       //     translate([0,0,-.1])cylinder(r=shaftrad*1.3, h=threadlen+.12);        
       //     translate([-.75,-threadod*1.1/2,-.1])cube([1.5,threadod*0.94,ballrad]);  
        }   
    }
*/
}
