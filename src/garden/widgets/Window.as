package garden.widgets
{
	
	import flash.display.BitmapData;
	
	import garden.garden_internal;
	import garden.events.Event;
	import garden.events.PropertyChangeEvent;
	import garden.events.WindowEvent;
	import garden.system.Application;
	import garden.widgets.contents.ContainerOfWindow;
	
	public class Window extends WidgetBase
	{
		
		private var _application:Application;
		private var _parent:Window;
		private var _children:Vector.<Window>;
		
		private var _container:ContainerOfWindow;
		
		private var _activateOnFocus:Boolean;
		private var _alpha:Number;
		private var _background:Boolean;
		private var _caption:String;
		private var _enabled:Boolean;
		private var _height:Number;
		private var _icon:BitmapData;
		private var _maximizable:Boolean;
		private var _maximized:Boolean;
		private var _minimizable:Boolean;
		private var _minimized:Boolean;
		private var _modal:Boolean;
		private var _position:String;
		private var _prioritizeContainerSize:Boolean;
		private var _resizable:Boolean;
		private var _showFrame:Boolean;
		private var _visible:Boolean;
		private var _width:Number;
		private var _x:Number;
		private var _y:Number;
		
		public function Window()
		{
			super();
			
			_application=null;
			_parent=null;
			_children=new Vector.<Window>();
			
			_container=new ContainerOfWindow(this);
			_container.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onContainerPropertyChange);
			
			_activateOnFocus=true;
			_alpha=1;
			_background=true;
			_caption="";
			_enabled=true;
			_height=0;
			_icon=null;
			_maximizable=true;
			_maximized=false;
			_minimizable=true;
			_minimized=false;
			_modal=false;
			_position=WindowPosition.DEFAULT;
			_prioritizeContainerSize=false;
			_resizable=true;
			_showFrame=true;
			_visible=true;
			_width=0;
			_x=NaN;
			_y=NaN;
		}
		
		// getter/setter properties
		public function get activateOnFocus():Boolean
		{
			return _activateOnFocus;
		}
		public function set activateOnFocus(value:Boolean):void
		{
			var oldValue:Object=_activateOnFocus;
			_activateOnFocus=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"activateOnFocus",oldValue,value));
		}
		public function get alpha():Number
		{
			return _alpha;
		}
		public function set alpha(value:Number):void
		{
			var oldValue:Object=_alpha;
			_alpha=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"alpha",oldValue,value));
		}
		
		public function get application():Application
		{
			return _application;
		}
		
		public function get background():Boolean
		{
			return _background;
		}
		public function set background(value:Boolean):void
		{
			var oldValue:Object=_background;
			_background=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"background",oldValue,value));
		}
		
		public function get caption():String
		{
			return _caption;
		}
		public function set caption(value:String):void
		{
			if(value==null){
				throw (new TypeError("'caption' should not be null"));
			}
			var oldValue:Object=_caption;
			_caption=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"caption",oldValue,value));
		}
		
		public function get children():Vector.<Window>
		{
			return _children.slice();
		}
		
		public function get container():ContainerOfWindow
		{
			return _container;
		}
		
		public function get containerHeight():Number
		{
			return _container.height;
		}
		public function set containerHeight(value:Number):void
		{
			var oldValue:Object=_container.height;
			_container.height=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"containerHeight",oldValue,value));
		}
		
		public function get containerWidth():Number
		{
			return _container.width;
		}
		public function set containerWidth(value:Number):void
		{
			var oldValue:Object=_container.width;
			_container.width=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"containerWidth",oldValue,value));
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		public function set enabled(value:Boolean):void
		{
			var oldValue:Object=_enabled;
			_enabled=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"enabled",oldValue,value));
		}
		
		public function get height():Number
		{
			return _height;
		}
		public function set height(value:Number):void
		{
			var oldValue:Object=_height;
			_height=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"height",oldValue,value));
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
		
		public function get maximizable():Boolean
		{
			return _maximizable;
		}
		public function set maximizable(value:Boolean):void
		{
			var oldValue:Object=_maximizable;
			_maximizable=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"maximizable",oldValue,value));
		}
		
		public function get maximized():Boolean
		{
			return _maximized;
		}
		public function set maximized(value:Boolean):void
		{
			var oldValue:Object=_maximized;
			_maximized=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"maximized",oldValue,value));
		}
		
		public function get minimizable():Boolean
		{
			return _minimizable;
		}
		public function set minimizable(value:Boolean):void
		{
			var oldValue:Object=_minimizable;
			_minimizable=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"minimizable",oldValue,value));
		}
		
		public function get minimized():Boolean
		{
			return _minimized;
		}
		public function set minimized(value:Boolean):void
		{
			var oldValue:Object=_minimized;
			_minimized=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"minimized",oldValue,value));
		}
		
		public function get modal():Boolean
		{
			return _modal;
		}
		public function set modal(value:Boolean):void
		{
			var oldValue:Object=_modal;
			_modal=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"modal",oldValue,value));
		}
		
		public function get position():String
		{
			return _position;
		}
		public function set position(value:String):void
		{
			var oldValue:Object=_position;
			_position=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"position",oldValue,value));
		}
		
		public function get prioritizeContainerSize():Boolean
		{
			return _prioritizeContainerSize;
		}
		public function set prioritizeContainerSize(value:Boolean):void
		{
			var oldValue:Object=_prioritizeContainerSize;
			_prioritizeContainerSize=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"prioritizeContainerSize",oldValue,value));
		}
		
		public function get parent():Window
		{
			return _parent;
		}
		
		public function get resizable():Boolean
		{
			return _resizable;
		}
		public function set resizable(value:Boolean):void
		{
			var oldValue:Object=_resizable;
			_resizable=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"resizable",oldValue,value));
		}
		
		public function get showFrame():Boolean
		{
			return _showFrame;
		}
		public function set showFrame(value:Boolean):void
		{
			var oldValue:Object=_showFrame;
			_showFrame=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"showFrame",oldValue,value));
		}
		
		public function get visible():Boolean
		{
			return _visible;
		}
		public function set visible(value:Boolean):void
		{
			var oldValue:Object=_visible;
			_visible=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"visible",oldValue,value));
		}
		
		public function get width():Number
		{
			return _width;
		}
		public function set width(value:Number):void
		{
			var oldValue:Object=_width;
			_width=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"width",oldValue,value));
		}
		
		public function get x():Number
		{
			return _x;
		}
		public function set x(value:Number):void
		{
			var oldValue:Object=_x;
			_x=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"x",oldValue,value));
		}
		
		public function get y():Number
		{
			return _y;
		}
		public function set y(value:Number):void
		{
			var oldValue:Object=_y;
			_y=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"y",oldValue,value));
		}
		
		// methods
		public function addChildWindow(child:Window):void
		{
		}
		
		public function close(forceClose:Boolean=false):Boolean
		{
			if(_application!=null)
			{
				var accepted:Boolean=dispatchEvent(new Event(Event.CLOSE,false,!forceClose));
				if(accepted)
				{
					_application.closeWindow(this);
					dispatchEvent(new WindowEvent(WindowEvent.CLOSED));
				}
				return accepted;
			}
			else
			{
				throw (new Error("this window may have already closed, or be not added to application"));
				return false;
			}
		}
		
		public function removeChildWindow(child:Window):void
		{
		}
		
		garden_internal function setApplication(application:Application):void
		{
			_application=application;
		}
		
		private function onContainerPropertyChange(e:PropertyChangeEvent):void
		{
			switch(e.propertyName)
			{
				case "height":
					if(e.oldValue!=e.newValue)
					{
						dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"containerHeight",e.oldValue,e.newValue));
					}
					break;
				case "width":
					if(e.oldValue!=e.newValue)
					{
						dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"containerWidth",e.oldValue,e.newValue));
					}
					break;
			}
		}
		
	}
	
}