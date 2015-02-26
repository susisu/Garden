package garden.events
{
	
	public class SystemEvent extends Event
	{
		
		public static const ACTIVE_WINDOW_CHANGE:String="activeWindowChange";
		public static const SHUT_DOWN:String="shutDown";
		public static const WINDOW_MAXIMIZING_RECT_CHANGE:String="windowMaximizingRectChange";
		
		public function SystemEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false)
		{
			super(type,bubbles,cancelable);
		}
		
		override public function clone():Event
		{
			return new SystemEvent(type,bubbles,cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("SystemEvent","type","bubbles","cancelable");
		}
		
	}
	
}