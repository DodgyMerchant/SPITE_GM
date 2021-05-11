/// @desc 

#region input

//movement
input_y= keyboard_check(ord("S"))-keyboard_check(ord("W"));
input_x= keyboard_check(ord("D"))-keyboard_check(ord("A"));
input_move_pressed = keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("A")) or keyboard_check_pressed(ord("S")) or keyboard_check_pressed(ord("D"));
input_sprint = keyboard_check(vk_shift);
input_sprint_p = keyboard_check_pressed(vk_shift);
//input_sprint_r = keyboard_check_released(vk_shift);
input_sprint_p = keyboard_check_pressed(vk_shift);
//input_sprint_r = keyboard_check_released(vk_shift);

//downed
input_downed_standup = keyboard_check_pressed(vk_space);

/////combat
//attack
input_ready = keyboard_check(ord("L"));
//input_ready_r = keyboard_check_released(ord("L"));
input_ready_p = keyboard_check_pressed(ord("L"));
input_attackp = keyboard_check_pressed(ord("K"));

//brace
input_brace_p = input_sprint_p;
input_brace = input_sprint;



////////////groupings ////////////////////

var _input_move_any = input_x!=0 or input_y!=0;//any movement input
var _input_any = _input_move_any;	//any input

//input_move_any_prev = _input_move_any
//var _input_move_start = _input_move_any and !input_move_any_prev

//general types


#endregion

#region status


