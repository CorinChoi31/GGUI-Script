function GSliderHorizontal(_x, _y, _width, _height, _frontfield_color, _frontfield_alpha, _backfield_color, _backfield_alpha, _outline_color, _outline_alpha) constructor
{
	parent = noone; parent_x = 0; parent_y = 0;
	parent_on_surface = false;
	
	x = _x; x_target = x; x_trace = 1;
	y = _y; y_target = y; y_trace = 1;
	width = _width; width_target = width; width_trace = 0.25;
	height = _height; height_target = height; height_trace = 0.25;
	
	value = 0; value_target = 0; value_trace = 1;
	value_ratio = 0;
	value_min = 0; value_max = 0;
	value_reverse = 0;
	
	frontfield_color = _frontfield_color; frontfield_color_target = frontfield_color; frontfield_color_trace = 1;
	frontfield_color_type = gColorType.RGB; frontfield_color_array = ggui_color_decompile(frontfield_color, gColorType.ALL);
	frontfield_alpha = _frontfield_alpha; frontfield_alpha_target = frontfield_alpha; frontfield_alpha_trace = 1;
	
	backfield_color = _backfield_color; backfield_color_target = backfield_color; backfield_color_trace = 1;
	backfield_color_type = gColorType.RGB; backfield_color_array = ggui_color_decompile(backfield_color, gColorType.ALL);
	backfield_alpha = _backfield_alpha; backfield_alpha_target = backfield_alpha; backfield_alpha_trace = 1;
	
	outline_thickness = 1;
	outline_color = _outline_color; outline_color_target = outline_color; outline_color_trace = 1;
	outline_color_type = gColorType.RGB; outline_color_array = ggui_color_decompile(outline_color, gColorType.ALL);
	outline_alpha = _outline_alpha; outline_alpha_target = outline_alpha; outline_alpha_trace = 1;
	
	button = noone; //new GButton(x, y, _height, _height, _frontfield_color, _frontfield_alpha, _outline_color, _outline_alpha);
	
	label = noone;
	label_halign = fa_center; label_halign_margin = 0; label_halign_margin_target = label_halign_margin; label_halign_margin_trace = 1;
	label_valign = fa_middle; label_valign_margin = 0; label_valign_margin_target = label_valign_margin; label_valign_margin_trace = 1;
	
	option_tick = 1;
	option_trigger_mouse_press_long = room_speed/2;
	
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
		
		if(value != value_target)
		{
			repeat(_frame)
				value = lerp(value, value_target, value_trace);
		}
		
		value_ratio = median(0, abs((value - value_min)/(value_max - value_min)), 1);
		
		if(frontfield_color != frontfield_color_target)
		{
			repeat(_frame)
				frontfield_color = ggui_color_lerp(frontfield_color, frontfield_color_target, frontfield_color_trace, frontfield_color_type, frontfield_color_array);
		}
		if(frontfield_alpha != frontfield_alpha_target)
		{
			repeat(_frame)
				frontfield_alpha = lerp(frontfield_alpha, frontfield_alpha_target, frontfield_alpha_trace);
		}
		
		if(backfield_color != backfield_color_target)
		{
			repeat(_frame)
				backfield_color = ggui_color_lerp(backfield_color, backfield_color_target, backfield_color_trace, backfield_color_type, backfield_color_array);
		}
		if(backfield_alpha != backfield_alpha_target)
		{
			repeat(_frame)
				backfield_alpha = lerp(backfield_alpha, backfield_alpha_target, backfield_alpha_trace);
		}
		
		if(outline_color != outline_color_target)
		{
			repeat(_frame)
				outline_color = ggui_color_lerp(outline_color, outline_color_target,  outline_color_trace,  outline_color_type,  outline_color_array);
		}
		if(outline_alpha != outline_alpha_target)
		{
			repeat(_frame)
				outline_alpha = lerp(outline_alpha, outline_alpha_target, outline_alpha_trace);
		}
		
		if(label_halign_margin != label_halign_margin_target)
		{
			repeat(_frame)
				label_halign_margin = lerp(label_halign_margin, label_halign_margin_target, label_halign_margin_trace);
		}
		if(label_valign_margin != label_valign_margin_target)
		{
			repeat(_frame)
				label_valign_margin = lerp(label_valign_margin, label_valign_margin_target, label_valign_margin_trace);
		}
		
		parent_x = x;
		parent_y = y;
		
		var _x = x;
		var _y = y;
		
		if(parent != noone)
		{
			_x += parent.parent_x;
			_y += parent.parent_y;
			
			parent_x += parent.parent_x;
			parent_y += parent.parent_y;
		}
		
		//show_debug_message(string(parent_x)+" "+string(parent_y))
		
		if(button != noone)
		{
			syncButton();
			button.step();
		}
		
		if(label != noone)
		{
			syncLabel();
			label.step();
		}
	}
	
	static draw = function()
	{
		var _x = x;
		var _y = y;
		
		if(parent != noone and !parent_on_surface)
		{
			_x += parent.parent_x;
			_y += parent.parent_y;
		}
		
		var _x1 = _x - width/2; var _y1 = _y - height/2;
		var _x2 = _x + width/2; var _y2 = _y + height/2;
		var _color = backfield_color;
		var _alpha = backfield_alpha;
		if(_alpha > 0)
			ggui_draw_rectangle(_x1, _y1, _x2, _y2, _color, _color, _color, _color, _alpha, _alpha, _alpha, _alpha, false);
		
		var _sign = ((!value_reverse) ? 1 : -1);
		_x1 = _x - width/2*_sign; _y1 = _y - height/2;
		_x2 = _x1 + width*value_ratio*_sign; _y2 = _y + height/2;
		_color = frontfield_color;
		_alpha = frontfield_alpha;
		if(_alpha > 0)
			ggui_draw_rectangle(_x1, _y1, _x2, _y2, _color, _color, _color, _color, _alpha, _alpha, _alpha, _alpha, false);
		
		_x1 = _x - width/2; var _y1 = _y - height/2;
		_x2 = _x + width/2; var _y2 = _y + height/2;
		_color = outline_color;
		_alpha = outline_alpha;
		if(_alpha > 0)
			ggui_draw_rectangle(_x1, _y1, _x2, _y2, _color, _color, _color, _color, _alpha, _alpha, _alpha, _alpha, true);
		
		if(button != noone)
		{
			button.draw();
		}
		
		if(label != noone)
		{
			label.draw();
		}
	}
	
	static setButton = function(_button)
	{
		var _prev = button;
		
		button = _button;
		
		button.parent = self;
		button.parent_on_surface = false;
		
		syncButton();
		
		button.x = button.x_target;
		button.y = button.y_target;
		
		return _prev;
	}
	static getButton = function()
	{
		return button; 
	}
	static syncButton = function()
	{
		var _sign = ((!value_reverse) ? 1 : -1);
		
		var _x = (-width/2 + width*value_ratio)*_sign;
		var _y = 0;
		
		button.x_target = _x;
		button.y_target = _y;
	}
	
	static setLabel = function(_label)
	{
		var _prev = label;
		
		label = _label;
		
		label.parent = self;
		label.parent_on_surface = false;
		
		syncLabel();
		
		label.x = label.x_target;
		label.y = label.y_target;
		
		return _prev;
	}
	static getLabel = function()
	{
		return label; 
	}
	static syncLabel = function()
	{
		var _x = 0;
		var _y = 0;
			
		switch(label_halign)
		{
			case fa_top:
				_x = -width/2+label_halign_margin;
				break;
			default:
			case fa_middle:
				_x += label_halign_margin;
				break;
			case fa_bottom:
				_x = width/2-label_halign_margin;
				break;
		}
			
		switch(label_valign)
		{
			case fa_top:
				_y = -height/2+label_valign_margin;
				break;
			default:
			case fa_middle:
				_y += label_valign_margin;
				break;
			case fa_bottom:
				_y = height/2-label_valign_margin;
				break;
		}
			
		label.x_target = _x;
		label.y_target = _y;
		
		label.halign = label_halign;
		label.valign = label_valign;
	}
}