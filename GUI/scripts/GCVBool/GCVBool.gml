/**
    @description GGUI > GContainer > GCVBool : GCValue
        GGUI에서 사용하는 Bool Value 를 포함하는 Container 입니다.
        Bool 만 가질 수 있습니다.
    
    @constructor    
    @argument       {Bool} _value
        Bool Value
    @returns        {Struct.GCVBool}
*/
function GCVBool(_value) : GCValue(_value) constructor {
    
    /** @type {Bool} */
    value = _value;
}