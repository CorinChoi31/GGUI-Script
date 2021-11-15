enum gFlag
{
    STRING = 0,
    REAL,
	BOOLEAN,
	
    SPRITE,
}

enum gColorType
{
	ALL = all,
	RGB = 0,
	HSV
}

/*function gGUI()
{
	
}
*/

global.__GGUI_SYSTEM = undefined;

function ggui_get_system()
{
	if(global.__GGUI_SYSTEM == undefined)
	{
		global.__GGUI_SYSTEM = new GSystem();	
	}
	
	return global.__GGUI_SYSTEM;
}

function ggui_color_decompile(_color, _type)
{
	/// @funct ggui_color_decompile(color, type)
	/// @descr
	/// @param {color} color
	/// @param {gColorType} type
	
	var _result = 0;
	switch(_type)
	{
		default:
		case gColorType.ALL:
			_result = [color_get_red(_color), color_get_green(_color), color_get_blue(_color), color_get_hue(_color), color_get_saturation(_color), color_get_value(_color)];
			break;
		case gColorType.RGB:
			_result = [color_get_red(_color), color_get_green(_color), color_get_blue(_color)];
			break;
		case gColorType.HSV:
			_result = [color_get_hue(_color), color_get_saturation(_color), color_get_value(_color)];
			break;
	}
	return _result;
}

function ggui_color_compile(_color, _type)
{
	/// @funct ggui_color_compile(color, type)
	/// @descr
	/// @param {color} color
	/// @param {gColorType} type
	
	var _result = 0;
	switch(_type)
	{
		default:
		case gColorType.RGB:
			_result = make_color_rgb(_color[0], _color[1], _color[2]);
			break;
		case gColorType.HSV:
			_result = make_color_hsv(_color[3], _color[4], _color[5]);
			break;
	}
	return _result;
}

function ggui_color_lerp(_color, _target, _trace, _type, _array)
{
	/// @funct ggui_color_lerp(color, target, trace, type, array)
	/// @descr
	/// @param {color} color
	/// @param {color} target
	/// @param {real} trace
	/// @param {gColorType} type
	/// @param {color} array
	
	switch(_type)
	{
		default:
		case gColorType.RGB:
			_array[@ 0] = lerp(_array[0], color_get_red(_target), _trace);
			_array[@ 1] = lerp(_array[1], color_get_green(_target), _trace);
			_array[@ 2] = lerp(_array[2], color_get_blue(_target), _trace);
			_color = ggui_color_compile(_array, _type);
					
			var _dec = ggui_color_decompile(_color, gColorType.HSV);
			_array[@ 3] = _dec[0]; _array[@ 4] = _dec[1]; _array[@ 5] = _dec[2];
			break;
		case gColorType.HSV:
			_array[@ 3] = lerp(_array[3], color_get_hue(_target), _trace);
			_array[@ 4] = lerp(_array[4], color_get_saturation(_target), _trace);
			_array[@ 5] = lerp(_array[5], color_get_value(_target), _trace);
			_color = ggui_color_compile(_array, _type);
					
			var _dec = ggui_color_decompile(_color, gColorType.RGB);
			_array[@ 0] = _dec[0]; _array[@ 1] = _dec[1]; _array[@ 2] = _dec[2];
			break;
	}
	
	return _color; 
}

function ggui_draw_rectangle(_x1, _y1, _x2, _y2, _c1, _c2, _c3, _c4, _a1, _a2, _a3, _a4, _outline)
{
	/// @funct ggui_draw_rectangle(x1, y1, x2, y2, color1, color2, color3, color4, alpha1, alpha2, alpha3, alpha4, outline)
	/// @descr
	/// @param {real} x1
	/// @param {real} y1
	/// @param {real} x2
	/// @param {real} y2
	/// @param {color} color1
	/// @param {color} color2
	/// @param {color} color3
	/// @param {color} color4
	/// @param {real} alpha1
	/// @param {real} alpha2
	/// @param {real} alpha3
	/// @param {real} alpha4
	/// @param {bool} outline
	
	if(_outline)
	{
		draw_primitive_begin(pr_linestrip);
			draw_vertex_color(_x1, _y1, _c1, _a1);
			draw_vertex_color(_x2, _y1, _c2, _a2);
			draw_vertex_color(_x2, _y2, _c3, _a3);
			draw_vertex_color(_x1, _y2, _c4, _a4);
			draw_vertex_color(_x1, _y1, _c1, _a1);
		draw_primitive_end();
	}
	else
	{
		draw_primitive_begin(pr_trianglestrip);
			draw_vertex_color(_x1, _y1, _c1, _a1);
			draw_vertex_color(_x1, _y2, _c4, _a4);
			draw_vertex_color(_x2, _y1, _c2, _a2);
			draw_vertex_color(_x2, _y2, _c3, _a3);
		draw_primitive_end();
	}
}