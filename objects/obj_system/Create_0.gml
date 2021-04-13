/// @desc

depth = 15000;




#region general

func_init_game = function() //initialize game and game room
	{
	#region background
	
	var _bid = layer_background_get_id("Background");
	//deactiuvate backgorund for reflect placement
	layer_background_visible(_bid, false);
	
	with(obj_water)
		{
		water_col = layer_background_get_blend(_bid);
		}
	
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
