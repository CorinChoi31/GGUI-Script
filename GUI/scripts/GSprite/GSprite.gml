function GSprite(_sprite, _subimg) constructor
{
	/// funct GSprite(sprite, subimg)
	/// descr 
	/// param {sprite} sprite
	/// param {real} subimg

	content = _sprite;
	subimg = _subimg;
	
	subindex = subimg;
	subindex_max = sprite_get_number(content);
	
	static draw = function(_x, _y, _scale_x, _scale_y, _rot, _color, _alpha)
	{
		draw_sprite_ext(content, subindex, _x, _y, _scale_x, _scale_y, _rot, _color, _alpha);
		
		if(subimg == -1)
		{
			subindex = (subindex + 1) % subindex_max;
		}
	}
	
	static clean = function()
	{
		
	}
}