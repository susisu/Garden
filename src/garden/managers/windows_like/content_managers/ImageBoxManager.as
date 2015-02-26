package garden.managers.windows_like.content_managers
{
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	
	import garden.events.PropertyChangeEvent;
	import garden.widgets.contents.ImageBox;
	import garden.widgets.contents.ImageBoxAlign;
	import garden.widgets.contents.ImageBoxScaleMode;
	
	import garden.managers.windows_like.Manager;
	
	public class ImageBoxManager extends ContentManager
	{
		
		private var _imageBox:ImageBox;
		
		private var _mask:Shape;
		private var _bitmap:Bitmap;
		
		public function ImageBoxManager(imageBox:ImageBox,manager:Manager)
		{
			super(imageBox,manager);
			
			_imageBox=imageBox;
			
			graphics.beginFill(_imageBox.backgroundColor,_imageBox.background?1:0);
			graphics.drawRect(0,0,_imageBox.width,_imageBox.height);
			graphics.endFill();
			
			_mask=new Shape();
			_mask.graphics.beginFill(0x000000,0);
			_mask.graphics.drawRect(0,0,_imageBox.width,_imageBox.height);
			_mask.graphics.endFill();
			addChild(_mask);
			mask=_mask;
			
			_bitmap=new Bitmap(_imageBox.image,"auto",true);
			scale();
			align();
			addChild(_bitmap);
			
			_imageBox.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onImageBoxPropertyChange);
		}
		
		override public function dispose():void
		{
			_imageBox.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onImageBoxPropertyChange);
			_imageBox=null;
			
			super.dispose();
		}
		
		private function onImageBoxPropertyChange(e:PropertyChangeEvent):void
		{	
			switch(e.propertyName)
			{
				case "align":
					align();
					break;
				case "background":
				case "backgroundColor":
					graphics.clear();
					graphics.beginFill(_imageBox.backgroundColor,_imageBox.background?1:0);
					graphics.drawRect(0,0,_imageBox.width,_imageBox.height);
					graphics.endFill();
					break;
				case "height":
					graphics.clear();
					graphics.beginFill(_imageBox.backgroundColor,_imageBox.background?1:0);
					graphics.drawRect(0,0,_imageBox.width,_imageBox.height);
					graphics.endFill();
					
					_mask.graphics.clear();
					_mask.graphics.beginFill(0x000000,0);
					_mask.graphics.drawRect(0,0,_imageBox.width,_imageBox.height);
					_mask.graphics.endFill();
					
					scale();
					align();
					break;
				case "image":
					_bitmap.bitmapData=_imageBox.image;
					
					scale();
					align();
					break;
				case "scaleMode":
					scale();
					align();
					break;
				case "width":
					graphics.clear();
					graphics.beginFill(_imageBox.backgroundColor,_imageBox.background?1:0);
					graphics.drawRect(0,0,_imageBox.width,_imageBox.height);
					graphics.endFill();
					
					_mask.graphics.clear();
					_mask.graphics.beginFill(0x000000,0);
					_mask.graphics.drawRect(0,0,_imageBox.width,_imageBox.height);
					_mask.graphics.endFill();
					
					scale();
					align();
					break;
			}
		}
		
		private function align():void
		{
			switch(_imageBox.align)
			{
				case ImageBoxAlign.TOP:
					_bitmap.x=(_imageBox.width-_bitmap.width)/2;
					_bitmap.y=0;
					break;
				case ImageBoxAlign.BOTTOM:
					_bitmap.x=(_imageBox.width-_bitmap.width)/2;
					_bitmap.y=_imageBox.height-_bitmap.height;
					break;
				case ImageBoxAlign.LEFT:
					_bitmap.x=0;
					_bitmap.y=(_imageBox.height-_bitmap.height)/2;
					break;
				case ImageBoxAlign.RIGHT:
					_bitmap.x=_imageBox.width-_bitmap.width;
					_bitmap.y=(_imageBox.height-_bitmap.height)/2;
					break;
				case ImageBoxAlign.TOP_LEFT:
					_bitmap.x=0;
					_bitmap.y=0;
					break;
				case ImageBoxAlign.TOP_RIGHT:
					_bitmap.x=_imageBox.width-_bitmap.width;
					_bitmap.y=0;
					break;
				case ImageBoxAlign.BOTTOM_LEFT:
					_bitmap.x=0;
					_bitmap.y=_imageBox.height-_bitmap.height;
					break;
				case ImageBoxAlign.BOTTOM_RIGHT:
					_bitmap.x=_imageBox.width-_bitmap.width;
					_bitmap.y=_imageBox.height-_bitmap.height;
					break;
				default:
					_bitmap.x=(_imageBox.width-_bitmap.width)/2;
					_bitmap.y=(_imageBox.height-_bitmap.height)/2;
			}
		}
		
		private function scale():void
		{
			switch(_imageBox.scaleMode)
			{
				case ImageBoxScaleMode.EXACT_FIT:
					_bitmap.width=_imageBox.width;
					_bitmap.height=_imageBox.height;
					break;
				case ImageBoxScaleMode.NO_BORDER:
					if(_imageBox.image)
					{
						if(_imageBox.width/_imageBox.height>=_imageBox.image.width/_imageBox.image.height)
						{
							_bitmap.width=_imageBox.width;
							_bitmap.height=_imageBox.width*_imageBox.image.height/_imageBox.image.width;
						}
						else
						{
							_bitmap.width=_imageBox.height*_imageBox.image.width/_imageBox.image.height;
							_bitmap.height=_imageBox.height;
						}
					}
					else
					{
						_bitmap.width=_imageBox.width;
						_bitmap.height=_imageBox.height;
					}
					break;
				case ImageBoxScaleMode.NO_SCALE:
					_bitmap.width=_imageBox.image.width;
					_bitmap.height=_imageBox.image.height;
					break;
				default:	//ImageBoxScaleMode.SHOW_ALL
					if(_imageBox.image)
					{
						if(_imageBox.width/_imageBox.height>=_imageBox.image.width/_imageBox.image.height)
						{
							_bitmap.width=_imageBox.height*_imageBox.image.width/_imageBox.image.height;
							_bitmap.height=_imageBox.height;
						}
						else
						{
							_bitmap.width=_imageBox.width;
							_bitmap.height=_imageBox.width*_imageBox.image.height/_imageBox.image.width;
						}
					}
					else
					{
						_bitmap.width=_imageBox.width;
						_bitmap.height=_imageBox.height;
					}
			}
		}
		
	}
	
}