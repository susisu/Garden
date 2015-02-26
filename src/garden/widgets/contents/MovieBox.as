package garden.widgets.contents
{
	
	import flash.display.DisplayObject;
	
	import garden.events.PropertyChangeEvent;
	
	public class MovieBox extends Content
	{
		
		private var _align:String;
		private var _background:Boolean;
		private var _backgroundColor:uint;
		private var _movie:DisplayObject;
		private var _movieHeight:Number;
		private var _movieWidth:Number;
		private var _scaleMode:String;
		
		public function MovieBox()
		{
			super();
			
			_align="";
			_background=true;
			_backgroundColor=0x000000;
			_movie=null;
			_movieHeight=0;
			_movieWidth=0;
			_scaleMode=MovieBoxScaleMode.SHOW_ALL;
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
		
		public function get movie():DisplayObject
		{
			return _movie;
		}
		public function set movie(value:DisplayObject):void
		{
			var oldValue:Object=_movie;
			_movie=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"movie",oldValue,value));
		}
		
		public function get movieHeight():Number
		{
			return _movieHeight;
		}
		public function set movieHeight(value:Number):void
		{
			var oldValue:Object=_movieHeight;
			_movieHeight=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"movieHeight",oldValue,value));
		}
		
		public function get movieWidth():Number
		{
			return _movieWidth;
		}
		public function set movieWidth(value:Number):void
		{
			var oldValue:Object=_movieWidth;
			_movieWidth=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"movieWidth",oldValue,value));
		}
		
		public function get scaleMode():String
		{
			return _scaleMode;
		}
		public function set scaleMode(value:String):void
		{
			var oldValue:Object=_scaleMode;
			_scaleMode=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"scaleMode",oldValue,value));
		}
		
		override public function getClass():Class
		{
			return MovieBox;
		}
		
	}
	
}