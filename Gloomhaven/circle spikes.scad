/*
 * Base Tiles - Hexagon Dungeon Tiles
 * By Craig Wood
 *
 */

$fn=20;

union() {
	for(i=[0:200]) {
		x = rands(1,360,1);
		y = rands(1,360,1);
		z = rands(1,360,1);
		h = rands(12,16,1);

		rotate([x[0],y[0],z[0]])
			cylinder(r1=.5,r2=.2,h=h[0]);

	}
}
