function GSystem() constructor
{
	/// funct GSystem()
	/// descr 
	/// param 
	
	global.__GGUI_SYSTEM = ptr(self);
	
	visible = false; //draw event
	active = true; //step event
	
	//manager_time = new GTimeManager();
	manager_screen = new GScreenManager();
	manager_keyboard = new GKeyboardManager();
	//manager_mouse = new GMouseManager(4, 0, 0);
	//manager_depth = new GDepthManager();
	
	contents = ds_list_create();
	
	option_tick = 1;
	
	static begin_step = function()
	{
		manager_screen.option_tick = option_tick;
		manager_keyboard.option_tick = option_tick;
		
		manager_screen.begin_step();
	}
	
	static step = function()
	{
		manager_keyboard.step();
		
		var _active = (!manager_keyboard.keyboard_open);
		
		var _i = 0;
		var _size = ds_list_size(contents);
		repeat(_size)
		{
			contents[|_i].active = _active;
			contents[|_i].option_tick = option_tick;
			_i++;
		}
	}
	
	static draw = function()
	{
		manager_keyboard.draw();
	}
	
	static addContent = function(_content)
	{
		ds_list_add(contents, _content);
	}
}