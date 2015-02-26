package garden.events
{
	
	public class DataChangeEvent extends Event
	{
		
		public static const DATA_CHANGE:String="dataChange";
		public static const PRE_DATA_CHANGE:String="preDataChange";
		
		private var _changeType:String;
		private var _endIndex:uint;
		private var _items:Array;
		private var _startIndex:uint;
		
		public function DataChangeEvent(eventType:String,changeType:String,items:Array,startIndex:int=-1,endIndex:int=-1)
		{
			super(eventType,false,false);
			
			_changeType=changeType;
			_items=items;
			_startIndex=startIndex
			_endIndex=endIndex;
		}
		
		public function get changeType():String
		{
			return _changeType;
		}
		
		public function get endIndex():uint
		{
			return _endIndex;
		}
		
		public function get items():Array
		{
			return _items;
		}
		
		public function get startIndex():uint
		{
			return _startIndex;
		}
		
		override public function clone():Event
		{
			return new DataChangeEvent(type,_changeType,_items,_startIndex,_endIndex);
		}
		
		override public function toString():String
		{
			return formatToString("DataChangeEvent","type","changeType","startIndex","endIndex","bubbles","cancelable");
		}
		
	}
	
}