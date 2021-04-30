/// @desc 

event_inherited();

image_blend = make_color_rgb(144,11,9);

image_speed = 1;

img_PBI_x_progresion_inversion = true;

#region general


enum PLAYER_STATUS
	{
	idle,
	combat,
	exhausted,
	laying,
	sitting,
	anim_lock,
	laying_menu //not implemented
	}
player_status = PLAYER_STATUS.idle;
player_speed = 0;//stores speed  set by statuses and inputs | movement per frame
player_spd_x = 0;//actual movement x axis
player_spd_y = 0;//actual movement y axis

player_cam_offset_y = 5;

func_player_status_set = function(_status)
	{
	if global.debug show_debug_message("status set from: "+string(player_status)+"|to: "+string(_status));
	
	#region CLEAN UP	
	switch(player_status)//old status
		{
		#region idle
		case PLAYER_STATUS.idle:
			
		break;
		#endregion
		#region combat
		case PLAYER_STATUS.combat:
			
			//brace
			combat_brace_count = 0;
			combat_brace = false;
			
		break;
		#endregion
		#region exhausted
		case PLAYER_STATUS.exhausted:
			
		break;
		#endregion
		#region laying
		case PLAYER_STATUS.laying:
			situp_value=0;
		break;
		#endregion
		#region sitting
		case PLAYER_STATUS.sitting:
			
		break;
		#endregion
		#region anim_lock
		case PLAYER_STATUS.anim_lock:
			
		break;
		#endregion
		
		
		default: show_debug_message("func_player_status_set /// CLEAN UP /// STATUS NOT FOUND!!!");
		}
	#endregion
	//update
	player_status = _status;
	
	#region prepair
	switch(player_status)//new status
		{
		#region idle
		case PLAYER_STATUS.idle:
			//cam
			Func_camera_seek_set_type(CAMERA_SEEK_TYPE.fraction,8);
			
			func_anim_sprite_set_full(spr_player_idle1);
			func_anim_index_set_type(IMG_TYPE.pingpong_edgeless);//smoother edge animation
			
			//stamina
			player_stamina_recovery_time= idle_stamina_recovery_time;
			player_stamina_recovery		= idle_stamina_recovery;
		break;
		#endregion
		#region combat
		case PLAYER_STATUS.combat:
			//cam
			Func_camera_seek_set_type(CAMERA_SEEK_TYPE.fraction,8);
			
			combat_direction = image_xscale;
			
			//stamina
			player_stamina_recovery_time= combat_stamina_recovery_time;
			player_stamina_recovery		= combat_stamina_recovery;
		break;
		#endregion
		#region exhausted
		case PLAYER_STATUS.exhausted:
			//cam
			Func_camera_seek_set_type(CAMERA_SEEK_TYPE.fraction,8);
			
			func_anim_sprite_set_full(spr_player_exhausted_standing);
			
			
			
			
			//stamina
			player_stamina_recovery_time= 0;
			player_stamina_recovery		= player_exhausted_recovery;
		break;
		#endregion
		#region laying
		case PLAYER_STATUS.laying:
			//cam
			Func_camera_seek_set_type(CAMERA_SEEK_TYPE.fraction,8);
			
			//sprite
			func_anim_sprite_set_full(spr_player_situp);
			func_anim_image_set_speed(0);
			func_anim_index_reset();
			
			//values
			situp_value = 0;
			
			//stamina
			player_stamina_recovery_time= -1;
			player_stamina_recovery		= 0;
		break;
		#endregion
		#region sitting
		case PLAYER_STATUS.sitting:
			//cam
			Func_camera_seek_set_type(CAMERA_SEEK_TYPE.fraction,8);
			
			func_anim_sprite_set_full(spr_player_standup);
			func_anim_image_set_speed(0);
			
			//stamina
			player_stamina_recovery_time= player_sitting_stamina_recovery_time;
			player_stamina_recovery		= player_sitting_stamina_recovery;
		break;
		#endregion
		#region anim_lock
		case PLAYER_STATUS.anim_lock:
			//cam
			Func_camera_seek_set_type(CAMERA_SEEK_TYPE.fraction,8);
			
			//stamina
			player_stamina_recovery_time= -1;//disabled
			player_stamina_recovery		= 0;
		break;
		#endregion
		default: show_debug_message("func_player_status_set /// PREPAIR /// STATUS NOT FOUND!!!");
		}
	#endregion
	
	//Func_camera_seek_set_type(CAMERA_SEEK_TYPE.fraction,8);
	
	
	}

func_player_death = function()
	{
	show_debug_message("//////////DEATH//////////////")
	}

