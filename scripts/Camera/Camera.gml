


function Func_camera_set_pos_center(_x,_y)
	{
	Func_camera_set_pos(_x - global.View_width/2,_y - global.View_height/2);
	
	}

function Func_camera_set_pos(_x,_y)
	{
	global.View_x = _x;
	global.View_y = _y;
	}


//seek system

function Func_camera_seek_set(_type,_val,_x,_y)	//set target type value and position
	{
	with (obj_camera)
		{
		camera_seek_type = _type;
		camera_seek_val = _val;
		camera_seek_target_x = _x;
		camera_seek_target_y = _y;
		}
	}

function Func_camera_seek_set_seek(_x,_y)		//set target position
	{
	with (obj_camera)
		{
		camera_seek_target_x = _x;
		camera_seek_target_y = _y;
		}
	}

function Func_camera_seek_set_pos(_x,_y)	//sets the camera position
	{
	with (obj_camera)
		{
		camera_seek_pos_x = _x;
		camera_seek_pos_y = _y;
	
		camera_seek_target_x = _x;
		camera_seek_target_y = _y;
		}
	}

function Func_camera_seek_set_type(_type,_val)	//set target type value and position
	{
	with (obj_camera)
		{
		camera_seek_type = _type;
		camera_seek_val = _val;
		}
	}

function Func_camera_seek_calc()		//calculate camera moevement
	{
	
	var _dist = point_distance(camera_seek_pos_x,camera_seek_pos_y,camera_seek_target_x,camera_seek_target_y);
	var _dir = point_direction(camera_seek_pos_x,camera_seek_pos_y,camera_seek_target_x,camera_seek_target_y);
	
	switch(camera_seek_type)
		{
		#region none
		case CAMERA_SEEK_TYPE.none:
			
			_dist = 0;
			
		break;
		#endregion
		#region linear
		case CAMERA_SEEK_TYPE.linear:
			
			_dist = min(_dist,camera_seek_val)
			
		break;
		#endregion
		#region fract
		case CAMERA_SEEK_TYPE.fraction:
			
			_dist = _dist / camera_seek_val;
			
		break;
		#endregion
		default:
			if animcurve_exists(camera_seek_type) == true
				{
				
				
				
				
				}
			show_debug_message("non viable cam type")
		}
	
	if _dist != 0
		{
		camera_seek_pos_x += lengthdir_x(_dist,_dir);
		camera_seek_pos_y += lengthdir_y(_dist,_dir);
		}
	
	Func_camera_seek_apply();
	}

function Func_camera_seek_apply()		//apply camera 
	{
	Func_camera_set_pos_center(camera_seek_pos_x,camera_seek_pos_y);
	}

function Func_camera_seek_disable()		//apply camera 
	{
	with (obj_camera)
		{
		camera_seek_type = CAMERA_SEEK_TYPE.none;
		camera_seek_val = 0;
		}
	}

function Func_camera_point_in_view(_x,_y)	//get if point is in camera view
	{
	return point_in_rectangle(_x,_y,global.View_x,global.View_y,global.View_x + global.View_width,global.View_y + global.View_height);
	}

function Func_camera_obj_in_view(_id)		//if obj bbox is in camera | return 1-4 == true	| return 0 == false
	{
	var _x,_y;
	var i=1;
	
	with (_id)
	repeat(4)
		{
		switch(i)
			{
			case 1:
			_x = bbox_left;
			_y = bbox_top;
			break;
			case 2:
			_x = bbox_right;
			_y = bbox_top;
			break;
			case 3:
			_x = bbox_left;
			_y = bbox_bottom;
			break;
			case 4:
			_x = bbox_right;
			_y = bbox_bottom;
			break;
			}
		
		if Func_camera_point_in_view(_x,_y)
			{
			return i;
			}
		i++;
		}
	
	
	return 0;
	
	}