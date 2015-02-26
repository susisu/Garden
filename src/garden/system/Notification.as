package garden.system
{
	
	import flash.display.BitmapData;
	
	public class Notification extends Object
	{
		
		private var _text:String;
		private var _icon:BitmapData;
		
		public function Notification(text:String,icon:BitmapData=null)
		{
			_text=text;
			_icon=icon;
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function get icon():BitmapData
		{
			return _icon;
		}
		
	}
	
}