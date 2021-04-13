//controlling draw a bit more easily
//
//
//
//
//

#region set
//set alpha
function Func_draw_set_alpha(a)
	{
	if draw_get_alpha()!=a
		draw_set_alpha(a);
	}
//set color
function Func_draw_set_color(c)
	{
	if draw_get_color()!=c
		draw_set_color(c);
	}
//set font
function Func_draw_set_font(f)
	{
	if draw_get_font()!=f
		draw_set_font(f);
	}
#endregion
#region reset
//reset alpha
function Func_draw_reset_alpha()
	{
	if draw_get_alpha()!=1
		draw_set_alpha(1);
	}
//reset color
function Func_draw_reset_color()
	{
	if draw_get_color()!=-1
		draw_set_color(-1);
	}
//reset all
function Func_draw_reset_all()
	{
	Func_draw_reset_alpha();
	Func_draw_reset_color();
	}

#endregion