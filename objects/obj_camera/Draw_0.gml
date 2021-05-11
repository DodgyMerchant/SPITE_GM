/// @desc 


if global.debug
	{
	Func_draw_set_color(c_green);
	if camera_seek_type != CAMERA_SEEK_TYPE.none
		{
		draw_point(camera_seek_pos_x,camera_seek_pos_y);
		}
	else
		draw_point(global.View_x+global.View_width/2,global.View_y+global.View_height/2);
	
	
	}