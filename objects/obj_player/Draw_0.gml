/// @desc 


//shader_set(shader1);



func_anim_drawself();




if global.debug
	{
	//draw_text(x,y-20,"y: "+string(y))
	draw_point(x,y);
	draw_circle(x,y,combat_threat_detect_r,true);
	draw_sprite_ext(mask_index,0,x,y,1,1,0,c_aqua,0.5);
	}


//shader_reset();
