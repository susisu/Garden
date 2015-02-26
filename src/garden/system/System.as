package garden.system
{
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import garden.garden_internal;
	import garden.Screen;
	import garden.ViewBase;
	import garden.ViewModelBase;
	import garden.events.ApplicationEvent;
	import garden.events.EventDispatcher;
	import garden.events.SystemApplicationEvent;
	import garden.events.SystemEvent;
	import garden.events.WindowEvent;
	import garden.widgets.Window;
	
	public class System extends EventDispatcher
	{
		
		private var _activeWindow:Window;
		private var _applications:Vector.<Application>;
		private var _screen:Screen;
		private var _views:Dictionary;
		private var _windowMaximizingRect:Rectangle;
		
		public function System(screen:Screen)
		{
			super();
			
			_activeWindow=null;
			_applications=new Vector.<Application>();
			_screen=screen;
			_views=new Dictionary();
			_windowMaximizingRect=null;
		}
		
		public function get activeWindow():Window
		{
			return _activeWindow;
		}
		public function set activeWindow(value:Window):void
		{
			if(value!=_activeWindow)
			{
				if(_activeWindow!=null)
				{
					_activeWindow.dispatchEvent(new WindowEvent(WindowEvent.DEACTIVATE,true));
				}
				_activeWindow=value;
				if(value!=null)
				{
					_activeWindow.dispatchEvent(new WindowEvent(WindowEvent.ACTIVATE,true));
				}
				dispatchEvent(new SystemEvent(SystemEvent.ACTIVE_WINDOW_CHANGE));
			}
		}
		
		public function get applications():Vector.<Application>
		{
			return _applications.slice();
		}
		
		public function get screen():Screen
		{
			return _screen;
		}
		
		public function get windowMaximizingRect():Rectangle
		{
			return _windowMaximizingRect;
		}
		public function set windowMaximizingRect(value:Rectangle):void
		{
			_windowMaximizingRect=value;
			dispatchEvent(new SystemEvent(SystemEvent.WINDOW_MAXIMIZING_RECT_CHANGE));
		}
		
		public function killApplication(application:Application):Boolean
		{
			var len:uint=_applications.length;
			for(var i:int=0;i<len;i++)
			{
				if(_applications[i]==application)
				{
					_applications.splice(i,1)[0];
					application.garden_internal::setSystem(null);
					var numWindows:uint=application.windows.length;
					while(numWindows>0)
					{
						application.windows[0].close(true);
						numWindows--;
					}
					delete _views[application];
					dispatchEvent(new SystemApplicationEvent(SystemApplicationEvent.APPLICATION_KILLED,false,false,application));
					return true;
				}
			}
			throw (new ArgumentError("specified 'application' does not exist"));
		}
		
		public function startApplication(id:String,viewModelClass:Class,viewClass:Class,args:Array=null):Application
		{
			var application:Application=new Application(this,id);
			_applications.push(application);
			dispatchEvent(new SystemApplicationEvent(SystemApplicationEvent.APPLICATION_STARTED,false,false,application));
			var viewModel:ViewModelBase=new viewModelClass(application,args);
			var view:ViewBase=new viewClass(application,viewModel);
			_views[application]=view;
			return application;
		}
		
		public function shutDown():void
		{
			var len:uint=_applications.length;
			while(len>0)
			{
				var application:Application=_applications.pop();
				application.garden_internal::setSystem(null);
				var numWindows:uint=application.windows.length;
				while(numWindows>0)
				{
					application.windows[0].close(true);
					numWindows--;
				}
				delete _views[application];
				dispatchEvent(new SystemApplicationEvent(SystemApplicationEvent.APPLICATION_KILLED,false,false,application));
				len--;
			}
			dispatchEvent(new SystemEvent(SystemEvent.SHUT_DOWN));
		}
		
	}
	
}