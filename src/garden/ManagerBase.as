package garden
{
	
	import garden.system.System;
	
	public class ManagerBase extends Object
	{
		
		private var _screen:Screen;
		private var _system:System;
		
		public function ManagerBase(system:System,screen:Screen)
		{
			_screen=screen;
			_system=system;
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
			return null;
		}
		
	}
	
}