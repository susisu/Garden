package garden
{
	
	import garden.events.Event;
	import garden.events.EventDispatcher;
	
	public class Screen extends EventDispatcher
	{
		
		private var _height:Number;
		private var _width:Number;
		
		public function Screen()
		{
			_height=0;
			_width=0;
		}
		
		public function get height():Number
		{
			return _height;
		}
		public function set height(value:Number):void
		{
			_height=value;
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		public function get width():Number
		{
			return _width;
		}
		public function set width(value:Number):void
		{
			_width=value;
			dispatchEvent(new Event(Event.RESIZE));
		}
		
	}
	
}