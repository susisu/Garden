package garden
{
	
	import garden.system.Application;
	
	public class ViewBase extends Object
	{
		
		private var _application:Application;
		private var _viewModel:ViewModelBase;
		
		public function ViewBase(application:Application,viewModel:ViewModelBase)
		{
			_application=application;
			_viewModel=viewModel;
		}
		
		public function get application():Application
		{
			return _application;
		}
		
		public function get viewModel():ViewModelBase
		{
			return _viewModel;
		}
		
	}
	
}