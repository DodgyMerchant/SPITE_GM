/// @desc 

//needs to be modified


enum IMG_TYPE//types of index handling
	{
	PBI,				//Progress Based Index
	forward,
	backward,
	pingpong,			//reverses on min or max index
	pingpong_edgeless	//reverses but skips the forst or last frame not doubling the time spent on those frames
	}

img_index = 0;					//image index control
img_index_show = 0;				//image_index_that is actually displayed		|needed as img_index if it overshoots is automatically looped
img_index_fresh = false;		//if the index changes this frame
img_looped = false;				//the boolean that tells if the sprite looped this frame | if the index surpassed the number of sub frames 
img_speed = 0;					//
img_type = IMG_TYPE.forward;	//how the image speed is applied
img_display_x = floor(xstart);	//where the sprite is being displayed	| needs to be done for Progress Based Index display
img_display_y = floor(ystart);
img_PBI_list = -1;	//stores the PBI list for less calls
img_PBI_x_progresion_inversion = false;	//progression inversion on the x axis
img_PBI_y_progresion_inversion = false;	//progression inversion on the y axis
#region ///////////// progression inversion INFO //////////////////
/*////////////////////////////////////////
///	progression inversion is a system how NEGATIVE x or y progression interacts with the image_index 
///	
///	normally this is disabled, which means that negative progression still increments the image index normally (positive).
///	
///	if enabled negative progress on the axis in question will decrement the image_index causing the animation to be played backwards.
///	for utility the image_xscale will define what is negativ progression
///	
///	sign(movement) != image_xscale  =>  negative progression
///	
///	
///	this enables the user to make more variant animations work
///	f.e.	make backwards walking use the same animation as forward walking but in reverse
///			but still able to to invert image_xscale to change the forward walking direction
///	
*/////////////////////////////////////////

////////////////maybe changes in the future////////
///
/// -atm negative progression is favored t.m. if one or more axis have negative progression the overall progression is negative
///		maybe a option foir this is needed
///
///
///
///

#endregion

func_anim_index_reset = function()			//resets values assosiated with the img_index
	{
	img_index_fresh=true;
	img_looped = false;
	img_index = 0;
	img_index_show = 0;
	func_anim_index_set_type(IMG_TYPE.forward);
	}

func_anim_index_set_type = function(_type)	//sets the image imdex type
	{
	/*
	IMG_TYPE.forward
	IMG_TYPE.backward
	IMG_TYPE.pingpong
	IMG_TYPE.pingpong_edgeless
	*/
	img_type = _type;
	}

func_anim_index_set = function(_val)
	{
	//is new image?
	if floor(img_index) != floor(_val)
		{//new image
		//if global.debug show_debug_message("index set frash! "+string(img_index)+"-"+string(_val));
		img_index_fresh = true;
		}
	else
		img_index_fresh = false;
	
	//set
	img_index = _val;
	}

func_anim_sprite_set_full = function(_spr)	//sets the sprite ald updates all assosiated properties (speed,reset) | checks for PBI
	{
	/*///////////////////////////////////
	PLEASE UPDATE PLAYER SPEED BEFOREHAND
	*////////////////////////////////////
	func_anim_sprite_set(_spr);
	
	//updates the sprites speed based on player speed and then sets the players image speed to the sprites speed
	func_anim_spriteupdateimageset_speed(_spr,player_speed);
	
	//reset index
	func_anim_index_reset();//also sets fresh
	
	//PBI
	if Func_PBI_spr_exists(_spr)
		{
		func_anim_index_set_type(IMG_TYPE.PBI);
		img_PBI_list = Func_PBI_find_list(_spr);
		func_anim_image_set_speed(0);
		//set pos
		img_display_x=round(x);
		img_display_y=round(y);
		}
	else
		{
		img_PBI_list = -1;
		}
	}

func_anim_sprite_set = function(_spr)		//sets a new sprite
	{
	sprite_index = _spr;
	}

func_anim_image_set_speed = function(_spd)	//sets the image speed value
	{
	img_speed = _spd;
	}

func_anim_sprite_get_speed = function()		//gets the speed FROM THE SPRITE  |in frames per game frame
	{
	return sprite_get_speed(sprite_index) / global.game_speed;
	}

func_anim_spriteupdateimageset_speed = function(_spr,_spd)	//update player image_speed from sprite speed
	{
	//get
	var _speed = func_anim_sprite_get_speed(_spr);
	
	func_anim_image_set_speed(_speed);//set player speed from sprite speed
	
	//if global.debug show_debug_message("img_speed change to: "+string(_speed)+"| sprite: "+string(sprite_get_name(_spr)));
	}

func_anim_drawself = function() //simple draw function using the anim system
	{
	//img_index_show	is needed to make animation smoother	| is the displayed index  not the real index
	//img_display_x/y	is needed to allow PBI to work			| is the displayed sprite position	not the real objekt position
	//
	
	draw_sprite_ext(sprite_index, img_index_show, img_display_x, img_display_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	//draw_sprite(sprite_index, img_index_show, img_display_x, img_display_y);
	
	}




/*/////////////////////////////////////////////////


create list for walkstart
create something that only a sprite is needed for the system to find the matching list
	so that maybe if I add new sprites that need this feature I deont need to go into the end step code and manually add the index to find the matching list





*/////////////////////////////////////////////////









