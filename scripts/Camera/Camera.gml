


function Func_camera_set_pos_center(_x,_y)
	{
	Func_camera_set_pos(_x - global.View_width/2,_y - global.View_height/2);
	
	}

function Func_camera_set_pos(_x,_y)
	{
	global.View_x = _x;
	global.View_y = _y;
	}