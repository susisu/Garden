package garden.managers.windows_like
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class WindowLayer extends Sprite
	{
		
		private var _behindLayer:Sprite;
		private var _defaultLayer:Sprite;
		private var _frontLayer:Sprite;
		
		public function WindowLayer()
		{
			_behindLayer=new Sprite();
			addChild(_behindLayer);
			
			_defaultLayer=new Sprite();
			addChild(_defaultLayer);
			
			_frontLayer=new Sprite();
			addChild(_frontLayer);
		}
		
		public function setToLayer(child:DisplayObject,layerName:String="default"):DisplayObject
		{
			switch(layerName)
			{
				case "behind":
					_behindLayer.addChild(child);
					break;
				case "front":
					_frontLayer.addChild(child);
					break;
				default:
					_defaultLayer.addChild(child);
			}
			return child;
		}
		
	}
	
}