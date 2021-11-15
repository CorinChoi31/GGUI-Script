function GPanel(_x, _y, _width, _height) constructor
{
	/// funct GPanel(x, y, width, height)
	/// descr A Pane, using Surface.
	/// param {real} x
	/// param {real} y
	/// param {real} width
	/// param {real} height
	
	parent = noone; parent_x = 0; parent_y = 0;
	parent_on_surface = false;
	
	x = _x; x_target = x; x_trace = 1;
	y = _y; y_target = y; y_trace = 1;
	width = _width; width_target = width; width_trace = 1;
	height = _height; height_target = height; height_trace = 1;
	
	contents = ds_list_create();
	
	surface = surface_create(width, height);
	
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
		
		var _i = 0;
		var _size = ds_list_size(contents);
		for(_i = 0; _i < _size; _i++)
		{
			contents[|_i].step();	
		}
	}
	
	static draw = function()
	{
		if(!surface_exists(surface))
		{
			surface = surface_create(width, height);
		}
		
		surface_set_target(surface);
		
		draw_clear_alpha(c_black, 0);
		
		var _i = 0;
		var _size = ds_list_size(contents);
		for(_i = 0; _i < _size; _i++)
		{
			contents[|_i].draw();	
		}
		
		surface_reset_target();
		
		draw_surface(surface, x, y);
	}
	
	static addContent = function(_content)
	{
		var _prev = _content.parent;
		
		_content.parent = self;
		_content.parent_on_surface = true;
		
		ds_list_add(contents, _content);
		
		return _prev;
	}
}