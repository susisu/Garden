package garden.utils
{
	
	import garden.events.IEventDispatcher;
	
	public interface IBindable extends IEventDispatcher
	{
		
		function get value():Object;
		function notifyChange():void;
		
	}
	
}