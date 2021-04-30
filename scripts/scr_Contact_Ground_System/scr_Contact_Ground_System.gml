//Contact Ground System
//
//manually adding coordinated to individual images in sprites to retriueve them aqnd use these coordinates
//
//f.e. water ripple footseps
//
//Func_CG_get_contact returns the information grid for the given sprite index



//renamed Splosh system
//for use for more things than water ripples


global.ContactGround_grid = ds_grid_create(CG_GRID_MAKEUP.cg_grid_width,1);
ds_grid_clear(global.ContactGround_grid,-1);

#region setting up CG grid


/*

global.ContactGround_grid		| holds sprite_indexes and their grids
>	sprite_grid					| holds image_indexes and their lists
>>		image_grid				| holds all the points of contact	type,x,y

*/
#region info

//	global.ContactGround_grid
//	
//	<----- 2 ----->
//	 ______ ______ 
//	|      |      |	/\
//	| spr4 | grid |	|
//	|______|______|	|
//	|      |      |	|
//	| spr7 | grid |	|
//	|______|______|	number of sprites in grid
//	|      |      |	|
//	| spr11| grid |	|
//	|______|______|	|
//	|      |      |	|
//	| spr12| grid |	|
//	|______|______|	\/
//
///////////////////////////////////////////////////
//	
//	"sprite_grid"
//	
//	<----- 2 ----->
//	 ______ ______ 
//	|      |      |	/\
//	|index1| igrid|	|
//	|______|______|	|
//	|      |      |	|
//	|index3| igrid|	|
//	|______|______|	number or registered images in the sprite
//	|      |      |	|
//	|index5| igrid|	|
//	|______|______|	|
//	|      |      |	|
//	|index8| igrid|	|
//	|______|______|	\/
//
///////////////////////////////////////////////////
//
//	"image_grid"
//
//	<----- 3 ----->
//	 ______ ______ ______ 
//	|      |      |      |	/\
//	| type |  x   |  y   |	|
//	|______|______|______|	|
//	|      |      |      |	|
//	| type |  x   |  y   |	|
//	|______|______|______|	number of Contacts registered for this image
//	|      |      |      |	|
//	| type |  x   |  y   |	|
//	|______|______|______|	|
//	|      |      |      |	|
//	| type |  x   |  y   |	|
//	|______|______|______|	\/





#endregion

enum CG_GRID_MAKEUP//useful data about the CG grids
	{
	cg_grid_spr		= 0,
	cg_grid_sgrid	= 1,
	cg_grid_width	= 2,
	//sprite_grid
	sprite_grid_index	= 0,
	sprite_grid_igrid	= 1,
	sprite_grid_width	= 2,
	//image grid
	image_grid_type		= 0,
	image_grid_x		= 1,
	image_grid_y		= 2,
	image_grid_width	= 2
	}
enum CG_TYPE//the types of rippleeffect
	{
	latest,		//new contact
	continued	//continued contact
	}

