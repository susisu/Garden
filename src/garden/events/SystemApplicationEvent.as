package garden.events
{
	
	import garden.system.Application;
	
	public class SystemApplicationEvent extends Event
	{
		
		public static const APPLICATION_STARTED:String="applicationStarted";
		public static const APPLICATION_KILLED:String="applicationKilled";
		
		private var _application:Application;
		
		public function SystemApplicationEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false,application:Application=null)
		{
			super(type,bubbles,cancelable);
			
			_application=application;
		}
		
		public function get application():Application
		{
			return _application;
		}
		
		override public function clone():Event
		{
			return new SystemApplicationEvent(type,bubbles,cancelable,_application);
		}
		
		override public function toString():String
		{
			return formatToString("SystemApplicationEvent","type","bubbles","cancelable","application");
		}
		
	}
	
}