package garden
{
	
	import garden.system.Application;
	
	public class ViewModelBase extends Object
	{
		
		private var _application:Application;
		
		public function ViewModelBase(application:Application,args:Array=null)
		{
			_application=application;
		}
		
		public function get application():Application
		{
			return _application;
		}
		
	}
	
}