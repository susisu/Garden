/*
	Copyright(C) 2013 Susisu
	see also: LICENSE
*/
package garden.utils
{
	
	import garden.events.Event;
	import garden.events.EventDispatcher;
	import garden.events.IEventDispatcher;
	import garden.events.PropertyChangeEvent;
	
	public dynamic class Binder extends EventDispatcher implements IBinder
	{
		
		private var _target:IEventDispatcher;
		private var _sourceList:Object;
		
		public function Binder(target:IEventDispatcher = null)
		{
			super();
			
			if(target == null)
			{
				_target = this;
			}
			else
			{
				_target = target;
			}
			_target.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onPropertyChange);
			
			_sourceList = new Object();
		}
		
		private function onPropertyChange(e:PropertyChangeEvent):void
		{
			var propertyName:String = e.propertyName;
			if(_sourceList[propertyName])
			{
				var value:Object = _target[propertyName];
				var source:BindableVar = _sourceList[propertyName][0] as BindableVar;
				if(source != null && source.value != value)
				{
					source.value = value;
				}
			}
		}
		
		public function setProperty(propertyName:String, value:Object):void
		{
			var oldValue:Object = _target[propertyName];
			_target[propertyName] = value;
			_target.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE, false, false,
				propertyName, oldValue, value));
		}
		
		public function bind(propertyName:String, source:IBindable):void
		{
			if(_sourceList[propertyName])
			{
				unbind(propertyName);
			}
			function onSourceValueChange(e:Event):void
			{
				if(_target[propertyName] !== source.value
					&& !(isNaN(_target[propertyName] as Number) && isNaN(source.value as Number)))
				{
					_target[propertyName] = source.value;
				}
			};
			source.addEventListener(Event.CHANGE, onSourceValueChange);
			_sourceList[propertyName] = [source,onSourceValueChange];
			
			_target[propertyName] = source.value;
		}
		
		public function unbind(propertyName:String):void
		{
			_sourceList[propertyName][0].removeEventListener(Event.CHANGE, _sourceList[propertyName][1]);	
			delete _sourceList[propertyName];
		}
		
		public function refresh():void
		{
			for(var propertyName:String in _sourceList)
			{
				_target[propertyName] = _sourceList[propertyName][0].value;
			}
		}
		
	}
	
}