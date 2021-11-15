function GFrame() constructor
{
	/// funct GFrame()
	/// descr 
	/// param 

	#region Variables
	pane = undefined;
	pane_update = true;
	pane_forced = false;

	x = 0; x_target = x; x_trace = 1;
	x_previous = x;
	y = 0; y_target = y; y_trace = 1;
	y_previous = y;
	width = 1; width_target = width; width_trace = 1;
	height = 1; height_target = height; height_trace = 1;
	backfield_alpha = 1; backfield_alpha_target = backfield_alpha; backfield_alpha_trace = 1;
	backfield_color = c_white; backfield_color_target = backfield_color; backfield_color_trace = 1;
	outline_thickness = 1;
	outline_alpha = 1; outline_alpha_target = outline_alpha; outline_alpha_trace = 1;
	outline_color = c_white; outline_color_target = outline_color; outline_color_trace = 1;
	
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