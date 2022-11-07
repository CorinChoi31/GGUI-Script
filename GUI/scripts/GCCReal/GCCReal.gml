/**
    @description GGUI > GContainer > GCCReal : GCContent
        GGUI에서 사용하는 Real Content를 포함하는 Container 입니다.
        Real 만 가질 수 있습니다.
    
    @constructor    
    @argument       {Real} _real
        Real Content
    @returns        {Struct.GCCReal}
*/
function GCCReal(_real) : GCContent() constructor {
    
    /** @type {Real} */
    content = _real;
    
    /**
        @description Content를 그립니다.
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
        draw_text_transformed_color(_x, _y, string(content), _scale_x, _scale_y, _rotate, _color, _color, _color, _color, _alpha);
    }
    
}