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