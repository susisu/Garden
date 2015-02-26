package garden.managers.windows_like.content_managers
{
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import garden.events.PropertyChangeEvent;
	import garden.widgets.contents.Content;
	
	import garden.managers.windows_like.Manager;
	import garden.managers.windows_like.Viewport;
	
	public class ContentManager extends Sprite
	{
		
		protected var _content:Content;
		protected var _manager:Manager;
		
		private var _tooltipTimer:Timer;
		
		public function ContentManager(content:Content,manager:Manager)
		{
			_content=content;
			_content.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onContentPropertyChange);
			_manager=manager;
			
			_tooltipTimer=new Timer(500,1);
			_tooltipTimer.addEventListener(TimerEvent.TIMER,onTooltipTimer);
			
			alpha=_content.alpha;
			mouseEnabled=_content.mouseEnabled;
			rotation=_content.rotation;
			tabEnabled=_content.tabEnabled;
			tabIndex=_content.tabIndex;
			visible=_content.visible;
			x=Math.floor(_content.x);
			y=Math.floor(_content.y);
			if(_content.tooltipText!=null)
			{
				addTooltipListeners();
			}
		}
		
		public function dispose():void
		{
			_content.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onContentPropertyChange);
			_content=null;
		}
		
		private function onContentPropertyChange(e:PropertyChangeEvent):void
		{
			switch(e.propertyName)
			{
				case "alpha":
					alpha=_content.alpha;
					break;
				case "mouseEnabled":
					mouseEnabled=_content.mouseEnabled;
					break;
				case "rotation":
					rotation=_content.rotation;
					break;
					tabEnabled=_content.tabEnabled;
				case "tabIndex":
					tabIndex=_content.tabIndex;
					break;
				case "tooltipText":
					if(_content.tooltipText!=null)
					{
						addTooltipListeners();
					}
					else
					{
						removeTooltipListeners();
						_manager.hideTooltip();
					}
					break;
				case "visible":
					visible=_content.visible;
					break;
				case "x":
					x=Math.floor(_content.x);
					break;
				case "y":
					y=Math.floor(_content.y);
					break;
			}
		}
		
		private function addTooltipListeners():void
		{
			addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			addEventListener(MouseEvent.ROLL_OUT,onRollOut);
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		private function removeTooltipListeners():void
		{
			removeEventListener(MouseEvent.ROLL_OVER,onRollOver);
			removeEventListener(MouseEvent.ROLL_OUT,onRollOut);
			removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			_tooltipTimer.reset();
			_tooltipTimer.start();
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			_manager.hideTooltip();
			_tooltipTimer.stop();
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			_manager.hideTooltip();
			_tooltipTimer.reset();
			_tooltipTimer.start();
		}
		
		private function onTooltipTimer(e:TimerEvent):void
		{
			var viewport:Viewport=_manager.viewport as Viewport;
			_manager.showTooltip(_content.tooltipText,viewport.mouseX,viewport.mouseY+20);
			_tooltipTimer.stop();
		}
		
	}
	
}