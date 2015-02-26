package garden.widgets.contents
{
	
	import garden.events.PropertyChangeEvent;
	
	public class NumericStepper extends Content
	{
		
		private var _maximum:Number;
		private var _minimum:Number;
		private var _stepSize:Number;
		private var _value:Number;
		
		public function NumericStepper()
		{
			super();
			
			_maximum=10;
			_minimum=0;
			_stepSize=1;
			_value=0;
		}
		
		public function get maximum():Number
		{
			return _maximum;
		}
		public function set maximum(value:Number):void
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
		public function set minimum(value:Number):void
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
		
		public function get stepSize():Number
		{
			return _stepSize
		}
		public function set stepSize(value:Number):void
		{
			var oldValue:Object=_stepSize;
			_stepSize=value;
			
			var tempValue:Number=Math.round(_value/_stepSize)*_stepSize;
			var decimalPart:*=_stepSize.toString().split(".")[1];
			if(decimalPart)
			{
				var scale:Number=Math.pow(10,decimalPart.length);
				tempValue=Math.round(tempValue*scale)/scale;
			}
			if(tempValue>_maximum)
			{
				tempValue=_maximum;
			}
			if(tempValue<_minimum)
			{
				tempValue=_minimum;
			}
			if(_value!=tempValue)
			{
				var oldValueValue:Object=_value;
				_value=tempValue;
				dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"value",oldValueValue,_value));
			}
			
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"stepSize",oldValue,value));
		}
		
		public function get value():Number
		{
			return _value;
		}
		public function set value(value:Number):void
		{
			var oldValue:Object=_value;
			
			value=Math.round(value/_stepSize)*_stepSize;
			var decimalPart:*=_stepSize.toString().split(".")[1];
			if(decimalPart)
			{
				var scale:Number=Math.pow(10,decimalPart.length);
				value=Math.round(value*scale)/scale;
			}
			if(value>_maximum)
			{
				value=_maximum;
			}
			if(value<_minimum)
			{
				value=_minimum;
			}
			
			_value=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"value",oldValue,value));
		}
		
		override public function getClass():Class
		{
			return NumericStepper
		}
		
	}

}