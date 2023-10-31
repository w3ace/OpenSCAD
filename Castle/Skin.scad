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



module brick (height,radius,rands,bpc =rands(12,45,1)[0], segments = 1, style="")
{
    // TODO : using rotation? make brick conform to any cone with radius2 [0..]
    // TODO : make brick rows conform to heights  union clean?
    // TODO : exposed brick outer shell erode

    brickwidth = (2*radius*3.14)/bpc;


    if (rands[3]>.7) {
        partbrick (height,radius,rands,bpc,1);
    } else {
   
        for(k=[brickwidth*.6*2:brickwidth*.6:height*.95]){

        //    echo ("K",k,height,"courses",height/brickwidth*.6,"interval",brickwidth*.6,k/(brickwidth*.6));

            for(i=[1:bpc]) {
                for(j=[1:segments]) {
                     for(h = [1:1]) {

                    location = (is_even(k/(brickwidth*.6))) ? 
                    360/bpc*i+(j*360/bpc/segments*.9) : 
                    360/bpc*i+(j*360/bpc/segments*.9)+180/bpc ;
     
                       rotate([0,0,location])
                            translate([radius*.95,0,k])
                             color("darkgray")
                                cube([radius*.15,(brickwidth/segments)*.9,brickwidth/2],center=true);
                            
                     }
                 }
                
            }
        }
    }
}



module partbrick (height,radius,rands,bpc = 24, segments = 1, totalbrickpercent = rands(3,8,1)[0])
{

    // DONE 11/2022 : make a patchy brick, clumps 4 to 10. 

    brickwidth = (2*radius*3.14)/bpc;
   
    for(k=[brickwidth*.6*3:brickwidth*.6:height*.95]){

    //    echo ("K",k,height,"courses",height/brickwidth*.6,"interval",brickwidth*.6,k/(brickwidth*.6));

        for(i=[1:bpc]) {
            for(j=[1:segments]) {
                if(rands(1,100,10)[0]<totalbrickpercent){
                 for(h = [1:round(rands(4,16,1)[0])]) {

                courseoff = round(rands(-2,2,1)[0]);
                radialoff = round(rands(-3,4,1)[0]);

                location = (is_even((k+(courseoff*brickwidth*.6))/(brickwidth*.6))) ? 
                360/bpc*i+(j*360/bpc/segments*.9)+(360/bpc)*radialoff : 
                360/bpc*i+(j*360/bpc/segments*.9)+180/bpc+(360/bpc)*radialoff;
 
                   rotate([0,0,location+((360/bpc)*i)])
                        translate([radius*.95,0,k+(courseoff*brickwidth*.6)])
                         color("darkgray")
                            cube([radius*.17,(brickwidth/segments)*.9,brickwidth/2],center=true);
                        
                 }
             }
            }
        }
    }
}

module rake (height,radius,rands,courses=5)
{
    for(k = [1:courses]) {
  //      echo (k,radius,height,courses,k*(height/courses)*height*.05)
        translate([0,0,k*(height/courses)])
        difference() {
            cylinder(height*.05,radius*1.01,radius*1.01);
            cylinder(height*.05,radius*.95,radius*.95);
       }
    }

}