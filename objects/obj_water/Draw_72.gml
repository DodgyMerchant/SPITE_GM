/// @desc 


#region water background


draw_clear_alpha(water_col,1);



#endregion
#region water reflection

//global.Water_surf = Func_SH_continuous_hygene(global.Water_surf,global.View_width,global.View_height);

var _light_col = make_color_rgb(144,11,9);
var _dark_col = water_col;//c_black
var _fade_dist = 24;//24
var _time = current_time*.01;


var _m = 255.;
shader_set(shd_reflection);
shader_set_uniform_f(shader_get_uniform(shd_reflection,"u_vLight"),		color_get_red(_light_col)/_m,color_get_green(_light_col)/_m,color_get_blue(_light_col)/_m);
shader_set_uniform_f(shader_get_uniform(shd_reflection,"u_vDark"),		color_get_red(_dark_col)/_m,color_get_green(_dark_col)/_m,color_get_blue(_dark_col)/_m);
shader_set_uniform_f(shader_get_uniform(shd_reflection,"u_fFadeDist"),	_fade_dist);
shader_set_uniform_f(shader_get_uniform(shd_reflection,"u_fTexSize"),	texture_get_texel_width(sprite_get_texture(spr_player_walk_h,0)));//sprite might not work
shader_set_uniform_f(shader_get_uniform(shd_reflection,"u_fTime"),		_time);
shader_reset();




#endregion