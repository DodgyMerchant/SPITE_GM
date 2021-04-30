/// @desc 


#region camera create
/*//////////////

100 x 100
800 x 800


*///////////////

#macro view view_camera[0]

global.View_x = 0;
global.View_y = 0;
global.View_x_frac = 0;	//actual view position
global.View_y_frac = 0;

application_surface_enable(false);

global.View_width = 100;
global.View_height = 100;
window_size = 8;
global.gui_size = 8;

// prevent default scaling behaviour:
surface_resize(application_surface, global.View_width, global.View_height);
display_set_gui_size(global.View_width * global.gui_size, global.View_height * global.gui_size);
camera_set_view_size(view, global.View_width + 1, global.View_height + 1);

view_surf = -1;


window_set_size(global.View_width * window_size, global.View_height * window_size);
alarm[0]=1;
#endregion


#region camera seek

camera_seek_pos_x = x;
camera_seek_pos_y = y;
camera_seek_target_x = x;
camera_seek_target_y = y;
camera_seek_type = CAMERA_SEEK_TYPE.linear;
camera_seek_val = 0;
enum CAMERA_SEEK_TYPE
	{
	none = -1,
	linear = -2,
	fraction = -3
	}



#endregion
