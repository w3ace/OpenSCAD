//============================================================
// OpenSCAD
// Lisence
//============================================================
/*

	Usage:
	use <Hexagones.scad>;
	Pour créer des jeux, des têtes de vis...

*/


//------------------------------------------------------------
// Demo
//------------------------------------------------------------
$fn = 25 ;			// OpenSCAD Resolution
connector_center = 3.4;
connector_diameter = 2.6;
connectors = [0,120,240];


//connector(connector_center, connector_diameter);
difference () {
	basehex(connectors);

	//translate ([-20,-20,3.6])
	//	scale ([.5,.5,.5])
	//        import ("water optimized	.stl", convexity=10);
}

module connector(center=3.4,diameter=3) {

	height = 1.8;
	shaft_length = 6.2;
	slop = 0.4;

					union () {
						for(i=[0:1]) {
						intersection () {
							translate([(center*2+shaft_length)*i,0,1])
							rotate_extrude(convexity=10)
								translate ([center,0,0])
									circle (d=diameter-slop);
								linear_extrude(height)
									translate ([-10+(center*2+shaft_length)*i,-10,0])
										square(size=20);
									}
								}

						linear_extrude(1.8)
							translate([center,(-diameter+slop)/2,0])
								square([6,diameter-slop]);
					}	
}

module basehex (connectors=[0:60:300]) {

	cle = 33;
	baseheight = 3;

	difference () {
		union() {
			translate([0,0,(baseheight-.4)/2])
				Hexagon(cle=cle,h=baseheight);
			hull() {
				translate([0,0,(baseheight+.2)/2])
					Hexagon(cle=cle-2,h=baseheight+.2);
				translate([0,0,(baseheight+.6)/2])
					Hexagon(cle=cle-4,h=baseheight+.6);
			}
		}
		connector_cutouts(10,connectors);
	} 

}

module connector_cutouts (size,connectors) {

	diameter = 3;
	center = 3.4;

		for (i=connectors) {
			rotate([0,0,i])
				translate ([size,0,0])
					union () {
						intersection () {
							translate([0,0,1])
							rotate_extrude(convexity=10)
								translate ([center,0,0])
									circle (d=diameter);
								linear_extrude(2.2)
									translate ([-10,-10,0])
										square(size=20);
									}
						linear_extrude(2.2)
							translate([diameter,-1.6,0])
								square([4,3.2]);
					}
		}
}


//------------------------------------------------------------
// Hexagone
// cle	écart, ex: clé de 12 alors cle=12
// h		hauteur
//------------------------------------------------------------
module Hexagon(cle,h)
{
	angle = 360/6;		// 6 pans
	cote = cle * cot(angle);

	union()
	{
		rotate([0,0,0])
			cube([cle,cote,h],center=true);
		rotate([0,0,angle])
			cube([cle,cote,h],center=true);
		rotate([0,0,2*angle])
			cube([cle,cote,h],center=true);
	}

// Vérification par un cercle de taille cle
//	#cylinder(r=cle/2,h=2*h,center=true);
//	%circle(r=cote,center=true);
//	#cube([cote,cote,1]);
}

//------------------------------------------------------------
// Fonction cotangente
// Permet d'avoir les bones dimensions
// utiliser $fn n'est pas bon
//------------------------------------------------------------
function cot(x)=1/tan(x);

//==EOF=======================================================