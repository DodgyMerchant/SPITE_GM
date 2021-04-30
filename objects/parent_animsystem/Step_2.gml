/// @desc 





switch (img_type)
	{
	#region PBI
	case IMG_TYPE.PBI:
	
	//var _dist = abs(x - img_display_x);//distance from last frame
	var _dist = point_distance(x,y,img_display_x,img_display_y);//distance from last frame
	
	
	//progression inversion
	var _xpi = (img_PBI_x_progresion_inversion ? sign(x - img_display_x) * image_xscale : 1);
	var _ypi = (img_PBI_y_progresion_inversion ? sign(y - img_display_y) * image_yscale : 1);
	
	//if one of them is negative the progression will be reversed
	var _progression = !(_xpi==-1 or _ypi==-1);
	
	
	#region get index to check
	if _progression
		var _index = img_index;
	else
		var _index = (img_index-1<0 ? image_number - 1 : img_index - 1);
	#endregion
	
	//Positive progression  =>  distance to last position is >= to this image_indexes logged distance	
	//Negative progression  =>  distance to last position is >= to last image_indexes logged distance
	if  _dist >= img_PBI_list[| _index]
		{
		if _progression //positive progression
			img_index++;
		else//negative progression
			img_index--;
		
		
		img_display_x = round(x);
		img_display_y = round(y);
		
		img_index_fresh = true;
		
		#region manage index
		//detect looped
		//Positive progression  =>  image_index larger than index max
		//Negative progression  =>  image_index <= 0
		if (_progression ? img_index >= image_number : img_index < 0)
			{
			img_looped = true;
			
			if img_index>0//positive
				img_index = img_index mod image_number;
			else
				img_index = image_number-1;
			
			//if global.debug show_debug_message("PBI looped: "+string(sprite_get_name(sprite_index)+"| prog: "+string(_progression)));
			}
		else
			img_looped = false;
		#endregion
		}
	else
		{
		img_index_fresh = false;
		}
	
	break;
	#endregion
	default:
		img_display_x = x;
		img_display_y = y;
	}


//overshoot correction and set
img_index_show = clamp(img_index,0,image_number-1);



