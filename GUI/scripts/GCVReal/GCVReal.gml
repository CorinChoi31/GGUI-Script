/**
    @description GGUI > GContainer > GCVReal : GCValue
        GGUI에서 사용하는 Real Value 를 포함하는 Container 입니다.
        Real 만 가질 수 있습니다.
    
    @constructor    
    @argument       {Real} _value
        Real Value
    @returns        {Struct.GCVReal}
*/
function GCVReal(_value) : GCValue(_value) constructor {
    
    /** @type {Real} */
    value = _value;
}

/**
    @description GGUI > GContainer > GCVRealMLinear : GCValueMotion
        실수 값의 선형 운동 제어용 Container 입니다.
    
    @constructor    
    @argument       {Real} _value
        시작 값
    @argument       {Real} _target
        종료 값
    @argument       {Real} [_speed]=(1)
        속력 (speed > 0)
    @argument       {Real} [_correction]=(0.01)
        오차 보정
    @returns        {Struct.GCVRealMLinear}
*/
function GCVRealMLinear(_value, _target, _speed=1, _correction=0.01) : GCValueMotion(_value, _target, _speed) constructor {
    
    /** @type {Real} */
    value = _value;
    
    /** @type {Real} */
    target = _target;
    /** @type {Real} */
    target_previous = _value;
    
    /** @type {Real} */
    speed = _speed;
    /** @type {Real} */
    correction = _correction;
    
    /**
        @description Value의 운동을 진행합니다.
            일반적으로 상위 Container에서 Step을 진행할 때 이 method를 호출합니다.
        
        @function       
        @argument       {Real} [_delta_tick]=(1)
            다음 틱까지의 실제 지나간 프레임 길이
        @returns        {Undefined}
        @static         
    */
    static Step = function(_delta_tick=1) {
        if(value != target) {
            if(correction > 0) {
                if(abs(target - value) < correction) {
                    value = target;
                    exit;
                }
            }
            
            var _speed = speed * global.__GGUI_FRAMESPEED;
            var _sign = sign(target - value);
            
            value += min(abs(target - value), _speed) * _sign;
        }
    }
}

/**
    @description GGUI > GContainer > GCVRealMSmooth : GCValueMotion
        실수 값의 비선형-부드러움 운동 제어용 Container 입니다.
    
    @constructor    
    @argument       {Real} _value
        시작 값
    @argument       {Real} _target
        종료 값
    @argument       {Real} [_speed]=(0.5)
        부드러움 정도 (1 >= speed > 0)
    @argument       {Real} [_correction]=(0.01)
        오차 보정
    @returns        {Struct.GCVRealMSmooth}
*/
function GCVRealMSmooth(_value, _target, _speed=0.5, _correction=0.01) : GCValueMotion(_value, _target, _speed) constructor {
    
    /** @type {Real} */
    value = _value;
    
    /** @type {Real} */
    target = _target;
    /** @type {Real} */
    target_previous = _value;
    
    /** @type {Real} */
    speed = _speed;
    /** @type {Real} */
    correction = _correction;
    
    /**
        @description Value의 운동을 진행합니다.
            일반적으로 상위 Container에서 Step을 진행할 때 이 method를 호출합니다.
        
        @function       
        @argument       {Real} [_delta_tick]=(1)
            다음 틱까지의 실제 지나간 프레임 길이
        @returns        {Undefined}
        @static         
    */
    static Step = function(_delta_tick=1) {
        if(value != target) {
            if(correction > 0) {
                if(abs(target - value) < correction) {
                    value = target;
                    exit;
                }
            }
            var _speed = speed * global.__GGUI_FRAMESPEED;
            
            value = lerp(value, target, power(_speed, _delta_tick));
        }
    }
}

