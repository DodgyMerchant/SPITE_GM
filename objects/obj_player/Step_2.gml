/// @desc 




event_inherited();

#region image

var _input_move_any = input_x!=0 or input_y!=0;//any movement input
var _moving = player_spd_x!=0 or player_spd_y!=0; //is moving

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
			if img_looped //if start or walk animation looped
				func_anim_sprite_set_full(spr_player_walk_h_stop);
			}
		else if img_looped//if walk_stop animation looped
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
	
	func_player_speed_reset();
	func_anim_sprite_set_full(spr_p);
	func_anim_index_set_type(IMG_TYPE.);
	img_looped
	if sprite_index !=
	
	
	*/
	
	#region moving
	if _moving//moving
		{
		if _input_move_any//wanting to move
			{
			//set walk
			if sprite_index != spr_player_combat_walk
				{
				//works with walking backwards
				func_anim_sprite_set_full(spr_player_combat_walk);
				
				if input_x != combat_direction
					{
					func_anim_index_set(image_number-1);
					}
				}
			}
			//not wanting to move
		else if img_looped//if animation stop playing and animation is done
			{
			//stop movement
			func_player_speed_reset();
			
			
			//set animation
			if sprite_index != spr_player_combat_idle
				{
				func_anim_sprite_set_full(spr_player_combat_idle);
				func_anim_index_set_type(IMG_TYPE.pingpong_edgeless);
				}
			}
		}
	#endregion
	else
		{
		#region bracing
		if func_player_combat_is_brace_active()
			{
			if !combat_brace//brace in progress
				{
				if sprite_index != spr_player_combat_brace_ready
					{
					func_anim_sprite_set_full(spr_player_combat_brace_ready);
					func_anim_image_set_speed(0);
					}
				
				func_anim_index_set(lerp(0,image_number,combat_brace_count / combat_brace_time));
				
				}
			else//fully braced
				{
				if sprite_index != spr_player_combat_brace_idle
					func_anim_sprite_set_full(spr_player_combat_brace_idle);
				}
			}
		#endregion
		#region attacking
		
		else if func_player_combat_is_attack_active()
			{
			if sprite_index != spr_player_combat_attack_ready
					{
					func_anim_sprite_set_full(spr_player_combat_attack_ready);
					func_anim_image_set_speed(0);
					}
			
			func_anim_index_set(lerp(0,image_number-1,combat_attack_ready_count/ combat_attack_ready_time));
			}
		
		
		#endregion
		//if nothing happens  IDLE
		else if sprite_index != spr_player_combat_idle
			{
			func_anim_sprite_set_full(spr_player_combat_idle);
			func_anim_index_set_type(IMG_TYPE.pingpong_edgeless);
			}
		}
		
	
	image_xscale = combat_direction;
	
	
	break;
	#endregion
	#region exhausted
	case PLAYER_STATUS.exhausted:
	
	var _type = func_player_exhausted_sprite_get_type(sprite_index);
	
	#region start and loop
	if _type == ExSprType.start
		{
		//set to looped anim
		if img_looped
			{
			func_anim_sprite_set_full( func_player_exhausted_sprite_get(sprite_index,ExSprType.loop) );
			}
		}
	#endregion
	
	#region end
	var _reg_time_left = (player_stamina_max - player_stamina) / player_stamina_recovery; //stamina left to regen
	if _type != ExSprType.endt and  player_exhausted_anim_end >= _reg_time_left
		{
		func_anim_sprite_set_full( func_player_exhausted_sprite_get(sprite_index,ExSprType.endt) );
		}
	#endregion
	
	
	break;
	#endregion
	#region downed
	case PLAYER_STATUS.downed:
		//sitting up   image index to situp effort
		img_index = lerp(0,image_number-1,downed_value / downed_value_max);
	break;
	#endregion
	#region anim_lock
	case PLAYER_STATUS.anim_lock:
		
		switch(sprite_index)
			{
			#region idle <=> combat
			case spr_player_combat_transition:
				
				if img_looped//animation played through
					if img_type == IMG_TYPE.forward //from idle to combat
						func_player_status_set(PLAYER_STATUS.combat);
					else	//from combat to idle
						func_player_status_set(PLAYER_STATUS.idle);
			break;
			#endregion
			#region combat brace hit => combat
			case spr_player_combat_brace_hit_moving:
				
				if img_looped//animation played through
					{
					func_player_status_set(PLAYER_STATUS.combat);
					func_anim_sprite_set_full(spr_player_combat_idle);
					
					//update position
					x -= combat_brace_pushback * combat_direction;
					img_display_x = x;
					}
				
			break;
			#endregion
			#region combat attack => combat attack recovery
			case spr_player_combat_attack_slash:
				
				if img_looped//animation played through
					{
					func_player_status_set(PLAYER_STATUS.anim_lock);
					func_anim_sprite_set_full(spr_player_combat_attack_recovery);
					}
				else if img_index_fresh
					{
					func_player_combat_attack();
					}
				
			break;
			#endregion
			#region combat whiff => combat
			case spr_player_combat_attack_whiff:
				
				if img_looped//animation played through
					{
					func_player_status_set(PLAYER_STATUS.combat);
					func_anim_sprite_set_full(spr_player_combat_idle);
					}
				
			break;
			#endregion
			#region combat recovery => combat
			case spr_player_combat_attack_recovery:
				
				if img_looped//animation played through
					{
					func_player_status_set(PLAYER_STATUS.combat);
					func_anim_sprite_set_full(spr_player_combat_idle);
					}
				
			break;
			#endregion
			#region combat turnaround => idle
			case spr_player_combat_turnaround:
				
				if img_looped//animation played through
					{
					image_xscale = combat_direction;
					func_player_status_set(PLAYER_STATUS.combat);
					func_anim_sprite_set_full(spr_player_combat_idle);
					//pos
					//pos
					x += 2 * combat_direction;
					img_display_x = x;
					}
				
			break;
			#endregion
			#region hit => downed
			case spr_player_hit_front:
			case spr_player_hit_back:
			
				if img_looped//animation played through
					{
					func_player_status_set(PLAYER_STATUS.downed);
					if sprite_index == spr_player_hit_front
						func_anim_sprite_set_full(spr_player_downed_front);
					else
						func_anim_sprite_set_full(spr_player_downed_back);
					
					func_anim_image_set_speed(0);
					
					//x += 2 * combat_direction;
					//img_display_x = x;
					}
				
			break;
			#endregion
			}
		
		
		
		
	break;
	#endregion
	#region laying_menu
	case PLAYER_STATUS.laying_menu:
		
		
		
		
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