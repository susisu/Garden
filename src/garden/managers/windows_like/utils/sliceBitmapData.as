package garden.managers.windows_like.utils
{
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public function sliceBitmapData(source:BitmapData,width:uint,height:uint):Vector.<BitmapData>
	{
		if(source==null)
		{
			return null;
		}
		var result:Vector.<BitmapData>=new Vector.<BitmapData>();
		var w:int=Math.floor(source.width/width);
		var h:int=Math.floor(source.height/height);
		const p0:Point=new Point(0,0);
		const rect:Rectangle=new Rectangle(0,0,width,height);
		for(var i:int=0;i<h;i++)
		{
			for(var j:int=0;j<w;j++)
			{
				var bmd:BitmapData=new BitmapData(width,height,source.transparent,0x00000000);
				rect.x=width*j;
				rect.y=height*i;
				bmd.copyPixels(source,rect,p0,null,null,true);
				result.push(bmd);
			}
		}
		return result;
	}
	
}