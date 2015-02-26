package garden.utils
{
	
	import garden.events.Event;
	import garden.events.EventDispatcher;
	import garden.events.IEventDispatcher;
	import garden.events.PropertyChangeEvent;
	
	public dynamic class Binder extends EventDispatcher implements IBinder
	{
		
		private var _target:IEventDispatcher;
		private var _list:Object;
		
		public function Binder(target:IEventDispatcher=null)
		{
			super();
			
			if(target==null)
			{
				_target=this;
			}
			else
			{
				_target=target;
			}
			_target.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onPropertyChange);
			
			_list=new Object();
		}
		
		private function onPropertyChange(e:PropertyChangeEvent):void
		{
			var propertyName:String=e.propertyName;
			if(_list[propertyName])
			{
				var value:Object=_target[propertyName];
				var bindableVar:BindableVar=_list[propertyName][0] as BindableVar;
				if(bindableVar!=null && bindableVar.value!=value)
				{
					bindableVar.value=value;
				}
			}
		}
		
		public function setProperty(propertyName:String,value:Object):void
		{
			var oldValue:Object=_target[propertyName];
			_target[propertyName]=value;
			_target.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,propertyName,oldValue,value));
		}
		
		public function bind(propertyName:String,bindable:IBindable):void
		{
			function onBindableValueChange(e:Event):void
			{
				if(_target[propertyName]!==bindable.value && !(isNaN(_target[propertyName] as Number) && isNaN(bindable.value as Number)))
				{
					_target[propertyName]=bindable.value;
				}
			};
			bindable.addEventListener(Event.CHANGE,onBindableValueChange);
			_list[propertyName]=[bindable,onBindableValueChange];
			
			_target[propertyName]=bindable.value;
		}
		
		public function unbind(propertyName:String):void
		{
			_list[propertyName][0].removeEventListener(Event.CHANGE,_list[propertyName][1]);	
			delete _list[propertyName];
		}
		
		public function refresh():void
		{
			for(var propertyName:String in _list)
			{
				_target[propertyName]=_list[propertyName][0].value;
			}
		}
		
	}
	
}