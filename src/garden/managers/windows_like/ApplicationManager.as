package garden.managers.windows_like
{
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import garden.system.Application;
	import garden.events.ApplicationWindowEvent;
	
	public class ApplicationManager extends Object
	{
		
		private var _application:Application;
		private var _manager:Manager;
		
		private var _winManagers:Dictionary;
		
		public function ApplicationManager(application:Application,manager:Manager)
		{
			_application=application;
			_manager=manager;
			
			_winManagers=new Dictionary();
			
			_application.addEventListener(ApplicationWindowEvent.WINDOW_OPENED,onWindowOpened);
			_application.addEventListener(ApplicationWindowEvent.WINDOW_CLOSED,onWindowClosed);
		}
		
		private function onWindowOpened(e:ApplicationWindowEvent):void
		{
			var windowManager:WindowManager=new WindowManager(e.window,_manager);
			_application.system.activeWindow=e.window;
			_winManagers[e.window]=windowManager;
		}
		
		private function onWindowClosed(e:ApplicationWindowEvent):void
		{
			var windowManager:WindowManager=_winManagers[e.window];
			windowManager.dispose();
			delete _winManagers[e.window];
		}
		
	}
	
}