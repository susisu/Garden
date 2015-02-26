package garden.utils
{
	
	import garden.events.Event;
	import garden.events.EventDispatcher;
	
	public class BindableVar extends EventDispatcher implements IBindable
	{
		
		private var _value:Object;
		
		public function BindableVar(value:Object=null)
		{
			super();
			
			_value=value;
		}
		
		public function get value():Object
		{
			return _value;
		}
		
		public function set value(value:Object):void
		{
			_value=value;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function notifyChange():void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}
	
}