package garden.utils
{
	
	public interface IBinder
	{
		
		function bind(propertyName:String,bindable:IBindable):void;
		function unbind(propertyName:String):void;
		function refresh():void;
		
	}
	
}