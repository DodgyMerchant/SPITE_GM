

function Func_blood_drop_create(num,_x,_y,groundy,spd_min,spd_max,_size,puddle_min,puddle_max,arch_min,arch_max,ang_min,ang_max,dist_min,dist_max)
	{
	repeat(num)
		{
		var _inst = instance_create_layer(_x,_y,"Instances",obj_blood_splatter);
		
		with(_inst)
			{
			func_blood_setup(_x,_y,groundy,spd_min,spd_max,_size,puddle_min,puddle_max,arch_min,arch_max,ang_min,ang_max,dist_min,dist_max);
			}
		}
	
	
	}

function Func_blood_puddle_create(_type,_spr,_x,_y,_time,_size,_size_to,_alpha,_alpha_to)
	{
	if _spr == -1
		{
		_spr = spr_blood_puddle;
		}
	
	var _elem = layer_sprite_create("Blood",_x,_y,_spr);
	
	with(obj_water)
		{
		switch(_type)
			{
			case BLOOD_PUDDLE_TYPE.temporary:
				ds_list_add(blood_puddle_list,new func_blood_puddle_temp_construc(_type,_elem,_spr,_time,_size,_size_to,_alpha,_alpha_to));
			break;
			case BLOOD_PUDDLE_TYPE.permanent:
				ds_list_add(blood_puddle_list,new func_blood_puddle_perm_construc(_type,_elem,_spr,_time,_size,_size_to,_alpha,_alpha_to));
			break;
			}
		}
	
	}





