package garden.utils
{
	
	import garden.events.Event;
	import garden.events.EventDispatcher;
	
	public class BindableFunction extends EventDispatcher implements IBindable
	{
		
		private var _func:Function;
		
		public function BindableFunction(func:Function)
		{
			super();
			
			_func=func;
		}
		
		public function get value():Object
		{
			return _func();
		}
		
		public function notifyChange():void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}
	
}