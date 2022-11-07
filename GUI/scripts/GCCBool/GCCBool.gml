/**
    @description GGUI > GContainer > GCCBool : GCContent
        GGUI에서 사용하는 Bool Content를 포함하는 Container 입니다.
        Bool 만 가질 수 있습니다.
    
    @constructor    
    @argument       {Bool} _bool
        Bool Content
    @argument       {String} [_string_true]=("true")
        Content가 true일 때의 Draw 및 toString 할 String
    @argument       {String} [_string_false]=("false")
        Content가 false일 때의 Draw 및 toString 할 String
    @returns        {Struct.GCCBool}
*/
function GCCBool(_bool, _string_true="true", _string_false="false") : GCContent() constructor {
    
    /** @type {Bool} */
    content = _bool;
    /** @type {String} */
    string_true = _string_true;
    /** @type {String} */
	string_false = _string_false;
    
    /**
        @description Content를 미리 지정한 String을 이용하여 그립니다.
            일반적으로 상위 Container에서 Draw 할 때 이 method를 호출합니다.
        
        @function       
        @argument       {Real} _x
            Content를 그릴 때의 x 좌표
        @argument       {Real} _y
            Content를 그릴 때의 y 좌표
        @argument       {Real} _scale_x
            Content를 그릴 때의 x 배율
        @argument       {Real} _scale_y
            Content를 그릴 때의 y 배율
        @argument       {Real} _rotate
            Content를 그릴 때의 각도
        @argument       {Constant.Color} _color
            Content를 그릴 때의 색깔
        @argument       {Real} _alpha
            Content를 그릴 때의 투명도
        @returns        {Undefined}
        @static         
    */
    static Draw = function(_x, _y, _scale_x, _scale_y, _rotate, _color, _alpha) {
        draw_text_transformed_color(_x, _y, (content == true) ? string_true : string_false, _scale_x, _scale_y, _rotate, _color, _color, _color, _color, _alpha);
    }
    
    /**
        @description Content를 미리 지정한 String을 이용하여 문자열로 변환합니다.
        
        @override
        @function       
        @returns        {String}
            이 함수는 Content를 String으로 변환한 값을 반환합니다.
    */
    static toString = function() {
        return (content == true) ? string_true : string_false;
    }
}