var func_contact_add = function(_spr,_index,_type,_x,_y)
	{
	
	var _func_find_val_in_grid_w0 = function(_grid,_val)
		{//returns the index   or   -1
		var _h = ds_grid_height(_grid);
		for (var i=0;i<_h;i++)
			if _grid[# 0,i] == _val
				return i;//return grid
		
		return -1;
		}
	
	
	/*
	sprite to bind the ripple to
	index of the sprite
	type of ripple		refert to CG_TYPE enum
	x,y relative to top left of sprite
	*/
	
	var _sprite_grid = _func_find_val_in_grid_w0(global.ContactGround_grid,_spr);
	
	#region sprite_grid find/create
	
	//sprite DOESNT exist in the grid
	if _sprite_grid==-1
		{
		var _h = ds_grid_height(global.ContactGround_grid);
		#region resizing
		//grid not empty
		if global.ContactGround_grid[# 0,0] != -1
			{
			ds_grid_resize(global.ContactGround_grid,2,_h+1);
			_h = _h;
			}
		else//empty
			{
			_h = 0;
			}
		#endregion
		
		//create and enter new grid
		var _sprite_grid = ds_grid_create(2,1);
		ds_grid_clear(_sprite_grid,-1);
		global.ContactGround_grid[# CG_GRID_MAKEUP.cg_grid_spr,	_h] = _spr;
		global.ContactGround_grid[# CG_GRID_MAKEUP.cg_grid_sgrid,	_h] = _sprite_grid;
		
		}
	else
		{
		//get sprite_grid from Splosh_grid
		_sprite_grid = global.ContactGround_grid[# CG_GRID_MAKEUP.cg_grid_sgrid,_sprite_grid];
		}
	
	#endregion
	
	var _image_grid = _func_find_val_in_grid_w0(_sprite_grid,_index);
	
	#region image_grid find/create
	//look if image exists already
	
	if _image_grid==-1//index does not exist
		{
		
		#region resizing
		var _h = ds_grid_height(_sprite_grid);
		//grid not empty
		if _sprite_grid[# 0,0] != -1
			{
			//resize
			ds_grid_resize(_sprite_grid,2,_h+1);
			_h = _h;
			}
		else//empty
			{
			_h=0;
			}
		#endregion
		
		//create and enter imae_grid into sprite_grid
		var _image_grid = ds_grid_create(3,1);
		ds_grid_clear(_image_grid,-1);
		_sprite_grid[# CG_GRID_MAKEUP.sprite_grid_index,_h] = _index;
		_sprite_grid[# CG_GRID_MAKEUP.sprite_grid_igrid,_h] = _image_grid;
		}
	else
		{
		//get image_grid from sprite_grid
		_image_grid = _sprite_grid[# CG_GRID_MAKEUP.sprite_grid_igrid,_image_grid];
		}
	
	#endregion
	
	#region contact add
	
	////////////////////////////
	// NO CHECKS /// JUST ADD //
	////////////////////////////
	
	
	//check if empty
	if _image_grid[# 0,0]!=-1
		{//not empty
		//resize
		var _h = ds_grid_height(_image_grid)
		ds_grid_resize(_image_grid,3, _h+1);
		_h = _h;
		}
	else//empty
		var _h = 0;
	
	//add data
	_image_grid[# CG_GRID_MAKEUP.image_grid_type,_h] = _type;
	_image_grid[# CG_GRID_MAKEUP.image_grid_x	,_h] = _x;
	_image_grid[# CG_GRID_MAKEUP.image_grid_y	,_h] = _y;
	
	#endregion
	
	}


//external use





#endregion
#region adding ALL contacts

//func_contact_add(_spr,_index,_type,	_x,	_y);
//
//CG_TYPE.vbig	//for massive firce into water
//CG_TYPE.latest		//big ripple for new contact with the water
//CG_TYPE.continued	//for stationary contact with watrer

#region idle
#region walk

#region walk_h
//0
func_contact_add(spr_player_walk_h,0,CG_TYPE.continued,	7,	22);
func_contact_add(spr_player_walk_h,0,CG_TYPE.latest,	15,	22);
//1
func_contact_add(spr_player_walk_h,1,CG_TYPE.continued,	13,	22);
//2
func_contact_add(spr_player_walk_h,2,CG_TYPE.continued,	11,	22);
//3
func_contact_add(spr_player_walk_h,3,CG_TYPE.continued,	10,	22);
//4
func_contact_add(spr_player_walk_h,4,CG_TYPE.continued,	9,	22);

#endregion
#region walk_h_start
////0
func_contact_add(spr_player_walk_h_start,0,CG_TYPE.continued,	6,	22);
////1
func_contact_add(spr_player_walk_h_start,1,CG_TYPE.continued,	5,	22);


#endregion
#region walk_h_stop
////0
func_contact_add(spr_player_walk_h_stop,0,CG_TYPE.continued,	7,	22);//11 9
func_contact_add(spr_player_walk_h_stop,0,CG_TYPE.latest,	14,	22);
////1
func_contact_add(spr_player_walk_h_stop,1,CG_TYPE.continued,	13,	22);
func_contact_add(spr_player_walk_h_stop,1,CG_TYPE.continued,	7,	22);



#endregion

#endregion
#region idle

#region idle1

func_contact_add(spr_player_idle1,0,CG_TYPE.continued,	8,	21);//11 8
func_contact_add(spr_player_idle1,0,CG_TYPE.continued,	12,	21);//11 8
func_contact_add(spr_player_idle1,1,CG_TYPE.continued,	8,	21);
func_contact_add(spr_player_idle1,1,CG_TYPE.continued,	12,	21);
func_contact_add(spr_player_idle1,2,CG_TYPE.continued,	8,	21);
func_contact_add(spr_player_idle1,2,CG_TYPE.continued,	12,	21);


#endregion


#endregion
#endregion
#region combat
#region other
#region idle
//0
func_contact_add(spr_player_combat_idle,0,CG_TYPE.continued,	0,	22);//5 9
func_contact_add(spr_player_combat_idle,0,CG_TYPE.continued,	7,	22);
//1
func_contact_add(spr_player_combat_idle,1,CG_TYPE.continued,	0,	22);//5 9
func_contact_add(spr_player_combat_idle,1,CG_TYPE.continued,	7,	22);
//2
func_contact_add(spr_player_combat_idle,2,CG_TYPE.continued,	0,	22);//5 9
func_contact_add(spr_player_combat_idle,2,CG_TYPE.continued,	7,	22);


#endregion
#region walk
//0
func_contact_add(spr_player_combat_walk,0,CG_TYPE.continued,	0,	22);//5 9
func_contact_add(spr_player_combat_walk,0,CG_TYPE.continued,	7,	22);//5 9
//1
func_contact_add(spr_player_combat_walk,1,CG_TYPE.continued,	6,	22);//5 9
//2
func_contact_add(spr_player_combat_walk,2,CG_TYPE.latest,		2,	22);//5 9
func_contact_add(spr_player_combat_walk,2,CG_TYPE.continued,	5,	22);//5 9
//3
func_contact_add(spr_player_combat_walk,3,CG_TYPE.continued,	1,	22);//5 9




#endregion
#region transition
//0
func_contact_add(spr_player_combat_transition,0,CG_TYPE.continued,	4,	22);//7 9
func_contact_add(spr_player_combat_transition,0,CG_TYPE.continued,	9,	22);
//1
func_contact_add(spr_player_combat_transition,1,CG_TYPE.latest,	3,	22);
func_contact_add(spr_player_combat_transition,1,CG_TYPE.continued,	9,	22);
//2
func_contact_add(spr_player_combat_transition,2,CG_TYPE.continued,	3,	22);
func_contact_add(spr_player_combat_transition,2,CG_TYPE.continued,	9,	22);

#endregion
#region turnaround

//0
func_contact_add(spr_player_combat_turnaround,0,CG_TYPE.continued,	10,	22);//8 9
//1
func_contact_add(spr_player_combat_turnaround,1,CG_TYPE.latest,		3,	22);
func_contact_add(spr_player_combat_turnaround,1,CG_TYPE.continued,	10,	22);
//2
func_contact_add(spr_player_combat_turnaround,2,CG_TYPE.continued,	3,	22);

#endregion
#endregion
#region brace
#region ready
//0
func_contact_add(spr_player_combat_brace_ready,0,CG_TYPE.continued,	0,	21);//5 8
func_contact_add(spr_player_combat_brace_ready,0,CG_TYPE.continued,	7,	21);
//1
func_contact_add(spr_player_combat_brace_ready,1,CG_TYPE.continued,	0,	21);
func_contact_add(spr_player_combat_brace_ready,1,CG_TYPE.continued,	7,	21);


#endregion
#region idle

//0
func_contact_add(spr_player_combat_brace_idle,0,CG_TYPE.continued,	0,	20);//5 7
func_contact_add(spr_player_combat_brace_idle,0,CG_TYPE.latest,		7,	20);
//1
func_contact_add(spr_player_combat_brace_idle,1,CG_TYPE.continued,	0,	20);
func_contact_add(spr_player_combat_brace_idle,1,CG_TYPE.latest,		8,	20);

#endregion
#region hit

//moving
//0
func_contact_add(spr_player_combat_brace_hit_moving,0,CG_TYPE.continued,	9,	22);//14 9
//1
func_contact_add(spr_player_combat_brace_hit_moving,1,CG_TYPE.continued,	9,	22);
func_contact_add(spr_player_combat_brace_hit_moving,1,CG_TYPE.latest,		15,	22);
//2
func_contact_add(spr_player_combat_brace_hit_moving,2,CG_TYPE.continued,	15,	22);
//3
func_contact_add(spr_player_combat_brace_hit_moving,3,CG_TYPE.latest,		7,	22);
func_contact_add(spr_player_combat_brace_hit_moving,3,CG_TYPE.continued,	15,	22);
//4
func_contact_add(spr_player_combat_brace_hit_moving,4,CG_TYPE.continued,	7,	22);
func_contact_add(spr_player_combat_brace_hit_moving,4,CG_TYPE.continued,	14,	22);//mnovement but no new contact
//5
func_contact_add(spr_player_combat_brace_hit_moving,5,CG_TYPE.continued,	7,	22);
func_contact_add(spr_player_combat_brace_hit_moving,5,CG_TYPE.continued,	14,	22);

#endregion
#endregion
#region attack
#region ready
//0
func_contact_add(spr_player_combat_attack_ready,0,CG_TYPE.continued,	0,	27);//5 14
func_contact_add(spr_player_combat_attack_ready,0,CG_TYPE.continued,	7,	27);
//1
func_contact_add(spr_player_combat_attack_ready,1,CG_TYPE.continued,	0,	27);
func_contact_add(spr_player_combat_attack_ready,1,CG_TYPE.continued,	7,	27);
//2
func_contact_add(spr_player_combat_attack_ready,2,CG_TYPE.continued,	0,	27);
func_contact_add(spr_player_combat_attack_ready,2,CG_TYPE.continued,	7,	27);
//3
func_contact_add(spr_player_combat_attack_ready,3,CG_TYPE.continued,	0,	27);
func_contact_add(spr_player_combat_attack_ready,3,CG_TYPE.continued,	7,	27);

#endregion
#region slash

//0
func_contact_add(spr_player_combat_attack_slash,0,CG_TYPE.continued,	1,	28);//6 15
func_contact_add(spr_player_combat_attack_slash,0,CG_TYPE.continued,	9,	28);
//1
func_contact_add(spr_player_combat_attack_slash,1,CG_TYPE.latest,	0,	28);
func_contact_add(spr_player_combat_attack_slash,1,CG_TYPE.continued,	9,	28);
//2
func_contact_add(spr_player_combat_attack_slash,2,CG_TYPE.continued,	0,	28);
func_contact_add(spr_player_combat_attack_slash,2,CG_TYPE.continued,	9,	28);
func_contact_add(spr_player_combat_attack_slash,2,CG_TYPE.latest,	22,	28); //sword


#endregion
#region recovery

//0
func_contact_add(spr_player_combat_attack_recovery,0,CG_TYPE.continued,	0,	19);//6 6
func_contact_add(spr_player_combat_attack_recovery,0,CG_TYPE.continued,	9,	19);
//1
func_contact_add(spr_player_combat_attack_recovery,1,CG_TYPE.continued,	1,	19);
func_contact_add(spr_player_combat_attack_recovery,1,CG_TYPE.continued,	9,	19);

//sword fx
//0
func_contact_add(spr_player_combat_attack_recovery,0,CG_TYPE.continued, 22,	19);//6 6
func_contact_add(spr_player_combat_attack_recovery,0,CG_TYPE.continued,	20,	19);



#endregion
#region whiff

//0
func_contact_add(spr_player_combat_attack_whiff,0,CG_TYPE.latest,		2,	22);//8 9
func_contact_add(spr_player_combat_attack_whiff,0,CG_TYPE.continued,	10,	22);
//1
func_contact_add(spr_player_combat_attack_whiff,1,CG_TYPE.latest,		3,	22);
func_contact_add(spr_player_combat_attack_whiff,1,CG_TYPE.continued,	10,	22);
//2
func_contact_add(spr_player_combat_attack_whiff,2,CG_TYPE.latest,		2,	22);
func_contact_add(spr_player_combat_attack_whiff,2,CG_TYPE.latest,		11,	22);
//3
func_contact_add(spr_player_combat_attack_whiff,3,CG_TYPE.latest,		0,	22);
func_contact_add(spr_player_combat_attack_whiff,3,CG_TYPE.latest,		11,	22);
//4
func_contact_add(spr_player_combat_attack_whiff,4,CG_TYPE.latest,		1,	22);
func_contact_add(spr_player_combat_attack_whiff,4,CG_TYPE.continued,	11,	22);
//5
func_contact_add(spr_player_combat_attack_whiff,5,CG_TYPE.latest,		2,	22);
func_contact_add(spr_player_combat_attack_whiff,5,CG_TYPE.latest,		10,	22);
//6
func_contact_add(spr_player_combat_attack_whiff,6,CG_TYPE.latest,		3,	22);
func_contact_add(spr_player_combat_attack_whiff,6,CG_TYPE.continued,	10,	22);


#endregion
#endregion
#endregion

#endregion


//to use in other systems
function Func_CG_get_contact(_spr,_index)
	{//returns the grid for the given sprite index  or  -1

	#region find sprite	_sprite_grid
	//search for sprite
	var _h= ds_grid_height(global.ContactGround_grid);
	var _sprite_grid = -1;
	for (var i=0;i<_h;i++)
		{
		if global.ContactGround_grid[# CG_GRID_MAKEUP.cg_grid_spr,i]==_spr
			_sprite_grid = global.ContactGround_grid[# CG_GRID_MAKEUP.cg_grid_sgrid,i];
		}
	//if sprite doesnt exist
	if _sprite_grid==-1
		return -1;
	
	#endregion
	#region find image		_image_grid
	//search for image in sprite
	var _h= ds_grid_height(_sprite_grid);
	var _image_grid = -1;
	for (var i=0;i<_h;i++)
		{
		if _sprite_grid[# CG_GRID_MAKEUP.sprite_grid_index,i]==_index
			return _sprite_grid[# CG_GRID_MAKEUP.sprite_grid_igrid,i];//found grid return
		}
	
	//if image doesnt exist
	if _image_grid==-1
		return -1;
	#endregion
	}
