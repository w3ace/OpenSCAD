/*
Game Box Organizer
Created by: Craig Wood
Last Modified: Nov. 22, 2016
*/


// Round Bottom is based off width and always runs the length

CardBox (25,48,40.5,32,58,1.6,16,8,17,8,18,18,0);
/*translate([29,0,0]) 
	CardBox (25,48,40.5,32,58,1.6,16,8,17,8,18,18,0);

translate([58,0,0]) 
	CardBox (45,48,40.5,52,58,1.6,16,8,17,8,18,18,0);
/*
translate([85,0,0])
	CardBox (33,78,33.5,40,85,1.6,16,12,17,12,18,6,1);
translate([0,210,0])
	rotate([0,0,270])
		CardBox (33,78,33.5,40,85,1.6,16,12,17,12,18,6,0);

*/



/*

// Container 1 for Gilded Compass

CardBox (57,32,60,73,45,1.6,22,17,17,12,12,0,0);
translate([0,45,0])
	CardBox (65,55,60,73,68,1.6,22,17,22,17,12,0,0);
translate([0,113,0])
	CardBox (62,32,60,73,45,1.6,22,17,17,12,12,0,0);
translate([0,158,0])
	CardBox (57,32,60,73,45,1.6,22,17,17,12,12,0,0);

	*/


module CardBox (length,width,height,outer_length,outer_width,base,bottom_len_l,top_len_l,
				bottom_len_w,top_len_w,bottom_height_l,bottom_height_w,bottom_type) {

// bottom_type is 0 for hollowed, 1 for filled, 2 for round

	bottom_width_l = (outer_length-length )/ 2;
	top_width_l = bottom_width_l - 1.5;
	total_height = base+height;
	bottom_width = (outer_width-width) / 2;
	top_width = bottom_width - 1.5;


	echo ("Top Width L",top_width,top_width_l,bottom_width,bottom_width_l,outer_width,width);

	FullBoxPoints = [
	  [  0,  0,  0 ],  //0
	  [ outer_length,  0,  0 ],  //1
	  [ outer_length,  outer_width,  0 ],  //2
	  [  0,  outer_width,  0 ],  //3
	  [  0,  0,  total_height ],  //4
	  [ outer_length,  0,  total_height ],  //5
	  [ outer_length,  outer_width,  total_height ],  //6
	  [  0,  outer_width,  total_height ]]; //7


	HollowFullBox = [
	  [ bottom_width_l,  bottom_width,  base ],  //0
	  [ outer_length-bottom_width_l,  bottom_width,  base ],  //1
	  [ outer_length-bottom_width_l,  outer_width-bottom_width,  base ],  //2
	  [  bottom_width_l,  outer_width-bottom_width,  base ],  //3
	  [  top_width_l,  top_width,  total_height ],  //4
	  [ outer_length-top_width_l,  top_width,  total_height ],  //5
	  [ outer_length-top_width_l,  outer_width-top_width,  total_height ],  //6
	  [  top_width_l,  outer_width-top_width,  total_height ]]; //7
	  
	HollowRoundBox = [
	  [ bottom_width_l,  bottom_width,  base+(bottom_width/2) ],  //0
	  [ outer_length-bottom_width_l,  bottom_width,base+(bottom_width/2) ],  //1
	  [ outer_length-bottom_width_l,  outer_width-bottom_width,  base+(bottom_width/2)],  //2
	  [  bottom_width_l,  outer_width-bottom_width,  base+(bottom_width/2) ],  //3
	  [  top_width_l,  top_width,  total_height ],  //4
	  [ outer_length-top_width_l,  top_width,  total_height ],  //5
	  [ outer_length-top_width_l,  outer_width-top_width,  total_height ],  //6
	  [  top_width_l,  outer_width-top_width,  total_height ]]; //7

	HollowLength = [
	  [  0,  bottom_len_w,  bottom_height_l ],  //0
	  [ outer_length,  bottom_len_w,  bottom_height_l ],  //1
	  [ outer_length,  outer_width-bottom_len_w,  bottom_height_l ],  //2
	  [ 0,  outer_width-bottom_len_w,  bottom_height_l ],  //3
	  [  0,  top_len_w,  total_height ],  //4
	  [ outer_length , top_len_w,  total_height ],  //5
	  [ outer_length,  outer_width-top_len_w,  total_height ],  //6
	  [  0, outer_width-top_len_w,  total_height ]]; //7
  
	HollowWidth = [
	  [ bottom_len_l,  0,  bottom_height_w ],  //0
	  [ outer_length-bottom_len_l,  0,  bottom_height_w ],  //1
	  [ outer_length-bottom_len_l,  outer_width,  bottom_height_w ],  //2
	  [ bottom_len_l,  outer_width,  bottom_height_w ],  //3
	  [ top_len_l,  0,  total_height ],  //4
	  [ outer_length-top_len_l,  0,  total_height ],  //5
	  [ outer_length-top_len_l,  outer_width,  total_height ],  //6
	  [ top_len_l,  outer_width,  total_height ]]; //7

	HollowBottom = [
	  [ bottom_width_l+7,  bottom_width+7,  0 ],  //0
	  [ outer_length-bottom_width_l-7,  bottom_width+7,  0 ],  //1
	  [ outer_length-bottom_width_l-7,  outer_width-bottom_width-7,  0 ],  //2
	  [  bottom_width_l+7,  outer_width-bottom_width-7,  0 ],  //3
	  [  bottom_width_l+7,  bottom_width+7,  base ],  //4
	  [ outer_length-bottom_width_l-7,  bottom_width+7,  base ],  //5
	  [ outer_length-bottom_width_l-7,  outer_width-bottom_width-7,  base ],  //6
	  [  bottom_width_l+7,  outer_width-bottom_width-7,  base ]]; //7

	 FillBottom = [
	  [  bottom_width_l-2,  bottom_width-2,  0 ],  //0
	  [ outer_length-bottom_width_l+2,  bottom_width-2,  0 ],  //1
	  [ outer_length-bottom_width_l+2,  outer_width-bottom_width+2,  0 ],  //2
	  [  bottom_width_l-2,  outer_width-bottom_width+2,  0 ],  //3
	  [  bottom_width_l-2,  bottom_width-2,  base ],  //4
	  [ outer_length-bottom_width_l+2,  bottom_width-2,  base ],  //5
	  [ outer_length-bottom_width_l+2,  outer_width-bottom_width+2,  base ],  //6
	  [  bottom_width_l-2,  outer_width-bottom_width+2,  base ]]; //7

	  RoundBottom =[
	  ];

	CubeFaces = [ [0,1,2,3], [4,5,1,0],  [7,6,5,4],  [5,6,2,1],  [6,7,3,2],   [7,4,0,3]]; // left

	difference() {
		union () {
			difference () {
				polyhedron( FullBoxPoints, CubeFaces );
				if (bottom_type==2) {
					polyhedron( HollowRoundBox, CubeFaces );
				} else {
					polyhedron( HollowFullBox, CubeFaces );
				}
				polyhedron( HollowLength, CubeFaces );
				polyhedron( HollowWidth, CubeFaces );
			}
				polyhedron( FillBottom, CubeFaces);
			}
			if (bottom_type==0) {
				polyhedron( HollowBottom, CubeFaces );
			}
		}
	
}