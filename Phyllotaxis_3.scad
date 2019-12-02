/* Phyllotaxis is a term used for the patterns that emerge in the growth of plants. Spiral phyllotaxis is observed in the heads of sunflowers, in pine-cones and pineapples, and in a variety of other plants.

In the script below Vogel's formula is used to describe a pattern of seeds in a plane (a=n*137.5 and r=c*sqrt(n))

A general articles on Phyllotaxis can be found here
https://en.wikipedia.org/wiki/Phyllotaxis
http://algorithmicbotany.org/papers/abop/abop-ch4.pdf

For the relation between Phyllotaxis and the Fibonacci sequence watch this YouTube video
https://www.youtube.com/watch?v=_GkxCIW46to&t=210s

Approaches to generate these patterns can be found in these links
http://www.mathrecreation.com/2008/09/phyllotaxis-spirals.html
https://maxwelldemon.com/2012/03/18/prime-phyllotaxis-spirals/
http://www.algorithmicbotany.org/papers/abop/abop-ch4.pdf
https://www.youtube.com/watch?v=KWoJgHFYWxY (Daniel Schiffman)
*/

$fn=20;
//c determines the radius of the phyllotaxis pattern (scale)
c = 4;
//pi is, well you know what pi is.
pi = 3.141592;

/* Variables */

//max_seeds is an integer that contains the maximum number of seeds
max_seeds = 400; //[400:2000]

//seed_diameter determines the diameter of the seed. The higher the seed_diameter the smaller the diameter of the seed
seed_diameter = 3; //[3:8]

//fibonacci is a number that highlights different spirals with a secundary color
fibonacci = 13;//[2,3,5,8,13,21,34,55,89,144]

//different angles to choose from. 137.5 however is the 'golden angle'
golden_angle = 137.5; //[137.3, 137.5, 137.6]

//choose a primary color
color1="red"; //["red", "blue", "yellow", "cyan", "lime", "violet", "tan"]

//choose a secondary color
color2="lime"; //["red", "green", "yellow", "cyan", "lime", "violet", "tan"]


module line(start, end, thickness = 1) {
    hull() {
        translate(start) sphere(thickness);
        translate(end) sphere(thickness);
    }
}



/* Modules */ 
module phyllotaxis (max_seeds, seed_diameter, fibonnaci, golden_angle, color1, color2) {

    for (n = [1:max_seeds]) {
        //Vogel's formula
        theta = n *golden_angle;
        r = c * sqrt(n);
        //end Vogel's formula
       x = r * cos(theta);
        y = r * sin(theta);

        cyl_radius = sqrt(r)/seed_diameter;
        //cyl_radius = 10 * sqrt(1/r)
        if (n % fibonacci == 0) { 
//            if(prv) {
            gamma = prv * golden_angle;
            r1 = c * sqrt(prv);
            echo (gamma,r1,c,prv);
            //end Vogel's formula
            x1 = r1 * cos(gamma);
            y1 = r1 * sin(gamma);

            echo (x1,y1,x,y);

            color(color1) translate([x,y]) sphere(r=cyl_radius);
            echo (prv,x1, y1);
            line([x,y,0],[x1,y1,0]);

            let (prv = n);
            echo (prv,n);
  //      }
        }
        else {
     //       color(color2) translate([x,y]) cylinder(r=cyl_radius, h=5.5);
        }
    }
}

/* MAIN */
//make it 3d printable
//hull() 
    //diameter of the cylinder scales with the number of seeds.
//    cylinder(d=8*sqrt(max_seeds)+10, h=3, $fn=50);

        phyllotaxis(max_seeds, seed_diameter, fibonacci, golden_angle, color1, color2);
