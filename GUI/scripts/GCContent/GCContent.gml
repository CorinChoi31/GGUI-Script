/**
    @description GGUI > GContainer > GCContent
        GGUI에서 사용하는 Content를 포함하는 Container 입니다.
        어떤 유형이든 가질 수 있지만 method가 구현되어 있지 않습니다.
    
    @constructor    
    @returns        {Struct.GCContent}
*/
function GCContent() constructor {
    
    /** @type {Any} */
    content = undefined;
    
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
        
    }
    
    /**
        @description Content를 정리합니다.
            일반적으로 상위 Container에서 Clean 할 때 이 method를 호출합니다.
        
        @function       
        @returns        {Undefined}
        @static         
    */
    static Clean = function() {
        
    }
    
    /**
        @description Content를 문자열로 변환합니다.
        
        @override
        @function       
        @returns        {String}
            이 함수는 Content를 String으로 변환한 값을 반환합니다.
    */
    static toString = function() {
        return string(content);
    }
}
