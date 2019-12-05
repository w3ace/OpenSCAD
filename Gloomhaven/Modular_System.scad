// modular dungeon system
// uses Brick Library to create modular terrain
// by Les Hall
// started Wed Apr 13 2016, 2:14 AM
//



// include library
//include <Brick Library.scad>



// instantiate one floor tile
rough_bricks();
//simple_cobbles();

module rough_bricks() {

    // make the floor tile of overlapping bricks
    div = 8;
    tile_size = 25.4;
    x_factor = 1.5;
    y_factor = 1.1;

    for (x=[0:div-1], y=[0:div-1]) {
        translate([1, 1, 0] * tile_size/div/2)
         translate([((y%2==0)? x*x_factor*2*.9 : x*x_factor*2*.9-x_factor*2*.45), y, 0]  * tile_size/div)
        // translate([x*2+x, y, 0]  * tile_size/div)
        cobble ([
            tile_size/div*x_factor, 
            tile_size/div*y_factor, tile_size/8], 
            2, 0.75, 12, 4);
    }
}


// make a floor tile from many bricks
module simple_cobbles() {

    // make the floor tile of overlapping bricks
    div = 8;
    tile_size = 25.4;
    x_factor = 1.25;
    y_factor = 1.1;

    for (x=[0:div-1], y=[0:div-1]) {
        translate([1, 1, 0] 
            * tile_size/div/2)
        translate([x, y, 0] 
            * tile_size/div)
        cobble ([
            tile_size/div*x_factor, 
            tile_size/div*y_factor, tile_size/8], 
            1, 0.75, 12, 4);
    }
}


function sigmoid(x, tau) = 1/(1+exp(x/tau))-1/2;



// one brick
module cobble (s=[8, 4, 3], x=1, tau=0.75, k=11, cubes=4) {
    
    // make the brick
    hull() {  // hull does a shrinkwrap, creating low poly
        // add features
        for (f=[0:cubes-1]) {
            translate([
                sigmoid(rands(-1, 1, 1)[0], tau) * s[0]/k, 
                sigmoid(rands(-1, 1, 1)[0], tau) * s[1]/k, 
                sigmoid(rands(-1, 1, 1)[0], tau) * s[2]/k 
            ])
            scale ([x,1,1])
                rotate(rands(-10, 10, 1)[0], rands(-1, 1, 3))
                    cube(s*rands(0.75, 0.85, 1)[0], center=true);
        }
    }
}



