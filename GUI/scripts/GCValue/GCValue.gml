/**
    @description GGUI > GContainer > GCValue
        GGUI에서 사용하는 Value를 포함하는 Container 입니다.
        어떤 유형이든 가질 수 있지만 method가 구현되어 있지 않습니다.
    
    @constructor    
    @argument       {Any} _value
        포함할 값
    @returns        {Struct.GCValue}
*/
function GCValue(_value) constructor {
    
    /** @type {Any} */
    origin = _value;
    /** @type {Any} */
    value = _value;
    
    /**
        @description Value를 문자열로 변환합니다.
        
        @override
        @function       
        @returns        {String}
            이 함수는 Value를 String으로 변환한 값을 반환합니다.
    */
    static toString = function() {
        return string(value);   
    }
}

/**
    @description GGUI > GContainer > GCValueMotion : GCValue
        GGUI에서 사용하는 Value를 포함하는 Container 입니다.
        어떤 유형이든 가질 수 있지만 method가 구현되어 있지 않습니다.
    
    @constructor    
    @argument       {Any} _value
        시작 값
    @argument       {Any} _target
        종료 값
    @argument       {Real} _speed
        속도
    @returns        {Struct.GCValueMotion}
*/
function GCValueMotion(_value, _target, _speed) : GCValue(_value) constructor {
    
    /** @type {Any} */
    origin = _value;
    /** @type {Any} */
    value = _value;
    
    /** @type {Any} */
    target = _target;
    /** @type {Any} */
    target_previous = _value;
    
    /** @type {Real} */
    speed = _speed;
    
    /**
        @description Value의 모션을 진행합니다.
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
        @description 운동의 Target값을 변경합니다.
        
        @function       
        @argument       {Any} _value
            Target 값
        @returns        {Undefined}
        @static         
    */
    static SetTarget = function(_value) {
        target_previous = target;
        target = _value;
    }
    
    /**
        @description 운동의 Target값을 이전에 설정한 값과 치환합니다.
        
        @function       
        @returns        {Undefined}
        @static         
    */
    static Switch = function() {
        SetTarget(target_previous);
    }
    
    /**
        @description 운동의 Value값을 Target값으로 즉시 적용합니다.
        
        @function       
        @returns        {Undefined}
        @static         
    */
    static Apply = function() {
        value = target;
    }
}