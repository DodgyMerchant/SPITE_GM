/// @desc

depth = 15000;




#region general

window_set_caption("S P I T E");

func_init_level = function() //init the level		| level & tutorial
	{
	#region background
	
	var _bid = layer_background_get_id("Background");
	//deactiuvate backgorund for reflect placement
	layer_background_visible(_bid, false);
	
	#region water
	with(obj_water)
		{
		water_clear_col = layer_background_get_blend(_bid);
		}
	#endregion
	#region player and cam
	
	with(obj_player)
		{
		if player_status != PLAYER_STATUS.laying_menu
			{
			func_player_status_set(PLAYER_STATUS.downed);
			
			//fast cam
			var _x = x + downed_cam_offset_x;
			var _y = y + downed_cam_offset_y;
			Func_camera_seek_set_pos(_x,_y);
			}
		}
	
	#endregion
	
	
	#endregion
	}

global.game_speed = game_get_speed(gamespeed_fps);

room_goto(rm_game);

#endregion

#region PBI
//create and setup the PBI SYSTEM | here because it is only run one time
Scr_PBI();

#endregion
#region ContactGround

scr_Contact_Ground_System(); //Func_Splosh_get_activate(_spr,_index)

#endregion




