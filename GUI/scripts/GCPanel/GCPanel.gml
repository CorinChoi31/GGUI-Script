function GCPanel(
    _surface=false,
    _position=new GAPosition(0, 0),
    _size=new GASize(32, 32),
    _scale=new GAScale(1, 1),
    _rotation=new GARotation(0),
    _backfield_color=new GAColor(c_white, ggTYPE.COLOR_RGB),
    _backfield_alpha=new GAAlpha(0.1),
    _forefield_color=new GAColor(c_white, ggTYPE.COLOR_RGB),
    _forefield_alpha=new GAAlpha(0),
    _outline_thickness=new GAThickness(1),
    _outline_color=new GAColor(c_white, ggTYPE.COLOR_RGB),
    _outline_alpha=new GAAlpha(1),
    _alpha=new GAAlpha(1),
    _blend=bm_normal,
    _valign=fa_top,
    _halign=fa_left
) constructor {
    
    parent = undefined;
    parent_on_surface = false;
    
    parent_affects_to_position = true;
    parent_position_x = 0;
    parent_position_y = 0;
    
    parent_affects_to_scale = true;
    parent_scale_x = 1;
    parent_scale_y = 1;
    
    parent_affects_to_rotation = true;
    parent_rotation = 0;
    
    parent_affects_to_alpha = true;
    parent_alpha = 1;
    
    //
    
    firststep = true;
    stepable = true;
    firstdraw = true;
    drawable = true;
    focusing = false;
    
    //
    
    surface_usage = _surface;
    surface = surface_usage ? surface_create(1, 1) : undefined;
    surface_width = 0;
    surface_height = 0;
    
    contents = array_create(0);
    
    position_x = new GCVRealMotions(
        _position.x, _position.x, 
        _position.x_motion.type, _position.x_motion.speed, _position.x_motion.smooth, _position.x_motion.spring, _position.x_motion.correction
    );
    position_y = new GCVRealMotions(
        _position.y, _position.y, 
        _position.y_motion.type, _position.y_motion.speed, _position.y_motion.smooth, _position.y_motion.spring, _position.y_motion.correction
    );
    
    size_width = new GCVRealMotions(
        _size.width, _size.width, 
        _size.width_motion.type, _size.width_motion.speed, _size.width_motion.smooth, _size.width_motion.spring, _size.width_motion.correction
    );
    size_height = new GCVRealMotions(
        _size.height, _size.height, 
        _size.height_motion.type, _size.height_motion.speed, _size.height_motion.smooth, _size.height_motion.spring, _size.height_motion.correction
    );
    
    scale_x = new GCVRealMotions(
        _scale.x, _scale.x, 
        _scale.x_motion.type, _scale.x_motion.speed, _scale.x_motion.smooth, _scale.x_motion.spring, _scale.x_motion.correction
    );
    scale_y = new GCVRealMotions(
        _scale.y, _scale.y, 
        _scale.y_motion.type, _scale.y_motion.speed, _scale.y_motion.smooth, _scale.y_motion.spring, _scale.y_motion.correction
    );
    
    rotation = new GCVRealRangeMotions(
        _rotation.rotation, _rotation.rotation, 
        360, 
        _rotation.rotation_motion.type, _rotation.rotation_motion.speed, _rotation.rotation_motion.smooth, _rotation.rotation_motion.spring, _rotation.rotation_motion.correction
    );
    
    backfield_color = new GPColorMotions(
        _backfield_color.color, _backfield_color.color, 
        _backfield_color.color_type, 
        _backfield_color.color_motion.type, _backfield_color.color_motion.speed, _backfield_color.color_motion.smooth, _backfield_color.color_motion.spring, _backfield_color.color_motion.correction
    );
    backfield_alpha = new GCVRealMotions(
        _backfield_alpha.alpha, _backfield_alpha.alpha, 
        _backfield_alpha.alpha_motion.type, _backfield_alpha.alpha_motion.speed, _backfield_alpha.alpha_motion.smooth, _backfield_alpha.alpha_motion.spring, _backfield_alpha.alpha_motion.correction
    );
    backfield_blend = _blend;
    
    forefield_color = new GPColorMotions(
        _forefield_color.color, _forefield_color.color, 
        _forefield_color.color_type, 
        _forefield_color.color_motion.type, _forefield_color.color_motion.speed, _forefield_color.color_motion.smooth, _forefield_color.color_motion.spring, _forefield_color.color_motion.correction
    );
    forefield_alpha = new GCVRealMotions(
        _forefield_alpha.alpha, _forefield_alpha.alpha, 
        _forefield_alpha.alpha_motion.type, _forefield_alpha.alpha_motion.speed, _forefield_alpha.alpha_motion.smooth, _forefield_alpha.alpha_motion.spring, _forefield_alpha.alpha_motion.correction
    );
    forefield_blend = _blend;
    
    outline_thickness = new GCVRealMotions(
        _outline_thickness.thickness, _outline_thickness.thickness,
        _outline_thickness.thickness_motion.type, _outline_thickness.thickness_motion.speed, _outline_thickness.thickness_motion.smooth, _outline_thickness.thickness_motion.spring, _outline_thickness.thickness_motion.correction
    );
    outline_color = new GPColorMotions(
        _outline_color.color, _outline_color.color, 
        _outline_color.color_type, 
        _outline_color.color_motion.type, _outline_color.color_motion.speed, _outline_color.color_motion.smooth, _outline_color.color_motion.spring, _outline_color.color_motion.correction
    );
    outline_alpha = new GCVRealMotions(
        _outline_alpha.alpha, _outline_alpha.alpha, 
        _outline_alpha.alpha_motion.type, _outline_alpha.alpha_motion.speed, _outline_alpha.alpha_motion.smooth, _outline_alpha.alpha_motion.spring, _outline_alpha.alpha_motion.correction
    );
    outline_blend = _blend;
    
    alpha = new GCVRealMotions(
        _alpha.alpha, _alpha.alpha, 
        _alpha.alpha_motion.type, _alpha.alpha_motion.speed, _alpha.alpha_motion.smooth, _alpha.alpha_motion.spring, _alpha.alpha_motion.correction
    );
    
    valign = _valign;
    halign = _halign;
    
    //
    
    
    static Step = function(_delta_tick=1) {
        if(stepable) {
            position_x.Step(_delta_tick);
            position_y.Step(_delta_tick);
            
            size_width.Step(_delta_tick);
            size_height.Step(_delta_tick);
        
            scale_x.Step(_delta_tick);
            scale_y.Step(_delta_tick);
        
            rotation.Step(_delta_tick);
        
            backfield_color.Step(_delta_tick);
            backfield_alpha.Step(_delta_tick);
            
            forefield_color.Step(_delta_tick);
            forefield_alpha.Step(_delta_tick);
            
            outline_thickness.Step(_delta_tick);
            outline_color.Step(_delta_tick);
            outline_alpha.Step(_delta_tick);
            
            alpha.Step(_delta_tick);
            
            
            var _position_x = position_x.value;
            var _position_y = position_y.value;
            
            var _size_width = size_width.value;
            var _size_height = size_height.value;
            
            var _scale_x = scale_x.value;
            var _scale_y = scale_y.value;
            
            var _rotation = rotation.value;
            
            var _backfield_color = backfield_color.color;
            var _backfield_alpha = backfield_alpha.value;
            var _backfield_blend = backfield_blend;
            
            var _forefield_color = forefield_color.color;
            var _forefield_alpha = forefield_alpha.value;
            var _forefield_blend = forefield_blend;
            
            var _outline_thickness = outline_thickness.value;
            var _outline_color = outline_color.color;
            var _outline_alpha = outline_alpha.value;
            var _outline_blend = outline_blend;
            
            var _alpha = alpha.value;
            
            
            if(parent != undefined) {
                if(parent_affects_to_alpha) {
                    _alpha = alpha.value * parent_alpha;
                }
                if(parent_affects_to_rotation) {
                    _rotation = rotation.value + parent_rotation;
                }
                if(parent_affects_to_scale) {
                    _scale_x = scale_x.value * parent_scale_x;
                    _scale_y = scale_y.value * parent_scale_y;
                }
                if(parent_affects_to_position) {
                    _position_x = parent_position_x + lengthdir_x(position_x.value * parent_scale_x, _rotation) - lengthdir_y(position_y.value * parent_scale_y, _rotation);
                    _position_y = parent_position_y + lengthdir_y(position_x.value * parent_scale_x, _rotation) + lengthdir_x(position_y.value * parent_scale_y, _rotation);
                }
            }
            
            
            var _px = _position_x;
            var _py = _position_y;
            
            var _sw = _size_width * _scale_x;
            var _sh = _size_height * _scale_y;
            
            switch(halign) {
                case fa_left:
                    _px += lengthdir_x(_sw * 0.5, _rotation);
                    _py += lengthdir_y(_sw * 0.5, _rotation);
                    break;
                default:
                case fa_center:
                    
                    break;
                case fa_right:
                    _px += lengthdir_x(_sw * 0.5, _rotation + 180);
                    _py += lengthdir_y(_sw * 0.5, _rotation + 180);
            }
            
            switch(valign) {
                case fa_top:
                    _px += lengthdir_x(_sh * 0.5, _rotation - 90);
                    _py += lengthdir_y(_sh * 0.5, _rotation - 90);
                    break;
                default:
                case fa_middle:
                    
                    break;
                case fa_bottom:
                    _px += lengthdir_x(_sh * 0.5, _rotation + 90);
                    _py += lengthdir_y(_sh * 0.5, _rotation + 90);
            }
            
            CustomStep(_delta_tick, _position_x, _position_y, _scale_x, _scale_y, _rotation, _alpha);
            
            var _i = 0; var _length = array_length(contents);
            var _content = undefined;
            repeat(_length) {
                _content = contents[_i++];
                
                _content.parent_position_x = _position_x;
                _content.parent_position_y = _position_y;
                
                _content.parent_scale_x = _scale_x;
                _content.parent_scale_y = _scale_y;
                
                _content.parent_rotation = _rotation;
                
                _content.parent_alpha = _alpha;
                
                _content.Step();
            }
        }
    }
    
    static Draw = function() {
        if(drawable) {
            var _position_x = position_x.value;
            var _position_y = position_y.value;
            
            var _size_width = size_width.value;
            var _size_height = size_height.value;
            
            var _scale_x = scale_x.value;
            var _scale_y = scale_y.value;
            
            var _rotation = rotation.value;
            
            var _backfield_color = backfield_color.color;
            var _backfield_alpha = backfield_alpha.value;
            var _backfield_blend = backfield_blend;
            
            var _forefield_color = forefield_color.color;
            var _forefield_alpha = forefield_alpha.value;
            var _forefield_blend = forefield_blend;
            
            var _outline_thickness = outline_thickness.value;
            var _outline_color = outline_color.color;
            var _outline_alpha = outline_alpha.value;
            var _outline_blend = outline_blend;
            
            var _alpha = alpha.value;
            
            
            if(parent != undefined) {
                if(parent_affects_to_alpha) {
                    _alpha = alpha.value * parent_alpha;
                }
                if(parent_affects_to_rotation) {
                    _rotation = rotation.value + parent_rotation;
                }
                if(parent_affects_to_scale) {
                    _scale_x = scale_x.value * parent_scale_x;
                    _scale_y = scale_y.value * parent_scale_y;
                }
                if(parent_affects_to_position) {
                    _position_x = parent_position_x + lengthdir_x(position_x.value * parent_scale_x, _rotation) - lengthdir_y(position_y.value * parent_scale_y, _rotation);
                    _position_y = parent_position_y + lengthdir_y(position_x.value * parent_scale_x, _rotation) + lengthdir_x(position_y.value * parent_scale_y, _rotation);
                }
            }
            
            
            var _surface_usage = surface_usage;
            
            if(_surface_usage) {
                if(surface == undefined or !surface_exists(surface)) {
                    surface_width = max(0, _size_width * _scale_x); surface_height = max(0, _size_height * _scale_y);
                    surface = surface_create(surface_width + 1, surface_height + 1);
                }
                else {
                    if(surface_width != _size_width * _scale_x or surface_height != _size_height * _scale_y) {
                        surface_width = max(0, _size_width * _scale_x); surface_height = max(0, _size_height * _scale_y);
                        surface_resize(surface, surface_width + 1, surface_height + 1);
                    }
                }
                
                _position_x = 0;
                _position_y = 0;
                
                surface_set_target(surface);
                
                draw_clear_alpha(c_black, 1);
            }
            
            
            var _px = _position_x;
            var _py = _position_y;
            
            var _sw = _size_width * _scale_x;
            var _sh = _size_height * _scale_y;
            
            var _otw = max(_outline_thickness * _scale_x, 0);
            var _oth = max(_outline_thickness * _scale_y, 0);
            
            var _ba = _backfield_alpha * _alpha;
            var _fa = _forefield_alpha * _alpha;
            var _oa = _outline_alpha * _alpha;
            
            switch(halign) {
                case fa_left:
                    _px += lengthdir_x(_sw * 0.5, _rotation);
                    _py += lengthdir_y(_sw * 0.5, _rotation);
                    break;
                default:
                case fa_center:
                    
                    break;
                case fa_right:
                    _px += lengthdir_x(_sw * 0.5, _rotation + 180);
                    _py += lengthdir_y(_sw * 0.5, _rotation + 180);
            }
            
            switch(valign) {
                case fa_top:
                    _px += lengthdir_x(_sh * 0.5, _rotation - 90);
                    _py += lengthdir_y(_sh * 0.5, _rotation - 90);
                    break;
                default:
                case fa_middle:
                    
                    break;
                case fa_bottom:
                    _px += lengthdir_x(_sh * 0.5, _rotation + 90);
                    _py += lengthdir_y(_sh * 0.5, _rotation + 90);
            }
            
            
            var _w = _sw * 0.5;
            var _h = _sh * 0.5;
            var _points_1 = ggui_get_rectangle_points(_px, _py, _w, _h, _rotation);
            var _points_2 = ggui_get_rectangle_points(_px, _py, _w - _otw, _h - _oth, _rotation);
            
            if(_ba > 0) {
                var _b = gpu_get_blendmode();
                if(_b != _backfield_blend and _backfield_blend != undefined) {
                    gpu_set_blendmode(_backfield_blend);
                }
                
                ggui_draw_rectangle(_points_1,
                    _backfield_color, _backfield_color, _backfield_color, _backfield_color,
                    _ba, _ba, _ba, _ba, 
                    false
                );
            }
            
            CustomDraw(_position_x, _position_y, _scale_x, _scale_y, _rotation, _alpha);
            
            var _i = 0; var _length = array_length(contents);
            var _content = undefined;
            repeat(_length) {
                _content = contents[_i++];
                
                _content.parent_position_x = _position_x;
                _content.parent_position_y = _position_y;
                
                _content.parent_scale_x = _scale_x;
                _content.parent_scale_y = _scale_y;
                
                _content.parent_rotation = _rotation;
                
                _content.parent_alpha = _alpha;
                
                _content.Draw();
            }
            
            if(_fa > 0) {
                var _b = gpu_get_blendmode();
                if(_b != _forefield_blend and _forefield_blend != undefined) {
                    gpu_set_blendmode(_forefield_blend);
                }
                
                ggui_draw_rectangle(_points_1,
                    _forefield_color, _forefield_color, _forefield_color, _forefield_color,
                    _fa, _fa, _fa, _fa, 
                    false
                );
            }
            
            if(_oa > 0 and (_otw > 0 or _oth > 0)) {
                var _b = gpu_get_blendmode();
                if(_b != _outline_blend and _outline_blend != undefined) {
                    gpu_set_blendmode(_outline_blend);
                }
                
                ggui_draw_rectangle_outline(_points_1, _points_2,
                    _outline_color, _outline_color, _outline_color, _outline_color,
                    _oa, _oa, _oa, _oa
                );
            }
            
            if(_surface_usage) {
                surface_reset_target();
                
                draw_surface_ext(surface, position_x.value, position_y.value, 1, 1, _rotation, c_white, 1);
            }
        }
    }
    
    static Open = function() {
        EventOpen();
        
        var _i = 0; var _length = array_length(contents);
        var _content = undefined;
        repeat(_length) {
            _content = contents[_i++];
            
            _content.Open();
        }
    }
    
    static Close = function() {
        EventClose();
        
        var _i = 0; var _length = array_length(contents);
        var _content = undefined;
        repeat(_length) {
            _content = contents[_i++];
            
            _content.Close();
        }
    }
    
    AddContent = function(_content) {
        array_push(contents, _content);
    }
    
    CustomStep = function(_delta_tick, _position_x, _position_y, _scale_x, _scale_y, _rotation, _alpha) { }
    CustomDraw = function(_position_x, _position_y, _scale_x, _scale_y, _rotation, _alpha) { }
    
    EventOpen = function() { }
    EventClose = function() { }
}