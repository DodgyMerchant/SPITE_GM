/// @desc 



//var _x = (global.View_x>0 ? floor(global.View_x) : ceil(global.View_x));
//var _y = (global.View_y>0 ? floor(global.View_y) : ceil(global.View_y));
camera_set_view_pos(view, floor(global.View_x), floor(global.View_y));
camera_set_view_size(view, global.View_width + 1, global.View_height + 1);

if (!surface_exists(view_surf)) {
    view_surf = surface_create(global.View_width + 1, global.View_height + 1);
}
view_surface_id[0] = view_surf;