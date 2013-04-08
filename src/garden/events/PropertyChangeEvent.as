/*
	Copyright(C) 2013 Susisu
	see also: LICENSE
*/
package garden.events
{
	
	public class PropertyChangeEvent extends Event
	{
		
		public static const PROPERTY_CHANGE:String="propertyChange";
		
		public var propertyName:String;
		public var newValue:Object;
		public var oldValue:Object;
		
		public function PropertyChangeEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false,propertyName:String="",oldValue:Object=null,newValue:Object=null)
		{
			super(type,bubbles,cancelable);
			
			this.propertyName=propertyName;
			this.newValue=newValue;
			this.oldValue=oldValue;
		}
		
		override public function clone():Event
		{
			return new PropertyChangeEvent(type,bubbles,cancelable,propertyName,oldValue,newValue);
		}
		
		override public function toString():String
		{
			return formatToString("PropertyChangeEvent","type","bubbles","cancelable","propertyName","oldValue","newValue");
		}
		
	}
	
}