/**
    @description GGUI > GContainer > GCVRealMSmooth : GCValueMotion
        실수 값의 비선형-탄성 운동 제어용 Container 입니다.
    
    @constructor    
    @argument       {Real} _value
        시작 값
    @argument       {Real} _target
        종료 값
    @argument       {Real} [_speed]=(0.5)
        부드러움 정도 (1 >= speed > 0)
    @argument       {Real} [_spring]=(0.2)
        탄성 강도 (1 >= spring > 0)
    @argument       {Real} [_correction]=(0.001)
        오차 보정
    @returns        {Struct.GCVRealMSpring}
*/
function GCVRealMSpring(_value, _target, _speed=0.5, _spring=0.2, _correction=0.001) : GCValueMotion(_value, _target, _speed) constructor {
    
    /** @type {Real} */
    value = _value;
    
    /** @type {Real} */
    target = _target;
    /** @type {Real} */
    target_previous = _value;
    
    /** @type {Real} */
    speed = _speed;
    /** @type {Real} */
    spring = _spring;
    /** @type {Real} */
    correction = _correction;
    
    /** @type {Real} */
    delta = 0;
    
    /**
        @description Value의 운동을 진행합니다.
            일반적으로 상위 Container에서 Step을 진행할 때 이 method를 호출합니다.
        
        @function       
        @argument       {Real} [_delta_tick]=(1)
            다음 틱까지의 실제 지나간 프레임 길이
        @returns        {Undefined}
        @static         
    */
    static Step = function(_delta_tick=1) {
        if(value != target) {
            if(correction > 0) {
                if(abs(target - value) < correction) {
                    value = target;
                    delta = 0;
                    exit;
                }
            }
            
            var _speed = speed * global.__GGUI_FRAMESPEED;
            var _spring = spring * global.__GGUI_FRAMESPEED;
            
            delta = lerp(delta, (target - value) * power(_speed, _delta_tick), power(_spring, _delta_tick));
            value += delta;
        }
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
        
        difference = target - value;
    }
}

/**
    @description GGUI > GContainer > GCVRealMSmooth : GCValueMotion
        실수 값의 선형-부드러움 운동 제어용 Container 입니다.
    
    @constructor    
    @argument       {Real} _value
        시작 값
    @argument       {Real} _target
        종료 값
    @argument       {Real} [_speed]=(1)
        최고 속력 (speed > 0)
    @argument       {Real} [_smooth]=(0.5)
        부드러움 정도 (1 >= smooth > 0)
    @argument       {Real} [_correction]=(0.01)
        오차 보정
    @returns        {Struct.GCVRealMSmooth}
*/
function GCVRealMLinearSmooth(_value, _target, _speed=1, _smooth=0.5, _correction=0.01) : GCValueMotion(_value, _target, _speed) constructor {
    
    /** @type {Real} */
    value = _value;
    
    /** @type {Real} */
    target = _target;
    /** @type {Real} */
    target_previous = _value;
    
    /** @type {Real} */
    speed = _speed;
    /** @type {Real} */
    smooth = _smooth;
    /** @type {Real} */
    correction = _correction;
    
    /**
        @description Value의 운동을 진행합니다.
            일반적으로 상위 Container에서 Step을 진행할 때 이 method를 호출합니다.
        
        @function       
        @argument       {Real} [_delta_tick]=(1)
            다음 틱까지의 실제 지나간 프레임 길이
        @returns        {Undefined}
        @static         
    */
    static Step = function(_delta_tick=1) {
        if(value != target) {
            if(correction > 0) {
                if(abs(target - value) < correction) {
                    value = target;
                    exit;
                }
            }
            
            var _speed = speed * global.__GGUI_FRAMESPEED;
            var _smooth = smooth * global.__GGUI_FRAMESPEED;
            
            var _delta_value = (target - value) * power(_smooth, _delta_tick);
            var _sign = sign(_delta_value);
            
            value += min(_speed, abs(_delta_value)) * _sign;
        }
    }
}

