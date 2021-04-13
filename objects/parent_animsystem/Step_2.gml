/// @desc 





switch (img_type)
	{
	#region PBI
	case IMG_TYPE.PBI:
	
	
	//var _dist = abs(x - img_display_x);//distance from last frame
	var _dist = point_distance(x,y,img_display_x,img_display_y);//distance from last frame
	
	if _dist >= img_PBI_list[| img_index]
		{
		img_index++;
		img_display_x = round(x);
		img_display_y = round(y);
		
		img_index_fresh = true;
		
		#region manage index
		//detect looped
		if img_index >= image_number
			{
			img_looped = true;
			img_index = img_index mod image_number;
			if global.debug show_debug_message("PBI looped: "+string(sprite_get_name(sprite_index)));
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



