package garden.managers.windows_like.content_managers
{
	
	import flash.display.Shape;
	import flash.utils.Dictionary;
	
	import garden.events.ContainerEvent;
	import garden.events.PropertyChangeEvent;
	import garden.widgets.contents.Container;
	import garden.widgets.contents.Content;
	
	import garden.managers.windows_like.Manager;
	import garden.managers.windows_like.content_managers.ContentManagerDictionary;
	
	public class ContainerManager extends ContentManager
	{
		
		private var _container:Container;
		
		private var _mask:Shape;
		private var _childContentManagers:Dictionary;
		
		public function ContainerManager(container:Container,manager:Manager)
		{
			super(container,manager);
			
			_container=container;
			
			_container.addEventListener(ContainerEvent.CONTENT_ADDED,onContainerContentAdded);
			_container.addEventListener(ContainerEvent.CONTENT_REMOVED,onContainerContentRemoved);
			_container.addEventListener(ContainerEvent.CONTENT_INDEX_CHANGED,onContainerContentIndexChanged);
			_container.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onContainerPropertyChange);
			
			
			_mask=new Shape();
			_mask.graphics.beginFill(0x000000,0);
			_mask.graphics.drawRect(0,0,_container.width,_container.height);
			_mask.graphics.endFill();
			addChild(_mask);
			mask=_mask;
			
			_childContentManagers=new Dictionary();
			
			var children:Vector.<Content>=_container.children;
			var len:uint=children.length;
			for(var i:int=0;i<len;i++)
			{
				var child:Content=children[i];
				var childContentManager:ContentManager=new (ContentManagerDictionary.getManagerClassByContent(child))(child,_manager);
				_childContentManagers[child]=childContentManager;
				addChild(childContentManager);
			}
		}
		
		override public function dispose():void
		{
			for(var content:Object in _childContentManagers)
			{
				_childContentManagers[content].dispose();
				delete _childContentManagers[content];
			}
			_container.removeEventListener(ContainerEvent.CONTENT_ADDED,onContainerContentAdded);
			_container.removeEventListener(ContainerEvent.CONTENT_REMOVED,onContainerContentRemoved);
			_container.removeEventListener(ContainerEvent.CONTENT_INDEX_CHANGED,onContainerContentIndexChanged);
			_container.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onContainerPropertyChange);
			_container=null;
			
			super.dispose();
		}
		
		private function onContainerContentAdded(e:ContainerEvent):void
		{
			var child:Content=e.childContent;
			var childContentManager:ContentManager=new (ContentManagerDictionary.getManagerClassByContent(child))(child,_manager);
			_childContentManagers[child]=childContentManager;
			addChildAt(childContentManager,e.index);
		}
		
		private function onContainerContentRemoved(e:ContainerEvent):void
		{
			var child:Content=e.childContent;
			var childContentManager:ContentManager=_childContentManagers[child];
			removeChild(childContentManager);
			childContentManager.dispose();
			delete _childContentManagers[child];
		}
		
		private function onContainerContentIndexChanged(e:ContainerEvent):void
		{
			var child:Content=e.childContent;
			var childContentManager:ContentManager=_childContentManagers[child];
			setChildIndex(childContentManager,e.index);
		}
		
		private function onContainerPropertyChange(e:PropertyChangeEvent):void
		{	
			switch(e.propertyName)
			{
				case "height":
				case "width":
					_mask.graphics.clear();
					_mask.graphics.beginFill(0x000000,0);
					_mask.graphics.drawRect(0,0,_container.width,_container.height);
					_mask.graphics.endFill();
					break;
			}
		}
		
	}
	
}