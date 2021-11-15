function GKeyboardManager() constructor
{
	system = ggui_get_system();
	
	visible = true; //draw event
	active = true; //step event
	
	
	keyboard_input = false;
	keyboard_input_target = noone;
	
	keyboard_input_type = kbv_type_default;
	keyboard_input_autocapitalize = kbv_autocapitalize_none;
	
	keyboard_open = false;
	keyboard_status = false;
	
	keyboard_option_title = "";
	keyboard_option_input = "";
	
	
	backfield_color = c_black; backfield_color_target = backfield_color; backfield_color_trace = 1;
	backfield_color_type = gColorType.RGB; backfield_color_array = ggui_color_decompile(backfield_color, gColorType.ALL);
	backfield_alpha = 0.75; backfield_alpha_target = backfield_alpha; backfield_alpha_trace = 1;
	
	forefield_color = c_white; forefield_color_target = forefield_color; forefield_color_trace = 1;
	forefield_color_type = gColorType.RGB; forefield_color_array = ggui_color_decompile(forefield_color, gColorType.ALL);
	forefield_alpha = 1; forefield_alpha_target = forefield_alpha; forefield_alpha_trace = 1;
	
	outline_thickness = 1;
	outline_color = c_white; outline_color_target = outline_color; outline_color_trace = 1;
	outline_color_type = gColorType.RGB; outline_color_array = ggui_color_decompile(outline_color, gColorType.ALL);
	outline_alpha = 1; outline_alpha_target = outline_alpha; outline_alpha_trace = 1;
	
	title_color = c_white; title_color_target = title_color; title_color_trace = 1;
	title_color_type = gColorType.RGB; title_color_array = ggui_color_decompile(title_color, gColorType.ALL);
	title_font = global.__font;
	
	input_color = c_black; input_color_target = input_color; input_color_trace = 1;
	input_color_type = gColorType.RGB; input_color_array = ggui_color_decompile(input_color, gColorType.ALL);
	input_font = Default_Font;
	
	option_tick = 1;
	
	
	static step = function()
	{
		var _frame = round(option_tick);
		
		if(keyboard_input_target != noone)
		{
			if(active)
			{
				if(backfield_color != backfield_color_target)
				{
					repeat(_frame)
						backfield_color = ggui_color_lerp(backfield_color, backfield_color_target, backfield_color_trace, backfield_color_type, backfield_color_array);
				}
				if(backfield_alpha != backfield_alpha_target)
				{
					repeat(_frame)
						backfield_alpha = lerp(backfield_alpha, backfield_alpha_target, backfield_alpha_trace);
				}
			
				if(outline_color != outline_color_target)
				{
					repeat(_frame)
						outline_color = ggui_color_lerp(outline_color, outline_color_target,  outline_color_trace,  outline_color_type,  outline_color_array);
				}
				if(outline_alpha != outline_alpha_target)
				{
					repeat(_frame)
						outline_alpha = lerp(outline_alpha, outline_alpha_target, outline_alpha_trace);
				}
			
				if(title_color != title_color_target)
				{
					repeat(_frame)
						title_color = ggui_color_lerp(title_color, title_color_target,  title_color_trace,  title_color_type,  title_color_array);
				}
			
				if(input_color != input_color_target)
				{
					repeat(_frame)
						input_color = ggui_color_lerp(input_color, input_color_target,  input_color_trace,  input_color_type,  input_color_array);
				}
			}
			
			switch(os_type)
			{
				default:
				case os_windows:
					if(!keyboard_open)
					{
						keyboard_open = true;
						
						keyboard_string = keyboard_input_target.content;
					}
					else
					{
						if(mouse_check_button_released(mb_left) || keyboard_check(vk_escape))
						{
							keyboard_input_target = noone;
							keyboard_open = false;
							
							keyboard_option_title = "";
							keyboard_option_input = "";
						}
						
						if(keyboard_check(vk_enter))
						{
							keyboard_input_target.content = string_copy(keyboard_string, 1, string_length(keyboard_string));
									
							keyboard_input_target = noone;
							keyboard_open = false;
							
							keyboard_option_title = "";
							keyboard_option_input = "";
						}
					}
					break;
				case os_android:
					if(!keyboard_open)
					{
						keyboard_open = true;
						
						keyboard_string = keyboard_input_target.content;
					}
					else
					{
						if(keyboard_virtual_status())
						{
							if(mouse_check_button_released(mb_left) || keyboard_check(vk_escape))
							{
								keyboard_input_target = noone;
								keyboard_open = false;
								
								keyboard_option_title = "";
								keyboard_option_input = "";
								
								keyboard_virtual_hide();
							}
							
							if(keyboard_check(vk_enter))
							{
								keyboard_input_target.content = string_copy(keyboard_string, 1, string_length(keyboard_string));
									
								keyboard_input_target = noone;
								keyboard_open = false;
								
								keyboard_option_title = "";
								keyboard_option_input = "";
								
								keyboard_virtual_hide();
							}
						}
						else
						{
							keyboard_virtual_show(keyboard_input_type, kbv_returnkey_default, keyboard_input_autocapitalize, false);
						}
					}
					break;
			}
		}
	}
	
	static draw = function()
	{
		if(visible)
		{
			if(keyboard_open)
			{
				var _x1 = 0;
				var _y1 = 0;
				var _x2 = system.manager_screen.screen_width; 
				var _y2 = system.manager_screen.screen_height;
				
				var _color = backfield_color;
				var _alpha = backfield_alpha;
				if(_alpha > 0)
					ggui_draw_rectangle(_x1, _y1, _x2, _y2, _color, _color, _color, _color, _alpha, _alpha, _alpha, _alpha, false);
				
				_y1 = system.manager_screen.screen_height - (is_undefined(keyboard_virtual_height()) ? 0 : keyboard_virtual_height());
				ggui_draw_rectangle(_x1, _y1, _x2, _y2, c_black, c_black, c_black, c_black, 1, 1, 1, 1, false);
				
				
				_y2 = _y1;
				_y1 = 0;
				
				draw_set_font(input_font);
				var _h = string_height("M");
				_y1 = _y2 - (_h * 2);
				
				_color = forefield_color;
				_alpha = forefield_alpha;
				if(_alpha > 0)
					ggui_draw_rectangle(_x1, _y1, _x2, _y2, _color, _color, _color, _color, _alpha, _alpha, _alpha, _alpha, false);
					
				_color = outline_color;
				_alpha = outline_alpha;
				if(_alpha > 0)
					ggui_draw_rectangle(_x1, _y1, _x2, _y2, _color, _color, _color, _color, _alpha, _alpha, _alpha, _alpha, true);
				
				draw_set_color(input_color);
				draw_set_halign(fa_left);
				draw_set_valign(fa_center);
				
				var _w = string_width(" ") * 2;
				_x2 = _x1 - max(string_width(keyboard_string) + _w - _x2, 0) + _w;
				_y2 = (_y1 + _y2)/2;
				if(keyboard_string == "")
				{
					draw_set_alpha(0.5);
					draw_text(_x2, _y2, keyboard_option_input);
				}
				else
				{
					draw_set_alpha(1);
					draw_text(_x2, _y2, keyboard_string);
				}
				
				_x2 = _x1 + _w * 0.5;
				_y2 = _y1 - _h * 0.5;
				draw_set_alpha(1);
				draw_set_font(title_font);
				draw_set_color(title_color);
				draw_set_halign(fa_left);
				draw_set_valign(fa_bottom);
				draw_text(_x2, _y2, keyboard_option_title);
			}
		}
	}
}