package garden.widgets.contents
{
	
	import flash.display.BitmapData;
	
	import garden.events.PropertyChangeEvent;
	
	public class Button extends Content
	{
		
		private var _autoRepeat:Boolean;
		private var _emphasized:Boolean;
		private var _icon:BitmapData;
		private var _iconPosition:String;
		private var _label:String;
		private var _selected:Boolean;
		private var _toggle:Boolean;
		
		public function Button()
		{
			super();
			
			width=100;
			height=24;
			
			_autoRepeat=false;
			_emphasized=false;
			_icon=null;
			_iconPosition=ButtonIconPosition.LEFT;
			_label="";
			_selected=false;
			_toggle=false;
		}
		
		public function get autoRepeat():Boolean
		{
			return _autoRepeat;
		}
		public function set autoRepeat(value:Boolean):void
		{
			var oldValue:Object=_autoRepeat;
			_autoRepeat=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"autoRepeat",oldValue,value));
		}
		
		public function get emphasized():Boolean
		{
			return _emphasized;
		}
		public function set emphasized(value:Boolean):void
		{
			var oldValue:Object=_emphasized;
			_emphasized=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"emphasized",oldValue,value));
		}
		
		public function get icon():BitmapData
		{
			return _icon;
		}
		public function set icon(value:BitmapData):void
		{
			var oldValue:Object=_icon;
			_icon=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"icon",oldValue,value));
		}
		
		public function get iconPosition():String
		{
			return _iconPosition;
		}
		public function set iconPosition(value:String):void
		{
			var oldValue:Object=_iconPosition;
			_iconPosition=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"iconPosition",oldValue,value));
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
		
		public function get toggle():Boolean
		{
			return _toggle;
		}
		public function set toggle(value:Boolean):void
		{
			var oldValue:Object=_toggle;
			_toggle=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"toggle",oldValue,value));
		}
		
		override public function getClass():Class
		{
			return Button;
		}
		
	}

}