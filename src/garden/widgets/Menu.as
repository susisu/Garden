package garden.widgets
{
	
	public class Menu extends WidgetBase
	{
		
		private var _items:Vector.<MenuItem>;
		
		public function Menu()
		{
			super();
			
			_items=new Vector.<MenuItems>();
		}
		
		public function addItem(item:MenuItem):void
		{
			_items.push(item);
		}
		/*
		public function addItemAt(item:MenuItem,index:int):void
		{
			_items.push(item);
		}
		*/
		public function getItemAt(index:int):MenuItem
		{
			if(index>=0 && index<_items.length)
			{
				return _items[index];
			}
			else
			{
				throw (new ArgumentError("'index' is out of range"));
				return null;
			}
		}
		/*
		public function getItemIndex(item:MenuItem):int
		{
			
		}
		*/
		public function removeItem(item:MenuItem):void
		{
			var len:int=_items.length;
			for(var i:int=0;i<len;i++){
				if(_items[i]==item)
				{
					_items.splice(i,1);
					return;
				}
			}
		}
		/*
		public function removeItemAt(index:int):void
		{
			
		}
		*/
	}
	
}