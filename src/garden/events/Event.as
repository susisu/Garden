/*
	Copyright(C) 2013 Susisu
	see also: LICENSE
*/
package garden.events
{
	
	public class Event extends Object
	{
		
		public static const ADDED:String="added";
		public static const ADDED_TO_WINDOW:String="addedToWindow";
		public static const CHANGE:String="change";
		public static const CLOSE:String="close";
		public static const REMOVED:String="removed";
		public static const REMOVED_FROM_WINDOW:String="removedFromWindow";
		public static const RESIZE:String="resize";
		
		internal var _currentTarget:Object;
		internal var _eventPhase:uint;
		internal var _stopsImmediatePropagation:Boolean;
		internal var _stopsPropagation:Boolean;
		internal var _target:Object;
		
		private var _bubbles:Boolean;
		private var _cancelable:Boolean;
		private var _defaultPrevented:Boolean;
		private var _type:String;
		
		public function Event(type:String,bubbles:Boolean=false,cancelable:Boolean=false)
		{
			if(type==null)
			{
				throw (new TypeError("'type' should not be null."));
			}
			
			_type=type;
			_bubbles=bubbles;
			_cancelable=cancelable;
			
			_currentTarget=null;
			_eventPhase=EventPhase.AT_TARGET;
			_stopsImmediatePropagation=false;
			_stopsPropagation=false;
			_target=null;
			
			_defaultPrevented=false;
		}
		
		public function get bubbles():Boolean
		{
			return _bubbles;
		}
		
		public function get cancelable():Boolean
		{
			return _cancelable;
		}
		
		public function get currentTarget():Object
		{
			return _currentTarget;
		}
		
		public function get eventPhase():uint
		{
			return _eventPhase;
		}
		
		public function get target():Object
		{
			return _target;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function clone():Event
		{
			return (new Event(_type,_bubbles,_cancelable));
		}
		
		public function formatToString(className:String,...arguments):String
		{
			var str:String="["+className;
			var len:int=arguments.length;
			for(var i:int=0;i<len;i++)
			{
				var name:String=arguments[i];
				var value:Object=this[name];
				if(value is String)
				{
					str+=" "+name+"=\""+value+"\"";
				}
				else
				{
					str+=" "+name+"="+value.toString();
				}
			}
			str+="]";
			return str;
		}
		
		public function isDefaultPrevented():Boolean
		{
			return _defaultPrevented;
		}
		
		public function preventDefault():void
		{
			if(_cancelable)
			{
				_defaultPrevented=true;
			}
		}
		
		public function stopImmediatePropagation():void
		{
			_stopsImmediatePropagation=true;
			_stopsPropagation=true;
		}
		
		public function stopPropagation():void
		{
			_stopsPropagation=true;
		}
		
		public function toString():String
		{
			return (formatToString("Event","type","bubbles","cancelable"));
		}
		
	}
	
}