/// @desc 


if life_count < life
	{
	//progression
	var _t = (life_count / life);
	
	display_x = lerp(xstart,target_x,_t);
	display_y = lerp(ystart,target_y,_t) - animcurve_channel_evaluate(ac_arc,_t) * arc_height;
	}
else
	func_blood_end();
	
	
	
	
	
life_count++;
