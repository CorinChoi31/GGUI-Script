// MACROS
#macro __GGUI_VERSION "0.0.1"

// ENUMS
enum ggFLAG {
    
    CONTENT_STRING = 0, 
    CONTENT_REAL, 
    CONTENT_BOOLEAN, 
    CONTENT_SPRITE, 
}

enum ggTYPE {
    
    COLOR_INCLUDE = -4,
    COLOR_EXCLUDE = -1,
    COLOR_ALL = all, 
    COLOR_RGB = 0, 
    COLOR_HSV,
    
    MOTION_INCLUDE = -4,
    MOTION_EXCLUDE = -1,
    MOTION_LINEAR = 0,
    MOTION_SMOOTH,
    MOTION_SPRING,
    MOTION_LINEAR_SMOOTH,
    
    MOUSE_GUI = 0,
    MOUSE_GAME = 1,
}


// GLOBAL VARIABLES
global.__GGUI_SYSTEM = undefined;
global.__GGUI_PROPERTY = ds_map_create();

global.__GGUI_FRAMESPEED = 1;

#region
    var _frame_speed_standard = 1/60 * 1000;
    var _frame_speed_current = game_get_speed(gamespeed_microseconds)/1000;
    var _frame_speed_ratio = _frame_speed_current/_frame_speed_standard;
    
    global.__GGUI_FRAMESPEED = _frame_speed_ratio;
    
    // frame
    
    
    // colors
    global.__GGUI_PROPERTY[? "color-type"] = ggTYPE.COLOR_RGB;
    
    // motions
    global.__GGUI_PROPERTY[? "motion-default"] = new GAMotion(ggTYPE.MOTION_SMOOTH, 1, 0.5, 0.25, 0.01);
    
    // mouse
    global.__GGUI_PROPERTY[? "mouse-click-long"] = 60 / 2 * global.__GGUI_FRAMESPEED;
#endregion



// GLOBAL SCRIPTS
function ggui_get_system() {
    
    if(global.__GGUI_SYSTEM == undefined) {
        global.__GGUI_SYSTEM = new GSystem();
    }
    
    return global.__GGUI_SYSTEM;
}

function ggui_get_value_in_range(_value, _range) {
    var _result = _value;
    
    if(_value < 0 or _value >= _range) {
        var _q = floor(_value/_range);
        _result = _value - _q * _range;
    }
    
    return _result;
}

function ggui_get_value_difference_in_range(_value_1, _value_2, _range) {
    var _result = 0;
    
    _value_1 = ggui_get_value_in_range(_value_1, _range);
    _value_2 = ggui_get_value_in_range(_value_2, _range);
        
    _result = _value_2 -_value_1;
    if(_result > _range/2) {
        _result = _result - _range;
    }
    if(_result < -_range/2) {
        _result = _result + _range;
    }
    
    return _result;
}

function ggui_check_in_range(_value, _range_1, _range_2) {
    var _min = min(_range_1, _range_2);
    var _max = max(_range_1, _range_2);
    
    var _result = false;
    
    if(_min <= _value and _value <= _max) {
        _result = true;
    }
    
    return _result;
}

function ggui_check_point_in_area(_px, _py, _area_center_x, _area_center_y, _area_points) {
    var _area_length = array_length(_area_points);
    
    var _area_size = 0;
    var _point_size = 0;
    
    var _edge_length = 0;
    var _p1_length = 0; var _p2_length = 0;
    var _s1 = 0; var _s2 = 0;
    
    var _i1 = 0; var _i2 = 0;
    for(var _i = 0; _i < _area_length; _i += 1) {
        _i1 = _i; _i2 = _i + 1;
        if(_i2 == _area_length) {
            _i2 = 0;
        }
        
        _edge_length = point_distance(_area_points[_i1][0], _area_points[_i1][1], _area_points[_i2][0], _area_points[_i2][1]);
        _p1_length = point_distance(_area_center_x, _area_center_y, _area_points[_i1][0], _area_points[_i1][1]);
        _p2_length = point_distance(_area_center_x, _area_center_y, _area_points[_i2][0], _area_points[_i2][1]);
        _s1 = (_edge_length + _p1_length + _p2_length) * 0.5;
        _area_size += sqrt(max(_s1 * (_s1 - _edge_length) * (_s1 - _p1_length) * (_s1 - _p2_length), 1));
        
        _p1_length = point_distance(_px, _py, _area_points[_i1][0], _area_points[_i1][1]);
        _p2_length = point_distance(_px, _py, _area_points[_i2][0], _area_points[_i2][1]);
        _s2 = (_edge_length + _p1_length + _p2_length) * 0.5;
        _point_size += sqrt(max(_s2 * (_s2 - _edge_length) * (_s2 - _p1_length) * (_s2 - _p2_length), 1));
    }
    
    return abs(_area_size - _point_size) < 1;
}

