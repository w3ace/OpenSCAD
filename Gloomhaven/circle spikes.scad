/*
 * Base Tiles - Hexagon Dungeon Tiles
 * By Craig Wood
 *
 */

$fn=20;

union() {
	for(i=[0:40]) {
		x = rands(1,180,1);
		y = rands(1,180,1);
		z = rands(91,360,1);
		h = rands(8,14,1);

		rotate([x[0],y[0],0])
			cylinder(r1=.5,r2=.2,h=h[0]);

	}
}
