package garden.managers.windows_like.utils
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class FrameBitmap extends Bitmap
	{
		
		private var _bitmapData:BitmapData;
		private var _scale9Grid:Rectangle;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _smoothing:Boolean;
		
		private var _originalHeight:Number;
		private var _originalWidth:Number;
		private var _scaledBitmapData:BitmapData;
		
		public function FrameBitmap(bitmapData:BitmapData=null,pixelSnapping:String="auto",smoothing:Boolean=false)
		{
			super(bitmapData,pixelSnapping,smoothing);
			
			_bitmapData=bitmapData;
			_scale9Grid=null;
			_scaleX=1;
			_scaleY=1;
			_smoothing=smoothing;
			
			if(bitmapData)
			{
				_originalHeight=bitmapData.height;
				_originalWidth=bitmapData.width;
			}
			else
			{
				_originalHeight=0;
				_originalWidth=0;
			}
			_scaledBitmapData=null;
		}
		
		override public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}
		override public function set bitmapData(value:BitmapData):void
		{
			_bitmapData=value;
			if(value)
			{
				_originalHeight=value.height;
				_originalWidth=value.width;
			}
			else
			{
				_originalHeight=0;
				_originalWidth=0;
			}
			refresh();
		}
		
		override public function get height():Number
		{
			if(_bitmapData)
			{
				return _scaleY*_originalHeight;
			}
			else
			{
				return 0;
			}
		}
		override public function set height(value:Number):void
		{
			if(_bitmapData)
			{
				_scaleY=value/_originalHeight;
				refresh();
			}
			else
			{
				_scaleY=0;
			}
		}
		
		override public function get scale9Grid():Rectangle
		{
			if(_scale9Grid)
			{
				return _scale9Grid.clone();
			}
			else
			{
				return null;
			}
		}
		override public function set scale9Grid(value:Rectangle):void
		{
			if(value)
			{
				if(value.x+value.width>_originalWidth || value.y+value.height>_originalHeight)
				{
					throw (new ArgumentError("the parameter is invalid"));
				}
				else
				{
					_scale9Grid=value.clone();
				}
			}
			else
			{
				_scale9Grid=null;
			}
			refresh();
		}
		
		override public function get scaleX():Number
		{
			return _scaleX;
		}
		override public function set scaleX(value:Number):void
		{
			_scaleX=value;
			refresh();
		}
		
		override public function get scaleY():Number
		{
			return _scaleY;
		}
		override public function set scaleY(value:Number):void
		{
			_scaleY=value;
			refresh();
		}
		
		override public function get smoothing():Boolean
		{
			return _smoothing;
		}
		override public function set smoothing(value:Boolean):void
		{
			_smoothing=value;
		}
		
		override public function get width():Number
		{
			if(_bitmapData)
			{
				return _scaleX*_originalWidth;
			}
			else
			{
				return 0;
			}
		}
		override public function set width(value:Number):void
		{
			if(_bitmapData)
			{
				_scaleX=value/_originalWidth;
				refresh();
			}
			else
			{
				_scaleX=0;
			}
		}
		
		private function refresh():void
		{
			if(!_bitmapData || !_scale9Grid || _scaleX==0 || _scaleY==0)
			{
				super.bitmapData=_bitmapData;
				super.scaleX=_scaleX;
				super.scaleY=_scaleY;
				super.smoothing=_smoothing;
			}
			else
			{
				var transparent:Boolean=_bitmapData.transparent;
				var width:Number=Math.abs(this.width);
				var height:Number=Math.abs(this.height);
				var xSign:int=this.width>0 ? 1 : -1;
				var ySign:int=this.height>0 ? 1 : -1;
				
				var gridCenterWidth:Number=_scale9Grid.width;
				var gridCenterHeight:Number=_scale9Grid.height;
				var gridLeftWidth:Number=_scale9Grid.x;
				var gridRightWidth:Number=_originalWidth-_scale9Grid.x-_scale9Grid.width;
				var gridTopHeight:Number=_scale9Grid.y;
				var gridBottomHeight:Number=_originalHeight-_scale9Grid.y-_scale9Grid.height;
				
				var centerWidth:Number=Math.max(0,width-gridLeftWidth-gridRightWidth);
				var centerHeight:Number=Math.max(0,height-gridTopHeight-gridBottomHeight);
				var leftWidth:Number=centerWidth>0 ? gridLeftWidth : width*gridLeftWidth/(gridLeftWidth+gridRightWidth);
				var rightWidth:Number=centerWidth>0 ? gridRightWidth : width*gridRightWidth/(gridLeftWidth+gridRightWidth);
				var topHeight:Number=centerHeight>0 ? gridTopHeight : height*gridTopHeight/(gridTopHeight+gridBottomHeight);
				var bottomHeight:Number=centerHeight>0 ? gridBottomHeight : height*gridBottomHeight/(gridTopHeight+gridBottomHeight);
				
				if(!_scaledBitmapData || _scaledBitmapData.width!=Math.ceil(width) || _scaledBitmapData.height!=Math.ceil(height))
				{
					if(_scaledBitmapData)
					{
						_scaledBitmapData.dispose();
					}
					_scaledBitmapData=new BitmapData(Math.ceil(width),Math.ceil(height),transparent,0x00000000);
				}
				else
				{
					_scaledBitmapData.fillRect(_scaledBitmapData.rect,0x00000000);
				}
				
				_scaledBitmapData.lock();
				
				var matrix:Matrix=new Matrix(1,0,0,1,0,0);
				var rect:Rectangle=new Rectangle(0,0,0,0);
				
				//top
				matrix.d=topHeight/gridTopHeight;
				matrix.ty=0;
				rect.y=0;
				rect.height=topHeight;
				//top left
				matrix.a=leftWidth/gridLeftWidth;
				matrix.tx=0;
				rect.x=0;
				rect.width=leftWidth;
				_scaledBitmapData.draw(_bitmapData,matrix,null,null,rect,smoothing);
				
				//top center
				matrix.a=centerWidth/gridCenterWidth;
				matrix.tx=leftWidth-gridLeftWidth*centerWidth/gridCenterWidth;
				rect.x=leftWidth;
				rect.width=centerWidth;
				_scaledBitmapData.draw(_bitmapData,matrix,null,null,rect,smoothing);
				
				//top right
				matrix.a=rightWidth/gridRightWidth;
				matrix.tx=leftWidth+centerWidth-(gridLeftWidth+gridCenterWidth)*rightWidth/gridRightWidth;
				rect.x=leftWidth+centerWidth;
				rect.width=rightWidth;
				_scaledBitmapData.draw(_bitmapData,matrix,null,null,rect,smoothing);
				
				//center
				matrix.d=centerHeight/gridCenterHeight;
				matrix.ty=topHeight-gridTopHeight*centerHeight/gridCenterHeight;
				rect.y=topHeight;
				rect.height=centerHeight;
				//center left
				matrix.a=leftWidth/gridLeftWidth;
				matrix.tx=0;
				rect.x=0;
				rect.width=leftWidth;
				_scaledBitmapData.draw(_bitmapData,matrix,null,null,rect,smoothing);
				/*
				//center center
				matrix.a=centerWidth/gridCenterWidth;
				matrix.tx=leftWidth-gridLeftWidth*centerWidth/gridCenterWidth;
				rect.x=leftWidth;
				rect.width=centerWidth;
				_scaledBitmapData.draw(_bitmapData,matrix,null,null,rect,smoothing);
				*/
				//center right
				matrix.a=rightWidth/gridRightWidth;
				matrix.tx=leftWidth+centerWidth-(gridLeftWidth+gridCenterWidth)*rightWidth/gridRightWidth;
				rect.x=leftWidth+centerWidth;
				rect.width=rightWidth;
				_scaledBitmapData.draw(_bitmapData,matrix,null,null,rect,smoothing);
				
				//bottom
				matrix.d=bottomHeight/gridBottomHeight;
				matrix.ty=topHeight+centerHeight-(gridTopHeight+gridCenterHeight)*bottomHeight/gridBottomHeight;
				rect.y=topHeight+centerHeight;
				rect.height=bottomHeight;
				//bottom left
				matrix.a=leftWidth/gridLeftWidth;
				matrix.tx=0;
				rect.x=0;
				rect.width=leftWidth;
				_scaledBitmapData.draw(_bitmapData,matrix,null,null,rect,smoothing);
				
				//bottom center
				matrix.a=centerWidth/gridCenterWidth;
				matrix.tx=leftWidth-gridLeftWidth*centerWidth/gridCenterWidth;
				rect.x=leftWidth;
				rect.width=centerWidth;
				_scaledBitmapData.draw(_bitmapData,matrix,null,null,rect,smoothing);
				
				//bottom right
				matrix.a=rightWidth/gridRightWidth;
				matrix.tx=leftWidth+centerWidth-(gridLeftWidth+gridCenterWidth)*rightWidth/gridRightWidth;
				rect.x=leftWidth+centerWidth;
				rect.width=rightWidth;
				_scaledBitmapData.draw(_bitmapData,matrix,null,null,rect,smoothing);
				
				_scaledBitmapData.unlock();
				
				super.bitmapData=_scaledBitmapData;
				super.scaleX=xSign;
				super.scaleY=ySign;
				super.smoothing=_smoothing;
			}
		}
		
	}
	
}