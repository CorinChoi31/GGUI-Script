function GAPosition(_x, _y, _x_motion=global.__GGUI_PROPERTY[? "motion-default"], _y_motion=global.__GGUI_PROPERTY[? "motion-default"]) constructor {
    
    x = _x;
    y = _y;
    
    x_motion = _x_motion;
    y_motion = _y_motion;
    
}

function GASize(_width, _height, _width_motion=global.__GGUI_PROPERTY[? "motion-default"], _height_motion=global.__GGUI_PROPERTY[? "motion-default"]) constructor {
    
    width = _width;
    height = _height;
    
    width_motion = _width_motion;
    height_motion = _height_motion;
    
}

function GAScale(_x, _y, _x_motion=global.__GGUI_PROPERTY[? "motion-default"], _y_motion=global.__GGUI_PROPERTY[? "motion-default"]) constructor {
    
    x = _x;
    y = _y;
    
    x_motion = _x_motion;
    y_motion = _y_motion;
    
}

function GARotation(_rotation, _rotation_motion=global.__GGUI_PROPERTY[? "motion-default"]) constructor {
    
    rotation = _rotation;
    rotation_motion = _rotation_motion;
}

function GAThickness(_thickness, _thickness_motion=global.__GGUI_PROPERTY[? "motion-default"]) constructor {
    
    thickness = _thickness;
    thickness_motion = _thickness_motion;
}

function GAColor(_color, _color_type, _color_motion=global.__GGUI_PROPERTY[? "motion-default"]) constructor {
    
    color = _color;
    color_type = _color_type;
    
    color_motion = _color_motion;
}

function GAAlpha(_alpha, _alpha_motion=global.__GGUI_PROPERTY[? "motion-default"]) constructor {
    
    alpha = _alpha;
    alpha_motion = _alpha_motion;
}

function GAMotion(_type, _speed=1, _smooth=0.5, _spring=0.2, _correction=0.01) constructor {
    
    type = _type;
    
    speed = _speed;
    smooth = _smooth;
    spring = _spring;
    
    correction = _correction;
    
}