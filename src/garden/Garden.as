package garden
{
	
	import garden.system.System;
	
	public class Garden extends Object
	{
		
		use namespace garden_internal;
		
		private var _screen:Screen;
		private var _system:System;
		private var _manager:ManagerBase;
		
		public function Garden(managerClass:Class)
		{
			_screen=new Screen();
			_system=new System(_screen);
			_manager=new managerClass(_system,_screen);
		}
		
		public function get screen():Screen
		{
			return _screen;
		}
		
		public function get system():System
		{
			return _system;
		}
		
		public function get viewport():Object
		{
			return _manager.viewport;
		}
		
	}
	
}