func_player_step = function() //player made a footstep   what happens?
	{
	
	//get grid
	var _CG_grid = Func_CG_get_contact(sprite_index,floor(img_index_show));
	
	if _CG_grid != -1//not empty
		{
		//calc top left of sprite in world	| CG coord are based on this
		var  _offsetx = img_display_x - sprite_xoffset;
		var  _offsety = img_display_y - sprite_yoffset;
		var _x,_y,_type;
		
		//go through contact grid
		var _h = ds_grid_height(_CG_grid);
		for (var i=0;i<_h;i++)
			{
			//get info and coords for this contact
			_type	= _CG_grid[# CG_GRID_MAKEUP.image_grid_type	,i];	//rotation and offset compensation
			_x		= _CG_grid[# CG_GRID_MAKEUP.image_grid_x	,i] * image_xscale + (image_xscale==-1 ? -1 : 0) + _offsetx;
			_y		= _CG_grid[# CG_GRID_MAKEUP.image_grid_y	,i] + _offsety;
			
			//do whatever with the contacts
			//create water ripples
			Func_Splosh_create(_type,_x,_y);
			}
		
		//image_xscale
		
		
		//if global.debug show_debug_message("step done: "+string(sprite_get_name(sprite_index))+"|i: "+string(img_index_show));
		}
	}

func_player_speed_reset = function()//sets the players applied speed to 0
	{
	player_spd_x = 0;
	player_spd_y = 0;
	}

func_player_exhausted = function()//decides what happens to the player when exhaused
	{
	//what event this triggered and what to do
	switch(player_status)
		{
		#region idle
		case PLAYER_STATUS.idle:
			
			
			
			
		break;
		#endregion
		#region
		case PLAYER_STATUS.combat:
			
			
			
			
			
		break;
		#endregion
		}
	
	func_player_status_set(PLAYER_STATUS.exhausted);
	
	
	
	
	
	}

func_player_check_enemies = function()
	{
	if instance_exists(parent_enemy)
		{
		var _inst = instance_nearest(x,y,parent_enemy);
		if point_distance(x,y,_inst.x,_inst.y) < combat_threat_detect_r
			{
			return true;
				
				
			}
		}
	
	return false;
	}

func_player_hit = function(_hit_dir) //manages what happens when the player is hit
	{
	var _hit_dir2 = (_hit_dir < 90 ? 0 : 180)
	
	if player_stamina!=0
	//if able to deflect hit
	if player_status == PLAYER_STATUS.combat and combat_brace
	//if hit direction is right
	if (combat_direction == COMBAT_DIR.right and _hit_dir2 == 180) or (combat_direction == COMBAT_DIR.left and _hit_dir2 == 0)
	//stamina lower than required amount
	if player_stamina >= combat_brace_stamina_hit
		{
		//deflect
		func_player_combat_brace_hit();
		return //end script
		}
	
	
	//sprite change
	
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
	
	Func_blood_drop_create(_num,x,y,bbox_bottom,_spd_min,_spd_max,_size,_puddle_min,_puddle_max,_arch_min,_arch_max,_hit_dir - _angle_lee,_hit_dir + _angle_lee,_dist_min,_dist_max);
	
	show_debug_message("///////////PLAYER HIT///////////")
	
	}

#endregion

#region stamina
/*
player_stamina_recovery_time == -1
disables recovery




*/

player_stamina_max = 100;	//max amount of player stamina
player_stamina = player_stamina_max;

stamina_hit=0; //stamina drain for 1 frame  if this is >0 recovery gets deactivated

player_stamina_recovery_count=0;//counter | counts up to player_stamina_recovery_time  then recovery happenes
player_stamina_recovery_time=0;	//the recovery time that the counter has to reach
player_stamina_recovery=0;		//the amount of stamina recovered


func_player_stamina_drain = function(_val)
	{
	stamina_hit += _val;
	}

func_player_stamina_recovery_enable = function(_enable) //enable and disable recovery
	{//true = anable recovery | false = disable recovery
	
	if _enable == false//deactivate recovery
		player_stamina_recovery_time = -1;
	else //enable recovery
		switch(player_status)//new status
			{
			#region idle
			case PLAYER_STATUS.idle:
				player_stamina_recovery_time= idle_stamina_recovery_time;
			break;
			#endregion
			#region combat
			case PLAYER_STATUS.combat:
				//stamina
				player_stamina_recovery_time= combat_stamina_recovery_time;
				
			break;
			#endregion
			#region exhausted
			case PLAYER_STATUS.exhausted:
				player_stamina_recovery_time= 0;
			break;
			#endregion
			#region laying
			case PLAYER_STATUS.laying:
				player_stamina_recovery_time= -1;
			break;
			#endregion
			#region sitting
			case PLAYER_STATUS.sitting:
				player_stamina_recovery_time= player_sitting_stamina_recovery_time;
			break;
			#endregion
			default: show_debug_message("func_player_stamina_recovery_enable /// STATUS NOT FOUND!!!");
			}
	
	}

#endregion

#region idle

//speed to animation speed
idle_spd_walk = 0.10; //walk speed that feels good
idle_spd_sprint = 0.25; //walk speed that feels good

idle_stamina_sprint_drain = 0.5;

idle_stamina_recovery_time = global.game_speed * 1;
idle_stamina_recovery = 1;


#endregion
#region laying & sitting

sit_cam_offset_x = -3;
sit_cam_offset_y = +3;
situp_value = 0;
situp_value_max = 100;
situp_value_add = 10;
situp_value_decrease = 1;
situp_stamina_drain = 1;

laying_cam_offset_x = -6;
laying_cam_offset_y = 3;
laying_timeout_decay = player_stamina_max / ( global.game_speed * 30 );	//time till player passes out DEATH

//standup_stamina_drain = (player_stamina_max * 0.5) / (sprite_get_number(spr_player_standup) * sprite_get_speed(spr_player_standup));
standup_stamina_drain = 0.5;

player_sitting_stamina_recovery_time = global.game_speed * 0.3;
player_sitting_stamina_recovery = player_stamina_max / ( global.game_speed * 7);


#endregion
#region combat

combat_cam_offset_x = 20;//10
//uses player_cam_offset_y

#region bracing

combat_brace = false;//is the player braced
combat_brace_count = 0;//counter
combat_brace_time = global.game_speed * 0.25;//time it takes to brace

combat_brace_pushback = 2;

combat_brace_stamina_drain = player_stamina_max / (global.game_speed * 20);	//constant stamina drain
combat_brace_stamina_hit = player_stamina_max/8;	//stamina cost of a blocked attack

func_player_combat_is_brace_active = function()// if the brace is in progress  | any brace progress
	{
	return combat_brace_count>0
	}

func_player_combat_is_being_braced = function()// the player is trying to brace	|| brace positive progress and brace ctive
	{
	return combat_brace or (combat_brace_count>0 and input_brace)
	}

func_player_combat_brace_hit = function()
	{
	//stamina drain for blocked attack
	func_player_stamina_drain(combat_brace_stamina_hit);
	//sprite change
	func_anim_sprite_set_full(spr_player_combat_brace_hit_moving);
	//set status to transitioning state
	func_player_status_set(PLAYER_STATUS.anim_lock);
	
	//set vars
	//combat_brace = false;		//cleanup done in status set script!!!
	//combat_brace_count = 0;
	
	
	show_debug_message("//////////PLAYER DEFLECTED HIT////////////");
	}

#endregion
#region ready and attack

//combat_
combat_attack_ready_count = 0;	//couinter for ready attack
combat_attack_ready_time = global.game_speed * 2;//time it takes to brace
combat_attack_de_ready_mult = 3;	//multiplier for howmuch faster de-reading an attack is


combat_attack_ready_stamina = player_stamina_max / (global.game_speed * 30);	//ready stamina drain


combat_attack_stamina = player_stamina_max / 6;			//stamina cost of attack
combat_attack_whiff_stamina = player_stamina_max / 8;	//stamina cost of whiff

func_player_combat_is_attack_active = function()
	{
	return combat_attack_ready_count >0
	}

func_player_combat_attack = function()	//if the player attacks this will be repeated
	{
	#region hit collision
	//prep
	var _mask = mask_index;
	mask_index = spr_player_combat_attack_slash_hit;
	
	var _list = ds_list_create();
	var _val = instance_place_list(x,y,parent_enemy,_list,false)
	
	if _val!=0//if list not empty
	//if !ds_list_empty(_list)//if list not empty
		{//all isntance will be hit
		for (var i=0;i<_val;i++)
			Func_hit(_list[| i])
		}
	
	
	ds_list_destroy(_list);
	
	//redo
	mask_index = _mask;
	#endregion
	}

#endregion
#region threat detection

combat_threat_detect_r = 60;



#endregion
#region movement and direction
spd_combat_forward = 0.07;
spd_combat_backward = spd_combat_forward;

enum COMBAT_DIR
	{
	right = 1,
	left = -1
	}
combat_direction = COMBAT_DIR.right;

combat_direction_change = 0;	//counts the frames
combat_direction_change_duration = global.game_speed * 0.2; //button press time to NOT change direction   in sec

func_player_combat_direction_change = function()	//changing player combat direction  TOGGLE
	{
	//set direction
	//combat_direction = _dir;
	
	
	//*//change direction
	switch(combat_direction)
		{
		case COMBAT_DIR.right:	combat_direction=COMBAT_DIR.left	break;
		case COMBAT_DIR.left:	combat_direction=COMBAT_DIR.right	break;
		}
	//*/
	
	//sprite
	func_player_status_set(PLAYER_STATUS.anim_lock);
	func_anim_sprite_set_full(spr_player_combat_turnaround);
	//speed
	func_player_speed_reset();
	player_speed=0;
	}


#endregion
#region combat stamina

//combat_stamina_drain = player_stamina_max / (global.game_speed * 20);

combat_stamina_recovery_time =	global.game_speed * 1;
combat_stamina_recovery =		0.1;


#endregion
#endregion
#region exhausted

player_exhausted_recovery = player_stamina_max / (global.game_speed * 5);


#endregion







//game gaming

func_player_status_set(PLAYER_STATUS.idle);
Func_camera_seek_set_pos(x,y);