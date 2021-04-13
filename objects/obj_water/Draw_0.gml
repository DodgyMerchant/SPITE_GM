/// @desc 



#region water

//draw_surface(global.Water_surf,global.View_x,global.View_y);


#endregion

#region Splosh | water ripples

var _size = ds_list_size(splosh_display_list);

Func_draw_set_color(splosh_col);


for (var i = 0; i < _size; i++)
{
	//get
    var _struct = splosh_display_list[| i];
	//draw
	
    _struct.func_draw();
	//delete
	if _struct.count<=0
		{
		//delete
		_struct=-1;
		delete splosh_display_list[| i];
		ds_list_delete(splosh_display_list,i);
		
		//adapt counter and size
		i--;
		_size--;
		
		}
}





#endregion

Func_draw_reset_alpha();