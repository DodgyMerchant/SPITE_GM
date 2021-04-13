/// @desc 


//delete all splosh and list
var _size = ds_list_size(splosh_display_list);

for (var i = 0; i < _size; i++)
{
    delete splosh_display_list[| i];
}

ds_list_destroy(splosh_display_list);