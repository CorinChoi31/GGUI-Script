function GString(_string) constructor
{
	/// funct GString(string)
	/// descr 
	/// param {string} string
	
	content = _string;
	
	static draw = function(_x, _y, _scale_x, _scale_y, _rot, _color, _alpha)
	{
		draw_text_transformed_color(_x, _y, content, _scale_x, _scale_y, _rot, _color, _color, _color, _color, _alpha);
	}
	
	static clean = function()
	{
		
	}
}

function GStrings(_string, _width) constructor
{
	/// funct GStrings(string)
	/// descr 
	/// param {string} string
	
	content = _string;
	width = _width;
	
	static draw = function(_x, _y, _scale_x, _scale_y, _rot, _color, _alpha)
	{
		var _scale = min(width/max(string_width(content) * _scale_x, 1), 1);

		if(_scale < 0.5)
		{
			_scale_x *= 0.5;
			_scale_y *= 0.5;
			draw_text_ext_transformed_color(_x, _y, content, -1, width, _scale_x, _scale_y, _rot, _color, _color, _color, _color, _alpha);
		}
		else
		{
			_scale_x *= _scale;
			_scale_y *= _scale;
			draw_text_transformed_color(_x, _y, content, _scale_x, _scale_y, _rot, _color, _color, _color, _color, _alpha);
		}
		
	}
	
	static clean = function()
	{
		
	}
}