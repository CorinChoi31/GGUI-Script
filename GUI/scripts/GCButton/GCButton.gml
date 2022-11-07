function GCButton(
    _position=new GAPosition(0, 0),
    _size=new GASize(32, 32),
    _scale=new GAScale(1, 1),
    _rotation=new GARotation(0),
    _backfield_color=new GAColor(c_white, ggTYPE.COLOR_RGB),
    _backfield_alpha=new GAAlpha(0),
    _forefield_color=new GAColor(c_white, ggTYPE.COLOR_RGB),
    _forefield_alpha=new GAAlpha(0),
    _outline_thickness=new GAThickness(1),
    _outline_color=new GAColor(c_white, ggTYPE.COLOR_RGB),
    _outline_alpha=new GAAlpha(1),
    _alpha=new GAAlpha(1),
    _blend=bm_normal,
    _valign=fa_middle,
    _halign=fa_center
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
    clickable = true;
    
    //
    
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
    
    label = undefined;
    
    label_valign = fa_middle;
    label_halign = fa_center;
    
    var _vmargin_motion = global.__GGUI_PROPERTY[? "motion-default"];
    label_vmargin = new GCVRealMotions(
        0, 0,
        _vmargin_motion.type, _vmargin_motion.speed, _vmargin_motion.smooth, _vmargin_motion.spring, _vmargin_motion.correction
    );
    var _hmargin_motion = global.__GGUI_PROPERTY[? "motion-default"];
    label_hmargin = new GCVRealMotions(
        0, 0,
        _hmargin_motion.type, _hmargin_motion.speed, _hmargin_motion.smooth, _hmargin_motion.spring, _hmargin_motion.correction
    );
    
    //
    
    mouse_input_mode = ggTYPE.MOUSE_GUI;
    mouse_input_size = 1;
    mouse_input = [];
    mouse_input_index = -1;
    mouse_input_x = 0;
    mouse_input_y = 0;
    
    mouse_input_event_over = false;
    mouse_input_event_pressed = false;
    mouse_input_event_pressing = 0;
    mouse_input_event_pressing_max = global.__GGUI_PROPERTY[? "mouse-click-long"];
    mouse_input_event_released = false;
    mouse_input_event_done = false;
    
    //
    
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
            
            
            CustomStep(_delta_tick, _position_x, _position_y, _scale_x, _scale_y, _rotation, _alpha);
            
            
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
            
            
            var _w = _sw * 0.5;
            var _h = _sh * 0.5;
            var _points = ggui_get_rectangle_points(_px, _py, _w, _h, _rotation);
            
            var _i = 0;
            if(clickable) {
                if(mouse_input_index < 0) {
                    var _len = array_length(mouse_input);
                    if(_len > 0) {
                        array_delete(mouse_input, 0, _len);
                    }
                    
                    repeat(mouse_input_size) {
                        var _mx = 0;
                        var _my = 0;
                        switch(mouse_input_mode) {
                            default:
                            case ggTYPE.MOUSE_GUI:
                                _mx = device_mouse_x_to_gui(_i);
                                _my = device_mouse_y_to_gui(_i);
                                break;
                            case ggTYPE.MOUSE_GAME:
                                _mx = device_mouse_x(_i);
                                _my = device_mouse_y(_i);
                                break;
                        }
                        if(point_in_circle(_mx, _my, _px, _py, max(_w, _h))) {
                            array_push(mouse_input, _i);
                        }
                        _i += 1;
                    }
                
                    _i = 0;
                    repeat(array_length(mouse_input)) {
                        var _m = mouse_input[_i];
                        var _mx = 0;
                        var _my = 0;
                        switch(mouse_input_mode) {
                            default:
                            case ggTYPE.MOUSE_GUI:
                                _mx = device_mouse_x_to_gui(_i);
                                _my = device_mouse_y_to_gui(_i);
                                break;
                            case ggTYPE.MOUSE_GAME:
                                _mx = device_mouse_x(_i);
                                _my = device_mouse_y(_i);
                                break;
                        }
                        if(ggui_check_point_in_area(_mx, _my, _px, _py, _points)) {
                            mouse_input_index = _i;
                            break;
                        }
                    }
                }
            }
            if(mouse_input_index >= 0) {
                switch(mouse_input_mode) {
                    default:
                    case ggTYPE.MOUSE_GUI:
                        mouse_input_x = device_mouse_x_to_gui(mouse_input_index);
                        mouse_input_y = device_mouse_y_to_gui(mouse_input_index);
                        break;
                    case ggTYPE.MOUSE_GAME:
                        mouse_input_x = device_mouse_x(mouse_input_index);
                        mouse_input_y = device_mouse_y(mouse_input_index);
                        break;
                }
                
                if(!mouse_input_event_over) {
                    mouse_input_event_over = true;
                    mouse_input_event_done = false;
                    mouse_input_event_release = false;
                    
                    EventMouseOver();
                }
                else {
                    var _collied = ggui_check_point_in_area(mouse_input_x, mouse_input_y, _px, _py, _points);
                    
                    if(!mouse_input_event_pressed) {
                        
                        if(!_collied) {
                            EventMouseLeave();
                            if(!mouse_input_event_done) {
                                EventMouseDone();
                            }
                            
                            mouse_input_event_over = false;
                            
                            mouse_input_index = -1;
                            exit;
                        }
                        else {
                            
                        }
                        
                        if(device_mouse_check_button_pressed(mouse_input_index, mb_left)) {
                            mouse_input_event_pressed = true;
                            mouse_input_event_pressing = 0;
                            
                            mouse_input_event_done = false;
                            
                            EventMousePressed();
                            EventMousePressing();
                        }
                    }
                    
                    if(mouse_input_event_pressed) {
                        if(device_mouse_check_button(mouse_input_index, mb_left)) {
                            if(_collied)
                                mouse_input_event_pressing += 1;
                            
                            if(mouse_input_event_pressing <= mouse_input_event_pressing_max) {
                                EventMousePressing();
                            }
                            else {
                                EventMousePressingLong();
                            }
                        }
                        
                        if(device_mouse_check_button_released(mouse_input_index, mb_left)) {
                            if(_collied) {
                                if(mouse_input_event_pressing <= mouse_input_event_pressing_max) {
                                    EventMouseReleased();
                                    
                                    mouse_input_event_released = true;
                                }
                                else {
                                    EventMouseReleasedLong();
                                    
                                    mouse_input_event_released = true;
                                }
                            }
                            
                            if(!mouse_input_event_done) {
                                EventMouseDone();
                            }
                            
                            mouse_input_event_over = false;
                            mouse_input_event_pressed = false;
                            mouse_input_event_done = true;
                            
                            mouse_input_index = -1;
                        }
                    }
                }
            }
            
            CustomStep(_delta_tick, _position_x, _position_y, _scale_x, _scale_y, _rotation, _alpha);
            
            if(label != undefined) {
                label.Step();
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
            
            CustomDraw(_px, _py, _scale_x, _scale_y, _rotation, _alpha);
            
            if(label != undefined) {
                if(label != undefined) {
                    _px = 0;
                    _py = 0;
                    
                    var _vm = label_vmargin.value * _scale_y;
                    var _hm = label_hmargin.value * _scale_x;
                    
                    var _hx = lengthdir_x(_hm, _rotation);
                    var _hy = lengthdir_y(_hm, _rotation);
                    var _vx = lengthdir_x(_vm, _rotation);
                    var _vy = lengthdir_y(_vm, _rotation);
                    
                    var _mx = _hx - _vy;
                    var _my = _hy + _vx;
                    
                    if(label_valign == fa_top and label_halign == fa_left) {
                        _px = _points_1[0][0] + _mx;
                        _py = _points_1[0][1] + _my;
                    }
                    else if(label_valign == fa_top and label_halign == fa_center) {
                        _px = mean(_points_1[0][0], _points_1[1][0]) + _mx;
                        _py = mean(_points_1[0][1], _points_1[1][1]) + _my;
                    }
                    else if(label_valign == fa_top and label_halign == fa_right) {
                        _px = _points_1[1][0] + _mx;
                        _py = _points_1[1][1] + _my;
                    }
                    else if(label_valign == fa_middle and label_halign == fa_left) {
                        _px = mean(_points_1[0][0], _points_1[3][0]) + _mx;
                        _py = mean(_points_1[0][1], _points_1[3][1]) + _my;
                    }
                    else if(label_valign == fa_middle and label_halign == fa_center) {
                        _px = mean(_points_1[0][0], _points_1[1][0], _points_1[2][0], _points_1[3][0]) + _mx;
                        _py = mean(_points_1[0][1], _points_1[1][1], _points_1[2][1], _points_1[3][1]) + _my;
                    }
                    else if(label_valign == fa_middle and label_halign == fa_right) {
                        _px = mean(_points_1[1][0], _points_1[2][0]) + _mx;
                        _py = mean(_points_1[1][1], _points_1[2][1]) + _my;
                    }
                    else if(label_valign == fa_bottom and label_halign == fa_left) {
                        _px = _points_1[3][0] + _mx;
                        _py = _points_1[3][1] + _my;
                    }
                    else if(label_valign == fa_bottom and label_halign == fa_center) {
                        _px = mean(_points_1[2][0], _points_1[3][0]) + _mx;
                        _py = mean(_points_1[2][1], _points_1[3][1]) + _my;
                    }
                    else if(label_valign == fa_bottom and label_halign == fa_right) {
                        _px = _points_1[2][0] + _mx;
                        _py = _points_1[2][1] + _my;
                    }
                    
                    label.parent_position_x = _px;
                    label.parent_position_y = _py;
                    
                    label.parent_scale_x = _scale_x;
                    label.parent_scale_y = _scale_y;
                    
                    label.parent_rotation = _rotation;
                    
                    label.parent_alpha = _alpha;
                }
                label.Draw();
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
        }
    }
    
    static Open = function() {
        EventOpen();
        
        if(label != undefined) {
            label.Open();
        }
    }
    
    static Close = function() {
        EventClose();
        
        mouse_input_event_over = false;
        mouse_input_event_pressed = false;
        mouse_input_event_released = false;
        mouse_input_event_done = false;
        
        if(label != undefined) {
            label.Close();
        }
    }
    
    //
    
    CustomStep = function(_delta_tick, _position_x, _position_y, _scale_x, _scale_y, _rotation, _alpha) { }
    CustomDraw = function(_position_x, _position_y, _scale_x, _scale_y, _rotation, _alpha) { }
    
    EventMouseOver = function() { }
    EventMousePressed = function() { }
    EventMousePressing = function() { }
    EventMousePressingLong = function() { EventMousePressing(); }
    EventMouseReleased = function() { }
    EventMouseReleasedLong = function() { EventMouseReleased(); }
    EventMouseLeave = function() { }
    EventMouseDone = function() { }
    
    EventOpen = function() { }
    EventClose = function() { }
    
    //
    
    static SetParent = function(_parent=undefined) {
        var _prev = parent;
        parent = _parent;
        
        return _prev;
    }
    
    static SetLabel = function(_label, _label_valign=undefined, _label_halign=undefined, _label_vmargin=undefined, _label_hmargin=undefined, _immediately=true, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        if(_label_valign != undefined) {
            label_valign = _label_valign;
        }
        
        if(_label_halign != undefined) {
            label_halign = _label_halign;
        }
        
        if(_label_vmargin != undefined) {
            label_vmargin.SetTarget(_label_vmargin, _motion_type);
            
            if(_immediately) {
                label_vmargin.value = _label_vmargin;
            }
        }
        
        if(_label_hmargin != undefined) {
            label_hmargin.SetTarget(_label_hmargin, _motion_type);
            
            if(_immediately) {
                label_hmargin.value = _label_hmargin;
            }
        }
        
        var _prev = label;
        label = _label;
        
        label.SetParent(self);
        
        return _prev;
    }
    
    static SetLabelAlign = function(_label_valign, _label_halign) {
        label_valign = _label_valign;
        label_halign = _label_halign;
    }
    
    static SetLabelMargin = function(_label_vmargin, _label_hmargin, _immediately=true, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        label_vmargin.SetTarget(_label_vmargin, _motion_type);
        label_hmargin.SetTarget(_label_hmargin, _motion_type);
        
        if(_immediately) {
            label_vmargin.value = _label_vmargin;
            label_hmargin.value = _label_hmargin;
        }
    }
    
    static SetPosition = function(_x, _y, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        position_x.SetTarget(_x, _motion_type);
        position_y.SetTarget(_y, _motion_type);
        
        if(_immediately) {
            position_x.value = _x;
            position_y.value = _y;
        }
    }
    
    static SetSize = function(_width, _height, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        size_width.SetTarget(_width, _motion_type);
        size_height.SetTarget(_height, _motion_type);
        
        if(_immediately) {
            size_width.value = _width;
            size_height.value = _height;
        }
    }
    
    static SetScale = function(_x, _y, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        scale_x.SetTarget(_x, _motion_type);
        scale_y.SetTarget(_y, _motion_type);
        
        if(_immediately) {
            scale_x.value = _x;
            scale_y.value = _y;
        }
    }
    
    static SetRotation = function(_rotation, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        rotation.SetTarget(_rotation, _motion_type);
        
        if(_immediately) {
            rotation.value = _rotation;
        }
    }
    
    static SetBackfieldColor = function(_color, _immediately=false, _type=ggTYPE.COLOR_EXCLUDE, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        backfield_color.SetTarget(_color, _type, _motion_type);
        
        if(_immediately) {
            backfield_color.color = _color;
            backfield_color.rgb.Import(_color, _color);
            backfield_color.hsv.Import(_color, _color);
        }
    }
    static SetBackfieldAlpha = function(_alpha, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        backfield_alpha.SetTarget(_alpha, _motion_type);
        
        if(_immediately) {
            backfield_alpha.value = _alpha;
        }
    }
    static SetForefieldColor = function(_color, _immediately=false, _type=ggTYPE.COLOR_EXCLUDE, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        forefield_color.SetTarget(_color, _type, _motion_type);
        
        if(_immediately) {
            forefield_color.color = _color;
            forefield_color.rgb.Import(_color, _color);
            forefield_color.hsv.Import(_color, _color);
        }
    }
    static SetForefieldAlpha = function(_alpha, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        forefield_alpha.SetTarget(_alpha, _motion_type);
        
        if(_immediately) {
            forefield_alpha.value = _alpha;
        }
    }
    
    static SetOutlineThickness = function(_thickness, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        outline_thickness.SetTarget(_thickness, _motion_type);
        
        if(_immediately) {
            outline_thickness.value = _thickness;
        }
    }
    static SetOutlineColor = function(_color, _immediately=false, _type=ggTYPE.COLOR_EXCLUDE, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        outline_color.SetTarget(_color, _type, _motion_type);
        
        if(_immediately) {
            outline_color.color = _color;
            outline_color.rgb.Import(_color, _color);
            outline_color.hsv.Import(_color, _color);
        }
    }
    static SetOutlineAlpha = function(_alpha, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        outline_alpha.SetTarget(_alpha, _motion_type);
        
        if(_immediately) {
            outline_alpha.value = _alpha;
        }
    }
    
    static SetAlpha = function(_alpha, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        alpha.SetTarget(_alpha, _motion_type);
        
        if(_immediately) {
            alpha.value = _alpha;
        }
    }
    
    static SetBackfieldBlend = function(_blend) {
        backfield_blend = _blend;
    }
    static SetOutlineBlend = function(_blend) {
        outline_blend = _blend;
    }
    
    static SetAlign = function(_valign, _halign) {
        valign = _valign;
        halign = _halign;
    }
}