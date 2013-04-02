/*
	Copyright (c) 2013 Susisu
	see also: LICENSE
*/
package garden.utils
{

	import flash.utils.Dictionary;
	
	public class WeakReference extends Object
	{
		
		private var _dictionary:Dictionary;
		
		public function WeakReference(value:Object)
		{
			_dictionary=new Dictionary(true);
			_dictionary[value]=null;
		}
		
		public function getValue():Object
		{
			for(var obj:Object in _dictionary)
			{
				return obj;
			}
			return null;
		}
		
	}
	
}