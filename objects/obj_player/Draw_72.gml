/// @desc 




//water reflec
var _mult;
switch(player_status)//get _mult
	{
	case PLAYER_STATUS.laying:
		_mult = 0;
		break;
	case PLAYER_STATUS.sitting:
		if sprite_index == spr_player_standup
			_mult = image_index/image_number;
		else   
			_mult = 0;
		break;
	default:
		_mult = 1;
	}


Func_water_draw_self_reflection(_mult);

