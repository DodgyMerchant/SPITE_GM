// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


// all this trouble to get fractional mouse coordinates!

function Func_mouse_GUI_update()	//mouse woking with new camera gui
	{
	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();
	var _wnd_w = window_get_width();
	var _wnd_h = window_get_height();
	var gui_scale = min(_wnd_w / _gui_w, _wnd_h / _gui_h) ;
	var _gui_x = (_wnd_w - _gui_w * gui_scale) div 2;
	var _gui_y = (_wnd_h - _gui_h * gui_scale) div 2;
	
	global.mouse_x_gui = (window_mouse_get_x() - _gui_x) / gui_scale / global.gui_size;
	global.mouse_y_gui = (window_mouse_get_y() - _gui_y) / gui_scale / global.gui_size;
	}
function Func_mouse_view_update() //mouse working with new camera gui and view
	{
	global.mouse_x_view = global.mouse_x_gui + global.View_x;
	global.mouse_y_view = global.mouse_y_gui + global.View_y;
	}