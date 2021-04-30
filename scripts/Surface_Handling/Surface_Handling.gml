

function Func_SH_continuous_hygene(_surf,_w,_h)
	{//returns the surface	///NEEDS TO BE RETURNED
	
	//surface exists
	if surface_exists(_surf)
		{
		surface_set_target(_surf);
		draw_clear_alpha(0,0);
		surface_reset_target();
		
		return _surf;
		}
	else//surf got destroyed
		{
		return surface_create(_w,_h);
		}
	}