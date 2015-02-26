package garden.widgets.contents
{
	
	import garden.events.PropertyChangeEvent;
	
	public class Panel extends Container
	{
		
		private var _background:Boolean;
		private var _backgroundColor:uint;
		
		public function Panel()
		{
			super();
			
			_background=false;
			_backgroundColor=0x000000;
		}
		
		public function get background():Boolean
		{
			return _background;
		}
		public function set background(value:Boolean):void
		{
			var oldValue:Object=_background;
			_background=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"background",oldValue,value));
		}
		
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		public function set backgroundColor(value:uint):void
		{
			var oldValue:Object=_backgroundColor;
			_backgroundColor=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"backgroundColor",oldValue,value));
		}
		
		public function get numChildren():uint
		{
			return $numChildren;
		}
		
		public function addChild(child:Content):Content
		{
			return $addChild(child);
		}
		
		public function addChildAt(child:Content,index:int):Content
		{
			return $addChildAt(child,index);
		}
		
		public function contains(child:Content):Boolean
		{
			return $contains(child);
		}
		
		public function getChildAt(index:int):Content
		{
			return $getChildAt(index);
		}
		
		public function getChildByName(name:String):Content
		{
			return $getChildByName(name);
		}
		
		public function getChildIndex(child:Content):int
		{
			return $getChildIndex(child);
		}
		
		override public function getClass():Class
		{
			return Panel;
		}
		
		public function removeChild(child:Content):Content
		{
			return $removeChild(child);
		}
		
		public function removeChildAt(index:int):Content
		{
			return $removeChildAt(index);
		}
		
		public function setChildIndex(child:Content,index:int):void
		{
			$setChildIndex(child,index);
		}
		
		public function swapChildren(child1:Content,child2:Content):void
		{
			$swapChildren(child1,child2);
		}
		
		public function swapChildrenAt(index1:int,index2:int):void
		{
			$swapChildrenAt(index1,index2);
		}
		
	}
	
}