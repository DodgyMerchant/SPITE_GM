/// @desc 



#region blood


#region blood puddle dissolving

/*
blood_dis_alpha_decay
*/

var _size = ds_list_size(blood_puddle_list);
for (var i=0;i<_size;i++)
	{
	var _struct = blood_puddle_list[| i];
	
	//step
	var _bool = _struct.func_calc(i)
	
	
	//destroyed
	if _bool == false
		{
		//delete _struct;		struct will delete itself from list
		ds_list_delete(blood_puddle_list,i);
		i--;
		_size--;
		}
	}

//adjust layer
//"Blood"

layer_x(BLOOD_LAYER,-global.View_x);
layer_y(BLOOD_LAYER,-global.View_y);


#endregion
#region water purity
var _t = min(blood_water_count / blood_water_clarity,1);
var _r = lerp(color_get_red(water_clear_col),color_get_red(water_bloody_col),_t);
var _g = lerp(color_get_green(water_clear_col),color_get_green(water_bloody_col),_t);
var _b = lerp(color_get_blue(water_clear_col),color_get_blue(water_bloody_col),_t);

water_col = make_color_rgb(_r,_g,_b);
#endregion

#endregion


