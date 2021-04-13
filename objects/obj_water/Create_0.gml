/// @desc 





#region water

water_col = 0;


#endregion
#region water reflection

//global.Water_surf = surface_create(global.View_width,global.View_height);

//water_reflec_a = 0.4;//0.6

//Water_Reflect();//setup global function

#endregion
#region Splosh Water ripples
scr_Splosh();//setup the global Function

//vars
splosh_display_list = ds_list_create();
splosh_col = c_maroon;

//constructor
func_Splosh_construct = function(_type,_x,_y) constructor
	{
	type = _type;
	x = _x;
	y = _y;
	
	switch(type)
		{
		case CG_TYPE.continued:
		size=7
		duration = 1 * global.game_speed;
		alpha = 0.3;
		times = 1;
		break;
		case CG_TYPE.latest:
		size=17
		duration = 3 * global.game_speed;
		alpha = 0.5;
		times = 1;
		break;
		}
	
	count = duration;
	
	func_draw = function()
		{
		//drawing and calc
		var _t = (count / duration);	//tansition
		//var _it = (_t * -1) +1;			//inverted
		
		Func_draw_set_alpha(lerp(0,alpha,_t));
		draw_circle(x,y,lerp(size,1,_t),true);
		if global.debug draw_point(x,y);
		
		//duration
		count--;//deleted by obj_water
		}
	
	toString = function()
		{
		return "t:"+string(type)+"|d:"+string(duration);
		}
	}

#endregion
#region Blood on water









#endregion