switch(player_status)
	{
	#region idle
	case PLAYER_STATUS.idle:
		
		Func_camera_seek_set_seek(x,y + player_cam_offset_y);
		
		
		if !func_player_check_enemies()
			{//no threat
			//speed
			if input_sprint and player_stamina>0
				{
				player_speed = idle_spd_sprint;
				
				//if moving stamina drain
				if _input_move_any
					func_player_stamina_drain(idle_stamina_sprint_drain);
				}
			else
				player_speed = idle_spd_walk;
			
			//stamina
			if player_stamina == 0
				{
				func_player_exhausted(false);
				}
			}
		
		#region threat detection
		//check for enemies
		
		//if enemies in range
		else //threat
			{
			//input denial might not be the best solution
			input_x = 0;
			input_y = 0;
			player_speed =0;
			
			if sprite_index == spr_player_idle1
				{
				//change to combat
				//func_player_status_set(PLAYER_STATUS.combat);
				func_player_status_set(PLAYER_STATUS.anim_lock);
				func_anim_sprite_set_full(spr_player_combat_transition);
				}
			}
		#endregion
		
		
	break;
	#endregion
	#region combat
	case PLAYER_STATUS.combat:
		
		#region camera
		Func_camera_seek_set_seek(x + combat_cam_offset_x * combat_direction,y + player_cam_offset_y);
		#endregion
		#region bracing
		
		//if idle or already bracing
		if sprite_index == spr_player_combat_idle or func_player_combat_is_brace_active()
			{
			
			//brace active or in progress
			if input_brace or func_player_combat_is_brace_active()
				{
				if input_brace//button pressed
					{
					//brace add
					combat_brace_count = min(combat_brace_count + 1,combat_brace_time);
					//drain stamina
					func_player_stamina_drain(combat_brace_stamina_drain);
					}
				else
					{
					//brace subtract
					combat_brace_count = max(combat_brace_count - 1, 0);
					}
				//add or subtract to timer
				//combat_brace_count = clamp(combat_brace_count + (input_brace - !input_brace), 0, combat_brace_time);
				}
			
			//if brace is up
			if combat_brace_count == combat_brace_time
				{
				//breaced
				combat_brace = true;
				}
			else//brace is not up
				{
				//not braced
				combat_brace = false;
				}
			}
		
		#endregion
		#region ready and attack
		
		if sprite_index == spr_player_combat_idle or sprite_index == spr_player_combat_attack_ready
		if (func_player_combat_is_attack_active() or input_ready_p)
			{
			#region ready
			if input_ready//button pressed
				{
				//brace add
				combat_attack_ready_count = min(combat_attack_ready_count + 1,combat_attack_ready_time);
				//drain stamina
				func_player_stamina_drain(combat_attack_ready_stamina);
				}
			else
				{
				//brace subtract
				combat_attack_ready_count = max(combat_attack_ready_count - (1 * combat_attack_de_ready_mult), 0);
				}
			#endregion
			#region attacking
			if input_attackp//attack pbutton pressed
				{
				
				//					is the ready done						and		enough stamina
				if combat_attack_ready_count == combat_attack_ready_time and player_stamina >= combat_attack_stamina
					{//attack
					func_player_stamina_drain(combat_attack_stamina);
					
					func_player_status_set(PLAYER_STATUS.anim_lock);
					func_anim_sprite_set_full(spr_player_combat_attack_slash);
					}
				else//whiff
					{
					func_player_stamina_drain(combat_attack_whiff_stamina);
					
					func_player_status_set(PLAYER_STATUS.anim_lock);
					func_anim_sprite_set_full(spr_player_combat_attack_whiff);
					}
				
				//reset
				combat_attack_ready_count = 0;
				}
			#endregion
			}			
		
		
		#endregion
		
		
		#region direction change
		
		//if moving against combat direction
		if input_x !=0 and input_x != combat_direction //input_x == combat_direction*-1
			{
			combat_direction_change++;
			}
		else if combat_direction_change!=0
			{
			//counter lower than duration
			if combat_direction_change < combat_direction_change_duration
			//if func_player_combat_is_direction_changing()
				{
				//direction change
				func_player_combat_direction_change();//change direction
				}
			//reset
			combat_direction_change=0;
			}
		
		#endregion
		#region moving and speed
		
		if func_player_combat_is_brace_active() or func_player_combat_is_attack_active()
			{//no movement
			func_player_stop();
			}
		else//can move freely
			{
			var _dir = point_direction(0,0,input_x,input_y);
			player_speed = lerp(spd_combat_backward,spd_combat_forward,(dcos(_dir) * combat_direction) * 0.5 + 0.5);
			}
		
		#endregion
		#region stamina
		
		// if something active
		//		moving				player bracing
		if _input_move_any or func_player_combat_is_being_braced() or func_player_combat_is_attack_active()
			{
			func_player_stamina_recovery_enable(false);
			}
		else
			func_player_stamina_recovery_enable(true);
		
		
		if player_stamina == 0
			{
			//func_player_status_set(PLAYER_STATUS.exhausted);
			func_player_exhausted(false);
			}
		
		#endregion
		#region threat detection
		//check for enemies
		
		if func_player_check_enemies() == false
			{
			//func_player_status_set(PLAYER_STATUS.idle);
			
			//set to animation lock and play transition animation backward
			func_player_status_set(PLAYER_STATUS.anim_lock);
			func_anim_sprite_set_full(spr_player_combat_transition);
			func_anim_index_set_type(IMG_TYPE.backward);
			func_anim_index_set(image_number-1);//set to the end of the animation
			}
		
		
		#endregion
		
		
	break;
	#endregion
	#region exhausted
	case PLAYER_STATUS.exhausted:
		//camera
		Func_camera_seek_set_seek(x,y + player_cam_offset_y);
		
		if player_stamina==player_stamina_max
			func_player_status_set(PLAYER_STATUS.idle);
		
	break;
	#endregion
	#region downed
	case PLAYER_STATUS.downed:
		//camera
		Func_camera_seek_set_seek(x + downed_cam_offset_x,y + downed_cam_offset_y);
		//speed
		player_speed = 0;
		
		//input
		if input_downed_standup
			{
			downed_value += downed_value_add;
			
			//stamina cost
			func_player_stamina_drain(downed_stamina_drain);
			}
		else
			downed_value = max(downed_value- downed_value_decrease,0);
		
		//standing up
		if downed_value >= downed_value_max
			{//end
			//first sprite set		//if sprite front then front	else back
			var _fam = (image_index == spr_player_downed_front ? ExSprFam.front : ExSprFam.back);
			func_anim_sprite_set_full( func_player_exhausted_sprite_get_from_family(_fam,ExSprType.loop) );
			func_player_status_set(PLAYER_STATUS.exhausted);
			}
		//stamina decay
		func_player_stamina_drain(downed_timeout_decay);
		
		if player_stamina == 0
			func_player_death();
		
	break;
	#endregion
	#region anim_lock
	case PLAYER_STATUS.anim_lock:
		
		///NOTHING REALLY///
		
		switch(sprite_index)
			{
			#region idle <=> combat
			case spr_player_combat_transition:
				
				Func_camera_seek_set_seek(x,y + player_cam_offset_y);
			break;
			#endregion
			#region combat brace hit
			case spr_player_combat_brace_hit_moving:
				
				//camera same as combat
				Func_camera_seek_set_seek(x + combat_cam_offset_x * combat_direction - combat_brace_pushback,y + player_cam_offset_y);
				//Func_camera_seek_set_seek(x - combat_brace_pushback,y + player_cam_offset_y);
				
				//Func_camera_seek_set_type(CAMERA_SEEK_TYPE.linear,0.01);
				
				
			break;
			#endregion
			#region combat turnaround
			case spr_player_combat_turnaround:
				
				//camera same as combat
				Func_camera_seek_set_seek(x + combat_cam_offset_x * combat_direction - combat_brace_pushback,y + player_cam_offset_y);
				//speed
				func_player_stop();
				
				
			break;
			#endregion
			#region combat attack
			case spr_player_combat_attack_slash:
				
				//func_player_combat_attack(); maybe in end step
				
			break;
			#endregion
			
			}
		
		
		
	break;
	#endregion
	#region laying_menu
	case PLAYER_STATUS.laying_menu:
		
		
		
		if !instance_exists(obj_menu)
			{
			func_player_status_set(PLAYER_STATUS.downed);
			}
		
	break;
	#endregion
	default: show_debug_message("Step status /// STATUS NOT FOUND!!!");
	}


#endregion
#region movement calc
 
 
#region restriction

//update direction and speed
//if player input move buttons  AND  player possible speed >0
if _input_move_any and player_speed > 0
	{
	
	var _dir = point_direction(0,0,input_x,input_y);
	
	player_spd_x = lengthdir_x(player_speed,_dir);
	player_spd_y = lengthdir_y(player_speed,_dir);
	}



#endregion



//apply
x += player_spd_x;
y += player_spd_y;

#endregion



//end
//input_move_any_prev = _input_move_any;
depth = -y;