// Brick Library
// to preserve the work I did making a brick
// by Les Hall
// started Sun April 10 2016, 4:34 pm
//



// calculations
// sigmoid function
function sigmoid(x, tau) = 1/(1+exp(x/tau))-1/2;



// one brick
module brick(s=[8, 4, 3], tau=0.75, k=11, cubes=4) {
    
    // make the brick
    hull() {  // hull does a shrinkwrap, creating low poly
        // add features
        for (f=[0:cubes-1]) {
            translate([
                sigmoid(rands(-1, 1, 1)[0], tau) * s[0]/k, 
                sigmoid(rands(-1, 1, 1)[0], tau) * s[1]/k, 
                sigmoid(rands(-1, 1, 1)[0], tau) * s[2]/k 
            ])
            rotate(rands(-10, 10, 1)[0], rands(-1, 1, 3))
            cube(s*rands(0.75, 0.85, 1)[0], center=true);
        }
    }
}

