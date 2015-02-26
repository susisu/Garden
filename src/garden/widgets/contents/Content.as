package garden.widgets.contents
{
	
	import garden.events.EventNode;
	import garden.events.PropertyChangeEvent;
	import garden.widgets.WidgetBase;
	
	public class Content extends WidgetBase
	{
		
		internal var _parent:Container;
		
		private var _alpha:Number;
		private var _enabled:Boolean;
		private var _height:Number;
		private var _mouseEnabled:Boolean;
		private var _name:String;
		private var _rotation:Number;
		private var _tabEnabled:Boolean;
		private var _tabIndex:int;
		private var _tooltipText:String;
		private var _visible:Boolean;
		private var _width:Number;
		private var _x:Number;
		private var _y:Number;
		
		public function Content()
		{
			super();
			
			_parent=null;
			
			_alpha=1;
			_enabled=true;
			_height=0;
			_mouseEnabled=true;
			_name="";
			_rotation=0;
			_tabEnabled=false;
			_tabIndex=-1;
			_tooltipText=null;
			_visible=true;
			_width=0;
			_x=0;
			_y=0;
		}
		
		// getter/setter properties
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
		
		public function get containerOfWindow():ContainerOfWindow
		{
			return (root as ContainerOfWindow);
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
		
		public function get mouseEnabled():Boolean
		{
			return _mouseEnabled;
		}
		public function set mouseEnabled(value:Boolean):void
		{
			var oldValue:Object=_mouseEnabled;
			_mouseEnabled=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"mouseEnabled",oldValue,value));
		}
		
		public function get name():String
		{
			return _name;
		}
		public function set name(value:String):void
		{
			if(value==null){
				throw (new TypeError("'name' should not be null"));
			}
			var oldValue:Object=_name;
			_name=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"name",oldValue,value));
		}
		
		public function get parent():Container
		{
			return _parent;
		}
		
		override public function get parentEventNode():EventNode
		{
			return (_parent as EventNode);
		}
		
		public function get root():Content
		{
			if(_parent==null)
			{
				return this;
			}
			else
			{
				return _parent.root;
			}
		}
		
		public function get rotation():Number
		{
			return _rotation;
		}
		public function set rotation(value:Number):void
		{
			var oldValue:Object=_rotation;
			_rotation=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"rotation",oldValue,value));
		}
		
		public function get tabEnabled():Boolean
		{
			return _tabEnabled;
		}
		public function set tabEnabled(value:Boolean):void
		{
			var oldValue:Object=_tabEnabled;
			_tabEnabled=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"tabEnabled",oldValue,value));
		}
		
		public function get tabIndex():int
		{
			return _tabIndex;
		}
		public function set tabIndex(value:int):void
		{
			var oldValue:Object=_tabIndex;
			_tabIndex=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"tabIndex",oldValue,value));
		}
		
		public function get tooltipText():String
		{
			return _tooltipText;
		}
		public function set tooltipText(value:String):void
		{
			var oldValue:Object=_tooltipText;
			_tooltipText=value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,"tooltipText",oldValue,value));
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
		
		//methods
		public function getClass():Class
		{
			return Content;
		}
		
		public function copyParameters(target:Content=null):Content
		{
			var content:Content;
			if(target==null)
			{
				content=new Content();
			}
			else
			{
				content=target;
			}
			content.alpha=_alpha;
			content.enabled=_enabled;
			content.height=_height;
			content.mouseEnabled=_mouseEnabled;
			content.name=_name;
			content.rotation=_rotation;
			content.tabEnabled=_tabEnabled;
			content.tabIndex=_tabIndex;
			content.visible=_visible;
			content.width=_width;
			content.x=_x;
			content.y=_y;
			return content;
		}
		
	}
	
}