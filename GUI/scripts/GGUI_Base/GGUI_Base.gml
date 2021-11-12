function GContainer() constructor
{
	
}

function GTimeManager() constructor
{
	/// funct GTimeManager()
	/// descr
	/// param
	
	#region Variables
	tick = 0;
	time = 0;
	
	tick_delta = 0;
	time_delta = 0;
	
	tick_real = 0;
	time_real = 0;
	#endregion
	
	#region Events
	static begin_step = function()
	{
		time += 1/room_speed;
		tick += 1;
		
		time_delta = delta_time/1000000;
		tick_delta = time_delta*room_speed;
		
		time_real += time_delta;
		tick_real += tick_delta;
	}
	#endregion
}

function GMouseManager(_number, _x, _y) constructor
{
	/// funct GMouseManager(number, x, y)
	/// descr 
	/// param 
	
	#region Variables
	number = _number;
	
	x = array_create(number, _x);
	x_previous =  array_create(number, _x);
	x_gui = array_create(number, _x);
	x_gui_previous = array_create(number, _x);
	
	y = array_create(number, _y);
	y_previous = array_create(number, _y);
	y_gui = array_create(number, _y);
	y_gui_previous = array_create(number, _y);
	
	left_pressed = array_create(number, false);
	left_pressing = array_create(number, false);
	left_released = array_create(number, false);
	
	middle_pressed = array_create(number, false);
	middle_pressing = array_create(number, false);
	middle_released = array_create(number, false);
	
	right_pressed = array_create(number, false);
	right_pressing = array_create(number, false);
	right_released = array_create(number, false);
	#endregion
	
	#region Events
	static begin_step = function()
	{
		var _i = number;
		repeat(number)
		{
			_i -= 1;

			x_previous[_i] = x[_i];
			x[_i] = device_mouse_x(_i);
			x_gui_previous[_i] = x_gui[_i];
			x_gui[_i] = device_mouse_x_to_gui(_i);
			
			y_previous[_i] = y[_i];
			y[_i] = device_mouse_y(_i);
			y_gui_previous[_i] = y_gui[_i];
			y_gui[_i] = device_mouse_y_to_gui(_i);
			
			left_pressed[_i] = device_mouse_check_button_pressed(_i, mb_left);
			left_pressing[_i] = device_mouse_check_button(_i, mb_left);
			left_released[_i] = device_mouse_check_button_released(_i, mb_left);
			
			middle_pressed[_i] = device_mouse_check_button_pressed(_i, mb_middle);
			middle_pressing[_i] = device_mouse_check_button(_i, mb_middle);
			middle_released[_i] = device_mouse_check_button_released(_i, mb_middle);
			
			right_pressed[_i] = device_mouse_check_button_pressed(_i, mb_right);
			right_pressing[_i] = device_mouse_check_button(_i, mb_right);
			right_released[_i] = device_mouse_check_button_released(_i, mb_right);
		}
	}
	#endregion
	
	#region Functions
	getLastestMouse = function()
	{
		var _i = number; var _return = undefined;
		repeat(number)
		{
			_i -= 1;
			if(
				(left_pressing[_i] || left_pressed[_i] || left_released[_i]) or
				(right_pressing[_i] || right_pressed[_i] || right_released[_i]) or
				(middle_pressing[_i] || middle_pressed[_i] || middle_released[_i]) or
				(getDeltaX(_i) || getDeltaY(_i))
			)
			{
				_return = _i;
			}
		}
		return _return;
	}
	getLastestMouseMoved = function()
	{
		var _i = number; var _return = 0;
		repeat(number)
		{
			_i -= 1;
			if(getDeltaX(_i) || getDeltaY(_i))
			{
				_return = _i;
			}
		}
		return _return;
	}
	getLastestMousePress = function()
	{
		var _i = 0; var _return = 0;
		repeat(number)
		{
			if(
				(left_pressing[_i] || left_pressed[_i] || left_released[_i]) or
				(right_pressing[_i] || right_pressed[_i] || right_released[_i]) or
				(middle_pressing[_i] || middle_pressed[_i] || middle_released[_i])
			)
			{
				_return = _i;
			}
			_i += 1;
		}
		return _return;
	}
	getLastestMousePressed = function()
	{
		var _i = 0; var _return = 0;
		repeat(number)
		{
			if(left_pressed[_i] || right_pressed[_i] || middle_pressed[_i])
			{
				_return = _i;
			}
			_i += 1;
		}
		return _return;
	}
	getLastestMouseReleased = function()
	{
		var _i = 0; var _return = 0;
		repeat(number)
		{
			if(left_released[_i] || right_released[_i] || middle_released[_i])
			{
				_return = _i;
			}
			_i += 1;
		}
		return _return;
	}
	
	getX = function(_index)
	{
		return x[_index];
	}
	getY = function(_index)
	{
		return y[_index];
	}
	
	getDeltaX = function(_index)
	{
		return x[_index]-x_previous[_index];
	}
	getDeltaY = function(_index)
	{
		return y[_index]-y_previous[_index];
	}
	#endregion
}

