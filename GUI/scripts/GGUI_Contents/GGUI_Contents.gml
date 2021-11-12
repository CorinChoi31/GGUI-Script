function GContent(_flag, _content, _x, _y, _scale_x, _scale_y, _rot, _color, _alpha) constructor
{
	flag = _flag;
	content = pointer_null;
	switch(flag)
    {
		default:
		case gFlag.STRING:
			if(is_array(_content)) //1
				content = ptr(new GString(_content[0]));
			else
				content = ptr(new GString(_content));
			break;
		case gFlag.REAL:
			if(is_array(_content)) //1
				content = ptr(new GReal(_content[0]));
			else
				content = ptr(new GReal(_content));
			break;
		case gFlag.BOOLEAN:
			if(is_array(_content)) //3
				content = ptr(new GBoolean(_content[0], _content[1], _content[2]));
			else
				content = ptr(new GBoolean(_content, "true", "false"));
			break;
		case gFlag.SPRITE:
			if(is_array(_content)) //2
				content = ptr(new GSprite(_content[0], _content[1]));
			else
				content = ptr(new GSprite(_content, -1));
			break;
    }

	x = _x;
	y = _y;
	
	scale_x = _scale_x;
	scale_y = _scale_y;

	rotation = _rot;
	color = _color;
	alpha = _alpha;

	static draw = function()
	{
		content.draw(x, y, scale_x, scale_y, rotation, color, alpha);
	}
}

function GString(_string) constructor
{
	/// funct GString(string)
	/// descr 
	/// param {string} string
	
	content = _string;
	
	static draw = function(_x, _y, _scale_x, _scale_y, _rot, _color, _alpha)
	{
		draw_text_transformed_color(_x, _y, _content, _scale_x, _scale_y, _rot, _color, _color, _color, _color, _alpha);
	}
}

function GReal(_real) constructor
{
	/// funct GReal(real)
	/// descr 
	/// param {real} real

	content = _real;
	
	static draw = function(_x, _y, _scale_x, _scale_y, _rot, _color, _alpha)
	{
		draw_text_transformed_color(_x, _y, content, _scale_x, _scale_y, _rot, _color, _color, _color, _color, _alpha);
	}
}

function GBoolean(_boolean, _truetype, _falsetype) constructor
{
	/// funct GBoolean(boolean)
	/// descr 
	/// param {boolean} boolean
	/// param {string} truetype
	/// param {string} falsetype

	content = _boolean;
	truetype = "true";
	falsetype = "false";
	
	static draw = function(_x, _y, _scale_x, _scale_y, _rot, _color, _alpha)
	{
		draw_text_transformed_color(_x, _y, content ? truetype : falsetype, _scale_x, _scale_y, _rot, _color, _color, _color, _color, _alpha);
	}
}

function GSprite(_sprite, _subimg) constructor
{
	/// funct GSprite(sprite, subimg)
	/// descr 
	/// param {sprite} sprite
	/// param {real} subimg

	content = _sprite;
	subimg = _subimg;
	
	static draw = function(_x, _y, _scale_x, _scale_y, _rot, _color, _alpha)
	{
		draw_sprite_ext(content, subimg, _x, _y, _scale_x, _scale_y, _rot, _color, _alpha);
	}
}

