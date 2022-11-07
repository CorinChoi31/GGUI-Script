function GCLabel(
    _position=new GAPosition(0, 0),
    _scale=new GAScale(1, 1),
    _rotation=new GARotation(0),
    _color=new GAColor(c_white, ggTYPE.COLOR_RGB),
    _alpha=new GAAlpha(1),
    _blend=bm_normal,
    _font=GRFont_12pt,
    _valign=fa_middle,
    _halign=fa_center,
    _content=undefined
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
    
    //
    
    position_x = new GCVRealMotions(
        _position.x, _position.x, 
        _position.x_motion.type, _position.x_motion.speed, _position.x_motion.smooth, _position.x_motion.spring, _position.x_motion.correction
    );
    position_y = new GCVRealMotions(
        _position.y, _position.y, 
        _position.y_motion.type, _position.y_motion.speed, _position.y_motion.smooth, _position.y_motion.spring, _position.y_motion.correction
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
    
    color = new GPColorMotions(
        _color.color, _color.color, 
        _color.color_type, 
        _color.color_motion.type, _color.color_motion.speed, _color.color_motion.smooth, _color.color_motion.spring, _color.color_motion.correction
    );
    
    alpha = new GCVRealMotions(
        _alpha.alpha, _alpha.alpha, 
        _alpha.alpha_motion.type, _alpha.alpha_motion.speed, _alpha.alpha_motion.smooth, _alpha.alpha_motion.spring, _alpha.alpha_motion.correction
    );
    
    blend = _blend;
    
    valign = _valign;
    halign = _halign;
    
    font = _font;
    
    content = _content;
    
    //
    
    //
    
    static Step = function(_delta_tick=1) {
        if(stepable) {
            
            position_x.Step(_delta_tick);
            position_y.Step(_delta_tick);
        
            scale_x.Step(_delta_tick);
            scale_y.Step(_delta_tick);
        
            rotation.Step(_delta_tick);
        
            color.Step(_delta_tick);
            alpha.Step(_delta_tick);
            
            if(content != undefined) {
                content.Step(_delta_tick);
            }
            
            CustomStep(_delta_tick);
        }
    }
    
    static Draw = function() {
        if(drawable) {
            if(content != undefined) {
                var _position_x = position_x.value;
                var _position_y = position_y.value;
                
                var _scale_x = scale_x.value;
                var _scale_y = scale_y.value;
                
                var _rotation = rotation.value;
                
                var _color = color.color;
                var _alpha = alpha.value;
                
                var _blend = blend;
                var _font = font;
                
                
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
                
                CustomDraw(_position_x, _position_y, _scale_x, _scale_y, _rotation, _alpha);
                
                if(_alpha > 0) {
                    var _b = gpu_get_blendmode();
                    var _f = draw_get_font();
                    var _h = draw_get_halign();
                    var _v = draw_get_valign();
                
                    if(_b != _blend and _blend != undefined)
                        gpu_set_blendmode(_blend);
                    if(_f != _font and _font != undefined)
                        draw_set_font(_font);
                    if(_h != halign and halign != undefined)
                        draw_set_halign(halign);
                    if(_v != valign and valign != undefined)
                        draw_set_valign(valign);
                
                    content.Draw(_position_x, _position_y, _scale_x, _scale_y, _rotation, _color, _alpha);
                }
            }
        }
    }
    
    static Open = function() {
        EventOpen();
    }
    
    static Close = function() {
        EventClose();
    }
    
    //
    
    CustomStep = function(_delta_tick=1) { }
    CustomDraw = function(_position_x, _position_y, _scale_x, _scale_y, _rotation, _alpha) { }
    
    EventOpen = function() { }
    EventClose = function() { }
    
    //
    
    
    static SetParent = function(_parent=undefined) {
        var _prev = parent;
        parent = _parent;
        
        return _prev;
    }
    
    static SetContent = function(_content) {
        var _prev = content;
        content = _content;
        
        return _prev;
    }
    
    static SetPosition = function(_x, _y, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        position_x.SetTarget(_x, _motion_type);
        position_y.SetTarget(_y, _motion_type);
        
        if(_immediately) {
            position_x.value = _x;
            position_y.value = _y;
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
    
    static SetColor = function(_color, _immediately=false, _type=ggTYPE.COLOR_EXCLUDE, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        color.SetTarget(_color, _type, _motion_type);
        
        if(_immediately) {
            color.color = _color;
            color.rgb.Import(_color, _color);
            color.hsv.Import(_color, _color);
        }
    }
    
    static SetAlpha = function(_alpha, _immediately=false, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        alpha.SetTarget(_alpha, _motion_type);
        
        if(_immediately) {
            alpha.value = _alpha;
        }
    }
    
    static SetBlend = function(_blend) {
        blend = _blend;
    }
    
    static SetAlign = function(_valign, _halign) {
        valign = _valign;
        halign = _halign;
    }
    
    static SetFont = function(_font) {
        font = _font;
    }
}