function GDepthManager() constructor
{
	/// funct GDepthManager()
	/// descr 
	/// param 
	
	#region Variables
	mouse_manager = undefined;
	
	containers = ds_list_create();
	focus = -1;
	#endregion
	
	#region Events
	static begin_step = function()
	{
		if(focus >= 0)
		{
			if(containers[| _i].collide(mouse_manager.x_gui[mouse_manager.getLastestMouseReleased()], mouse_y))
			{
				
			}
		}
		
		var _focused = false;
		for(var _i = 0; _i < ds_list_size(containers); _i++)
		{
			if(containers[| _i].collide)
			{
				if(!_focused)
				{
					
				}
				array_push(_collied, );
			}
		}
	}
	static step = function()
	{
		
	}
	static clean = function()
	{
		ds_list_destroy(containers);	
	}
	#endregion
	
	#region Functions
	addContainer = function(_container)
	{
		ds_list_add(containers, _container);
	}
	#endregion
}

function GFrame() constructor
{
	/// funct GFrame()
	/// descr 
	/// param 

	#region Variables
	pane = undefined;
	pane_update = true;
	pane_forced = false;

	x = 0; x_target = x; x_trace = 0;
	x_previous = x;
	y = 0; y_target = y; y_trace = 0;
	y_previous = y;
	width = 1; width_target = width; width_trace = 0;
	height = 1; height_target = height; height_trace = 0;
	backfield_alpha = 1; backfield_alpha_target = backfield_alpha; backfield_alpha_trace = 0;
	backfield_color = c_white; backfield_color_target = backfield_color; backfield_color_trace = 0;
	outline_thickness = 1;
	outline_alpha = 1; outline_alpha_target = outline_alpha; outline_alpha_trace = 0;
	outline_color = c_white; outline_color_target = outline_color; outline_color_trace = 0;
	
	visible = true;
	focusable = true;
	focusing = false;
	
	titlebar = undefined; //ptr
	contents = ds_grid_create(2, 1); //ptr, priority
	#endregion

	#region Events
	static step = function()
	{
		/// funct step()
		/// descr 
		/// param 
	}
	static draw = function()
	{
		/// funct draw()
		/// descr 
		/// param 
	}
	static collide = function(_x, _y)
	{
		var _width = x+width;
		var _height = y+height;
		
		return visible and point_in_rectangle(_x, _y, x, y, _width, _height);
	}
	#endregion

	#region Functions
	static setTitle = function(_title) //GString
	{
		/// funct setTitle(title)
		/// descr 
		/// param {GString} title

		var _titlebar = (titlebar == undefined) ? new GTitlebar() : titlebar;
		_titlebar.setText(_title);
		
		titlebar = ptr(_titlebar);
	}
	#endregion
}

function GTitlebar() constructor
{
	visible = true;
	
	height = 16; height_target = height; height_trace = 0;
}

function GButton() constructor
{
	
}