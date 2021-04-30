/// @desc 


#region water

water_col = 0;
water_clear_col = 0;
water_bloody_col = make_color_rgb(47,0,0);


#endregion
#region water reflection



//water_reflec_a = 0.4;//0.6

//Water_Reflect();//setup global function

#endregion
#region Splosh Water ripples
scr_Splosh();//setup the global Function

//vars
splosh_display_list = ds_list_create();
splosh_col = c_maroon;

//constructor
func_Splosh_construct = function(_type,_x,_y) constructor
	{
	type = _type;
	x = _x;
	y = _y;
	
	switch(type)
		{
		case CG_TYPE.continued:
		size=7
		duration = 1 * global.game_speed;
		alpha = 0.3;
		times = 1;
		break;
		case CG_TYPE.latest:
		size=17
		duration = 3 * global.game_speed;
		alpha = 0.5;
		times = 1;
		break;
		}
	
	count = duration;
	
	func_draw = function()
		{
		//drawing and calc
		var _t = (count / duration);	//tansition
		//var _it = (_t * -1) +1;			//inverted
		
		Func_draw_set_alpha(lerp(0,alpha,_t));
		draw_circle(x,y,lerp(size,1,_t),true);
		if global.debug draw_point(x,y);
		
		//duration
		count--;//deleted by obj_water
		}
	
	toString = function()
		{
		return "t:"+string(type)+"|d:"+string(duration);
		}
	}

#endregion
#region Blood on water

#macro BLOOD_LAYER layer_get_id("Blood")

global.Blood_surf = surface_create(global.View_width,global.View_height); //all blood is drawn to the surface

blood_puddle_list = ds_list_create();

enum BLOOD_PUDDLE_TYPE
	{
	temporary,
	permanent
	}

blood_color = make_color_rgb(180,11,9);

blood_water_clarity = 1000;//how many pools have to dissolve to make the water read
blood_water_count = 0;

blood_puddle_alpha = 0.7;

//blood_dis_alpha_end = 0.001;
 
Blood_Splatter();//init scripts


//constructor
function parent_blood_puddle_constructor(_type,_elem,_spr,_time,_size,_size_to,_alpha,_alpha_to) constructor
	{
	#region info
	/*
	_type			=	type of puddle
	_elem			=	element id for the sprite in the asset layer
	_spr			=	the sprite used	|| for measurements
	_time			=	time active
	_size			=	the wanted size of the sprite
	_size_to		=	size end
	_alpha			=	the starting alpha
	_alpha_to		=	alpha end
	*/
	#endregion
	//setup self
	type = _type;
	element = _elem;
	time_count = 0;
	time_max = _time;
	size =		(1 / sprite_get_width(_spr)) * _size;
	size_to =	(1 / sprite_get_width(_spr)) * _size_to;
	alpha = _alpha;
	alpha_to = _alpha_to;
	
	
	//setup element
	//layer_sprite_angle(_elem,random(360));
	layer_sprite_alpha(_elem,alpha);
	layer_sprite_blend(_elem,obj_water.blood_color);
	layer_sprite_xscale(_elem,size);
	layer_sprite_yscale(_elem,size);
	
	func_time = function()
		{
		if time_count == time_max
			{
			return false
			}
		else
			{
			time_count++;
			return true
			}
		}
	
	func_calc = function(i)
		{
		
		if func_time()
			{//alive
			//progress
			var _t = time_count / time_max;
			//alpha
			layer_sprite_alpha(element,		lerp(alpha,alpha_to,_t));
			//size
			var _s = lerp(size,size_to,_t);
			layer_sprite_xscale(element,	_s);
			layer_sprite_yscale(element,	_s);
			
			
			
			//blood_water_count++;
			return true;
			}
		else
			{//destroy
			func_end(i);
			
			return false;
			}
		}
	
	toString = function()
		{
		return "e:"+string(element)+"|t:"+string(abs(time_count - time_max));
		}
	}
function func_blood_puddle_temp_construc(_type,_elem,_spr,_time,_size,_size_to,_alpha,_alpha_to) : parent_blood_puddle_constructor(_type,_elem,_spr,_time,_size,_size_to,_alpha,_alpha_to) constructor
	{
	func_end = function(i)
		{
		//destroy self
		delete obj_water.blood_puddle_list[| i];
		//destroy element
		layer_sprite_destroy(element);
		}
	}
function func_blood_puddle_perm_construc(_type,_elem,_spr,_time,_size,_size_to,_alpha,_alpha_to) : parent_blood_puddle_constructor(_type,_elem,_spr,_time,_size,_size_to,_alpha,_alpha_to) constructor
	{
	func_end = function(i)
		{
		//destroy self
		delete obj_water.blood_puddle_list[| i];
		//do not destroy element
		}
	}

#region surface setup






function Water_surf_layer_script_begin()
	{
	//set surface to draw too this layer
	if surface_exists(global.Blood_surf)
		surface_set_target(global.Blood_surf);
	
	
	}
function Water_surf_layer_script_end()
	{
	//reset draw surface
	if surface_exists(global.Blood_surf)
		surface_reset_target();
	
	}

//set the scripts to the surface
layer_script_begin("Blood",Water_surf_layer_script_begin);
layer_script_end("Blood",Water_surf_layer_script_end);




#endregion


#endregion

