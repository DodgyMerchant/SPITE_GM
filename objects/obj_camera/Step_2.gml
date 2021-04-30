/// @desc 


Func_camera_seek_calc()

#region create end step
//var _x = (global.View_x>0 ? floor(global.View_x) : ceil(global.View_x));
//var _y = (global.View_y>0 ? floor(global.View_y) : ceil(global.View_y));
camera_set_view_pos(view, floor(global.View_x), floor(global.View_y));
camera_set_view_size(view, global.View_width + 1, global.View_height + 1);

global.View_x_frac = global.View_x>0 ? frac(global.View_x) : frac(global.View_x)+1;//balance out weird around 0
global.View_y_frac = global.View_y>0 ? frac(global.View_y) : frac(global.View_y)+1;

if (!surface_exists(view_surf)) {
    view_surf = surface_create(global.View_width + 1, global.View_height + 1);
}
view_surface_id[0] = view_surf;

#endregion