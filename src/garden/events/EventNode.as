/*
	Copyright (c) 2013 Susisu
	see also: LICENSE
*/
package garden.events
{
	
	public class EventNode extends EventDispatcher
	{
		
		public function EventNode()
		{
			super();
		}
		
		public function get parentEventNode():EventNode
		{
			return null;
		}
		
	}
	
}