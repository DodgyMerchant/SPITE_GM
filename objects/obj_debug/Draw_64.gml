/// @desc 




if global.debug
	{
	var _y = 20;
	
	draw_set_halign(fa_left);
	Func_draw_set_alpha(1);
	Func_draw_set_color(c_white);
	Func_draw_set_font(fn_debug);
	
	#region vars
	//*
	_y = scr_debug_txt(0,_y,
	"//////GENERAL//////",
	"scroll_value "+string(scroll_value),
	"blood_water_count "+string(obj_water.blood_water_count)+"/"+string(obj_water.blood_water_clarity),
	"mxy "+string(mouse_x)+"|"+string(mouse_y),
	"mguixy "+string(global.mouse_x_gui)+"|"+string(global.mouse_y_gui),
	"mviewxy "+string(global.mouse_x_view)+"|"+string(global.mouse_y_view),
	
	"///////CAMERA//////",
	"app surf w|h: "+string(surface_get_width(application_surface))+"|"+string(surface_get_width(application_surface)),
	"cam x|y: "+string(global.View_x)+"|"+string(global.View_y),
	"port w|h: "+string(view_wport[0])+"|"+string(view_hport[0]),
	);
	//*/
	
	#region player
	var _inst = obj_player;
	if instance_exists(_inst)
	{
	#region status
	
	var _status = _inst.player_status;
	
	switch(_status)
		{
		case PLAYER_STATUS.idle:			_status = "Idle";		break;
		case PLAYER_STATUS.combat:			_status = "Combat";		break;
		case PLAYER_STATUS.exhausted:		_status = "Exhausted";	break;
		case PLAYER_STATUS.downed:			_status = "Downed";		break;
		case PLAYER_STATUS.anim_lock:		_status = "Anim_lock";	break;
		case PLAYER_STATUS.laying_menu:	_status = "Laying_menu";break;
		}
	
	#endregion
	
	_y = scr_debug_txt(0,_y,
		"////////////PLAYER//////////",
		//"stamina "+string(_inst.player_stamina),
		"x/y: "+string(_inst.x)+"/"+string(_inst.y),
		"display x/y: "+string(_inst.img_display_x)+"/"+string(_inst.img_display_y),
		"status: "+_status,
		"sprite: "+string(sprite_get_name(_inst.sprite_index)),
		"img_index "+string(_inst.img_index),
		"img_indexs "+string(_inst.img_index_show),
		"img_speed "+string(_inst.img_speed),
		"img_type "+string(_inst.img_type),
		"speed x/y: "+string(_inst.player_spd_x)+"/"+string(_inst.player_spd_y),
		"///////////COMBAT/////////////",
		"brace count: "+string(_inst.combat_brace_count),
		"attack count: "+string(_inst.combat_attack_ready_count),
		"direction: "+string(_inst.combat_direction),
		
		
		);
	
	//player stamina bar
	var _guix = display_get_gui_width();
	var _guiy = display_get_gui_height();
	var _x1 = _guix / 10;
	var _x2 = _guiy - _guiy / 8;
	var _y1 = _guix - _guix / 10;
	var _y2 = _guiy - _guiy / 20;
	
	draw_set_color(c_white);
	draw_rectangle(_x1,_y1,lerp(_x1,_x2,_inst.player_stamina / _inst.player_stamina_max),_y2,false);
	draw_set_color(c_red);
	draw_rectangle(_x1,_y1,_x2,_y2,true);
	}
	#endregion
	
	
	#endregion
	#region DS
	
	Func_draw_set_color(c_white);
	draw_set_halign(fa_right);
	
	var _y = 20;
	var _x = display_get_gui_width();
	
	_y = scr_debug_txt(_x,_y,
	"splosh list size: "+string(ds_list_size(obj_water.splosh_display_list))
	);
	_y = scr_debug_list(_x,_y,obj_water.blood_puddle_list,"blood_puddle_list");//doesnt look informative
	
	
	
	
	
	
	#endregion
	
	}