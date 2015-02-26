package garden.widgets
{
	
	import garden.events.EventNode;
	import garden.utils.Binder;
	import garden.utils.IBindable;
	import garden.utils.IBinder;
	
	public class WidgetBase extends EventNode implements IBinder
	{
		
		private var _binder:Binder;
		
		public function WidgetBase()
		{
			super();
			
			_binder=new Binder(this);
		}
		
		public function bind(propertyName:String,bindable:IBindable):void
		{
			_binder.bind(propertyName,bindable);
		}
		
		public function unbind(propertyName:String):void
		{
			_binder.unbind(propertyName);
		}
		
		public function refresh():void
		{
			_binder.refresh();
		}
		
	}
	
}