function ggui_get_rectangle_points(_x, _y, _w, _h, _rotation) {
    var _l = point_distance(0, 0, _w, _h);
    
    var _d1 = point_direction(0, 0, -_w, -_h);
    var _r1 = _d1 + _rotation;
    var _x1 = _x + lengthdir_x(_l, _r1);
    var _y1 = _y +lengthdir_y(_l, _r1);
    
    var _d2 = point_direction(0, 0, _w, -_h);
    var _r2 = _d2 + _rotation;
    var _x2 = _x + lengthdir_x(_l, _r2);
    var _y2 = _y +lengthdir_y(_l, _r2);
    
    var _d3 = point_direction(0, 0, _w, _h);
    var _r3 = _d3 + _rotation;
    var _x3 = _x + lengthdir_x(_l, _r3);
    var _y3 = _y +lengthdir_y(_l, _r3);
    
    var _d4 = point_direction(0, 0, -_w, _h);
    var _r4 = _d4 + _rotation;
    var _x4 = _x + lengthdir_x(_l, _r4);
    var _y4 = _y + lengthdir_y(_l, _r4);
    
    return [[_x1, _y1], [_x2, _y2], [_x3, _y3], [_x4, _y4]];
}

function ggui_draw_rectangle(_points, _color_tl, _color_tr, _color_br, _color_bl, _alpha_tl, _alpha_tr, _alpha_br, _alpha_bl, _outline) {
    if(_outline) {
        draw_primitive_begin(pr_linestrip);
            draw_vertex_color(_points[0][0], _points[0][1], _color_tl, _alpha_tl);
            draw_vertex_color(_points[1][0], _points[1][1], _color_tr, _alpha_tr);
            draw_vertex_color(_points[2][0], _points[2][1], _color_br, _alpha_br);
            draw_vertex_color(_points[3][0], _points[3][1], _color_bl, _alpha_bl);
            draw_vertex_color(_points[0][0], _points[0][1], _color_tl, _alpha_tl);
        draw_primitive_end();
    }
    else {
        draw_primitive_begin(pr_trianglestrip);
            draw_vertex_color(_points[0][0], _points[0][1], _color_tl, _alpha_tl);
            draw_vertex_color(_points[1][0], _points[1][1], _color_tr, _alpha_tr);
            draw_vertex_color(_points[3][0], _points[3][1], _color_bl, _alpha_bl);
            draw_vertex_color(_points[2][0], _points[2][1], _color_br, _alpha_br);
        draw_primitive_end();
    }
}

function ggui_draw_rectangle_outline(_points_1, _points_2, _color_tl, _color_tr, _color_br, _color_bl, _alpha_tl, _alpha_tr, _alpha_br, _alpha_bl) {
    draw_primitive_begin(pr_trianglestrip);
        draw_vertex_color(_points_1[0][0], _points_1[0][1], _color_tl, _alpha_tl);
            draw_vertex_color(_points_2[0][0], _points_2[0][1], _color_tl, _alpha_tl);
        draw_vertex_color(_points_1[1][0], _points_1[1][1], _color_tr, _alpha_tr);
            draw_vertex_color(_points_2[1][0], _points_2[1][1], _color_tr, _alpha_tr);
        draw_vertex_color(_points_1[2][0], _points_1[2][1], _color_br, _alpha_br);
            draw_vertex_color(_points_2[2][0], _points_2[2][1], _color_br, _alpha_br);
        draw_vertex_color(_points_1[3][0], _points_1[3][1], _color_bl, _alpha_bl);
            draw_vertex_color(_points_2[3][0], _points_2[3][1], _color_bl, _alpha_bl);
            
        draw_vertex_color(_points_1[0][0], _points_1[0][1], _color_tl, _alpha_tl);
            draw_vertex_color(_points_2[0][0], _points_2[0][1], _color_tl, _alpha_tl);
    draw_primitive_end();
    
    return _points_1;
}