package garden.managers.windows_like
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	//import flash.display.BlendMode;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import garden.Screen;
	import garden.events.Event;
	import garden.events.PropertyChangeEvent;
	import garden.events.SystemEvent;
	import garden.events.WindowEvent;
	import garden.widgets.Window;
	import garden.widgets.WindowPosition;
	
	import garden.managers.windows_like.content_managers.ContentManager;
	import garden.managers.windows_like.content_managers.ContentManagerDictionary;
	import garden.managers.windows_like.utils.FrameBitmap;
	import garden.managers.windows_like.utils.sliceBitmapData;
	
	public class WindowManager extends Sprite
	{
		
		[Embed("assets/window_frame.png")]
		private static const WindowFrameBitmap:Class;
		[Embed("assets/window_frame_maximized.png")]
		private static const WindowFrameMaximizedBitmap:Class;
		[Embed("assets/window_closeButton.png")]
		private static const WindowCloseButtonBitmap:Class;
		[Embed("assets/window_maximizeButton.png")]
		private static const WindowMaximizeButtonBitmap:Class;
		[Embed("assets/window_minimizeButton.png")]
		private static const WindowMinimizeButtonBitmap:Class;
		
		private static const VEC_BMD_WINDOW_FRAME:Vector.<BitmapData>=sliceBitmapData((new WindowFrameBitmap()).bitmapData,13,34);
		private static const BMD_WINDOW_FRAME_D:BitmapData=VEC_BMD_WINDOW_FRAME[0];
		private static const BMD_WINDOW_FRAME_A:BitmapData=VEC_BMD_WINDOW_FRAME[1];
		private static const WINDOW_FRAME_SCALE_9_GRID:Rectangle=new Rectangle(6,27,1,1);
		
		private static const VEC_BMD_WINDOW_FRAME_MAXIMIZED:Vector.<BitmapData>=sliceBitmapData((new WindowFrameMaximizedBitmap()).bitmapData,1,22);
		private static const BMD_WINDOW_FRAME_MAXIMIZED_D:BitmapData=VEC_BMD_WINDOW_FRAME_MAXIMIZED[0];
		private static const BMD_WINDOW_FRAME_MAXIMIZED_A:BitmapData=VEC_BMD_WINDOW_FRAME_MAXIMIZED[1];
		private static const WINDOW_FRAME_MAXIMIZED_SCALE_9_GRID:Rectangle=new Rectangle(0,21,1,1);
		
		private static const VEC_BMD_WINDOW_CLOSE_BUTTON:Vector.<BitmapData>=sliceBitmapData((new WindowCloseButtonBitmap()).bitmapData,42,20);
		private static const BMD_WINDOW_CLOSE_BUTTON_D_UP:BitmapData=VEC_BMD_WINDOW_CLOSE_BUTTON[0];
		private static const BMD_WINDOW_CLOSE_BUTTON_D_OVER:BitmapData=VEC_BMD_WINDOW_CLOSE_BUTTON[1];
		private static const BMD_WINDOW_CLOSE_BUTTON_D_DOWN:BitmapData=VEC_BMD_WINDOW_CLOSE_BUTTON[2];
		private static const BMD_WINDOW_CLOSE_BUTTON_A_UP:BitmapData=VEC_BMD_WINDOW_CLOSE_BUTTON[3];
		private static const BMD_WINDOW_CLOSE_BUTTON_A_OVER:BitmapData=VEC_BMD_WINDOW_CLOSE_BUTTON[4];
		private static const BMD_WINDOW_CLOSE_BUTTON_A_DOWN:BitmapData=VEC_BMD_WINDOW_CLOSE_BUTTON[5];
		
		private static const VEC_BMD_WINDOW_MAXIMIZE_BUTTON:Vector.<BitmapData>=sliceBitmapData((new WindowMaximizeButtonBitmap()).bitmapData,24,20);
		private static const BMD_WINDOW_MAXIMIZE_BUTTON_D_UP:BitmapData=VEC_BMD_WINDOW_MAXIMIZE_BUTTON[0];
		private static const BMD_WINDOW_MAXIMIZE_BUTTON_D_OVER:BitmapData=VEC_BMD_WINDOW_MAXIMIZE_BUTTON[1];
		private static const BMD_WINDOW_MAXIMIZE_BUTTON_D_DOWN:BitmapData=VEC_BMD_WINDOW_MAXIMIZE_BUTTON[2];
		private static const BMD_WINDOW_MAXIMIZE_BUTTON_A_UP:BitmapData=VEC_BMD_WINDOW_MAXIMIZE_BUTTON[3];
		private static const BMD_WINDOW_MAXIMIZE_BUTTON_A_OVER:BitmapData=VEC_BMD_WINDOW_MAXIMIZE_BUTTON[4];
		private static const BMD_WINDOW_MAXIMIZE_BUTTON_A_DOWN:BitmapData=VEC_BMD_WINDOW_MAXIMIZE_BUTTON[5];
		
		private static const VEC_BMD_WINDOW_MINIMIZE_BUTTON:Vector.<BitmapData>=sliceBitmapData((new WindowMinimizeButtonBitmap()).bitmapData,24,20);
		private static const BMD_WINDOW_MINIMIZE_BUTTON_D_UP:BitmapData=VEC_BMD_WINDOW_MINIMIZE_BUTTON[0];
		private static const BMD_WINDOW_MINIMIZE_BUTTON_D_OVER:BitmapData=VEC_BMD_WINDOW_MINIMIZE_BUTTON[1];
		private static const BMD_WINDOW_MINIMIZE_BUTTON_D_DOWN:BitmapData=VEC_BMD_WINDOW_MINIMIZE_BUTTON[2];
		private static const BMD_WINDOW_MINIMIZE_BUTTON_A_UP:BitmapData=VEC_BMD_WINDOW_MINIMIZE_BUTTON[3];
		private static const BMD_WINDOW_MINIMIZE_BUTTON_A_OVER:BitmapData=VEC_BMD_WINDOW_MINIMIZE_BUTTON[4];
		private static const BMD_WINDOW_MINIMIZE_BUTTON_A_DOWN:BitmapData=VEC_BMD_WINDOW_MINIMIZE_BUTTON[5];
		
		private static const WINDOW_MIN_WIDTH:Number=160;
		private static const WINDOW_MIN_HEIGHT:Number=33;
		
		private static const WINDOW_LEFT_PADDING:Number=6;
		private static const WINDOW_RIGHT_PADDING:Number=6;
		private static const WINDOW_TOP_PADDING:Number=27;
		private static const WINDOW_MAXIMIZED_TOP_PADDING:Number=21;
		private static const WINDOW_BOTTOM_PADDING:Number=6;
		
		private static const CLOSE_BUTTON_WIDTH:Number=42;
		private static const MAXIMIZE_BUTTON_WIDTH:Number=24;
		private static const MINIMIZE_BUTTON_WIDTH:Number=24;
		
		private static var _windowOpenX:Number=10;
		private static var _windowOpenY:Number=10;
		
		private var _window:Window;
		private var _manager:Manager;
		
		private var _frameWrapper:Sprite;
		
		private var _frame:FrameBitmap;
		
		private var _caption:TextField;
		
		private var _icon:Bitmap;
		
		private var _buttons:Sprite;
		
		private var _closeButtonDUp:Bitmap;
		private var _closeButtonDOver:Bitmap;
		private var _closeButtonDDown:Bitmap;
		private var _closeButtonAUp:Bitmap;
		private var _closeButtonAOver:Bitmap;
		private var _closeButtonADown:Bitmap;
		private var _closeButton:SimpleButton;
		
		private var _maximizeButtonDUp:Bitmap;
		private var _maximizeButtonDOver:Bitmap;
		private var _maximizeButtonDDown:Bitmap;
		private var _maximizeButtonAUp:Bitmap;
		private var _maximizeButtonAOver:Bitmap;
		private var _maximizeButtonADown:Bitmap;
		private var _maximizeButton:SimpleButton;
		
		private var _minimizeButtonDUp:Bitmap;
		private var _minimizeButtonDOver:Bitmap;
		private var _minimizeButtonDDown:Bitmap;
		private var _minimizeButtonAUp:Bitmap;
		private var _minimizeButtonAOver:Bitmap;
		private var _minimizeButtonADown:Bitmap;
		private var _minimizeButton:SimpleButton;
		
		private var _contentWrapper:Sprite;
		private var _content:Sprite;
		
		private var _dropShadow:DropShadowFilter;
		
		//dragging (move, resize)
		private var _dragging:Boolean;
		private var _draggingMode:String;
		private var _startMouseX:Number;
		private var _startMouseY:Number;
		private var _startX:Number;
		private var _startY:Number;
		private var _startWidth:Number;
		private var _startHeight:Number;
		
		//maximize, minimize
		private var _originalX:Number;
		private var _originalY:Number;
		private var _originalWidth:Number;
		private var _originalHeight:Number;
		
		public function WindowManager(window:Window,manager:Manager)
		{
			_window=window;
			_manager=manager;
			
			_manager.system.addEventListener(SystemEvent.WINDOW_MAXIMIZING_RECT_CHANGE,onSystemWindowMaximizingRectChange);
			
			if(_window.maximized)
			{
				if(manager.system.windowMaximizingRect)
				{
					_window.x=manager.system.windowMaximizingRect.x;
					_window.y=manager.system.windowMaximizingRect.y;
					_window.width=manager.system.windowMaximizingRect.width;
					_window.height=manager.system.windowMaximizingRect.height;
				}
				else
				{
					_window.x=0;
					_window.y=0;
					_window.width=_manager.screen.width;
					_window.height=_manager.screen.height;
				}
				_window.containerWidth=Math.floor(_window.width);
				_window.containerHeight=Math.floor(_window.height-(_window.showFrame?WINDOW_MAXIMIZED_TOP_PADDING:0));
			}
			else
			{
				if(_window.prioritizeContainerSize)
				{
					if(_window.containerWidth+(_window.showFrame?WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING:0)<WINDOW_MIN_WIDTH)
					{
						_window.containerWidth=Math.floor(WINDOW_MIN_HEIGHT-(_window.showFrame?WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING:0));
						_window.width=WINDOW_MIN_WIDTH;
					}
					else
					{
						_window.width=_window.containerWidth+(_window.showFrame?WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING:0);
					}
					
					if(_window.containerHeight+(_window.showFrame?WINDOW_TOP_PADDING+WINDOW_BOTTOM_PADDING:0)<WINDOW_MIN_HEIGHT)
					{
						_window.containerHeight=Math.floor(WINDOW_MIN_HEIGHT-(_window.showFrame?WINDOW_TOP_PADDING+WINDOW_BOTTOM_PADDING:0));
						_window.height=WINDOW_MIN_HEIGHT;
					}
					else
					{
						_window.height=_window.containerHeight+(_window.showFrame?WINDOW_TOP_PADDING+WINDOW_BOTTOM_PADDING:0);
					}
				}
				else
				{
					if(_window.width<WINDOW_MIN_WIDTH)
					{
						_window.width=WINDOW_MIN_WIDTH;
					}
					if(_window.height<WINDOW_MIN_HEIGHT)
					{
						_window.height=WINDOW_MIN_HEIGHT;
					}
					_window.containerWidth=Math.floor(_window.width-(_window.showFrame?WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING:0));
					_window.containerHeight=Math.floor(_window.height-(_window.showFrame?WINDOW_TOP_PADDING+WINDOW_BOTTOM_PADDING:0));
				}
				if(isNaN(_window.x) || isNaN(_window.y))
				{
					if(_manager.system.windowMaximizingRect)
					{
						if(_windowOpenX+_window.width>_manager.system.windowMaximizingRect.width)
						{
							_windowOpenX=0;
						}
						if(_windowOpenY+_window.height>_manager.system.windowMaximizingRect.height)
						{
							_windowOpenY=0;
						}
						_window.x=_manager.system.windowMaximizingRect.x+_windowOpenX;
						_window.y=_manager.system.windowMaximizingRect.y+_windowOpenY;
					}
					else
					{
						if(_windowOpenX+_window.width>_manager.screen.width)
						{
							_windowOpenX=0;
						}
						if(_windowOpenY+_window.height>_manager.screen.height)
						{
							_windowOpenY=0;
						}
						_window.x=_windowOpenX;
						_window.y=_windowOpenY;
					}
					_windowOpenX+=20;
					_windowOpenY+=20;
				}
			}
			_window.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onWindowPropertyChange);
			_window.addEventListener(WindowEvent.ACTIVATE,onWindowActivate);
			_window.addEventListener(WindowEvent.DEACTIVATE,onWindowDeactivate);
			
			_manager.screen.addEventListener(Event.RESIZE,onScreenResize);
			(_manager.viewport as Viewport).addEventListener(MouseEvent.MOUSE_UP,onViewportMouseUp);
			(_manager.viewport as Viewport).addEventListener(MouseEvent.MOUSE_MOVE,onViewportMouseMove);
			
			graphics.beginFill(0xe0e0e0,_window.background?1:0);
			graphics.drawRect(0,0,Math.floor(_window.width),Math.floor(_window.height));
			graphics.endFill();
			//there may be a bug on using blendMode="layer"
			//blendMode=BlendMode.LAYER;
			alpha=_window.alpha;
			tabEnabled=false;
			visible=_window.visible&&!(_window.minimized);
			x=Math.floor(_window.x);
			y=Math.floor(_window.y);
			doubleClickEnabled=true;
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);
			
			_frameWrapper=new Sprite();
			_frameWrapper.mouseEnabled=false;
			_frameWrapper.tabEnabled=false;
			_frameWrapper.visible=_window.showFrame;
			addChild(_frameWrapper);
			
			_frame=new FrameBitmap(null,"auto");
			if(_window.maximized)
			{
				_frame.bitmapData=BMD_WINDOW_FRAME_MAXIMIZED_D;
				_frame.scale9Grid=WINDOW_FRAME_MAXIMIZED_SCALE_9_GRID;
			}
			else
			{
				_frame.bitmapData=BMD_WINDOW_FRAME_D;
				_frame.scale9Grid=WINDOW_FRAME_SCALE_9_GRID;
			}
			_frame.width=Math.floor(_window.width);
			_frame.height=Math.floor(_window.height);
			_frameWrapper.addChild(_frame);
			
			_caption=new TextField();
			_caption.x=WINDOW_LEFT_PADDING;
			_caption.y=_window.maximized?-1:2;
			_caption.width=Math.floor(_window.width-(WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING));
			_caption.height=WINDOW_TOP_PADDING;
			_caption.embedFonts=true;
			_caption.defaultTextFormat=new TextFormat("VL PGothic Regular",14,0x000000,false,false,false,null,null,TextFormatAlign.CENTER);
			_caption.selectable=false;
			_caption.mouseEnabled=false;
			_caption.text=_window.caption;
			_frameWrapper.addChild(_caption);
			
			_icon=new Bitmap(_window.icon,"auto",true);
			_icon.x=_window.maximized?WINDOW_LEFT_PADDING:WINDOW_LEFT_PADDING*2;
			_icon.y=_window.maximized?1:4;
			_icon.width=18;
			_icon.height=18;
			_frameWrapper.addChild(_icon);
			
			_buttons=new Sprite();
			_buttons.x=Math.floor(_window.width-(_window.maximized?0:WINDOW_RIGHT_PADDING-1));
			_buttons.y=_window.maximized?-1:0;
			_frameWrapper.addChild(_buttons);
			
			_closeButtonDUp=new Bitmap(BMD_WINDOW_CLOSE_BUTTON_D_UP);
			_closeButtonDOver=new Bitmap(BMD_WINDOW_CLOSE_BUTTON_D_OVER);
			_closeButtonDDown=new Bitmap(BMD_WINDOW_CLOSE_BUTTON_D_DOWN);
			_closeButtonAUp=new Bitmap(BMD_WINDOW_CLOSE_BUTTON_A_UP);
			_closeButtonAOver=new Bitmap(BMD_WINDOW_CLOSE_BUTTON_A_OVER);
			_closeButtonADown=new Bitmap(BMD_WINDOW_CLOSE_BUTTON_A_DOWN);
			_closeButton=new SimpleButton(_closeButtonDUp,_closeButtonDOver,_closeButtonDDown,_closeButtonDUp);
			_closeButton.x=-CLOSE_BUTTON_WIDTH;
			_closeButton.tabEnabled=false;
			_closeButton.useHandCursor=false;
			_closeButton.addEventListener(MouseEvent.CLICK,onCloseButtonClick);
			_buttons.addChild(_closeButton);
			
			_maximizeButtonDUp=new Bitmap(BMD_WINDOW_MAXIMIZE_BUTTON_D_UP);
			_maximizeButtonDOver=new Bitmap(BMD_WINDOW_MAXIMIZE_BUTTON_D_OVER);
			_maximizeButtonDDown=new Bitmap(BMD_WINDOW_MAXIMIZE_BUTTON_D_DOWN);
			_maximizeButtonAUp=new Bitmap(BMD_WINDOW_MAXIMIZE_BUTTON_A_UP);
			_maximizeButtonAOver=new Bitmap(BMD_WINDOW_MAXIMIZE_BUTTON_A_OVER);
			_maximizeButtonADown=new Bitmap(BMD_WINDOW_MAXIMIZE_BUTTON_A_DOWN);
			_maximizeButton=new SimpleButton(_maximizeButtonDUp,_maximizeButtonDOver,_maximizeButtonDDown,_maximizeButtonDUp);
			_maximizeButton.x=-CLOSE_BUTTON_WIDTH-MAXIMIZE_BUTTON_WIDTH;
			_maximizeButton.tabEnabled=false;
			_maximizeButton.useHandCursor=false;
			_maximizeButton.visible=_window.maximizable;
			_maximizeButton.addEventListener(MouseEvent.CLICK,onMaximizeButtonClick);
			_buttons.addChild(_maximizeButton);
			
			_minimizeButtonDUp=new Bitmap(BMD_WINDOW_MINIMIZE_BUTTON_D_UP);
			_minimizeButtonDOver=new Bitmap(BMD_WINDOW_MINIMIZE_BUTTON_D_OVER);
			_minimizeButtonDDown=new Bitmap(BMD_WINDOW_MINIMIZE_BUTTON_D_DOWN);
			_minimizeButtonAUp=new Bitmap(BMD_WINDOW_MINIMIZE_BUTTON_A_UP);
			_minimizeButtonAOver=new Bitmap(BMD_WINDOW_MINIMIZE_BUTTON_A_OVER);
			_minimizeButtonADown=new Bitmap(BMD_WINDOW_MINIMIZE_BUTTON_A_DOWN);
			_minimizeButton=new SimpleButton(_minimizeButtonDUp,_minimizeButtonDOver,_minimizeButtonDDown,_minimizeButtonDUp);
			_minimizeButton.x=-CLOSE_BUTTON_WIDTH-(_window.maximizable?MAXIMIZE_BUTTON_WIDTH:0)-MINIMIZE_BUTTON_WIDTH;
			_minimizeButton.tabEnabled=false;
			_minimizeButton.useHandCursor=false;
			_minimizeButton.visible=_window.minimizable;
			_minimizeButton.addEventListener(MouseEvent.CLICK,onMinimizeButtonClick);
			_buttons.addChild(_minimizeButton);
			
			_contentWrapper=new Sprite();
			_contentWrapper.x=_window.showFrame?(_window.maximized?0:WINDOW_RIGHT_PADDING):0;
			_contentWrapper.y=_window.showFrame?(_window.maximized?WINDOW_MAXIMIZED_TOP_PADDING:WINDOW_TOP_PADDING):0;
			addChild(_contentWrapper);
			
			_content=new (ContentManagerDictionary.getManagerClassByContent(_window.container))(_window.container,_manager);
			_contentWrapper.addChild(_content);
			
			_dropShadow=new DropShadowFilter(0,0,0x000000,0,0,0);
			filters=[_dropShadow];
			
			_dragging=false;
			_draggingMode=null;
			_startMouseX=0;
			_startMouseY=0;
			_startX=0;
			_startY=0;
			_startWidth=0;
			_startHeight=0;
			
			_originalX=_window.x;
			_originalY=_window.y;
			_originalWidth=_window.width;
			_originalHeight=_window.height;
			
			switch(_window.position)
			{
				case WindowPosition.ALWAYS_BEHIND:
					_manager.windowLayer.setToLayer(this,"behind");
					break;
				case WindowPosition.ALWAYS_IN_FRONT:
					_manager.windowLayer.setToLayer(this,"front");
					break;
				default:
					_manager.windowLayer.setToLayer(this,"default");
			}
		}
		
		public function dispose():void
		{
			(_content as ContentManager).dispose();
			
			parent.removeChild(this);
			
			_manager.system.removeEventListener(SystemEvent.WINDOW_MAXIMIZING_RECT_CHANGE,onSystemWindowMaximizingRectChange);
			
			_window.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onWindowPropertyChange);
			_window.removeEventListener(WindowEvent.ACTIVATE,onWindowActivate);
			_window.removeEventListener(WindowEvent.DEACTIVATE,onWindowDeactivate);
			
			_manager.screen.removeEventListener(Event.RESIZE,onScreenResize);
			(_manager.viewport as Viewport).removeEventListener(MouseEvent.MOUSE_UP,onViewportMouseUp);
			(_manager.viewport as Viewport).removeEventListener(MouseEvent.MOUSE_MOVE,onViewportMouseMove);
			
			_window=null;
			_manager=null;
		}
		
		private function onSystemWindowMaximizingRectChange(e:SystemEvent):void
		{
			if(_window.maximized)
			{
				if(_manager.system.windowMaximizingRect)
				{
					_window.x=_manager.system.windowMaximizingRect.x;
					_window.y=_manager.system.windowMaximizingRect.y;
					_window.width=_manager.system.windowMaximizingRect.width;
					_window.height=_manager.system.windowMaximizingRect.height;
				}
				else
				{
					_window.x=0;
					_window.y=0;
					_window.width=_manager.screen.width;
					_window.height=_manager.screen.height;
				}
			}
		}
		
		private function onWindowPropertyChange(e:PropertyChangeEvent):void
		{
			switch(e.propertyName)
			{
				case "alpha":
					alpha=_window.alpha;
					break;
				case "background":
					graphics.clear();
					graphics.beginFill(0xe0e0e0,_window.background?1:0);
					graphics.drawRect(0,0,Math.floor(_window.width),Math.floor(_window.height));
					graphics.endFill();
					break;
				case "caption":
					_caption.text=_window.caption;
					break;
				case "containerHeight":
					if(e.oldValue!=e.newValue)
					{
						if(_window.maximized)
						{
							if(_manager.system.windowMaximizingRect
								&& _window.containerHeight!=_manager.system.windowMaximizingRect.height-(_window.showFrame?WINDOW_MAXIMIZED_TOP_PADDING:0))
							{
								_window.containerHeight=_manager.system.windowMaximizingRect.height-(_window.showFrame?WINDOW_MAXIMIZED_TOP_PADDING:0);
							}
							else if(!_manager.system.windowMaximizingRect
								&& _window.containerHeight!=_manager.screen.height-(_window.showFrame?WINDOW_MAXIMIZED_TOP_PADDING:0))
							{
								_window.containerHeight=_manager.screen.height-(_window.showFrame?WINDOW_MAXIMIZED_TOP_PADDING:0);
							}
							else
							{
								_window.height=Math.floor(_window.containerHeight+(_window.showFrame?WINDOW_MAXIMIZED_TOP_PADDING:0));
							}
						}
						else
						{
							_window.height=Math.floor(_window.containerHeight+(_window.showFrame?WINDOW_TOP_PADDING+WINDOW_BOTTOM_PADDING:0));
						}
					}
					break;
				case "containerWidth":
					if(e.oldValue!=e.newValue)
					{
						if(_window.maximized)
						{
							if(_manager.system.windowMaximizingRect && _window.containerWidth!=_manager.system.windowMaximizingRect.width)
							{
								_window.containerWidth=_manager.system.windowMaximizingRect.width;
							}
							else if(!_manager.system.windowMaximizingRect && _window.containerWidth!=_manager.screen.width)
							{
								_window.containerWidth=_manager.screen.width;
							}
							else
							{
								_window.width=Math.floor(_window.containerWidth);
							}
						}
						else
						{
							_window.width=Math.floor(_window.containerWidth+(_window.showFrame?WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING:0));
						}
					}
					break;
				case "enabled":
					mouseEnabled=_window.enabled;
					tabEnabled=_window.enabled;
					break;
				case "height":
					if(_window.maximized && _manager.system.windowMaximizingRect && _window.height!=_manager.system.windowMaximizingRect.height)
					{
						_window.height=_manager.system.windowMaximizingRect.height;
					}
					else if(_window.maximized && !_manager.system.windowMaximizingRect && _window.height!=_manager.screen.height)
					{
						_window.height=_manager.screen.height;
					}
					else
					{
						if(!_window.maximized && _window.height<WINDOW_MIN_HEIGHT){
							_window.height=WINDOW_MIN_HEIGHT;
						}
						else
						{
							graphics.clear();
							graphics.beginFill(0xe0e0e0,_window.background?1:0);
							graphics.drawRect(0,0,Math.floor(_window.width),Math.floor(_window.height));
							graphics.endFill();
							_frame.height=Math.floor(_window.height);
							
							if(_window.maximized)
							{
								_window.containerHeight=Math.floor(_window.height-(_window.showFrame?WINDOW_MAXIMIZED_TOP_PADDING:0));
							}
							else
							{
								_window.containerHeight=Math.floor(_window.height-(_window.showFrame?WINDOW_TOP_PADDING+WINDOW_BOTTOM_PADDING:0));
							}
						}
					}
					break;
				case "icon":
					_icon.bitmapData=_window.icon;
					break;
				case "maximizable":
					_maximizeButton.visible=_window.maximizable;
					_minimizeButton.x=-CLOSE_BUTTON_WIDTH-(_window.maximizable?MAXIMIZE_BUTTON_WIDTH:0)-MINIMIZE_BUTTON_WIDTH;
					break;
				case "maximized":
					if(_window.maximized)
					{
						if(!Boolean(e.oldValue))
						{
							_originalX=_window.x;
							_originalY=_window.y;
							_originalWidth=_window.width;
							_originalHeight=_window.height;
						}
						if(_manager.system.windowMaximizingRect)
						{
							_window.x=_manager.system.windowMaximizingRect.x;
							_window.y=_manager.system.windowMaximizingRect.y;
							_window.width=_manager.system.windowMaximizingRect.width;
							_window.height=_manager.system.windowMaximizingRect.height;
						}
						else
						{
							_window.x=0;
							_window.y=0;
							_window.width=_manager.screen.width;
							_window.height=_manager.screen.height;
						}
						if(_frame.bitmapData==BMD_WINDOW_FRAME_D)
						{
							_frame.bitmapData=BMD_WINDOW_FRAME_MAXIMIZED_D;
						}
						else if(_frame.bitmapData==BMD_WINDOW_FRAME_A)
						{
							_frame.bitmapData=BMD_WINDOW_FRAME_MAXIMIZED_A;
						}
						_frame.scale9Grid=WINDOW_FRAME_MAXIMIZED_SCALE_9_GRID;
					}
					else
					{
						if(Boolean(e.oldValue))
						{
							_window.x=_originalX;
							_window.y=_originalY;
							_window.width=_originalWidth;
							_window.height=_originalHeight;
						}
						if(_frame.bitmapData==BMD_WINDOW_FRAME_MAXIMIZED_D)
						{
							_frame.bitmapData=BMD_WINDOW_FRAME_D;
						}
						else if(_frame.bitmapData==BMD_WINDOW_FRAME_MAXIMIZED_A)
						{
							_frame.bitmapData=BMD_WINDOW_FRAME_A;
						}
						_frame.scale9Grid=WINDOW_FRAME_SCALE_9_GRID;
					}
					_frame.width=Math.floor(_window.width);
					_frame.height=Math.floor(_window.height);
					_caption.y=_window.maximized?-1:2;
					_icon.x=_window.maximized?WINDOW_LEFT_PADDING:WINDOW_LEFT_PADDING*2;
					_icon.y=_window.maximized?1:4;
					_buttons.x=Math.floor(_window.width-(_window.maximized?0:WINDOW_RIGHT_PADDING-1));
					_buttons.y=_window.maximized?-1:0;
					_contentWrapper.x=_window.showFrame?(_window.maximized?0:WINDOW_RIGHT_PADDING):0;
					_contentWrapper.y=_window.showFrame?(_window.maximized?WINDOW_MAXIMIZED_TOP_PADDING:WINDOW_TOP_PADDING):0;
					break;
				case "minimizable":
					_minimizeButton.visible=_window.minimizable;
					break;
				case "minimized":
					visible=_window.visible&&!(_window.minimized);
					break;
				case "position":
					if(String(e.oldValue)!=String(e.newValue))
					{
						switch(_window.position)
						{
							case WindowPosition.ALWAYS_BEHIND:
								_manager.windowLayer.setToLayer(this,"behind");
								break;
							case WindowPosition.ALWAYS_IN_FRONT:
								_manager.windowLayer.setToLayer(this,"front");
								break;
							default:
								_manager.windowLayer.setToLayer(this,"default");
						}
					}
					break;
				case "showFrame":
					_frameWrapper.visible=_window.showFrame;
					_contentWrapper.x=_window.showFrame?(_window.maximized?0:WINDOW_RIGHT_PADDING):0;
					_contentWrapper.y=_window.showFrame?(_window.maximized?WINDOW_MAXIMIZED_TOP_PADDING:WINDOW_TOP_PADDING):0;
					
					if(_window.maximized)
					{
						_window.containerWidth=Math.floor(_window.width);
						_window.containerHeight=Math.floor(_window.height-(_window.showFrame?WINDOW_MAXIMIZED_TOP_PADDING:0));
					}
					else
					{
						if(_window.prioritizeContainerSize)
						{
							if(_window.containerWidth+(_window.showFrame?WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING:0)<WINDOW_MIN_WIDTH)
							{
								_window.containerWidth=Math.floor(WINDOW_MIN_HEIGHT-(_window.showFrame?WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING:0));
								_window.width=WINDOW_MIN_WIDTH;
							}
							else
							{
								_window.width=_window.containerWidth+(_window.showFrame?WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING:0);
							}
							
							if(_window.containerHeight+(_window.showFrame?WINDOW_TOP_PADDING+WINDOW_BOTTOM_PADDING:0)<WINDOW_MIN_HEIGHT)
							{
								_window.containerHeight=Math.floor(WINDOW_MIN_HEIGHT-(_window.showFrame?WINDOW_TOP_PADDING+WINDOW_BOTTOM_PADDING:0));
								_window.height=WINDOW_MIN_HEIGHT;
							}
							else
							{
								_window.height=_window.containerHeight+(_window.showFrame?WINDOW_TOP_PADDING+WINDOW_BOTTOM_PADDING:0);
							}
						}
						else
						{
							if(_window.width<WINDOW_MIN_WIDTH)
							{
								_window.width=WINDOW_MIN_WIDTH;
							}
							if(_window.height<WINDOW_MIN_HEIGHT)
							{
								_window.height=WINDOW_MIN_HEIGHT;
							}
							_window.containerWidth=Math.floor(_window.width-(_window.showFrame?WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING:0));
							_window.containerHeight=Math.floor(_window.height-(_window.showFrame?WINDOW_TOP_PADDING+WINDOW_BOTTOM_PADDING:0));
						}
					}
					break;
				case "visible":
					visible=_window.visible&&!(_window.minimized);
					break;
				case "width":
					if(_window.maximized && _manager.system.windowMaximizingRect && _window.width!=_manager.system.windowMaximizingRect.width)
					{
						_window.width=_manager.system.windowMaximizingRect.width;
					}
					else if(_window.maximized && !_manager.system.windowMaximizingRect && _window.width!=_manager.screen.width)
					{
						_window.width=_manager.screen.width;
					}
					else
					{
						if(!_window.maximized && _window.width<WINDOW_MIN_WIDTH){
							_window.width=WINDOW_MIN_WIDTH;
						}
						else
						{
							graphics.clear();
							graphics.beginFill(0xe0e0e0,_window.background?1:0);
							graphics.drawRect(0,0,Math.floor(_window.width),Math.floor(_window.height));
							graphics.endFill();
							_frame.width=Math.floor(_window.width);
							_caption.x=WINDOW_LEFT_PADDING;
							_caption.width=Math.floor(_window.width-(WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING));
							_buttons.x=Math.floor(_window.width-(_window.maximized?0:WINDOW_RIGHT_PADDING-1));
							
							if(_window.maximized)
							{
								_window.containerWidth=Math.floor(_window.width);
							}
							else
							{
								_window.containerWidth=Math.floor(_window.width-(_window.showFrame?WINDOW_LEFT_PADDING+WINDOW_RIGHT_PADDING:0));
							}
						}
					}
					break;
				case "x":
					if(_window.maximized && _manager.system.windowMaximizingRect && _window.x!=_manager.system.windowMaximizingRect.x)
					{
						_window.x=_manager.system.windowMaximizingRect.x;
					}
					else if(_window.maximized && !_manager.system.windowMaximizingRect && _window.x!=0)
					{
						_window.x=0;
					}
					else
					{
						x=Math.floor(_window.x);
					}
					break;
				case "y":
					if(_window.maximized && _manager.system.windowMaximizingRect && _window.y!=_manager.system.windowMaximizingRect.y)
					{
						_window.y=_manager.system.windowMaximizingRect.y;
					}
					else if(_window.maximized && !_manager.system.windowMaximizingRect && _window.y!=0)
					{
						_window.y=0;
					}
					else
					{
						y=Math.floor(_window.y);
					}
					break;
			}
		}
		
		private function onWindowActivate(e:WindowEvent):void
		{
			parent.addChild(this);
			_dropShadow.alpha=0.5;
			_dropShadow.blurX=8;
			_dropShadow.blurY=8;
			filters=[_dropShadow];
			if(_window.maximized)
			{
				_frame.bitmapData=BMD_WINDOW_FRAME_MAXIMIZED_A;
			}
			else
			{
				_frame.bitmapData=BMD_WINDOW_FRAME_A;
			}
			_closeButton.upState=_closeButtonAUp;
			_closeButton.overState=_closeButtonAOver;
			_closeButton.downState=_closeButtonADown;
			_maximizeButton.upState=_maximizeButtonAUp;
			_maximizeButton.overState=_maximizeButtonAOver;
			_maximizeButton.downState=_maximizeButtonADown;
			_minimizeButton.upState=_minimizeButtonAUp;
			_minimizeButton.overState=_minimizeButtonAOver;
			_minimizeButton.downState=_minimizeButtonADown;
		}
		
		private function onWindowDeactivate(e:WindowEvent):void
		{
			_dropShadow.alpha=0;
			_dropShadow.blurX=0;
			_dropShadow.blurY=0;
			filters=[_dropShadow];
			if(_window.maximized)
			{
				_frame.bitmapData=BMD_WINDOW_FRAME_MAXIMIZED_D;
			}
			else
			{
				_frame.bitmapData=BMD_WINDOW_FRAME_D;
			}
			_closeButton.upState=_closeButtonDUp;
			_closeButton.overState=_closeButtonDOver;
			_closeButton.downState=_closeButtonDDown;
			_maximizeButton.upState=_maximizeButtonDUp;
			_maximizeButton.overState=_maximizeButtonDOver;
			_maximizeButton.downState=_maximizeButtonDDown;
			_minimizeButton.upState=_minimizeButtonDUp;
			_minimizeButton.overState=_minimizeButtonDOver;
			_minimizeButton.downState=_minimizeButtonDDown;
		}
		
		private function onScreenResize(e:Event):void
		{
			if(_window.maximized && !_manager.system.windowMaximizingRect)
			{
				_window.width=_manager.screen.width;
				_window.height=_manager.screen.height;
			}
		}
		
		private function onViewportMouseUp(e:MouseEvent):void
		{
			_dragging=false;
		}
		
		private function onViewportMouseMove(e:MouseEvent):void
		{
			if(_dragging)
			{
				var viewport:Viewport=_manager.viewport as Viewport;
				var mouseX:Number=viewport.mouseX;
				var mouseY:Number=viewport.mouseY;
				if(_manager.system.windowMaximizingRect)
				{
					if(mouseX<_manager.system.windowMaximizingRect.x)
					{
						mouseX=_manager.system.windowMaximizingRect.x;
					}
					else if(mouseX>=_manager.system.windowMaximizingRect.x+_manager.system.windowMaximizingRect.width)
					{
						mouseX=_manager.system.windowMaximizingRect.x+_manager.system.windowMaximizingRect.width-1;
					}
					if(mouseY<_manager.system.windowMaximizingRect.y)
					{
						mouseY=_manager.system.windowMaximizingRect.y;
					}
					else if(mouseY>=_manager.system.windowMaximizingRect.y+_manager.system.windowMaximizingRect.height)
					{
						mouseY=_manager.system.windowMaximizingRect.y+_manager.system.windowMaximizingRect.height-1;
					}
				}
				else
				{
					if(mouseX<0)
					{
						mouseX=0;
					}
					else if(mouseX>=_manager.screen.width)
					{
						mouseX=_manager.screen.width-1;
					}
					if(mouseY<0)
					{
						mouseY=0;
					}
					else if(mouseY>=_manager.screen.height)
					{
						mouseY=_manager.screen.height-1;
					}
				}
				switch(_draggingMode)
				{
					case "resizeTop":
						if(_startHeight-(mouseY-_startMouseY)<WINDOW_MIN_HEIGHT)
						{
							_window.y=_startY+_startHeight-WINDOW_MIN_HEIGHT;
							_window.height=WINDOW_MIN_HEIGHT;
						}
						else
						{
							_window.y=_startY+(mouseY-_startMouseY);
							_window.height=_startHeight-(mouseY-_startMouseY);
						}
						break;
					case "resizeBottom":
						if(_startHeight+(mouseY-_startMouseY)<WINDOW_MIN_HEIGHT)
						{
							_window.height=WINDOW_MIN_HEIGHT
						}
						else
						{
							_window.height=_startHeight+(mouseY-_startMouseY);
						}
						break;
					case "resizeLeft":
						if(_startWidth-(mouseX-_startMouseX)<WINDOW_MIN_WIDTH)
						{
							_window.x=_startX+_startWidth-WINDOW_MIN_WIDTH;
							_window.width=WINDOW_MIN_WIDTH;
						}
						else
						{
							_window.x=_startX+(mouseX-_startMouseX);
							_window.width=_startWidth-(mouseX-_startMouseX);
						}
						break;
					case "resizeRight":
						if(_startWidth+(mouseX-_startMouseX)<WINDOW_MIN_WIDTH)
						{
							_window.width=WINDOW_MIN_WIDTH;
						}
						else
						{
							_window.width=_startWidth+(mouseX-_startMouseX);
						}
						break;
					case "resizeTopLeft":
						//top
						if(_startHeight-(mouseY-_startMouseY)<WINDOW_MIN_HEIGHT)
						{
							_window.y=_startY+_startHeight-WINDOW_MIN_HEIGHT;
							_window.height=WINDOW_MIN_HEIGHT;
						}
						else
						{
							_window.y=_startY+(mouseY-_startMouseY);
							_window.height=_startHeight-(mouseY-_startMouseY);
						}
						//left
						if(_startWidth-(mouseX-_startMouseX)<WINDOW_MIN_WIDTH)
						{
							_window.x=_startX+_startWidth-WINDOW_MIN_WIDTH;
							_window.width=WINDOW_MIN_WIDTH;
						}
						else
						{
							_window.x=_startX+(mouseX-_startMouseX);
							_window.width=_startWidth-(mouseX-_startMouseX);
						}
						break;
					case "resizeTopRight":
						//top
						if(_startHeight-(mouseY-_startMouseY)<WINDOW_MIN_HEIGHT)
						{
							_window.y=_startY+_startHeight-WINDOW_MIN_HEIGHT;
							_window.height=WINDOW_MIN_HEIGHT;
						}
						else
						{
							_window.y=_startY+(mouseY-_startMouseY);
							_window.height=_startHeight-(mouseY-_startMouseY);
						}
						//right
						if(_startWidth+(mouseX-_startMouseX)<WINDOW_MIN_WIDTH)
						{
							_window.width=WINDOW_MIN_WIDTH;
						}
						else
						{
							_window.width=_startWidth+(mouseX-_startMouseX);
						}
						break;
					case "resizeBottomLeft":
						//bottom
						if(_startHeight+(mouseY-_startMouseY)<WINDOW_MIN_HEIGHT)
						{
							_window.height=WINDOW_MIN_HEIGHT
						}
						else
						{
							_window.height=_startHeight+(mouseY-_startMouseY);
						}
						//left
						if(_startWidth-(mouseX-_startMouseX)<WINDOW_MIN_WIDTH)
						{
							_window.x=_startX+_startWidth-WINDOW_MIN_WIDTH;
							_window.width=WINDOW_MIN_WIDTH;
						}
						else
						{
							_window.x=_startX+(mouseX-_startMouseX);
							_window.width=_startWidth-(mouseX-_startMouseX);
						}
						break;
					case "resizeBottomRight":
						//bottom
						if(_startHeight+(mouseY-_startMouseY)<WINDOW_MIN_HEIGHT)
						{
							_window.height=WINDOW_MIN_HEIGHT
						}
						else
						{
							_window.height=_startHeight+(mouseY-_startMouseY);
						}
						//right
						if(_startWidth+(mouseX-_startMouseX)<WINDOW_MIN_WIDTH)
						{
							_window.width=WINDOW_MIN_WIDTH;
						}
						else
						{
							_window.width=_startWidth+(mouseX-_startMouseX);
						}
						break;
					case "move":
						_window.x=_startX+mouseX-_startMouseX;
						_window.y=_startY+mouseY-_startMouseY;
						break;
				}
			}
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			if(_window.activateOnFocus)
			{
				_window.application.system.activeWindow=_window;
			}
			if(e.eventPhase==EventPhase.AT_TARGET && !_window.maximized && !_window.minimized)
			{
				if(_window.resizable)
				{
					if(mouseY<=WINDOW_BOTTOM_PADDING)
					{
						_dragging=true;
						_draggingMode="resizeTop";
						if(mouseX<=WINDOW_LEFT_PADDING*2)
						{
							_draggingMode+="Left";
						}
						else if(_window.width-mouseX<=WINDOW_RIGHT_PADDING*2)
						{
							_draggingMode+="Right";
						}
					}
					else if(_window.height-mouseY<=WINDOW_BOTTOM_PADDING)
					{
						_dragging=true;
						_draggingMode="resizeBottom";
						if(mouseX<=WINDOW_LEFT_PADDING*2)
						{
							_draggingMode+="Left";
						}
						else if(_window.width-mouseX<=WINDOW_RIGHT_PADDING*2)
						{
							_draggingMode+="Right";
						}
					}
					else if(mouseX<=WINDOW_LEFT_PADDING)
					{
						_dragging=true;
						_draggingMode="resizeLeft";
					}
					else if(_window.width-mouseX<=WINDOW_RIGHT_PADDING)
					{
						_dragging=true;
						_draggingMode="resizeRight";
					}
					else if(mouseY<=WINDOW_TOP_PADDING)
					{
						_dragging=true;
						_draggingMode="move";
					}
				}
				else
				{
					if(mouseY<=WINDOW_TOP_PADDING)
					{
						_dragging=true;
						_draggingMode="move";
					}
				}
				var viewport:Viewport=_manager.viewport as Viewport;
				_startMouseX=viewport.mouseX;
				_startMouseY=viewport.mouseY;
				_startX=_window.x;
				_startY=_window.y;
				_startWidth=_window.width;
				_startHeight=_window.height;
			}
		}
		
		private function onDoubleClick(e:MouseEvent):void
		{
			if(_window.maximizable && e.eventPhase==EventPhase.AT_TARGET && mouseY<=WINDOW_TOP_PADDING
				&& mouseX>WINDOW_LEFT_PADDING && _window.width-mouseX>WINDOW_RIGHT_PADDING)
			{
				onMaximizeButtonClick(e);
			}
		}
		
		private function onCloseButtonClick(e:MouseEvent):void
		{
			_window.close();
		}
		
		private function onMaximizeButtonClick(e:MouseEvent):void
		{
			_window.maximized=!_window.maximized;
		}
		
		private function onMinimizeButtonClick(e:MouseEvent):void
		{
			_window.minimized=!_window.minimized
		}
		
	}
	
}