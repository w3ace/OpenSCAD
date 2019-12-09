

/*
    Rock Formations Generator
    
    Fernando Jerez 2017
    License: CC-NC

*/
$fs = 0.15;

// This is only to force Customizer create many files. Changes doesn´t matter. Just click CREATE THING
part = "one"; // [one:Formation #1, two:Formation #2, three:Formation #3, four:Formation #4,five:Formation #5]

// : More corners --> More 'spheric' central stone
number_of_corners = 7; // [5:30]

// : Deforms central stone in vert  ical
stone_scale = [1,1,1]; // [0.2:0.1:3]

// Number of medium size stones
medium_stones = 0; // [5:30]

// Number of small stones
small_stones = 0; // [5:30]

/* [Hidden] */
radius = 20;
corner_size = 8;

// Example
intersection(){
    union(){
    
        // big central stone
        scale(stone_scale)
        
        betterRock(radius,corner_size,number_of_corners);

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
            rotate([0,y,z])
            
            // translate radius (minus half of corner size)
            translate([radius-corner_size*0.5,0,0])
            
            // draw cube as corner
            rotate([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]]) // random rotation
            roundedcube(rands(corner_size*0.5,corner_size,1)[0],center = true);
                
        }
    }

    // Done!
}



module betterRock(radius,corner_size,number_of_corners){
    // Draw rock
    hull()
    {
        // Make a hull..
        for(i=[0:number_of_corners]){
            // random position in 'sphere'
            y = rands(0,360,1)[0];
            z = rands(0,360,1)[0];
            size = rands(corner_size*0.5,corner_size,1)[0];
            round_radius = corner_size*rands(0,20,1)[0];
            cube_x = rands(0,360,1)[0];
            cube_y = rands(0,360,1)[0];
            cube_z = rands(0,360,1)[0];

            rotate([0,y,z])
            
            // translate radius (minus half of corner size)
            translate([radius-corner_size*0.5,0,0])
            union()
            {            
            // draw cube as corner
            rotate([cube_x,cube_y,cube_z]) // random rotation
                roundedcube(size,center = true);
            }
                
        }
    }

    // Done!
}

// More information: https://danielupshaw.com/openscad-rounded-corners/


module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
    // If single value, convert to [x, y, z] vector
    size = (size[0] == undef) ? [size, size, size] : size;

    translate_min = radius;
    translate_xmax = size[0] - radius;
    translate_ymax = size[1] - radius;
    translate_zmax = size[2] - radius;

    diameter = radius * 2;

    obj_translate = (center == false) ?
        [0, 0, 0] : [
            -(size[0] / 2),
            -(size[1] / 2),
            -(size[2] / 2)
        ];

    translate(v = obj_translate) {
        hull() {
            for (translate_x = [translate_min, translate_xmax]) {
                x_at = (translate_x == translate_min) ? "min" : "max";
                for (translate_y = [translate_min, translate_ymax]) {
                    y_at = (translate_y == translate_min) ? "min" : "max";
                    for (translate_z = [translate_min, translate_zmax]) {
                        z_at = (translate_z == translate_min) ? "min" : "max";

                        translate(v = [translate_x, translate_y, translate_z])
                        if (
                            (apply_to == "all") ||
                            (apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
                            (apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
                            (apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
                        ) {
                            sphere(r = radius);
                        } else {
                            rotate = 
                                (apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
                                (apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
                                [0, 0, 0]
                            );
                            rotate(a = rotate)
                            cylinder(h = diameter, r = radius, center = true);
                        }
                    }
                }
            }
        }
    }
}