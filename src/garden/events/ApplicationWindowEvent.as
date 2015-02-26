package garden.events
{
	
	import garden.widgets.Window;
	
	public class ApplicationWindowEvent extends Event
	{
		
		public static const WINDOW_OPENED:String="windowOpened";
		public static const WINDOW_CLOSED:String="windowClosed";
		
		private var _window:Window;
		
		public function ApplicationWindowEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false,window:Window=null)
		{
			super(type,bubbles,cancelable);
			
			_window=window;
		}
		
		public function get window():Window
		{
			return _window;
		}
		
		override public function clone():Event
		{
			return new ApplicationWindowEvent(type,bubbles,cancelable,_window);
		}
		
		override public function toString():String
		{
			return formatToString("ApplicationWindowEvent","type","bubbles","cancelable","window");
		}
		
	}
	
}