/*
PBI = Progression Based Index

A one time setup that need to be run

creates a master list that cointains a list for each sprite that neets to be animatied using PBI
each list contains the number of pixels that need to be progressed for the next frame to be displayed

//index == frame in animation | value pixel movement to next frame

*/


//	
//	<----- 2 ----->
//	 ______ ______ 
//	|      |      |	/\
//	| spr4 | list |	|
//	|______|______|	|
//	|      |      |	|
//	| spr7 | list |	|
//	|______|______|	number of sprites in enum
//	|      |      |	|
//	| spr11| list |	|
//	|______|______|	|
//	|      |      |	|
//	| spr12| list |	|
//	|______|______|	\/


global.img_pbi_grid = ds_grid_create(2, 1);
ds_grid_clear(global.img_pbi_grid,-1);

var func_PBI_create = function(_spr,px)	//creates an entry in the PBI grid	| global.img_pbi_grid
	{
	var _w,_h;
	
	#region resize or dont
	if global.img_pbi_grid[# 0,0] != -1	//if grid is used
		{
		//resize
		_w = ds_grid_width(global.img_pbi_grid);
		_h = ds_grid_height(global.img_pbi_grid);
		ds_grid_resize(global.img_pbi_grid,_w,_h+1);
		}
	else
		{
		//dont resize
		_w = ds_grid_width(global.img_pbi_grid);
		_h = ds_grid_height(global.img_pbi_grid) -1;	//a.k.a. 0
		}
	#endregion
	
	var _index_h = _h;	//number to index  doent need to be changed
	var _list = ds_list_create();
	
	global.img_pbi_grid[# 0,_index_h] = _spr;
	global.img_pbi_grid[# 1,_index_h] = _list;
	
	//enter all frame data into list
	for (var i=1;i<argument_count;i++)
		{
		ds_list_add(_list,argument[i]);
		}
	}

func_PBI_cleanup = function()
	{
	//cleanup lists
	var _h = ds_grid_height(global.img_pbi_grid);
	for (var i=0;i<_h;i++)
		{
		ds_list_destroy( global.img_pbi_grid[# 1,i]);
		}
	//cleanup grid
	ds_grid_destroy(global.img_pbi_grid);
	}

function Func_PBI_find_list(_spr)	//return the list for the sprite	| if none is found -1
	{
	for (var i=0;i<ds_grid_height(global.img_pbi_grid);i++)
		{
		if global.img_pbi_grid[# 0,i] == _spr
			return global.img_pbi_grid[# 1,i];
		}
	
	return -1;
	}

function Func_PBI_spr_exists(_spr)	//if the sprite exists in the PBI system
	{
	for (var i=0;i<ds_grid_height(global.img_pbi_grid);i++)
		{
		if global.img_pbi_grid[# 0,i] == _spr
			return true;
		}
	
	return false;
	}

//create PBIs for sprites
func_PBI_create(spr_player_walk_h,2,2,1,1,2);
func_PBI_create(spr_player_walk_h_start,1,1);
func_PBI_create(spr_player_walk_h_stop,1,1);