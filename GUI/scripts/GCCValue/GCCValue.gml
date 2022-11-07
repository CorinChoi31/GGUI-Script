/**
    @description GGUI > GContainer > GCCValue : GCContent
        GGUI에서 사용하는 Struct.GCValue Content를 포함하는 Container 입니다.
        Struct.GCValue 만 가질 수 있습니다.
    
    @constructor    
    @param          {Struct.GCValue} _value
        Struct.GCValue Content
    @returns        {Struct.GCCValue}
*/
function GCCValue(_value) : GCContent() constructor {
    
    /** @type {Struct.GCValue} */
    content = _value;
    
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
        draw_text_transformed_color(_x, _y, content.toString(), _scale_x, _scale_y, _rotate, _color, _color, _color, _color, _alpha);
    }
    
    /**
        @description Content를 문자열로 변환합니다.
        
        @override
        @function       
        @returns        {String}
            이 함수는 Content를 String으로 변환한 값을 반환합니다.
    */
    static toString = function() {
        return content.toString();
    }
}

/**
    @description GGUI > GContainer > GCCValueMotion : GCContent
        GGUI에서 사용하는 Struct.GCValueMotion Content를 포함하는 Container 입니다.
        Struct.GCValueMotion 만 가질 수 있습니다.
    
    @constructor    
    @param          {Struct.GCValueMotion} _value
        Struct.GCValueMotion Content
    @returns        {Struct.GCCValueMotion}
*/
function GCCValueMotion(_value) : GCContent() constructor {
    
    /** @type {Struct.GCValueMotion} */
    content = _value;
    
    /**
        @description Content의 단계를 실행합니다.
            일반적으로 상위 Container에서 Step을 진행할 때 이 method를 호출합니다.
        
        @function       
        @argument       {Real} [_delta_tick]=(1)
            다음 틱까지의 실제 지나간 프레임 길이
        @returns        {Undefined}
        @static         
    */
    static Step = function(_delta_tick=1) {
        content.Step();
    }
    
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
        draw_text_transformed_color(_x, _y, content.toString(), _scale_x, _scale_y, _rotate, _color, _color, _color, _color, _alpha);
    }
    
    /**
        @description Content를 문자열로 변환합니다.
        
        @override
        @function       
        @returns        {String}
            이 함수는 Content를 String으로 변환한 값을 반환합니다.
    */
    static toString = function() {
        return content.toString();
    }
}