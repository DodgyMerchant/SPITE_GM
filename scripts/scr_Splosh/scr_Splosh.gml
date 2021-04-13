//Creates water ripple at location



//to use in other systems
function Func_Splosh_create(_type,_x,_y)
	{//all splosh coordinates are saved oriented from the top left of the sprite
	
	with(obj_water)
		{
		ds_list_add(splosh_display_list, new func_Splosh_construct(_type,_x,_y));
		}
	}