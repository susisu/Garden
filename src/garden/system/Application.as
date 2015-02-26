package garden.system
{
	
	import garden.garden_internal;
	import garden.events.ApplicationEvent;
	import garden.events.ApplicationWindowEvent;
	import garden.events.Event;
	import garden.events.EventDispatcher;
	import garden.widgets.Window;
	
	public class Application extends EventDispatcher
	{
		
		private var _id:String;
		private var _system:System;
		private var _windows:Vector.<Window>;
		
		public function Application(system:System,id:String)
		{
			super();
			
			_system=system;
			_id=id;
			
			_windows=new Vector.<Window>();
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get system():System
		{
			return _system;
		}
		
		public function get windows():Vector.<Window>
		{
			return _windows.slice();
		}
		
		public function addWindow(window:Window):Window
		{
			if(window==null)
			{
				throw (new TypeError("'window' should not be null"));
				return null;
			}
			var len:uint=_windows.length;
			for(var i:int=0;i<len;i++)
			{
				if(_windows[i]==window)
				{
					throw (new ArgumentError("specified 'window' has already added"));
					return window;
				}
			}
			_windows.push(window);
			window.garden_internal::setApplication(this);
			dispatchEvent(new ApplicationWindowEvent(ApplicationWindowEvent.WINDOW_OPENED,false,false,window));
			return window;
		}
		
		public function closeWindow(window:Window):Window
		{
			var len:uint=_windows.length;
			for(var i:int=0;i<len;i++)
			{
				if(_windows[i]==window)
				{
					var window:Window=_windows.splice(i,1)[0];
					window.garden_internal::setApplication(null);
					dispatchEvent(new ApplicationWindowEvent(ApplicationWindowEvent.WINDOW_CLOSED,false,false,window));
					return window;
				}
			}
			throw (new ArgumentError("specified 'window' does not exist"));
			return null;
		}
		
		public function kill():Boolean
		{
			if(_system)
			{
				var accepted:Boolean=_system.killApplication(this);
				if(accepted)
				{
					dispatchEvent(new ApplicationEvent(ApplicationEvent.KILLED));
				}
				return accepted;
			}
			else
			{
				throw (new Error("this application may have already killed"));
				return false;
			}
		}
		
		garden_internal function setSystem(system:System):void
		{
			_system=system;
		}
		
	}
	
}