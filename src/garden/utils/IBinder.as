/*
	Copyright(C) 2013 Susisu
	see also: LICENSE
*/
package garden.utils
{
	
	public interface IBinder
	{
		
		function bind(propertyName:String, source:IBindable):void;
		function unbind(propertyName:String):void;
		function refresh():void;
		
	}
	
}