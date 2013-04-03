package garden.events
{
	
	public class EventDispatcher extends Object implements IEventDispatcher
	{
		
		private var _listeners:Object;
		private var _captureListeners:Object;
		
		private var _target:IEventDispatcher;
		
		public function EventDispatcher(target:IEventDispatcher=null)
		{
			_listeners=new Object();
			_captureListeners=new Object();
			
			_target=target;
		}
		
		private function getTarget():IEventDispatcher
		{
			if(_target==null)
			{
				return this;
			}
			else
			{
				return _target;
			}
		}
		
		public function addEventListener(type:String,listener:Function,useCapture:Boolean=false,priority:int=0,useWeakReference:Boolean=false):void
		{
			if(type==null)
			{
				throw (new TypeError("'type' should not be null."));
				return;
			}
			if(listener==null)
			{
				throw (new TypeError("'listener' should not be null."));
				return;
			}
			
			var list:Vector.<EventListener>;
			if(useCapture)
			{
				if(_captureListeners[type]==undefined)
				{
					_captureListeners[type]=new Vector.<EventListener>();
				}
				list=_captureListeners[type];
			}
			else
			{
				if(_listeners[type]==undefined)
				{
					_listeners[type]=new Vector.<EventListener>();
				}
				list=_listeners[type];
			}
			//if already listener is added, then not re-add
			//priority and useWeakReference doesn't change
			var numListeners:uint=list.length;
			for(var i:int=0;i<numListeners;i++)
			{
				if(list[i].listener==listener)
				{
					return;
				}
			}
			//index smaller is priority higher
			var eventListener:EventListener=new EventListener(listener,priority,useWeakReference);
			for(i=numListeners-1;i>=0;i--)
			{
				if(list[i].priority>=eventListener.priority)
				{
					list.splice(i+1,0,eventListener);
					return;
				}
			}
			list.unshift(eventListener);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			if(event==null)
			{
				throw (new TypeError("'event' should not be null."));
				return false;
			}
			
			event=event.clone();
			var type:String=event.type;
			event._target=getTarget();
			var list:Vector.<EventListener>;
			var numListeners:uint;
			var i:int;
			var j:int;
			var listenerFunc:Function;
			if(event.bubbles && this is EventNode)
			{
				var flow:Vector.<EventNode>=new Vector.<EventNode>();
				var node:EventNode=this as EventNode;
				flow.push(node);
				while(node.parentEventNode!=null)
				{
					node=node.parentEventNode;
					flow.push(node);
				}
				var flowLength:uint=flow.length;
				
				//capturing
				if(!event._stopsPropagation)
				{
					event._eventPhase=EventPhase.CAPTURING_PHASE;
					for(i=flowLength-1;i>0;i--)
					{
						node=flow[i];
						event._currentTarget=node.getTarget();
						list=node._captureListeners[type];
						if(list!=null)
						{
							numListeners=list.length;
							for(j=0;j<numListeners;j++)
							{
								listenerFunc=list[j].listener;
								if(listenerFunc==null)
								{
									list.splice(j,1);
									j--;
									numListeners--;
								}
								else
								{
									listenerFunc(event);
								}
								
								if(event._stopsImmediatePropagation){
									break;
								}
							}
						}
						if(event._stopsPropagation)
						{
							break;
						}
					}
				}
				
				//at target
				if(!event._stopsPropagation)
				{
					event._eventPhase=EventPhase.AT_TARGET;
					event._currentTarget=getTarget();
					list=_listeners[type];
					if(list!=null)
					{
						numListeners=list.length;
						for(i=0;i<numListeners;i++)
						{
							listenerFunc=list[i].listener;
							if(listenerFunc==null)
							{
								list.splice(i,1);
								i--;
								numListeners--;
							}
							else
							{
								listenerFunc(event);
							}
							
							if(event._stopsImmediatePropagation)
							{
								break;
							}
						}
					}
				}
				
				//bubbling
				if(!event._stopsPropagation)
				{
					event._eventPhase=EventPhase.BUBBLING_PHASE;
					for(i=1;i<flowLength;i++)
					{
						node=flow[i];
						event._currentTarget=node.getTarget();
						list=node._listeners[type];
						if(list!=null)
						{
							numListeners=list.length;
							for(j=0;j<numListeners;j++)
							{
								listenerFunc=list[j].listener;
								if(listenerFunc==null)
								{
									list.splice(j,1);
									j--;
									numListeners--;
								}
								else
								{
									listenerFunc(event);
								}
								
								if(event._stopsImmediatePropagation)
								{
									break;
								}
							}
						}
						if(event._stopsPropagation)
						{
							break;
						}
					}
				}
			}
			else
			{
				event._currentTarget=getTarget();
				list=_listeners[type];
				if(list!=null)
				{
					numListeners=list.length;
					for(i=0;i<numListeners;i++)
					{
						listenerFunc=list[i].listener;
						if(listenerFunc==null)
						{
							list.splice(i,1);
							i--;
							numListeners--;
						}
						else
						{
							listenerFunc(event);
						}
						
						if(event._stopsImmediatePropagation)
						{
							break;
						}
					}
				}
			}
			return !event.isDefaultPrevented();
		}
		
		public function hasEventListener(type:String):Boolean
		{
			if(type==null)
			{
				throw (new TypeError("'type' should not be null."));
				return false;
			}
			
			var num:int=0;
			if(_listeners[type]!=undefined)
			{
				var list:Vector.<EventListener>=_listeners[type];
				var numListeners:uint=list.length;
				for(var i:int=0;i<numListeners;i++)
				{
					if(list[i].listener==null)
					{
						list.splice(i,1);
						i--;
						numListeners--;
					}
					else
					{
						return true;
					}
				}
			}
			if(_captureListeners[type]!=undefined)
			{
				list=_captureListeners[type];
				numListeners=list.length;
				for(i=0;i<numListeners;i++)
				{
					if(list[i].listener==null)
					{
						list.splice(i,1);
						i--;
						numListeners--;
					}
					else
					{
						return true;
					}
				}
			}
			return false;
		}
		
		public function removeEventListener(type:String,listener:Function,useCapture:Boolean=false):void
		{
			if(type==null)
			{
				throw (new TypeError("'type' should not be null."));
				return;
			}
			if(listener==null)
			{
				throw (new TypeError("'listener' should not be null."));
				return;
			}
			
			var list:Vector.<EventListener>;
			if(useCapture)
			{
				if(_captureListeners[type]==undefined)
				{
					return;
				}
				list=_captureListeners[type];
			}
			else
			{
				if(_listeners[type]==undefined)
				{
					return;
				}
				list=_listeners[type];
			}
			
			var numListeners:uint=list.length;
			for(var i:int=0;i<numListeners;i++)
			{
				if(list[i].listener==null)
				{
					list.splice(i,1);
					i--;
					numListeners--;
				}
				else if(list[i].listener==listener)
				{
					var eventListener:EventListener=list.splice(i,1)[0];
					eventListener.deleteReference();
					return;
				}
			}
		}
		
		public function willTrigger(type:String):Boolean
		{
			if(type==null)
			{
				throw (new TypeError("'type' should not be null."));
				return false;
			}
			
			if(this is EventNode)
			{
				var node:EventNode=this as EventNode;
				while(node!=null)
				{
					if(node.hasEventListener(type))
					{
						return true;
					}
					node=node.parentEventNode;
				}
				return false;
			}
			else
			{
				return hasEventListener(type);
			}
			return false;
		}
		
	}
	
}

import garden.utils.WeakReference;

class EventListener extends Object
{
	
	public var priority:int;
	
	private var _useWeakReference:Boolean;
	private var _wr:WeakReference;
	private var _listener:Function;
	
	public function EventListener(listener:Function,priority:int,useWeakReference:Boolean=false)
	{
		this.priority=priority;
		
		_useWeakReference=useWeakReference;
		if(_useWeakReference)
		{
			_wr=new WeakReference(listener);
		}
		else
		{
			_listener=listener;
		}
	}
	
	public function get listener():Function
	{
		if(_useWeakReference)
		{
			return _wr.getValue() as Function;
		}
		else
		{
			return _listener;
		} 
	}
	
	public function deleteReference():void
	{
		_wr=null;
		_listener=null;
	}
	
}