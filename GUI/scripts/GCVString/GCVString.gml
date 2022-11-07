/**
    @description GGUI > GContainer > GCVString : GCValue
        GGUI에서 사용하는 String Value 를 포함하는 Container 입니다.
        String 만 가질 수 있습니다.
    
    @constructor    
    @argument       {String} _value
        String Value
    @returns        {Struct.GCVString}
*/
function GCVString(_value) : GCValue(_value) constructor {
    
    /** @type {String} */
    value = _value;
    
    /**
        @description Value 반환합니다.
        
        @override
        @function       
        @returns        {String}
            이 함수는 Value를 반환합니다.
    */
    static toString = function() {
        return value;
    }
}