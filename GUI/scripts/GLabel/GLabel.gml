function GLabel(_x, _y, _valign, _halign, _scale_x, _scale_y, _rotation, _color, _alpha, _blend) constructor
{
	/// funct GLabel(x, y, valign, halign, scale_x, scale_y, rotation, color, alpha, blendmode)
	/// descr 
	/// param {real} x
	/// param {real} y
	/// param {valign} valign
	/// param {halign} halign
	/// param {real} scale_x
	/// param {real} scale_y
	/// param {degree} rotation
	/// param {color} color
	/// param {real} alpha
	/// param {blendmode} blendmode
	
	system = ggui_get_system();
	system.addContent(self);
	
	parent = noone; parent_x = 0; parent_y = 0;
	parent_on_surface = false;
	
	visible = true; //draw event
	active = true; //step event
	
	x = is_undefined(_x) ? 0 : _x; x_target = x; x_trace = 1;
	y = is_undefined(_y) ? 0 : _y; y_target = y; y_trace = 1;
	
	valign = is_undefined(_valign) ? fa_middle : _valign;
	halign = is_undefined(_halign) ? fa_center : _halign;
	
	font = Default_Font;
	
	scale_x = is_undefined(_scale_x) ? 1 : _scale_x; scale_x_target = scale_x; scale_x_trace = 1;
	scale_y = is_undefined(_scale_y) ? 1 : _scale_y; scale_y_target = scale_y; scale_y_trace = 1;

	rotation = _rotation; rotation_target = rotation; rotation_trace = 1;
	
	color = _color; color_target = color; color_trace = 1;
	color_type = gColorType.RGB; color_array = ggui_color_decompile(color, gColorType.ALL);
	alpha = _alpha; alpha_target = alpha; alpha_trace = 1;
	blend = _blend;
	
	content = noone;
	
	option_tick = 1;
	
	
	static step = function()
	{
		var _frame = round(option_tick);
		
		if(x != x_target)
		{
			repeat(_frame)
				x = lerp(x, x_target, x_trace);
		}
		if(y != y_target)
		{
			repeat(_frame)
				y = lerp(y, y_target, y_trace);
		}
		
		if(scale_x != scale_x_target)
		{
			repeat(_frame)
				scale_x = lerp(scale_x, scale_x_target, scale_x_trace);
		}
		if(scale_y != scale_y_target)
		{
			repeat(_frame)
				scale_y = lerp(scale_y, scale_y_target, scale_y_trace);
		}
		
		/*
		if(width != width_target)
		{
			repeat(_frame)
				width = lerp(width, width_target, width_trace);
		}
		if(height != height_target)
		{
			repeat(_frame)
				height = lerp(height, height_target, height_trace);
		}
		*/
		
		if(rotation != rotation_target)
		{
			repeat(_frame)
				rotation += angle_difference(rotation, rotation_target) * rotation_trace;
		}
		
		if(color != color_target)
		{
			repeat(_frame)
				color = ggui_color_lerp(color, color_target, color_trace, color_type, color_array);
		}
		if(alpha != alpha_target)
		{
			repeat(_frame)
				alpha = lerp(alpha, alpha_target, alpha_trace);
		}
	}
	
	static draw = function()
	{
		if(content != noone)
		{
			var _x = x;
			var _y = y;
		
			if(parent != noone and !parent_on_surface)
			{
				_x += parent.parent_x;
				_y += parent.parent_y;
			}
		
			var _f = draw_get_font();
			var _h = draw_get_halign();
			var _v = draw_get_valign();
		
			if(_f != font)
				draw_set_font(font);
			if(_h != halign)
				draw_set_halign(halign);
			if(_v != valign)
				draw_set_valign(valign);
			
			content.draw(_x, _y, scale_x, scale_y, rotation, color, alpha);
		
			if(_f != font)
				draw_set_font(_f);
			if(_h != halign)
				draw_set_halign(_h);
			if(_v != valign)
				draw_set_valign(_v);
		}
	}
	
	static setContent = function(_content)
	{
		var _prev = content;
		
		content = _content;
		
		return _prev;
	};
	static getContent = function()
	{
		return content;
	};
}