// modular dungeon system
// uses Brick Library to create modular terrain
// by Les Hall
// started Wed Apr 13 2016, 2:14 AM
//



// include library
//include <Brick Library.scad>



// instantiate one floor tile

minkowski () {
    crack_maker(0,0,3,3,30,30,1);
    cube(.5);
}
//rough_bricks(1,4);
//simple_cobbles();

module rough_bricks(length=2,num_blocks=8) {

    // make the floor tile of overlapping bricks
    tile_size = 25.4;
    x_factor = 1.5;
    y_factor = 1.1;

    for (x=[0:num_blocks-1], y=[0:num_blocks-1]) {
        translate([1, 1, 0] * tile_size/num_blocks/2)
         translate([((y%2==0)? x*x_factor*length*.9 : x*x_factor*length*.9-x_factor*length*.45), y, 0]  * tile_size/num_blocks)
        // translate([x*2+x, y, 0]  * tile_size/num_blocks)
        cobble ([
            tile_size/num_blocks*x_factor, 
            tile_size/num_blocks*y_factor, tile_size/8], 
            length, 0.75, 12, 4);
    }
}


// make a floor tile from many bricks
module simple_cobbles(num_blocks=8) {

    // make the floor tile of overlapping bricks
    num_blocks = 8;
    tile_size = 25.4;
    x_factor = 1.25;
    y_factor = 1.1;

    for (x=[0:num_blocks-1], y=[0:num_blocks-1]) {
        translate([1, 1, 0] 
            * tile_size/num_blocks/2)
        translate([x, y, 0] 
            * tile_size/num_blocks)
        cobble ([
            tile_size/num_blocks*x_factor, 
            tile_size/num_blocks*y_factor, tile_size/8], 
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

module crack_maker (x=0,y=0,x_len=3,y_len=3,x_total_length=30,y_total_length=30,crack_width,i=0,j=0) {

    x1 = rands((x_len>0 ? x : x+x_len),
                (x_len>0 ? x+x_len : x),1);
    y1 = rands((y_len>0 ? y : y+y_len),
                (y_len>0 ? y+y_len : y),1);

    branch = rands(1,100,1);
   if(branch[0]<4 && i==0 && j==0) { 
      echo ("new branch");
              crack_maker (x,y,x_len,-y_len,x_total_length,y_total_length,crack_width,i,j+1);
    }
    if(branch[0]>96 && i==0 && j==0) { 
      echo ("new branch");
              crack_maker (x,y,-x_len,y_len,x_total_length,y_total_length,crack_width,i+1,j);
    }
    echo (x,y,x1[0],y1[0],x_len,y_len);
    linear_extrude(1)
        polygon(points=[[x,y],[x,y-crack_width],[x1[0],y1[0]-crack_width],[x1[0],y1[0]]]);

    if(x1[0] < x_total_length && y1[0] < y_total_length && y1[0] > 0 && x1[0]> 0) {
  
         crack_maker(x1[0],y1[0],x_len,y_len,x_total_length,y_total_length,crack_width,i);
     }
}

