package garden.managers.windows_like.content_managers
{
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import garden.events.PropertyChangeEvent;
	import garden.widgets.contents.MovieBox;
	import garden.widgets.contents.MovieBoxAlign;
	import garden.widgets.contents.MovieBoxScaleMode;
	
	import garden.managers.windows_like.Manager;
	
	public class MovieBoxManager extends ContentManager
	{
		
		private var _movieBox:MovieBox;
		
		private var _mask:Shape;
		private var _sprite:Sprite;
		
		public function MovieBoxManager(movieBox:MovieBox,manager:Manager)
		{
			super(movieBox,manager);
			
			_movieBox=movieBox;
			
			graphics.beginFill(_movieBox.backgroundColor,_movieBox.background?1:0);
			graphics.drawRect(0,0,_movieBox.width,_movieBox.height);
			graphics.endFill();
			
			_mask=new Shape();
			_mask.graphics.beginFill(0x000000,0);
			_mask.graphics.drawRect(0,0,_movieBox.width,_movieBox.height);
			_mask.graphics.endFill();
			addChild(_mask);
			mask=_mask;
			
			_sprite=new Sprite();
			_sprite.tabChildren=false;
			if(_movieBox.movie)
			{
				_sprite.addChild(_movieBox.movie);
			}
			scale();
			align();
			addChild(_sprite);
			
			_movieBox.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onMovieBoxPropertyChange);
		}
		
		override public function dispose():void
		{
			_movieBox.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onMovieBoxPropertyChange);
			_movieBox=null;
			
			super.dispose();
		}
		
		private function onMovieBoxPropertyChange(e:PropertyChangeEvent):void
		{	
			switch(e.propertyName)
			{
				case "align":
					align();
					break;
				case "background":
				case "backgroundColor":
					graphics.clear();
					graphics.beginFill(_movieBox.backgroundColor,_movieBox.background?1:0);
					graphics.drawRect(0,0,_movieBox.width,_movieBox.height);
					graphics.endFill();
					break;
				case "height":
					graphics.clear();
					graphics.beginFill(_movieBox.backgroundColor,_movieBox.background?1:0);
					graphics.drawRect(0,0,_movieBox.width,_movieBox.height);
					graphics.endFill();
					
					_mask.graphics.clear();
					_mask.graphics.beginFill(0x000000,0);
					_mask.graphics.drawRect(0,0,_movieBox.width,_movieBox.height);
					_mask.graphics.endFill();
					
					scale();
					align();
					break;
				case "movie":
					if(e.oldValue as DisplayObject)
					{
						_sprite.removeChild(e.oldValue as DisplayObject);
					}
					if(_movieBox.movie)
					{
						_sprite.addChild(_movieBox.movie);
					}
					
					scale();
					align();
					break;
				case "movieHeight":
				case "movieWidth":
					scale();
					align();
					break;
				case "scaleMode":
					scale();
					align();
					break;
				case "width":
					graphics.clear();
					graphics.beginFill(_movieBox.backgroundColor,_movieBox.background?1:0);
					graphics.drawRect(0,0,_movieBox.width,_movieBox.height);
					graphics.endFill();
					
					_mask.graphics.clear();
					_mask.graphics.beginFill(0x000000,0);
					_mask.graphics.drawRect(0,0,_movieBox.width,_movieBox.height);
					_mask.graphics.endFill();
					
					scale();
					align();
					break;
			}
		}
		
		private function align():void
		{
			switch(_movieBox.align)
			{
				case MovieBoxAlign.TOP:
					_sprite.x=(_movieBox.width-_movieBox.movieWidth*_sprite.scaleX)/2;
					_sprite.y=0;
					break;
				case MovieBoxAlign.BOTTOM:
					_sprite.x=(_movieBox.width-_movieBox.movieWidth*_sprite.scaleX)/2;
					_sprite.y=_movieBox.height-_movieBox.movieHeight*_sprite.scaleY;
					break;
				case MovieBoxAlign.LEFT:
					_sprite.x=0;
					_sprite.y=Math.floor((_movieBox.height-_movieBox.movieHeight*_sprite.scaleY)/2);
					break;
				case MovieBoxAlign.RIGHT:
					_sprite.x=_movieBox.width-_movieBox.movieWidth*_sprite.scaleX;
					_sprite.y=Math.floor((_movieBox.height-_movieBox.movieHeight*_sprite.scaleY)/2);
					break;
				case MovieBoxAlign.TOP_LEFT:
					_sprite.x=0;
					_sprite.y=0;
					break;
				case MovieBoxAlign.TOP_RIGHT:
					_sprite.x=_movieBox.width-_movieBox.movieWidth*_sprite.scaleX;
					_sprite.y=0;
					break;
				case MovieBoxAlign.BOTTOM_LEFT:
					_sprite.x=0;
					_sprite.y=_movieBox.height-_movieBox.movieHeight*_sprite.scaleY;
					break;
				case MovieBoxAlign.BOTTOM_RIGHT:
					_sprite.x=_movieBox.width-_movieBox.movieWidth*_sprite.scaleX;
					_sprite.y=_movieBox.height-_movieBox.movieHeight*_sprite.scaleY;
					break;
				default:
					_sprite.x=Math.floor((_movieBox.width-_movieBox.movieWidth*_sprite.scaleX)/2);
					_sprite.y=Math.floor((_movieBox.height-_movieBox.movieHeight*_sprite.scaleY)/2);
			}
		}
		
		private function scale():void
		{
			switch(_movieBox.scaleMode)
			{
				case MovieBoxScaleMode.EXACT_FIT:
					_sprite.scaleX=_movieBox.width/_movieBox.movieWidth;
					_sprite.scaleY=_movieBox.height/_movieBox.movieHeight;
					break;
				case MovieBoxScaleMode.NO_BORDER:
					if(_movieBox.width/_movieBox.height>=_movieBox.movieWidth/_movieBox.movieHeight)
					{
						_sprite.scaleX=_movieBox.width/_movieBox.movieWidth;
						_sprite.scaleY=_movieBox.width/_movieBox.movieWidth;
					}
					else
					{
						_sprite.scaleX=_movieBox.height/_movieBox.movieHeight;
						_sprite.scaleY=_movieBox.height/_movieBox.movieHeight;
					}
					break;
				case MovieBoxScaleMode.NO_SCALE:
					_sprite.scaleX=1;
					_sprite.scaleY=1;
					break;
				default:	//MovieBoxScaleMode.SHOW_ALL
					if(_movieBox.width/_movieBox.height>=_movieBox.movieWidth/_movieBox.movieHeight)
					{
						_sprite.scaleX=_movieBox.height/_movieBox.movieHeight;
						_sprite.scaleY=_movieBox.height/_movieBox.movieHeight;
					}
					else
					{
						_sprite.scaleX=_movieBox.width/_movieBox.movieWidth;
						_sprite.scaleY=_movieBox.width/_movieBox.movieWidth;
					}
			}
		}
		
	}
	
}