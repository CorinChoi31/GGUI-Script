function GScreenManager() constructor
{
	system = ggui_get_system();
	
	screen_width = 0;
	screen_height = 0;
	
	option_tick = 1;
	
	static begin_step = function()
	{
		screen_width = global.screen_width;
		screen_height = global.screen_height;
	}
}