/**
    @description GGUI > GContainer > GCVRealMSmooth : GCValueMotion
        실수 값의 종합 운동 제어용 Container 입니다.
    
    @constructor    
    @argument       {Real} _value
        시작 값
    @argument       {Real} _target
        종료 값
    @argument       {Real} [_type]=(ggTYPE.MOTION_LINEAR)
        운동 유형
    @argument       {Real} [_speed]=(1)
        속력 (speed > 0)
    @argument       {Real} [_smooth]=(0.5)
        부드러움 정도 (1 >= smooth > 0)
    @argument       {Real} [_spring]=(0.2)
        탄성 강도 (1 >= spring > 0)
    @argument       {Real} [_correction]=(0.01)
        오차 보정
    @returns        {Struct.GCVRealMSmooth}
*/
function GCVRealMotions(_value, _target, _type=ggTYPE.MOTION_LINEAR, _speed=1, _smooth=0.5, _spring=0.2, _correction=0.01) : GCValueMotion(_value, _target, _speed) constructor {
    
    /** @type {Real} */
    value = _value;
    
    /** @type {Enum.ggTYPE} */
    type = _type;
    /** @type {Enum.ggTYPE} */
    type_previous = _type;
    
    /** @type {Real} */
    target = _target;
    /** @type {Real} */
    target_previous = _value;
    
    /** @type {Real} */
    speed = _speed;
    /** @type {Real} */
    smooth = _smooth;
    /** @type {Real} */
    spring = _spring;
    /** @type {Real} */
    correction = _correction;
    
    /** @type {Real} */
    delta = 0;
    
    /**
        @description Value의 운동을 진행합니다.
            일반적으로 상위 Container에서 Step을 진행할 때 이 method를 호출합니다.
        
        @function       
        @argument       {Real} [_delta_tick]=(1)
            다음 틱까지의 실제 지나간 프레임 길이
        @returns        {Undefined}
        @static         
    */
    static Step = function(_delta_tick=1) {
        if(value != target) {
            if(correction > 0) {
                if(abs(target - value) < correction) {
                    value = target;
                    delta = 0;
                    exit;
                }
            }
            
            var _sign = 0;
            
            var _speed = speed * global.__GGUI_FRAMESPEED;
            var _smooth = smooth * global.__GGUI_FRAMESPEED;
            var _spring = spring * global.__GGUI_FRAMESPEED;
            
            switch(type) {
                default:
                case ggTYPE.MOTION_LINEAR:
                    _sign = sign(target - value);
                    
                    value += min(abs(target - value), _speed) * _sign;
                    break;
                case ggTYPE.MOTION_SMOOTH:
                    value = lerp(value, target, power(_smooth, _delta_tick));
                    break;
                case ggTYPE.MOTION_SPRING:
                    delta = lerp(delta, (target - value) * power(_smooth, _delta_tick), power(_spring, _delta_tick));
                    value += delta;
                    break;
                case ggTYPE.MOTION_LINEAR_SMOOTH:
                    var _delta_value = (target - value) * power(_smooth, _delta_tick);
                    _sign = sign(_delta_value);
                    
                    value += min(_speed, abs(_delta_value)) * _sign;
                    break;
            }
        }
    }
    
    /**
        @description 운동의 움직임 유형을 변경합니다.
        
        @function       
        @argument       {Real} _type
            운동 유형
        @returns        {Undefined}
        @static         
    */
    
    static SetType = function(_type) {
        type_previous = type;
        type = _type;
    }
    
    /**
        @description 운동의 Target값을 변경합니다.
        
        @function       
        @argument       {Real} _value
            Target 값
        @argument       {Real} [_type]=(ggTYPE.MOTION_EXCLUDE)
            운동 유형
        @returns        {Undefined}
        @static         
    */
    static SetTarget = function(_value, _type=ggTYPE.MOTION_EXCLUDE) {
        if(_type != ggTYPE.MOTION_EXCLUDE and _type != ggTYPE.MOTION_INCLUDE) {
            SetType(_type);
        }
        target_previous = target;
        target = _value;
    }
    
    /**
        @description 운동의 Target값을 이전에 설정한 값과 치환합니다.
        
        @function       
        @argument       {Real} [_type]=(ggTYPE.MOTION_EXCLUDE)
            운동 유형
        @returns        {Undefined}
        @static         
    */
    static Switch = function(_type=ggTYPE.MOTION_INCLUDE) {
        if(_type == ggTYPE.MOTION_INCLUDE) {
            SetType(type_previous);
        }
        else {
            if(_type != ggTYPE.MOTION_EXCLUDE) {
                SetType(_type);
            }
        }
        SetTarget(target_previous);
    }
}