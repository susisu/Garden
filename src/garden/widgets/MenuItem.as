package garden.widgets
{
	
	public class MenuItem extends WidgetBase
	{
		
		private var _caption:String;
		private var _key:String;
		private var _childMenu:Menu;
		
		public function MenuItem(caption:String,key:String=null,childMenu=null)
		{
			super();
			
			_caption=caption;
			_key=key;
			_childMenu=null;
		}
		
	}
	
}