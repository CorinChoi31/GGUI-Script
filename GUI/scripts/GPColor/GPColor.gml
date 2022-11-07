function GPColor(_color) constructor {
    
    color = _color;
    
    rgb = new GPColorRGB(color);
    hsv = new GPColorHSV(color);
}

function GPColorRGB(_color) constructor {
    
    red = 0;
    green = 0;
    blue = 0;
    
    Initialize(_color);
    
    static Initialize = function(_color) {
        Import(_color);
    }
    
    static Import = function(_color) {
        red = color_get_red(_color);
        green = color_get_green(_color);
        blue = color_get_blue(_color);
    }
    
    static Export = function() {
        return make_color_rgb(red, green, blue);
    }
}

function GPColorHSV(_color) constructor {
    
    hue = 0;
    saturation = 0;
    value = 0;
    
    Initialize(_color);
    
    static Initialize = function(_color) {
        Import(_color);
    }
    
    static Import = function(_color) {
        hue = color_get_hue(_color);
        saturation = color_get_saturation(_color);
        value = color_get_value(_color);
    }
    
    static Export = function() {
        return make_color_hsv(hue, saturation, value);
    }
}

function GPColorMotions(
    _color, _target, _type=ggTYPE.COLOR_RGB, 
    _motion_type=ggTYPE.MOTION_LINEAR, _motion_speed=1, _motion_smooth=0.5, _motion_spring=0.2, _motion_correction=0.001
) constructor {
    
    color = _color;
    
    type = _type;
    type_previous = _type;
    
    target = _target;
    target_previous = _color;
    
    rgb = new GPColorRGBMotions(color, target, _motion_type, _motion_speed, _motion_smooth, _motion_spring, _motion_correction);
    hsv = new GPColorHSVMotions(color, target, _motion_type, _motion_speed, _motion_smooth, _motion_spring, _motion_correction);
    
    motion_type = _motion_type;
    motion_speed = _motion_speed;
    motion_smooth = _motion_smooth;
    motion_spring = _motion_spring;
    motion_correction = _motion_correction
    
    static Step = function(_delta_tick=1) {
        if(color != target) {
            switch(type) {
                default:
                case ggTYPE.COLOR_RGB:
                    rgb.Step(_delta_tick);
                    color = rgb.Export();
                
                    hsv.Import(color);
                    break;
                case ggTYPE.COLOR_HSV:
                    hsv.Step(_delta_tick);
                    color = hsv.Export();
                
                    rgb.Import(color);
                    break;
            }
        }
    }
    
    
    static SetType = function(_type) {
        type_previous = type;
        type = _type;
    }
    
    static SetTarget = function(_color, _type=ggTYPE.COLOR_EXCLUDE, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        if(_type != ggTYPE.COLOR_EXCLUDE and _type != ggTYPE.COLOR_INCLUDE) {
            SetType(_type);
        }
        
        rgb.SetTarget(_color, _motion_type);
        hsv.SetTarget(_color, _motion_type);
        
        target_previous = target;
        target = _color;
    }
    
    static Switch = function(_type=ggTYPE.COLOR_INCLUDE, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        if(_type == ggTYPE.COLOR_INCLUDE) {
            SetType(type_previous);
        }
        else {
            if(_type != ggTYPE.COLOR_EXCLUDE) {
                SetType(_type);
            }
        }
        SetTarget(target_previous, _motion_type);
    }
}

function GPColorRGBMotions(
    _color, _target, 
    _motion_type=ggTYPE.MOTION_LINEAR, _motion_speed=1, _motion_smooth=0.5, _motion_spring=0.2, _motion_correction=0.001
) constructor {
    
    red = new GCVRealMotions(0, 0, _motion_type, _motion_smooth, _motion_spring, _motion_correction);
    green = new GCVRealMotions(0, 0, _motion_type, _motion_smooth, _motion_spring, _motion_correction);
    blue = new GCVRealMotions(0, 0, _motion_type, _motion_smooth, _motion_spring, _motion_correction);
    
    Initialize(_color, _target);
    
    static Initialize = function(_color, _target) {
        Import(_color, _target);
    }
    
    static Step = function(_delta_tick=1) {
        red.Step(_delta_tick);
        green.Step(_delta_tick);
        blue.Step(_delta_tick);
    }
    
    
    static Import = function(_color, _target=undefined) {
        red.value = color_get_red(_color);
        green.value = color_get_green(_color);
        blue.value = color_get_blue(_color);
        
        if(_target != undefined) {
            red.SetTarget(color_get_red(_target));
            green.SetTarget(color_get_green(_target));
            blue.SetTarget(color_get_blue(_target));
        }
    }
    
    static Export = function() {
        return make_color_rgb(red.value, green.value, blue.value);
    }
    
    static SetTarget = function(_color, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        if(_motion_type != ggTYPE.MOTION_EXCLUDE and _motion_type != ggTYPE.MOTION_INCLUDE) {
            red.SetType(_motion_type);
            green.SetType(_motion_type);
            blue.SetType(_motion_type);
        }
        red.SetTarget(color_get_red(_color));
        green.SetTarget(color_get_green(_color));
        blue.SetTarget(color_get_blue(_color));
    }
}

function GPColorHSVMotions(
    _color, _target, 
    _motion_type=ggTYPE.MOTION_LINEAR, _motion_speed=1, _motion_smooth=0.5, _motion_spring=0.2, _motion_correction=0.001
) constructor {
    
    hue = new GCVRealMotions(0, 0, _motion_type, _motion_smooth, _motion_spring, _motion_correction);
    saturation = new GCVRealMotions(0, 0, _motion_type, _motion_smooth, _motion_spring, _motion_correction);
    value = new GCVRealMotions(0, 0, _motion_type, _motion_smooth, _motion_spring, _motion_correction);
    
    Initialize(_color, _target);
    
    static Initialize = function(_color, _target) {
        Import(_color, _target);
    }
    
    static Step = function(_delta_tick=1) {
        hue.Step(_delta_tick);
        saturation.Step(_delta_tick);
        value.Step(_delta_tick);
    }
    
    
    static Import = function(_color, _target=undefined) {
        hue.value = color_get_hue(_color);
        saturation.value = color_get_saturation(_color);
        value.value = color_get_value(_color);
        
        if(_target != undefined) {
            hue.SetTarget(color_get_hue(_target));
            saturation.SetTarget(color_get_saturation(_target));
            value.SetTarget(color_get_value(_target));
        }
    }
    
    static Export = function() {
        return make_color_hsv(hue.value, saturation.value, value.value);
    }
    
    static SetTarget = function(_color, _motion_type=ggTYPE.MOTION_EXCLUDE) {
        if(_motion_type != ggTYPE.MOTION_EXCLUDE and _motion_type != ggTYPE.MOTION_INCLUDE) {
            hue.SetType(_motion_type);
            saturation.SetType(_motion_type);
            value.SetType(_motion_type);
        }
        hue.SetTarget(color_get_hue(_color));
        saturation.SetTarget(color_get_saturation(_color));
        value.SetTarget(color_get_value(_color));
    }
}