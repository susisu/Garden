package garden.widgets.contents
{
	
	import garden.events.PropertyChangeEvent;
	import garden.widgets.WidgetBase;
	
	public class RadioButtonGroup extends WidgetBase
	{
		
		private var _radioButtons:Vector.<RadioButton>;
		private var _radioButtonListeners:Vector.<Function>;
		private var _stateList:Array;
		private var _processing:Boolean;
		
		private var _state:Object;
		
		public function RadioButtonGroup()
		{
			super();
			
			_radioButtons=new Vector.<RadioButton>();
			_radioButtonListeners=new Vector.<Function>();
			_stateList=[];
			_processing=false;
			
			_state=null;
		}
		
		public function get radioButtons():Vector.<RadioButton>
		{
			return _radioButtons.slice();
		}
		
		public function get state():Object
		{
			return _state;
		}
		public function set state(value:Object):void
		{
			var oldValue:Object=_state;
			_state=value;
			var len:uint=_stateList.length;
			_processing=true;
			for(var i:int=0;i<len;i++)
			{
				if(_state===_stateList[i])
				{
					selectionChange(i,true);
				}
				else
				{
					selectionChange(i,false);
				}
			}
			_processing=false;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"state",oldValue,value));
		}
		
		public function getStateList():Array
		{
			return _stateList.slice();
		}
		
		public function setStateList(value:Array):void
		{
			//remove old radio buttons
			var len:uint=_stateList.length;
			while(len>0)
			{
				_radioButtons.pop().removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,_radioButtonListeners.pop());
				len--;
			}
			
			_stateList=value.slice();
			
			//create new radio buttons
			len=_stateList.length;
			for(var i:int=0;i<len;i++)
			{
				var radioButton:RadioButton=new RadioButton();
				if(_state===_stateList[i])
				{
					radioButton.selected=true;
				}
				else
				{
					radioButton.selected=false;
				}
				(function():void
				{
					var index:int=i;
					function onRadioButtonPropertyChange(e:PropertyChangeEvent):void
					{
						if(e.propertyName=="selected" && e.newValue!==e.oldValue && !_processing)
						{
							_processing=true;
							selectionChange(index,Boolean(e.newValue));
							_processing=false;
							var oldState:Object=_state;
							_state=_stateList[index];
							dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"state",oldState,_state));
						}
					}
					radioButton.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onRadioButtonPropertyChange);
					_radioButtonListeners.push(onRadioButtonPropertyChange);
				})();
				_radioButtons.push(radioButton);
			}
		}
		
		private function selectionChange(index:int,selected:Boolean):void
		{
			if(selected)
			{
				var len:uint=_stateList.length;
				for(var i:int=0;i<len;i++)
				{
					var radioButton:RadioButton=_radioButtons[i];
					if(i==index)
					{
						if(!radioButton.selected)
						{
							radioButton.selected=true;
						}
					}
					else
					{
						if(radioButton.selected)
						{
							radioButton.selected=false;
						}
					}
				}
			}
			else
			{
				if(_radioButtons[index].selected)
				{
					_radioButtons[index].selected=false;
				}
			}
		}
		
	}
	
}