/**
    @description GGUI > System 
        GGUI의 전체를 관리하는 구조체입니다.
        GSystem은 GGUI를 사용하기 전에 필수적으로 존재해야 합니다.
        단일성(Singleton)을 보장합니다.
        생성되면 global.__GGUI_SYSTEM에 보관됩니다.
    
    @constructor    
    @returns        {Struct.GSystem}
*/
function GSystem() constructor {
    
    /** @type {Array.<Struct.GContainer>} */
    contains = [];
    
    Initialize();
    
    static Initialize = function() {
        if(global.__GGUI_SYSTEM == undefined) {
            global.__GGUI_SYSTEM = self;
        }
        else {
            delete global.__GGUI_SYSTEM;
            global.__GGUI_SYSTEM = self;
        }
    }
    
    static Create = function() {
        
    }
    
    static Step = function() {
        var _frame_speed_standard = 1/60 * 1000;
        var _frame_speed_current = game_get_speed(gamespeed_microseconds)/1000;
        var _frame_speed_ratio = _frame_speed_current/_frame_speed_standard;
        
        global.__GGUI_FRAMESPEED = _frame_speed_ratio;
        
        //show_debug_message("ggui_frame_fratio: " + string(_frame_speed_ratio));
    }
    
    static Draw = function() {
        
    }
    
    static toString = function() {
        return "";
    }
    
    static AddContainer = function(_container) {
        array_push(contains, _container);
    }
    
    static RemoveContainer = function(_container) {
        
    }
}
