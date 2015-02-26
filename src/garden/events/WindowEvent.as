package garden.events
{
	
	public class WindowEvent extends Event
	{
		
		public static const ACTIVATE:String="activate";
		public static const DEACTIVATE:String="deactivate";
		public static const CLOSED:String="closed";
		
		public function WindowEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false)
		{
			super(type,bubbles,cancelable);
		}
		
		override public function clone():Event
		{
			return new WindowEvent(type,bubbles,cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("WindowEvent","type","bubbles","cancelable");
		}
		
	}
	
}