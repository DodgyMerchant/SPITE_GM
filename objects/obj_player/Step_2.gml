/// @desc 

event_inherited();

#region image

var _input_move_any = input_x!=0 or input_y!=0;//any movement input
var _moving = player_spd_x!=0 or player_spd_y!=0 

switch(player_status)
	{
	#region idle
	case PLAYER_STATUS.idle:
	
	#region xscale
	
	if player_spd_x!=0
		{
		image_xscale = sign(player_spd_x);
		}
	
	#endregion
	
	#region sprite
	
	if _moving//moving
		{
		if _input_move_any//wanting to move
			{
			if sprite_index != spr_player_walk_h
			if sprite_index != spr_player_walk_h_start
				{
				func_anim_sprite_set_full(spr_player_walk_h_start);
				}
			else if img_looped
				{
				func_anim_sprite_set_full(spr_player_walk_h);
				}
			}
		//not wanting to move but moving
		else if sprite_index != spr_player_walk_h_stop 
			{
			if img_looped //either start or stop runb out
				func_anim_sprite_set_full(spr_player_walk_h_stop);
			}
		else if img_looped//if animation stop playing and animation is done
			{
			//stop player speed
			func_player_speed_reset();
			
			func_anim_sprite_set_full(spr_player_idle1);
			func_anim_index_set_type(IMG_TYPE.pingpong_edgeless);//smoother edge animation
			}
		}
	else
		{
		if sprite_index != spr_player_idle1
			{
			func_anim_sprite_set_full(spr_player_idle1);
			func_anim_index_set_type(IMG_TYPE.pingpong_edgeless);//smoother edge animation
			}
		}
	
	
	#endregion
	
	break;
	#endregion
	#region combat
	case PLAYER_STATUS.combat:
	
	/*
	//brace
	func_combat_brace_active()
	combat_brace
	
	func_player_speed_reset();
	func_anim_sprite_set_full(spr_p);
	img_looped
	if sprite_index !=
	
	
	*/
	
	
	if _moving//moving
		{
		if _input_move_any//wanting to move
			{
			if sprite_index != spr_player_walk_h
				{
				func_anim_sprite_set_full(spr_player_walk_h_start);
				}
			}
		//not wanting to move but moving
		else if sprite_index != spr_player_walk_h_stop 
			{
			if img_looped //either start or stop runb out
				func_anim_sprite_set_full(spr_player_walk_h_stop);
			}
		else if img_looped//if animation stop playing and animation is done
			{
			//stop player speed
			func_player_speed_reset();
			
			func_anim_sprite_set_full(spr_player_standing);
			func_anim_image_set_speed(0);
			}
		}
	else
		{
		if sprite_index != spr_player_standing
			{
			func_anim_sprite_set_full(spr_player_standing);
			func_anim_image_set_speed(0);
			}
		}
		
	
	
	
	
	
	
	
	
	image_xscale = combat_direction;
	
	
	break;
	#endregion
	#region exhausted
	case PLAYER_STATUS.exhausted:
	
	
	
	break;
	#endregion
	#region laying
	case PLAYER_STATUS.laying:
		//sitting up   image index to situp effort
		img_index = lerp(0,image_number-1,situp_value / situp_value_max);
	break;
	#endregion
	#region sitting
	case PLAYER_STATUS.sitting:
		
	break;
	#endregion
	default: show_debug_message("End Step /// image /// STATUS NOT FOUND!!!");
	}



#endregion
#region footsteps


if img_index_fresh//on new frame for PBI animations
		func_player_step();

if img_type == IMG_TYPE.PBI 
	{
	//if img_index_fresh//on new frame for PBI animations
	//	func_player_step();
	}
else
	{
	//current_time/2000
	
	
	}


#endregion
#region stamina

if stamina_hit == 0 and player_stamina_recovery_time!=-1//recovery not disabled
	{
	//count
	player_stamina_recovery_count= min(player_stamina_recovery_count + 1, player_stamina_recovery_time);
	
	//recovery system
	if player_stamina_recovery_count >= player_stamina_recovery_time
		{
		//recovery
		player_stamina= min(player_stamina + player_stamina_recovery, player_stamina_max);
		}
	}
else
	{
	//reset recovery counter
	player_stamina_recovery_count=0;
	
	//apply decrease
	
	player_stamina = max(player_stamina-stamina_hit,0);
	
	//reset
	stamina_hit=0;
	}



#endregion