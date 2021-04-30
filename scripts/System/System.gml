
function Func_hit(_inst)
	{
	
	with (_inst)
		{
		switch(object_index)
			{
			case obj_player:
				func_player_hit(point_direction(other.x,other.y,x,y));
			break;
			case obj_wolf:
				show_debug_message("////FUNC_HIT WOLF HIT////")
			break;
			}
		}
	}