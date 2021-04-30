 ///reflecting water


function Func_water_draw_self_reflection(_mult)
	{
	if _mult == 0
		return;
	
	//surf
	//surface_set_target(global.Water_surf);
	shader_set(shd_reflection);
	shader_set_uniform_f(shader_get_uniform(shd_reflection,"u_fOffset"),-(img_display_y+sprite_height - sprite_yoffset));
	//gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_src_alpha);
	
	var _yoff = (sprite_height - sprite_yoffset)*2;

	//Draw reflection
	//draw_sprite_ext(sprite_index,img_index_show,img_display_x - global.View_x, (img_display_y+_yoff) - global.View_y, image_xscale, -image_yscale, 0, image_blend, obj_water.water_reflec_a * _mult);
	draw_sprite_ext(sprite_index,img_index_show,img_display_x/* - global.View_x*/, (img_display_y+_yoff)/* - global.View_y*/, image_xscale, -image_yscale, 0, image_blend, _mult);
	
	//surface_reset_target();
	shader_reset();
	}




