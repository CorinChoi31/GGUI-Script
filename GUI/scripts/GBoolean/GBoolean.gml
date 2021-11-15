function GBoolean(_boolean, _truetype, _falsetype) constructor
{
	/// funct GBoolean(boolean)
	/// descr 
	/// param {boolean} boolean
	/// param {string} truetype
	/// param {string} falsetype
	
	#region Variables
	content = _boolean;
	truetype = is_undefined(_truetype) ? "true" : _truetype;
	falsetype = is_undefined(_falsetype) ? "false" : _falsetype;
	#endregion
	
	#region Events
	static draw = function(_x, _y, _scale_x, _scale_y, _rot, _color, _alpha)
	{
		/// @funct ggui_color_decompile(color, type)
		/// @descr
		/// @param {color} color
		/// @param {gColorType} type
		
		draw_text_transformed_color(_x, _y, content ? truetype : falsetype, _scale_x, _scale_y, _rot, _color, _color, _color, _color, _alpha);
	}
	
	static clean = function()
	{
		
	}
	#endregion
	
	#region Functions
	
	#endregion
}
