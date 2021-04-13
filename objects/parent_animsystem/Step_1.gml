/// @desc 



/*
IMG_TYPE.PBI
IMG_TYPE.forward
IMG_TYPE.backward
IMG_TYPE.pingpong
IMG_TYPE.pingpong_edgeless
*/

if img_speed!=0//no speed no run
switch (img_type)
	{
	#region PBI
	case IMG_TYPE.PBI:
	
	
	
	break;
	#endregion
	#region forward
	case IMG_TYPE.forward:
	//img_index += img_speed;
	//img_index_fresh = frac(img_index)==0 or (floor(img_index) > floor(img_index_show));
	
	func_anim_index_set(img_index + img_speed);
	
	
	//looped?
	if img_index > image_number
		{
		img_looped = true;
		img_index = img_index mod image_number;
		}
	else
		img_looped = false;
	break;
	#endregion
	#region backward
	case IMG_TYPE.backward:
	//img_index -= img_speed;
	//img_index_fresh = frac(img_index)==0 or (ceil(img_index) < ceil(img_index_show)); speed is not actually a negative value
	
	func_anim_index_set(img_index - img_speed);
	
	
	//looped?
	if img_index < 0
		{
		img_looped = true;
		img_index = img_index mod image_number;
		}
	else
		img_looped = false;
	
	break;
	#endregion
	#region pingpong and pingpong_edgeless
	case IMG_TYPE.pingpong:
	case IMG_TYPE.pingpong_edgeless:
	//img_index += img_speed;
	//img_index_fresh = frac(img_index)==0 or (floor(img_index) > floor(img_index_show));
	
	func_anim_index_set(img_index + img_speed);
	
	//looped?
	if (img_speed>0 ? img_index >= image_number : img_index <= 0)
	//if img_index > image_number
		{
		img_looped = true;
		img_speed = img_speed * -1;//invert image speed
		
		if img_type == IMG_TYPE.pingpong_edgeless
			{//edgeless
			/*
			skipping the frame at the end and beginning to make the animation more smooth
			
			I think +- 1 should work
			maybe *-1+1 also micvht work
			*/
			if img_index >= image_number
				func_anim_index_set(image_number -1);
			if img_index <= 0
				func_anim_index_set(1);
			}
		}
	else
		img_looped = false;
	break;
	#endregion
	}






