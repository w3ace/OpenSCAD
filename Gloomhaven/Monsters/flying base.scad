

$fn=30;

union() {
	hull() {
		linear_extrude(2.4)
			circle (d=22);

		linear_extrude(1.6)
			circle (d=24.5);
	}
	linear_extrude(10)
		circle(d=1.8);
	}