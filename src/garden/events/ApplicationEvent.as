package garden.events
{
	
	public class ApplicationEvent extends Event
	{
		
		public static const KILLED:String="killed";
		
		public function ApplicationEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false)
		{
			super(type,bubbles,cancelable);
		}
		
		override public function clone():Event
		{
			return new ApplicationEvent(type,bubbles,cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("ApplicationEvent","type","bubbles","cancelable");
		}
		
	}
	
}