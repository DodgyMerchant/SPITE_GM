/// @desc 



#region debug

#region j		debug
if keyboard_check_pressed(ord("J"))
	{
	global.debug = !global.debug;
	show_debug_overlay(global.debug);
	}
#endregion
#region r		debug
if keyboard_check_pressed(ord("R"))
	{
	game_restart();
	}
#endregion

#region o		debug fallover
if keyboard_check_pressed(ord("O"))
	{
	with obj_player {func_player_status_set(PLAYER_STATUS.laying)}
	}

#endregion
#region p		debug combat
if keyboard_check_pressed(ord("P"))
	{
	with obj_player
		{
		if player_status == PLAYER_STATUS.idle
			func_player_status_set(PLAYER_STATUS.combat);
		else if player_status == PLAYER_STATUS.combat
			func_player_status_set(PLAYER_STATUS.idle);
		}
	}

#endregion
#region scroll value

scroll_value += mouse_wheel_up() - mouse_wheel_down();

#endregion

#endregion