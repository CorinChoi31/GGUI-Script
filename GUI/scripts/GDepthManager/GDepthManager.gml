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
				//array_push(_collied, );
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