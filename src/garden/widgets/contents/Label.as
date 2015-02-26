package garden.widgets.contents
{
	
	import garden.events.PropertyChangeEvent;
	
	public class Label extends Content
	{
		
		private var _align:String;
		private var _background:Boolean;
		private var _backgroundColor:uint;
		private var _blockIndent:Number;
		private var _bold:Boolean;
		private var _border:Boolean;
		private var _borderColor:uint;
		private var _color:uint;
		private var _font:String;
		private var _indent:Number;
		private var _italic:Boolean;
		private var _kerning:Boolean;
		private var _leading:Number;
		private var _leftMargin:Number;
		private var _letterSpacing:Number;
		private var _mouseWheelEnabled:Boolean;
		private var _multiline:Boolean;
		private var _rightMargin:Number;
		private var _scrollH:Number;
		private var _scrollV:Number;
		private var _selectable:Boolean;
		private var _selectionBeginIndex:int;
		private var _selectionEndIndex:int;
		private var _size:Number;
		private var _text:String;
		private var _underline:Boolean;
		private var _wordWrap:Boolean;
		
		public function Label()
		{
			super();
			
			_align=TextAlign.LEFT;
			_background=false;
			_backgroundColor=0xffffff;
			_blockIndent=0;
			_bold=false;
			_border=false;
			_borderColor=0x000000;
			_color=0x000000;
			_font="";
			_indent=0;
			_italic=false;
			_kerning=false;
			_leading=0;
			_leftMargin=0;
			_letterSpacing=0;
			_mouseWheelEnabled=false;
			_multiline=false;
			_rightMargin=0;
			_scrollH=0;
			_scrollV=0;
			_selectable=false;
			_selectionBeginIndex=0;
			_selectionEndIndex=0;
			_size=12;
			_text="";
			_underline=false;
			_wordWrap=false;
		}
		
		public function get align():String
		{
			return _align;
		}
		public function set align(value:String):void
		{
			var oldValue:Object=_align;
			_align=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"align",oldValue,value));
		}
		
		public function get background():Boolean
		{
			return _background;
		}
		public function set background(value:Boolean):void
		{
			var oldValue:Object=_background;
			_background=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"background",oldValue,value));
		}
		
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		public function set backgroundColor(value:uint):void
		{
			var oldValue:Object=_backgroundColor;
			_backgroundColor=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"backgroundColor",oldValue,value));
		}
		
		public function get blockIndent():Number
		{
			return _blockIndent;
		}
		public function set blockIndent(value:Number):void
		{
			var oldValue:Object=_blockIndent;
			_blockIndent=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"blockIndent",oldValue,value));
		}
		
		public function get bold():Boolean
		{
			return _bold;
		}
		public function set bold(value:Boolean):void
		{
			var oldValue:Object=_bold;
			_bold=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"bold",oldValue,value));
		}
		
		public function get border():Boolean
		{
			return _border;
		}
		public function set border(value:Boolean):void
		{
			var oldValue:Object=_border;
			_border=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"border",oldValue,value));
		}
		
		public function get borderColor():uint
		{
			return _borderColor;
		}
		public function set borderColor(value:uint):void
		{
			var oldValue:Object=_borderColor;
			_borderColor=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"borderColor",oldValue,value));
		}
		
		public function get color():uint
		{
			return _color;
		}
		public function set color(value:uint):void
		{
			var oldValue:Object=_color;
			_color=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"color",oldValue,value));
		}
		
		public function get font():String
		{
			return _font;
		}
		public function set font(value:String):void
		{
			var oldValue:Object=_font;
			_font=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"font",oldValue,value));
		}
		
		public function get indent():Number
		{
			return _indent;
		}
		public function set indent(value:Number):void
		{
			var oldValue:Object=_indent;
			_indent=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"indent",oldValue,value));
		}
		
		public function get italic():Boolean
		{
			return _italic;
		}
		public function set italic(value:Boolean):void
		{
			var oldValue:Object=_italic;
			_italic=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"italic",oldValue,value));
		}
		
		public function get kerning():Boolean
		{
			return _kerning;
		}
		public function set kerning(value:Boolean):void
		{
			var oldValue:Object=_kerning;
			_kerning=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"kerning",oldValue,value));
		}
		
		public function get leading():Number
		{
			return _leading;
		}
		public function set leading(value:Number):void
		{
			var oldValue:Object=_leading;
			_leading=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"leading",oldValue,value));
		}
		
		public function get leftMargin():Number
		{
			return _leftMargin;
		}
		public function set leftMargin(value:Number):void
		{
			var oldValue:Object=_leftMargin;
			_leftMargin=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"leftMargin",oldValue,value));
		}
		
		public function get letterSpacing():Number
		{
			return _letterSpacing;
		}
		public function set letterSpacing(value:Number):void
		{
			var oldValue:Object=_letterSpacing;
			_letterSpacing=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"letterSpacing",oldValue,value));
		}
		
		public function get mouseWheelEnabled():Boolean
		{
			return _mouseWheelEnabled;
		}
		public function set mouseWheelEnabled(value:Boolean):void
		{
			var oldValue:Object=_mouseWheelEnabled;
			_mouseWheelEnabled=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"mouseWheelEnabled",oldValue,value));
		}
		
		public function get multiline():Boolean
		{
			return _multiline;
		}
		public function set multiline(value:Boolean):void
		{
			var oldValue:Object=_multiline;
			_multiline=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"multiline",oldValue,value));
		}
		
		public function get rightMargin():Number
		{
			return _rightMargin;
		}
		public function set rightMargin(value:Number):void
		{
			var oldValue:Object=_rightMargin;
			_rightMargin=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"rightMargin",oldValue,value));
		}
		
		public function get scrollH():Number
		{
			return _scrollH;
		}
		public function set scrollH(value:Number):void
		{
			var oldValue:Object=_scrollH;
			_scrollH=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"scrollH",oldValue,value));
		}
		
		public function get scrollV():Number
		{
			return _scrollV;
		}
		public function set scrollV(value:Number):void
		{
			var oldValue:Object=_scrollV;
			_scrollV=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"scrollV",oldValue,value));
		}
		
		public function get selectable():Boolean
		{
			return _selectable;
		}
		public function set selectable(value:Boolean):void
		{
			var oldValue:Object=_selectable;
			_selectable=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"selectable",oldValue,value));
		}
		
		public function get selectionBeginIndex():int
		{
			return _selectionBeginIndex;
		}
		public function set selectionBeginIndex(value:int):void
		{
			var oldValue:Object=_selectionBeginIndex;
			_selectionBeginIndex=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"selectionBeginIndex",oldValue,value));
		}
		
		public function get selectionEndIndex():int
		{
			return _selectionEndIndex;
		}
		public function set selectionEndIndex(value:int):void
		{
			var oldValue:Object=_selectionEndIndex;
			_selectionEndIndex=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"selectionEndIndex",oldValue,value));
		}
		
		public function get size():Number
		{
			return _size;
		}
		public function set size(value:Number):void
		{
			var oldValue:Object=_size;
			_size=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"size",oldValue,value));
		}
		
		public function get text():String
		{
			return _text;
		}
		public function set text(value:String):void
		{
			var oldValue:Object=_text;
			_text=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"text",oldValue,value));
		}
		
		public function get underline():Boolean
		{
			return _underline;
		}
		public function set underline(value:Boolean):void
		{
			var oldValue:Object=_underline;
			_underline=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"underline",oldValue,value));
		}
		
		public function get wordWrap():Boolean
		{
			return _wordWrap;
		}
		public function set wordWrap(value:Boolean):void
		{
			var oldValue:Object=_wordWrap;
			_wordWrap=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"wordWrap",oldValue,value));
		}
		
		override public function getClass():Class
		{
			return Label;
		}
		
	}
	
}