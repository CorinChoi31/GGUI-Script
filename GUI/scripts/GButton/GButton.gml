function GButton(_x, _y, _width, _height, _backfield_color, _backfield_alpha, _outline_color, _outline_alpha) constructor
{
	system = ggui_get_system();
	system.addContent(self);
	
	parent = noone; parent_x = 0; parent_y = 0;
	parent_on_surface = false;
	
	visible = true; //draw event
	active = true; //step event
	
	x = _x; x_target = x; x_trace = 1;
	y = _y; y_target = y; y_trace = 1;
	width = _width; width_target = width; width_trace = 0.25;
	height = _height; height_target = height; height_trace = 0.25;
	
	backfield_color = _backfield_color; backfield_color_target = backfield_color; backfield_color_trace = 1;
	backfield_color_type = gColorType.RGB; backfield_color_array = ggui_color_decompile(backfield_color, gColorType.ALL);
	backfield_alpha = _backfield_alpha; backfield_alpha_target = backfield_alpha; backfield_alpha_trace = 1;
	
	outline_thickness = 1;
	outline_color = _outline_color; outline_color_target = outline_color; outline_color_trace = 1;
	outline_color_type = gColorType.RGB; outline_color_array = ggui_color_decompile(outline_color, gColorType.ALL);
	outline_alpha = _outline_alpha; outline_alpha_target = outline_alpha; outline_alpha_trace = 1;
	
	label = noone;
	label_halign = fa_center; label_halign_margin = 0; label_halign_margin_target = label_halign_margin; label_halign_margin_trace = 1;
	label_valign = fa_middle; label_valign_margin = 0; label_valign_margin_target = label_valign_margin; label_valign_margin_trace = 1;
	
	option_tick = 1;
	option_trigger_mouse_press_long = room_speed/2;
	option_mouse_x = 0;
	option_mouse_y = 0;
	option_data = undefined;
	
	trigger_mouse_press_time = 0;
	trigger_mouse_activate_long = false;
	trigger_mouse_activate_focus = false;
	trigger_mouse_activated = false;
	
	static step = function()
	{
		if(active)
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
		
			var _x1 = _x - width/2; var _y1 = _y - height/2;
			var _x2 = _x + width/2; var _y2 = _y + height/2;
			
			var _checkin = point_in_rectangle(mouse_x, mouse_y, _x1, _y1, _x2, _y2);
			if(mouse_check_button_pressed(mb_left))
			{
				if(_checkin)
				{
					trigger_mouse_activate_focus = true;
					
					eventMousePress();
				
					trigger_mouse_press_time = 0;
					trigger_mouse_activated = true;
				}
			}
			if(mouse_check_button(mb_left))
			{
				if(_checkin)
				{
					if(trigger_mouse_press_time < option_trigger_mouse_press_long)
					{
						trigger_mouse_activate_long = false;
					}
					else
					{
						trigger_mouse_activate_long = true;	
					}
				}
				
				if(trigger_mouse_activate_focus)
				{
					if(!trigger_mouse_activate_long)
						eventMousePressing();
					else
						eventMousePressingLong();
					
					trigger_mouse_press_time += option_tick;
					trigger_mouse_activated = true;
				}
			}
			if(mouse_check_button_released(mb_left))
			{
				if(trigger_mouse_activate_focus)
				{
					if(_checkin)
					{
						eventMousePressed();
					}
					
					trigger_mouse_press_time = 0;
					trigger_mouse_activated = true;
				}
					
				eventMouseRelease();
					
				trigger_mouse_activate_focus = false;
			}
			
			eventStep();
		
			if(label != noone)
			{
				syncLabel();
				label.step();
			}
		}
	}
	
	static draw = function()
	{
		if(visible)
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
		
			_color = outline_color;
			_alpha = outline_alpha;
			if(_alpha > 0)
				ggui_draw_rectangle(_x1, _y1, _x2, _y2, _color, _color, _color, _color, _alpha, _alpha, _alpha, _alpha, true);
			
			if(label != noone)
			{
				label.draw();
			}
		}
	}
	
	
	eventStep = function() {};
	
	eventMouseOver = function() {}
	eventMousePress = function() {}
	eventMousePressing = function() {}
	eventMousePressingLong = function() { eventMousePressing(); }
	eventMousePressed = function() {}
	eventMouseRelease = function() {}
	eventMouseReleased = function() {}
	
	
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
		
		label.option_tick = option_tick;
		
		label.x_target = _x;
		label.y_target = _y;
		
		label.halign = label_halign;
		label.valign = label_valign;
	}
}