/// @desc 

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _gui_w2 = _gui_w/2;

#region title

draw_sprite(spr_title,0,_gui_w2,title_y);


#endregion
#region draw buttons

//draw button function
var _func_draw_button = function(_x,_y)
	{//takes the top middle position
	
	var _w = button_width/2;
	var _h = button_height;
	
	draw_rectangle(_x-_w,_y,_x+_w,_y+_h,true);
	
	return _y+_h;
	}

//go through buttons

var _y = button_menu_start_y;
for (var i=0;i< MENUBUTTONS.Height;i++)
	{
	_y = _func_draw_button(_gui_w/2,_y) + button_sep;
	}

#endregion