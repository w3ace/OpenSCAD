/*
 * CastleCode
 *
 * By Craig Wood
 *
 * Copyright 2022 Craig Wood - http://github.com/w3ace
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

$fn=60;

include <Polygon.scad>;
include <BezierCone.scad>;
include <Windows.scad>;
include <Skin.scad>
    
height = 40;
radius = 8;

style = [["type"],["watchtower"],["skin"],["bricked"]];

function is_even(num) = (round(num)/2 == ((round(round(num)/2)))) ? 1 : 0;

frand = rands(.93,1.12,400); // Random Numbers for all builds

//greenfield();

buildtowers();

module buildtowers() {
maxtowers = 7;
    
    for (j = [0:0]) {
        for (i = [1:maxtowers]) {
              furand = [frand[i*20+j],frand[i*20+j+10],frand[i*20+j+1],frand[i*20+j+5],frand[i*20+j+15]];
         //   rotate([0,0,360/maxtowers*i])
    	translate ([i*50-180,0, 0])
            tower(height*myrand(furand,3),radius*myrand(furand,3),furand,"watchtower");
        }
    }
}

function myrand (rands,len,count=0,prod=1) = (count <= len) ? myrand (rands,len,count+1,prod*rands[rands(0,(len(rands)),1)[0]]) : prod;

module greenfield () {
    translate([0,0,-2])
    scale([1,1.3,1])
        color("green") Polygon(N=20,A=200,h=2);
}

module battlement (height, width, radius, numarm=18)
{
    {
        depth = width/2;
        for (i=[1:numarm])
            rotate([0,0,(360/numarm*i)]) // Rotate the arm after it's centered
                translate([radius-depth,0,height/2]) 
                    cube([depth,width,height],center=true); // Make the arm extend along the X axis

    }
}



module base (baseheight,baseradius,rands,bpc)
{

    // module base
    //
    // tower add-ons for the base.
    // TODO: Make poly steps look like bricks.



    if(rands[2]>1) {
        cylinder(baseheight,baseradius,baseradius);
      //   brick(baseheight,baseradius,rands,bpc);
        // Taper
        if(rands[3]>1.1) {
            translate([0,0,baseheight])
                cylinder(height*.05*myrand(rands,3),baseradius,radius);
        // Battlements
        } else if (rands[1] >.92) { //} && (baseheight*2 > height)) {
            blockheight = round(baseheight*.2); //*abs(rands[2]));
            blockwidth = round(baseradius*.25); //*abs(rands[1]));
            translate([0,0,baseheight*.4])
                battlement(blockheight,blockwidth,baseradius*1.05);
        }
        // Polygon
    } else if(rands[2]>.85) {
        segments = rands(1,6,1)[0];
        polys = rands(7,11,1)[0];
        baseheight = height*.12*myrand(rands,3);
        baseradius = radius*.98;
        for(i=[1:segments]) {
            translate([0,0,baseheight-(baseheight/segments*i)])
            color("darkgray")
                Polygon(N=polys,A=(baseradius+((baseradius/7)*i)),h=(baseheight/segments)*(segments-i+1));
        }
    }
}


module watchtower (shaftheight,watchheight,height,radius,watchradius,rands)
{

    // TODO: Hollow Tubes when built. 

    // Main Shaft
                color("lightgray")
                    cylinder(shaftheight,r=radius);

echo ("Watchtower",shaftheight,watchheight,height,radius,watchradius);

            // Watchtower
            if(watchheight) {
              //  difference() {
               //     union() {
                        translate([0,0,shaftheight]) 
                            if (rands[1]>1.1) {
                                echo ("Warp");
                                    cylinder(watchheight,watchradius*myrand(rands,2),watchradius*myrand(rands,2));
                            } else if (rands[1]>1) {
                                echo ("Simple",watchheight,watchradius,watchradius);
                                    cylinder(watchheight,watchradius,watchradius); 


                            } else {
                                echo ("in rake");
                               difference() {
                                   cylinder(watchheight,watchradius,watchradius); 
                         //       rake(watchheight,watchradius,rands);
                                }
                            }
                        
                        //      Bottom Round
                        translate([0,0,shaftheight])
                            cylinder(watchheight*.15,watchradius*1.2,watchradius*1.2); // Bottom Round
                        //      Top Round
                        toproundheight = round(watchheight*.2);
                        translate([0,0,round(shaftheight+watchheight-toproundheight)]) 
                            cylinder(toproundheight,watchradius*1.3,watchradius*1.3); // Top Round
                    } 
           //         translate([0,0,shaftheight+watchheight*.2])  
           //             cylinder(watchheight*.8,watchradius*.9,watchradius*.9);
           //     }
       //     }

            // Peaked Roof
            blockheight = round(height*.1*myrand(rands,3));
            blockwidth = round(radius*.5*rands[1]);
            if(rands[2]>1.1) {
                echo("Pitched Roof");
                translate([0,0,shaftheight+watchheight])
                    cylinder(height*.5*myrand(rands,3),radius*1.5*myrand(rands,2),0);
                if(rands[1]>.90) {
                    translate([0,0,round(shaftheight+watchheight-blockheight)])
                        battlement(blockheight,blockwidth,radius*1.4,round(15*abs(rands[1])));
                }

            } else if (rands[2]>.95) { //.98 Saved Setting
                // Bezier Roof
                curve=rands(-2,10,1)[0];
                curve2=rands(0,20,1)[0]; 
                translate([0,0,shaftheight+watchheight])
                    BezCone(radius*1.4,h=20,curve=curve,curve2=curve2);
                echo("BezierRood", curve,curve2);
            } else {
                // Battlement Top
                blockheight = round(height*.1*myrand(rands,3));
                blockwidth = round(radius*.5*myrand(rands,1));
                translate([0,0,round(shaftheight+watchheight)])
                    battlement(blockheight,blockwidth,radius*1.4,round(10*abs(rands[1])));
                echo("Battlement Top",blockheight,blockwidth);
            } 
        }

module tower (height,radius,rands,style="watchtower")
{

    if (style == "watchtower") {
        // Main Stair Shaft
        baseheight = round(height*.25*myrand(rands,3));
        baseradius = (rands[1]>.9) ? round(radius*myrand(rands,4)) : 0;

        shaftheight = round(height*rands[0]*rands[1]*rands[2]*rands[3]);
        shaftradius = round(radius);
        watchheight = (myrand(rands,2)>.9) ? round(height*.4*rands[1]) : 0 ;
        watchradius = round(radius*1.1*myrand(rands,3));

        windowheight = round(height*.1*myrand(rands,3));
        windowwidth = round(radius*.5*myrand(rands,1));
        watchwindowheight=watchheight*rands(.3,.8,1)[0];
        bpc = round(rands(12,20,1)[0]);
        numwindows = round(rands(3,6,1)[0]);
        stup = round(rands(0,2,1)[0]);
        windowrand = rands[1];

        echo("Heights",shaftheight,watchheight,radius);

        // Square Windows
        difference() {
             union() {
                difference() {
                    union() {
                        if(baseradius && baseradius > 0) base(baseheight,baseradius,rands,bpc);
                           color("lightgray")
                            cylinder(shaftheight,r=radius);
              //                 brick(shaftheight,shaftradius,rands,round(bpc*(radius/shaftradius))); 

                    }
                    cylinder(shaftheight,radius*.95,radius*.95);
                }
                watchtower(shaftheight,watchheight,height,shaftradius,watchradius,rands);   
            //    translate([0,0,shaftheight])
                //    brick(watchheight,watchradius,rands,round(bpc*(radius/watchradius)));
           
             //  if(windowrand>1){
               //     translate([0,0,shaftheight*.40])
                 //      squarewindow(windowheight,windowwidth,shaftradius*1.1,numwindows,stup,frame=1.4);
                  //  squarewindow(shaftheight+watchwindowheight,windowwidth,watchradius*1.1,numwindows,frame=1.4,segments=1);
              // } 
           }
            union () {
                translate([0,0,shaftheight*.4]) 
                    squarewindow(windowheight,windowwidth,shaftradius*1.2,numwindows,stup);
                squarewindow(shaftheight+watchwindowheight,windowwidth,watchradius*1.2,numwindows,segments=1);
            }
        }            
    }
            

}
