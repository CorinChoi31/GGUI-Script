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