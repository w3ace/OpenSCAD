//============================================================
// OpenSCAD
// Licence : LICENCE PUBLIQUE RIEN À BRANLER
// Licence : do What The Fuck you want to Public License
//============================================================
/*

	Usage:
	use <Hexagones.scad>;
	Pour créer des jeux, des têtes de vis...

*/


//------------------------------------------------------------
// Demo
//------------------------------------------------------------
$fn = 15 ;			// OpenSCAD Resolution
connector_center = 3.4;
connector_diameter = 2.6;

connector(connector_center, connector_diameter);

//basehex();

module connector(center=3.4,diameter=3) {
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
							translate([center,-diameter/2,0])
								square([6,diameter]);
						translate([center*2+6,0,0])
						intersection () {
							translate([0,0,1])
							rotate_extrude(convexity=10)
								translate ([center,0,0])
									circle (d=diameter);
								linear_extrude(2.2)
									translate ([-10,-10,0])
										square(size=20);
									}
					}
}

module basehex () {
	difference () {

		hull() {
			translate([0,0,1.5])
				Hexagon(cle=33,h=3.0);
			translate([0,0,1.8])
				Hexagon(cle=31,h=3.6);
		}
		connector_cutouts(10);
	} 

}

module connector_cutouts (size) {

	diameter = 3;
	center = 3.4;

		for (i=[0:60:300]) {
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