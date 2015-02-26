package garden.managers.windows_like.content_managers
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import garden.events.PropertyChangeEvent;
	import garden.widgets.contents.Button;
	
	import garden.managers.windows_like.Manager;
	import garden.managers.windows_like.utils.sliceBitmapData;
	
	public class ButtonManager extends ContentManager
	{
		
		[Embed(source="../assets/button.png")]
		private static const ButtonBitmap:Class;
		
		private static const VEC_BMD_BUTTON:Vector.<BitmapData>=sliceBitmapData((new ButtonBitmap()).bitmapData,7,7);
		
		private var _button:Button;
		
		public function ButtonManager(button:Button,manager:Manager)
		{
			super(button,manager);
			
			_button=button;
			
			graphics.beginFill(0xff0000);
			graphics.drawRect(0,0,_button.width,_button.height);
			graphics.endFill();
			
			_button.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onButtonPropertyChange);
		}
		
		override public function dispose():void
		{
			_button.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onButtonPropertyChange);
			_button=null;
			
			super.dispose();
		}
		
		private function onButtonPropertyChange(e:PropertyChangeEvent):void
		{	
			
		}
		
	}
	
}