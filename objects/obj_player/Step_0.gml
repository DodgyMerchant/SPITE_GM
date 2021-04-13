/// @desc 

#region input

//movement
input_y= keyboard_check(ord("S"))-keyboard_check(ord("W"));
input_x= keyboard_check(ord("D"))-keyboard_check(ord("A"));
input_move_pressed = keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("A")) or keyboard_check_pressed(ord("S")) or keyboard_check_pressed(ord("D"));
input_sprint = keyboard_check(vk_shift);
input_sprint_p = keyboard_check_pressed(vk_shift);
//input_sprint_r = keyboard_check_released(vk_shift);
//input_sprint_p = keyboard_check_pressed(vk_shift);
//input_sprint_r = keyboard_check_released(vk_shift);

//situp & standup
input_situp = keyboard_check_pressed(vk_space);
input_standup = input_move_pressed;

/////combat
//attack
input_ready = keyboard_check(ord("L"));
input_ready_r = keyboard_check_released(ord("L"));
input_attackp = keyboard_check_pressed(ord("K"));

//brace
//input_brace_p = input_sprint_p;
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
		//camera
		player_cam_pos_x = x;
		player_cam_pos_y = y + player_cam_offset_y;
		
		
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
			func_player_exhausted();
			}
		
		
		#region threat detection
		//check for enemies
		
		//if enemies in range
		if func_player_check_enemies() == true
			{
			//change to combat
			func_player_status_set(PLAYER_STATUS.combat);
			}
		
		#endregion
		
		
	break;
	#endregion
	#region combat
	case PLAYER_STATUS.combat:
		
		#region camera
		player_cam_pos_x = x + combat_cam_offset * combat_direction;
		player_cam_pos_y = y + player_cam_offset_y;
		#endregion
		#region bracing
		
		if input_brace or func_combat_brace_active()
			//add or subtract to timer
			combat_brace_count = clamp(combat_brace_count + (input_brace - !input_brace), 0, combat_brace_time);
		
		//if brace in proigress
		if func_combat_brace_active()
			{
			func_player_stamina_recovery_enable(false);
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
		
		
		#endregion
		#region ready and attack
		
		
		
		
		
		
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
				func_player_combat_direction_change();//change direction
			
			//reset
			combat_direction_change=0;
			}
		
		
		
		
		#endregion
		#region moving and speed
		
		if func_combat_brace_active() //or attack readied
			{//no movement
			func_player_speed_reset();	//stop player movement
			player_speed=0;				//player cant move
			}
		else//can move freely
			{
			var _dir = point_direction(0,0,input_x,input_y);
			player_speed = lerp(spd_combat_backward,spd_combat_forward,(dcos(_dir) * combat_direction) * 0.5 + 0.5);
			}
		
		#endregion
		#region stamina
		
		if player_stamina == 0
			{
			//func_player_status_set(PLAYER_STATUS.exhausted);
			func_player_exhausted();
			}
		
		#endregion
		#region threat detection
		//check for enemies
		
		if func_player_check_enemies() == false
			{
			func_player_status_set(PLAYER_STATUS.idle);
			}
		
		#endregion
		
		
		
		
	break;
	#endregion
	#region exhausted
	case PLAYER_STATUS.exhausted:
		//camera
		player_cam_pos_x = x;
		player_cam_pos_y = y + player_cam_offset_y;
		
		//speed
		func_player_speed_reset();	//stop player movement
		player_speed=0;				//player cant move
		
		if player_stamina==player_stamina_max
			func_player_status_set(PLAYER_STATUS.idle);
		
	break;
	#endregion
	#region laying
	case PLAYER_STATUS.laying:
		//camera
		player_cam_pos_x = x + laying_cam_offset_x;
		player_cam_pos_y = y + laying_cam_offset_y;
		//speed
		player_speed = 0;
		
		//input
		if input_situp
			{
			situp_value += situp_value_add;
			
			//stamina cost
			func_player_stamina_drain(situp_stamina_drain);
			}
		else
			situp_value = max(situp_value- situp_value_decrease,0);
		
		//standing up
		if situp_value >= situp_value_max
			{
			
			
			//end
			func_player_status_set(PLAYER_STATUS.sitting);
			}
		//stamina decay
		func_player_stamina_drain(laying_timeout_decay);
		
		if player_stamina == 0
			func_player_death();
		
	break;
	#endregion
	#region sitting
	case PLAYER_STATUS.sitting:
		//camera
		player_cam_pos_x = x + sit_cam_offset_x;
		player_cam_pos_y = y + sit_cam_offset_y;
		//speed
		player_speed = 0;
		
		if input_standup
			{
			//set sprite
			if sprite_index != spr_player_standup
				func_anim_sprite_set_full(spr_player_standup);
			}
		
		//if animation done
		if sprite_index == spr_player_standup
			{
			func_player_stamina_drain(standup_stamina_drain);
			
			if img_looped//anim complete
				//end
				func_player_status_set(PLAYER_STATUS.idle);
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
Func_camera_set_pos_center(player_cam_pos_x,player_cam_pos_y);
depth = -y;