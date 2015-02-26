package garden.managers.windows_like.content_managers
{
	
	import garden.events.PropertyChangeEvent;
	import garden.widgets.contents.Panel;
	
	import garden.managers.windows_like.Manager;
	
	public class PanelManager extends ContainerManager
	{
		
		private var _panel:Panel;
		
		public function PanelManager(panel:Panel,manager:Manager)
		{
			super(panel,manager);
			
			_panel=panel;
			
			if(_panel.background)
			{
				graphics.beginFill(_panel.backgroundColor);
				graphics.drawRect(0,0,_panel.width,_panel.height);
				graphics.endFill();
			}
			
			_panel.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onPanelPropertyChange);
		}
		
		override public function dispose():void
		{
			_panel.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onPanelPropertyChange);
			_panel=null;
			
			super.dispose();
		}
		
		private function onPanelPropertyChange(e:PropertyChangeEvent):void
		{	
			switch(e.propertyName)
			{
				case "backgorund":
				case "backgroundColor":
				case "height":
				case "width":
					graphics.clear();
					if(_panel.background)
					{
						graphics.beginFill(_panel.backgroundColor);
						graphics.drawRect(0,0,_panel.width,_panel.height);
						graphics.endFill();
					}
					break;
			}
		}
		
	}
	
}