/*
	Copyright(C) 2013 Susisu
	see also: LICENSE
*/
package garden.utils
{
	
	import garden.events.Event;
	import garden.events.EventDispatcher;
	
	public class BindableFunc extends EventDispatcher implements IBindable
	{
		
		private var _func:Function;
		
		public function BindableFunc(func:Function)
		{
			super();
			
			_func = func;
		}
		
		public function get value():Object
		{
			return _func.call(null);
		}
		
		public function notifyChange():void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}
	
}