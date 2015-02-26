package garden.widgets.contents
{
	
	import garden.widgets.Window;
	
	public class ContainerOfWindow extends Panel
	{
		
		private var _window:Window;
		
		public function ContainerOfWindow(window:Window)
		{
			super();
		}
		
		public function get window():Window
		{
			return _window;
		}
		
		override public function getClass():Class
		{
			return ContainerOfWindow;
		}
		
	}
	
}