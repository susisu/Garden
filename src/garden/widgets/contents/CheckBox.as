package garden.widgets.contents
{
	
	import garden.events.PropertyChangeEvent;
	
	public class CheckBox extends Content
	{
		
		private var _label:String;
		private var _selected:Boolean;
		
		public function CheckBox()
		{
			super();
			
			_label="";
			_selected=false;
		}
		
		public function get label():String
		{
			return _label;
		}
		public function set label(value:String):void
		{
			var oldValue:Object=_label;
			_label=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"label",oldValue,value));
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected(value:Boolean):void
		{
			var oldValue:Object=_selected;
			_selected=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"selected",oldValue,value));
		}
		
		override public function getClass():Class
		{
			return CheckBox;
		}
		
	}

}