/// @desc 

image_blend = obj_water.blood_color;

ac_arc = animcurve_get_channel(ac_blood_splatter, 0);
arc_height = 0;
size = 0;
puddle = 0;

target_x = 0;
target_y = 0;

display_x = 0;
display_y = 0;

life = 0;
life_count = 0;

func_blood_setup = function(_x,_y,groundy,spd_min,spd_max,_size,puddle_min,puddle_max,arch_min,arch_max,ang_min,ang_max,dist_min,dist_max)
	{
	size = _size;
	puddle =  random_range(puddle_min,puddle_max);
	arc_height = random_range(arch_min,arch_max);
	
	var _dir = random_range(ang_min,ang_max);
	var _dist = random_range(dist_min,dist_max);
	
	target_x = _x + lengthdir_x(_dist,_dir);
	target_y = groundy + lengthdir_y(_dist,_dir);
	
	var _dist = point_distance(xstart,ystart,target_x,target_y);
	var _spd = random_range(spd_min,spd_max);
	life = ceil( _dist / _spd);
	
	}

func_blood_end = function()
	{
	Func_blood_puddle_create(BLOOD_PUDDLE_TYPE.temporary,-1,target_x,target_y,global.game_speed*10,puddle,puddle*2,
	obj_water.blood_puddle_alpha,0);
	
	
	instance_destroy();
	}


