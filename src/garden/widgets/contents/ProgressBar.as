package garden.widgets.contents
{
	
	import garden.events.PropertyChangeEvent;
	
	public class ProgressBar extends Content
	{
		
		private var _maximum:Number;
		private var _minimum:Number;
		private var _value:Number;
		
		public function ProgressBar()
		{
			super();
			
			_maximum=100;
			_minimum=0;
			_value=0;
		}
		
		public function get maximum():Number
		{
			return _maximum;
		}
		public function set maximum(value:Boolean):void
		{
			var oldValue:Object=_maximum;
			_maximum=value;
			if(_value>_maximum)
			{
				var oldValueValue:Object=_value;
				_value=_maximum;
				dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"value",oldValueValue,_value));
			}
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"maximum",oldValue,value));
		}
		
		public function get minimum():Number
		{
			return _minimum;
		}
		public function set minimum(value:Boolean):void
		{
			var oldValue:Object=_minimum;
			_minimum=value;
			if(_value<_minimum)
			{
				var oldValueValue:Object=_value;
				_value=_minimum;
				dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"value",oldValueValue,_value));
			}
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"minimum",oldValue,value));
		}
		
		public function get value():Number
		{
			return _value;
		}
		public function set value(value:Number):void
		{
			var oldValue:Object=_value;
			_value=value;
			if(_value>_maximum)
			{
				_value=_maximum;
			}
			if(_value<_minimum)
			{
				_value=_minimum;
			}
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"value",oldValue,value));
		}
		
		override public function getClass():Class
		{
			return ProgressBar;
		}
		
	}

}