
module brick (height,radius,rands)
{
    for(i=[1:100]) {
        echo(radius,height);
            rotate([0,0,rands(0,360,1)[0]]) 
                    translate([radius-.9,0,rands(1,height,1)[0]]) 
                        cube([2,1,.5],center=true); 
    }
}

radius = 9;
height = 12;

cylinder(height,radius,radius);
brick(height,radius);


