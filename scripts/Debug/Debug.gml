// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information



function scr_debug_grid(_x, _y, _grid, _txt)
	{
	/// displays ds_grids. returns the y of the last line.
	/// x		the x coord to display at.
	/// y		start height of the list. is added upon and returnd so it can be used in other debug scripts.
	/// grid	the index of the grid
	/// txt		the name of the list to identify it
	

	var _sep=20;//min distance to next entry
	//var _sep_w=string_length(" ");
	for (var i=0;i<ds_grid_width(_grid);i++)
	    {
	    var str="";
		var _h=ds_grid_height(_grid)
	    for (var ii=0; ii<_h; ii++)
	        {
	        str+=" "+string(_grid[# i,ii]);
	        if ii!=_h-1
	        while (string_width(str)<_sep*ii)    //min distance to next entry
	            {
	            str+=" ";
	            }
	        }
	    str=string_insert(_txt+" - "+string(i)+" - ",str,0);  //adding the grid name in front
	    draw_text(_x,_y+i*string_height(str),str);
	    }

	return _y+(i+1)*string_height(str)
	}

function scr_debug_txt(_x,_y,_txt)
	{
	/// displays lines of debug code. returns the y of the last line. 
	/// xx height of text
	/// yy height of text
	/// txt1 line of debug code.
	/// txt2... line of debug code.
	/*
	argument[0]	=	xx
	argument[1]	=	yy

	*/

	var _skip_to= 2;//number of arguments to skip // skips the xx,yy as displayable text

	for(var i=_skip_to;i<argument_count;i++)
	    {
	    var str=argument[i];
		draw_text(_x,_y,str);
		_y+=string_height(str);
	    }

	return _y


}

function scr_debug_list(_x, _y, _list, _txt)
	{
	/// displays ds_lists. returns the y of the last line.
	/// x
	/// y start height of the list. is added upon and returnd so it can be used in other debug scripts.
	/// list the index of the list
	/// txt the name of the list to identify it
	
	

	var _str=_txt+" - "+string(_list)+" - ";
	for (var i=0;i<ds_list_size(_list);i++)
	    {
	    _str+=" "+string(_list[| i]);
	    }
	draw_text(_x,_y,_str);
	return _y + string_height(_str)




}