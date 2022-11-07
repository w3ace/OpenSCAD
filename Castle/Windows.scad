/*
 * Castle Code
 * By Craig Wood
 *
 * Copyright 2022 Craig Wood - http://github.com/w3ace
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


module squarewindow (height, width, radius, numarm=5, stepup=0, frame=1, segments=3)
{
    // squarewindow - make a square window. This is used for the frame and the cutout
   
        depth = (frame==1) ? radius*.25 : radius*.2;
        numwin = (stepup>=1)?3:numarm;
       // segments = (frame==1) ? s : 1;
   //     echo("Square Window",width,depth,radius,numwin,numarm,stepup,frame);
        for (i=[1:numwin]) {
            for(j=[1:segments]) {
                zloc =360/numarm*i+(j*360/numarm/segments*.3) ;
                rotate([0,0,zloc]) 
                    translate([radius-depth+frame/2,0,height+(i*height*stepup)]) 
                        cube([depth,(width*frame)/segments,width*frame],center=true); 
            }
        }
    
}


module archwindow (height, width, radius, numarm=5, stepup=0, frame=1)
{
 
        depth = (frame==1) ? radius*.25 : radius*.2;
        numwin = (stepup>=1)?3:numarm;
    //    echo("Square Window",width,depth,radius,numwin,numarm,stepup,frame);
        for (i=[1:numwin]) {
            for(j=[1:4]) {
                rotate([0,0,(360/numarm*i)+(5*j)]) 
                    translate([radius-depth+frame/2,0,height+(i*height*stepup)]) 
                    union() {
                        cube([depth,(width*frame)/4,width*frame],center=true); 
                        newcube=sqrt(((width*frame)^2)/2);
                        translate([0,0,newcube*.71]) 
                        rotate([45,0,0])
                           cube([depth,newcube/4,newcube],center=true);
                            
                        }
                    }
        }
}
