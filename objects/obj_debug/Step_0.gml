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
#region o		debug fallover /////not in use
if keyboard_check_pressed(ord("O"))
	{
	
	}

#endregion
#region p		stamina = 0
if keyboard_check_pressed(ord("P"))
	{
	with obj_player
		{
		player_stamina = 0;
		}
	}

#endregion
#region u		hit
if keyboard_check_pressed(ord("U"))
	{
	with (obj_player) func_player_hit(point_direction(global.mouse_x_view,global.mouse_y_view,x,y));
	}

#endregion
#region i		blood test
if keyboard_check_pressed(ord("I"))
	{
	var _px = obj_player.x;
	var _py = obj_player.y;
	
	//var _dist = point_distance(global.mouse_x_view,global.mouse_y_view,_px,_py);
	//var _dir = point_direction(global.mouse_x_view,global.mouse_y_view,_px,_py);
	
	//Func_blood_drop_create(20,_px,_py,obj_player.bbox_bottom,1,2,1,2,3,3,6,_dir - scroll_value,_dir + scroll_value,2,_dist*2);
	
	
	
	var _hit_dir = point_direction(global.mouse_x_view,global.mouse_y_view,_px,_py);
	
	//blood
	var _num = 12;
	var _angle_lee = 20;
	var _dist_min =3;
	var _dist_max =20;
	var _spd_min =0.7;
	var _spd_max =2.2;
	var _size = 1;
	var _puddle_min = 2;
	var _puddle_max = 7;
	var _arch_min = 3;
	var _arch_max = 6;
	
	Func_blood_drop_create(_num,_px,_py,obj_player.bbox_bottom,_spd_min,_spd_max,_size,_puddle_min,_puddle_max,_arch_min,_arch_max,_hit_dir - _angle_lee,_hit_dir + _angle_lee,_dist_min,_dist_max);
	
	}

#endregion
#region z		blood buddle
if keyboard_check_pressed(ord("Z"))
	{
	
	
	Func_blood_puddle_create(BLOOD_PUDDLE_TYPE.permanent,-1,global.mouse_x_view,global.mouse_y_view,global.game_speed*2,0,10,obj_water.blood_puddle_alpha,0.5);
	}

#endregion
#region scroll value

scroll_value += mouse_wheel_up() - mouse_wheel_down();

#endregion


#endregion
