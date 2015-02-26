package garden.managers.windows_like
{
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import garden.Screen;
	import garden.ManagerBase;
	import garden.events.Event;
	import garden.events.SystemApplicationEvent;
	import garden.system.System;
	
	import garden.managers.windows_like.content_managers.ContentManagerDictionary;
	
	public class Manager extends ManagerBase
	{
		
		private var _viewport:Viewport;
		private var _tooltipLayer:Sprite;
		private var _menuLayer:Sprite;
		private var _windowLayer:WindowLayer;
		
		private var _appManagers:Dictionary;
		
		public function Manager(system:System,screen:Screen)
		{
			super(system,screen);
			
			ContentManagerDictionary.init();
			
			screen.width=800;
			screen.height=600;
			screen.addEventListener(Event.RESIZE,onScreenResize);
			
			system.addEventListener(SystemApplicationEvent.APPLICATION_STARTED,onApplicationStarted);
			system.addEventListener(SystemApplicationEvent.APPLICATION_KILLED,onApplicationKilled);
			
			_viewport=new Viewport();
			_viewport.graphics.beginFill(0x000000);
			_viewport.graphics.drawRect(-1,-1,screen.width+2,screen.height+2);
			_viewport.graphics.endFill();
			
			_tooltipLayer=new Sprite();
			_viewport.addChild(_tooltipLayer);
			
			_menuLayer=new Sprite();
			_viewport.addChild(_menuLayer);
			
			_windowLayer=new WindowLayer();
			_windowLayer.graphics.beginFill(0x000000,0);
			_windowLayer.graphics.drawRect(-1,-1,screen.width+2,screen.height+2);
			_windowLayer.graphics.endFill();
			_viewport.addChild(_windowLayer);
			
			_appManagers=new Dictionary();
		}
		
		override public function get viewport():Object
		{
			return _viewport;
		}
		
		public function get windowLayer():WindowLayer
		{
			return _windowLayer;
		}
		
		public function showTooltip(text:String,x:Number,y:Number):void
		{
			
		}
		
		public function hideTooltip():void
		{
			
		}
		
		private function onScreenResize(e:Event):void
		{
			_viewport.graphics.clear();
			_viewport.graphics.beginFill(0x000000);
			_viewport.graphics.drawRect(-1,-1,screen.width+2,screen.height+2);
			_viewport.graphics.endFill();
		}
		
		private function onApplicationStarted(e:SystemApplicationEvent):void
		{
			var appManager:ApplicationManager=new ApplicationManager(e.application,this);
			_appManagers[e.application]=appManager;
		}
		
		private function onApplicationKilled(e:SystemApplicationEvent):void
		{
			delete _appManagers[e.application];
		}
		
	}
	
}