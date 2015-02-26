package garden.widgets.contents
{
	
	import flash.display.BitmapData;
	
	import garden.events.PropertyChangeEvent;
	
	public class ImageBox extends Content
	{
		
		private var _align:String;
		private var _background:Boolean;
		private var _backgroundColor:uint;
		private var _image:BitmapData;
		private var _scaleMode:String;
		
		public function ImageBox()
		{
			super();
			
			_align="";
			_background=true;
			_backgroundColor=0x000000;
			_image=null;
			_scaleMode=ImageBoxScaleMode.SHOW_ALL;
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
		
		public function get image():BitmapData
		{
			return _image;
		}
		public function set image(value:BitmapData):void
		{
			var oldValue:Object=_image;
			_image=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"image",oldValue,value));
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
			return ImageBox;
		}
		
	}
	
}