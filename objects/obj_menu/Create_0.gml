/// @desc 




#region layout
enum MENUBUTTONS
	 {
	 start,
	 tutorial,
	 ex,
	 Height
	 }

var _title_sep = 4;
var _title_h = sprite_get_height(spr_title);
title_y = _title_sep + _title_h/2;


button_menu_start_y = _title_sep * 2 + _title_h;
button_height = 12;
button_width = 50;
button_sep = 4;
button_font = fn_pixel;




#endregion
#region set

with(obj_player)
	{
	func_player_status_set(PLAYER_STATUS.laying_menu);
	}

Func_camera_seek_disable();

var _menu_y2 = button_menu_start_y + MENUBUTTONS.Height * button_height + (MENUBUTTONS.Height-1) * button_sep;
var _free_space_center = (_menu_y2 - display_get_gui_height());



with(obj_player)
	Func_camera_set_pos_center(x + downed_cam_offset_x,y + downed_cam_offset_y + _free_space_center);

#endregion