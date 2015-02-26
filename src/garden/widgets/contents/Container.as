package garden.widgets.contents
{
	
	import garden.garden_internal;
	import garden.events.ContainerEvent;
	import garden.events.Event;
	import garden.events.PropertyChangeEvent;
	import garden.widgets.contents.ContainerOfWindow;
	
	public class Container extends Content
	{
		
		private var _children:Vector.<Content>;
		
		private var _mouseChildren:Boolean;
		private var _tabChildren:Boolean;
		
		public function Container()
		{
			super();
			
			_children=new Vector.<Content>();
			
			_mouseChildren=true;
			_tabChildren=false;
		}
		
		public function get children():Vector.<Content>
		{
			return _children.slice();
		}
		
		public function get mouseChildren():Boolean
		{
			return _mouseChildren;
		}
		public function set mouseChildren(value:Boolean):void
		{
			var oldValue:Object=_mouseChildren;
			_mouseChildren=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"mouseChildren",oldValue,value));
		}
		
		public function get tabChildren():Boolean
		{
			return _tabChildren;
		}
		public function set tabChildren(value:Boolean):void
		{
			var oldValue:Object=_tabChildren;
			_tabChildren=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"tabChildren",oldValue,value));
		}
		
		protected function get $numChildren():uint
		{
			return _children.length;
		}
		
		override public function getClass():Class
		{
			return Container;
		}
		
		override public function copyParameters(target:Content=null):Content
		{
			var content:Container;
			if(target==null)
			{
				content=new Container();
			}
			else if(target as Container==null)
			{
				throw (new ArgumentError("'target' should be a instance of Container or null."));
			}
			else
			{
				content=target as Container;
			}
			content.mouseChildren=_mouseChildren;
			content.tabChildren=_tabChildren;
			return content;
		}
		
		protected function $addChild(child:Content):Content
		{
			if(child==null)
			{
				throw (new TypeError("'child' should not be null."));
			}
			if(child is Container && (child as Container).$contains(this))
			{
				throw (new ArgumentError("'child' is the same as the parent, or has the parent as a child."));
			}
			if(child._parent!=null)
			{
				child._parent.$removeChild(child);
			}
			_children.push(child);
			child._parent=this;
			child.dispatchEvent(new Event(Event.ADDED,true));
			if(root is ContainerOfWindow)
			{
				if(child is Container)
				{
					(child as Container).triggerAddedToWindowEvent();
				}
				else
				{
					child.dispatchEvent(new Event(Event.ADDED_TO_WINDOW));
				}
			}
			dispatchEvent(new ContainerEvent(ContainerEvent.CONTENT_ADDED,false,false,child,_children.length-1));
			
			return child;
		}
		
		protected function $addChildAt(child:Content,index:int):Content
		{
			if(child==null)
			{
				throw (new TypeError("'child' should not be null."));
			}
			if(index<0 || index>_children.length)
			{
				throw (new RangeError("'index' is out of range."));
			}
			if(child is Container && (child as Container).$contains(this))
			{
				throw (new ArgumentError("'child' is the same as the parent, or has the parent as a child."));
			}
			if(child._parent!=null)
			{
				child._parent.$removeChild(child);
			}
			_children.splice(index,0,child);
			child._parent=this;
			child.dispatchEvent(new Event(Event.ADDED,true));
			if(root is ContainerOfWindow)
			{
				if(child is Container)
				{
					(child as Container).triggerAddedToWindowEvent();
				}
				else
				{
					child.dispatchEvent(new Event(Event.ADDED_TO_WINDOW));
				}
			}
			var len:uint=_children.length;
			for(var i:int=index+1;i<len;i++)
			{
				//_children[i].dispatchEvent(new Event(Event.INDEX_CHANGE,false,false));
				dispatchEvent(new ContainerEvent(ContainerEvent.CONTENT_INDEX_CHANGED,false,false,_children[i],i));
			}
			dispatchEvent(new ContainerEvent(ContainerEvent.CONTENT_ADDED,false,false,child,index));
			
			return child;
		}
		
		protected function $contains(child:Content):Boolean
		{
			if(child==null)
			{
				throw (new TypeError("'child' should not be null."));
			}
			if(this==child)
			{
				return true;
			}
			else
			{
				var len:uint=_children.length;
				for(var i:int=0;i<len;i++)
				{
					var child2:Content=_children[i];
					if(child2==child || (child2 is Container && (child2 as Container).$contains(child)))
					{
						return true;
					}
				}
			}
			return false;
		}
		
		protected function $getChildAt(index:int):Content
		{
			if(index<0 || index>=_children.length)
			{
				throw (new RangeError("'index' is out of range."));
			}
			return _children[index];
		}
		
		protected function $getChildByName(name:String):Content
		{
			if(name==null)
			{
				throw (new TypeError("'name' should not be null."));
			}
			var len:uint=_children.length;
			for(var i:int=0;i<len;i++)
			{
				if(_children[i].name==name)
				{
					return _children[i];
				}
			}
			return null;
		}
		
		protected function $getChildIndex(child:Content):int
		{
			if(child==null)
			{
				throw (new TypeError("'child' should not be null."));
			}
			var len:uint=_children.length;
			for(var i:int=0;i<len;i++)
			{
				if(_children[i]==child)
				{
					return i;
				}
			}
			throw (new ArgumentError("'child' is not a child."));
			return -1;
		}
		
		protected function $removeChild(child:Content):Content
		{
			if(child==null)
			{
				throw (new TypeError("'child' should not be null."));
			}
			var len:uint=_children.length;
			for(var i:int=0;i<len;i++)
			{
				if(_children[i]==child)
				{
					child.dispatchEvent(new Event(Event.REMOVED,true));
					if(root is ContainerOfWindow)
					{
						if(child is Container)
						{
							(child as Container).triggerRemovedFromWindowEvent();
						}
						else
						{
							child.dispatchEvent(new Event(Event.REMOVED_FROM_WINDOW));
						}
					}
					dispatchEvent(new ContainerEvent(ContainerEvent.CONTENT_REMOVED,false,false,child,i));
					
					_children.splice(i,1);
					child._parent=null;
					
					len--;
					for(var j:int=i;j<len;j++)
					{
						//_children[j].dispatchEvent(new Event(Event.INDEX_CHANGE));
						dispatchEvent(new ContainerEvent(ContainerEvent.CONTENT_INDEX_CHANGED,false,false,_children[j],j));
					}
					
					return child;
				}
			}
			throw (new ArgumentError("'child' is not a child."));
			return child;
		}
		
		protected function $removeChildAt(index:int):Content
		{
			if(index<0 || index>=_children.length)
			{
				throw (new RangeError("'index' is out of range."));
			}
			var child:Content=_children[index];
			child.dispatchEvent(new Event(Event.REMOVED,true));
			if(root is ContainerOfWindow)
			{
				if(child is Container)
				{
					(child as Container).triggerRemovedFromWindowEvent();
				}
				else
				{
					child.dispatchEvent(new Event(Event.REMOVED_FROM_WINDOW));
				}
			}
			dispatchEvent(new ContainerEvent(ContainerEvent.CONTENT_REMOVED,false,false,child,index));
			
			_children.splice(index,1);
			child._parent=null;
			
			var len:uint=_children.length;
			for(var i:int=index;i<len;i++)
			{
				//_children[i].dispatchEvent(new Event(Event.INDEX_CHANGE));
				dispatchEvent(new ContainerEvent(ContainerEvent.CONTENT_INDEX_CHANGED,false,false,_children[i],i));
			}
			return child;
		}
		
		protected function $setChildIndex(child:Content,index:int):void
		{
			if(child==null)
			{
				throw (new TypeError("'child' should not be null."));
			}
			var len:uint=_children.length;
			if(index<0 || index>=len)
			{
				throw (new RangeError("'index' is out of range."));
			}
			for(var i:int=0;i<len;i++)
			{
				if(_children[i]==child)
				{
					if(index!=i)
					{
						_children.splice(i,1);
						_children.splice(index,0,child);
						
						len=len-1;
						for(var j:int=i;j<len;j++)
						{
							//_children[j].dispatchEvent(new Event(Event.INDEX_CHANGE));
							dispatchEvent(new ContainerEvent(ContainerEvent.CONTENT_INDEX_CHANGED,false,false,_children[j],j));
						}
					}
					return;
				}
			}
			throw (new ArgumentError("'child' is not a child."));
		}
		
		protected function $swapChildren(child1:Content,child2:Content):void
		{
			if(child1==null)
			{
				throw (new TypeError("'child1' should not be null."));
			}
			if(child2==null)
			{
				throw (new TypeError("'child2' should not be null."));
			}
			if(child1==child2)
			{
				return;
			}
			var len:uint=_children.length;
			var index1:int=-1;
			var index2:int=-1;
			for(var i:int=0;i<len;i++)
			{
				if(_children[i]==child1)
				{
					index1=i;
					break;
				}
			}
			for(i=0;i<len;i++)
			{
				if(_children[i]==child2)
				{
					index2=i;
					break;
				}
			}
			if(index1<0 || index2<0)
			{
				throw (new ArgumentError("both 'child1' and 'child2' should be children."));
			}
			$swapChildrenAt(index1,index2);
		}
		
		protected function $swapChildrenAt(index1:int,index2:int):void
		{
			var len:uint=_children.length;
			if(index1<0 || index1>=len)
			{
				throw (new RangeError("'index1' is out of range."));
			}
			if(index2<0 || index2>=len)
			{
				throw (new RangeError("'index2' is out of range."));
			}
			if(index1==index2)
			{
				return;
			}
			var temp:Content=_children[index1];
			_children[index1]=_children[index2];
			_children[index2]=temp;
			//_children[index1].dispatchEvent(new Event(Event.INDEX_CHANGE));
			//_children[index2].dispatchEvent(new Event(Event.INDEX_CHANGE));
			dispatchEvent(new ContainerEvent(ContainerEvent.CONTENT_INDEX_CHANGED,false,false,_children[index1],index2));
			dispatchEvent(new ContainerEvent(ContainerEvent.CONTENT_INDEX_CHANGED,false,false,_children[index2],index1));
		}
		
		private function triggerAddedToWindowEvent():void
		{
			dispatchEvent(new Event(Event.ADDED_TO_WINDOW));
			var len:uint=_children.length;
			for(var i:int=0;i<len;i++)
			{
				var child:Content=_children[i];
				if(child is Container)
				{
					(child as Container).triggerAddedToWindowEvent();
				}
				else
				{
					child.dispatchEvent(new Event(Event.ADDED_TO_WINDOW));
				}
			}
		}
		
		private function triggerRemovedFromWindowEvent():void
		{
			dispatchEvent(new Event(Event.REMOVED_FROM_WINDOW));
			var len:uint=_children.length;
			for(var i:int=0;i<len;i++)
			{
				var child:Content=_children[i];
				if(child is Container)
				{
					(child as Container).triggerAddedToWindowEvent();
				}
				else
				{
					child.dispatchEvent(new Event(Event.REMOVED_FROM_WINDOW));
				}
			}
		}
		
	}
	
}