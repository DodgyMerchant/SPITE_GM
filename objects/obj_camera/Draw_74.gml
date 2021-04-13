/// @desc 




if (surface_exists(view_surf))
	{
	var _x = global.View_x>0 ? frac(global.View_x) : frac(global.View_x)+1;//balance out weird around 0
	var _y = global.View_y>0 ? frac(global.View_y) : frac(global.View_y)+1;
	
    draw_surface_part_ext(view_surf, _x, _y, global.View_width, global.View_height, 0, 0, global.gui_size, global.gui_size, -1, 1);
	//draw_surface_ext(view_surf, -frac(global.View_x)*global.gui_size, -frac(global.View_y)*global.gui_size, global.gui_size, global.gui_size, 0, -1, 1);
	
	}