/// @func scr_name(dist,prog);
/// @desc description
/// @arg {real} dist distance of the wave
/// @arg {real} prog progress of wave | 0==begin of wave  1==end of wave
function scr_wave2(argument0, argument1) {

	/*
	a wave at 0 -> distance
	from 0 == begi of wave
	to 1 == end of wave


	game time	  start time	convert to seconds	double time in one wave -> 2 second wave
	(current_time-begin_time)	* 0.001				* 0.5
	this uses the game running time as a automatic progress counter
	if the wave has to start at 0 a begin time should be taken from the game time and subtracted
	so the time used is 0
	*/

	var _dist = argument0*0.5;

	return _dist * -cos((pi*2) * argument1) + _dist;




}
