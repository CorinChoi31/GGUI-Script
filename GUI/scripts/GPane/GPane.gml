function GPane(_x, _y, _width, _height) constructor
{
	/// funct GPane(x, y, width, height)
	/// descr 
	/// param {real} x
	/// param {real} y
	/// param {real} width
	/// param {real} height
	
	system = ggui_get_system();
	system.addContent(self);
	
	parent = noone; parent_x = 0; parent_y = 0;
	parent_on_surface = false;
	
	visible = false; //draw event
	active = true; //step event
	
	x = _x; x_target = x; x_trace = 1;
	y = _y; y_target = y; y_trace = 1;
	width = _width; width_target = width; width_trace = 1;
	height = _height; height_target = height; height_trace = 1;
	
	outline_thickness = 1;
	outline_color = c_white; outline_color_target = outline_color; outline_color_trace = 1;
	outline_color_type = gColorType.RGB; outline_color_array = ggui_color_decompile(outline_color, gColorType.ALL);
	outline_alpha = 0; outline_alpha_target = outline_alpha; outline_alpha_trace = 1;
	
	contents = ds_list_create();
	
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
		
		var _i = 0;
		var _size = ds_list_size(contents);
		repeat(_size)
		{
			contents[|_i].option_tick = option_tick;
			contents[|_i].step();
			
			_i++;
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
		
		var _i = 0;
		var _size = ds_list_size(contents);
		repeat(_size)
		{
			contents[|_i].draw();
			
			_i++;
		}
		
		var _x1 = _x; var _y1 = _y;
		var _x2 = _x + width; var _y2 = _y + height;
		
		var _color = outline_color;
		var _alpha = outline_alpha;
		if(_alpha > 0)
			ggui_draw_rectangle(_x1, _y1, _x2, _y2, _color, _color, _color, _color, _alpha, _alpha, _alpha, _alpha, true);
	}
	
	
	static addContent = function(_content)
	{
		var _prev = _content.parent;
		
		_content.parent = self;
		_content.parent_on_surface = false;
		
		ds_list_add(contents, _content);
		
		return _prev;
	}
}