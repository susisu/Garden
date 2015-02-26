package garden.events
{
	
	import garden.widgets.contents.Content;
	
	public class ContainerEvent extends Event
	{
		
		public static const CONTENT_ADDED:String="contentAdded";
		public static const CONTENT_INDEX_CHANGED:String="contentIndexChanged";
		public static const CONTENT_REMOVED:String="contentRemoved";
		
		private var _childContent:Content;
		private var _index:int;
		
		public function ContainerEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false,childContent:Content=null,index:int=-1)
		{
			super(type,bubbles,cancelable);
			
			_childContent=childContent;
			_index=index;
		}
		
		public function get childContent():Content
		{
			return _childContent;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		override public function clone():Event
		{
			return new ContainerEvent(type,bubbles,cancelable,_childContent,_index);
		}
		
		override public function toString():String
		{
			return formatToString("ContainerEvent","type","bubbles","cancelable","childContent","index");
		}
		
	}
	
}