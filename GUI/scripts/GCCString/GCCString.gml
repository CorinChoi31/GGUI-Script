/**
    @description GGUI > GContainer > GCCString : GCContent
        GGUI에서 사용하는 String Content를 포함하는 Container 입니다.
        String 만 가질 수 있습니다.
    
    @constructor    
    @argument       {String} _string
        String Content
    @returns        {Struct.GCCString}
*/
function GCCString(_string) : GCContent() constructor {
    
    /** @type {String} */
    content = _string;
    
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
        draw_text_transformed_color(_x, _y, content, _scale_x, _scale_y, _rotate, _color, _color, _color, _color, _alpha);
    }
    
    /**
        @description Content를 문자열로 변환합니다.
        
        @override
        @function       
        @returns        {String}
            이 함수는 Content를 String으로 변환한 값을 반환합니다.
    */
    static toString = function() {
        return content;
    }
}

function GCCStringContext(_string, _width, _seq=-1) : GCContent() constructor {
    
    /** @type {String} */
    content = _string;
    width = _width
    seq = _seq;
    
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
        draw_text_ext_transformed_color(_x, _y, content, seq, width, _scale_x, _scale_y, _rotate, _color, _color, _color, _color, _alpha);
    }
    
    /**
        @description Content를 문자열로 변환합니다.
        
        @override
        @function       
        @returns        {String}
            이 함수는 Content를 String으로 변환한 값을 반환합니다.
    */
    static toString = function() {
        return content;
    }
}

//function GStrings(_string, _width) constructor
//{
//	/// funct GStrings(string)
//	/// descr 
//	/// param {string} string
	
//	content = string(_string);
//	width = real(_width);
	
//	/**
//	* Represents a book.
//	* @function
//	* @param {real} x - The title of the book.
//	* @param {real} y - The author of the book.
//	*/
 
//	static draw = function(_x, _y, _scale_x, _scale_y, _rot, _color, _alpha)
//	{
//		/// @funct draw(x, y, scale_x, scale_y, rot, color, alpha)
//		/// @descr 
//		/// @param x: Real
//		/// @param
		
//		var _content = string(content);
//		var _width = real(width);
		
//		var _size = max(string_width(content) * _scale_x, 1);
//		var _scale = min(width/_size, 1);

//		if(_scale < 0.5)
//		{
//			_scale_x *= 0.5;
//			_scale_y *= 0.5;
//			draw_text_ext_transformed_color(_x, _y, content, -1, width, _scale_x, _scale_y, _rot, _color, _color, _color, _color, _alpha);
//		}
//		else
//		{
//			_scale_x *= _scale;
//			_scale_y *= _scale;
//			draw_text_transformed_color(_x, _y, content, _scale_x, _scale_y, _rot, _color, _color, _color, _color, _alpha);
//		}
		
//	}
	
//	static clean = function()
//	{
		
//	}
	
//	static toString = function()
//	{
//		return content;	
//	}
//}