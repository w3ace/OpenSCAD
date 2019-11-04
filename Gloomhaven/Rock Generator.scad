

/*
    Rock Formations Generator
    
    Fernando Jerez 2017
    License: CC-NC

*/

// This is only to force Customizer create many files. Changes doesn´t matter. Just click CREATE THING
part = "one"; // [one:Formation #1, two:Formation #2, three:Formation #3, four:Formation #4,five:Formation #5]

// : More corners --> More 'spheric' central stone
number_of_corners = 7; // [5:30]

// : Deforms central stone in vert  ical
stone_scale = [1,1,1]; // [0.2:0.1:3]

// Number of medium size stones
medium_stones = 2; // [5:30]

// Number of small stones
small_stones = 6; // [5:30]

/* [Hidden] */
radius = 20;
corner_size = 8;

// Example
intersection(){
    union(){
    
        // big central stone
        scale(stone_scale)
        
        translate([radius*.6,radius*.6,0])
        randomRock(radius,corner_size,number_of_corners);

        scale(stone_scale)
        
        randomRock(radius,corner_size,number_of_corners);

        // medium size stones
        if(medium_stones>0){
            for(i=[1:medium_stones]){
                // random position in 'circle'
                z = rands(0,360,1)[0];
                rotate([0,0,z])
                
                // translate radius
                translate([rands(radius*0.6,radius*0.9,1)[0],0,0])
        scale(stone_scale)
                randomRock(rands(radius*0.3,radius*0.5,1)[0],corner_size*0.5,15);
            }
        }
        
        // small stones
        if(small_stones>0){
            for(i=[0:small_stones]){
                // random position in 'circle'
                z = rands(0,360,1)[0];
                rotate([0,0,z])
                
                // translate radius
                translate([rands(radius*0.7,radius*1.15,1)[0],0,0])
        scale(stone_scale)
                randomRock(rands(radius*0.1,radius*0.3,1)[0],corner_size*0.5,10);
            }
        }

    }
    // cut half of figure
    translate([-50,-50,0]) cube(100);
}


 

// Module randomRock : draws a random rock
module randomRock(radius,corner_size,number_of_corners){
    // Draw rock
    hull(){
        // Make a hull..
        for(i=[0:number_of_corners]){
            // random position in 'sphere'
            y = rands(0,360,1)[0];
            z = rands(0,360,1)[0];
            cubesize=rands(corner_size*0.5,corner_size,1)[0];
            rotate([0,y,z])
            
            // translate radius (minus half of corner size)
            translate([radius-corner_size*0.5,0,0])
            
            // draw cube as corner
            rotate([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]]) // random rotation
            cube([cubesize,cubesize,cubesize],center = true);
                
        }
    }

    // Done!
}