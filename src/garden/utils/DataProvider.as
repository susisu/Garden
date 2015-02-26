package garden.utils
{
	
	import garden.events.DataChangeEvent;
	import garden.events.DataChangeType;
	import garden.events.EventDispatcher;
	
	public class DataProvider extends EventDispatcher
	{
		
		private var _itemList:Array;
		
		public function DataProvider()
		{
			super();
			
			_itemList=[];
		}
		
		// getter/setter properties
		public function get length():uint
		{
			return _itemList.length;
		}
		
		//methods
		public function addItem(item:Object):void
		{
			var index:uint=_itemList.length;
			dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.ADD,[item],index,index));
			_itemList.push(item);
			dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.ADD,[item],index,index));
		}
		
		public function addItemAt(item:Object,index:uint):void
		{
			if(index>_itemList.length)
			{
				throw (new RangeError("'index' is out of range"));
				return;
			}
			dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.ADD,[item],index,index));
			_itemList.splice(index,0,item);
			dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.ADD,[item],index,index));
		}
		
		public function addItems(items:Object):void
		{
			var list:Array;
			if(items is DataProvider)
			{
				list=(items as DataProvider)._itemList.slice();
			}
			else
			{
				list=items as Array;
			}
			
			if(list==null)
			{
				throw (new TypeError("cannot convert 'items' to Array or DataProvider"));
				return;
			}
			
			var len:uint=list.length;
			if(len>0)
			{
				var index:uint=_itemList.length;
				dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.ADD,list,index,index+len-1));
				_itemList=_itemList.concat(list);
				dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.ADD,list,index,index+len-1));
			}
		}
		
		public function addItemsAt(items:Object,index:uint):void
		{
			if(index>_itemList.length)
			{
				throw (new RangeError("'index' is out of range"));
				return;
			}
			
			var list:Array;
			if(items is DataProvider)
			{
				list=(items as DataProvider)._itemList.slice();
			}
			else
			{
				list=items as Array;
			}
			
			if(list==null)
			{
				throw (new TypeError("cannot convert 'items' to Array or DataProvider"));
				return;
			}
			
			var len:uint=list.length;
			if(len>0)
			{
				dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.ADD,list,index,index+len-1));
				for(var i:int=0;i<len;i++)
				{
					_itemList.splice(index+i,0,list[i]);
				}
				dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.ADD,list,index,index+len-1));
			}
		}
		
		public function clone():DataProvider
		{
			var newDataProvider:DataProvider=new DataProvider();
			newDataProvider._itemList=_itemList.slice();
			return newDataProvider;
		}
		
		public function getItemAt(index:uint):Object
		{
			return _itemList[index];
		}
		
		public function getItemIndex(item:Object):int
		{
			var len:int=_itemList.length;
			for(var i:int=0;i<len;i++)
			{
				if(_itemList[i]==item)
				{
					return i;
				}
			}
			return -1;
		}
		
		public function merge(newData:Array):void
		{
			var list:Array;
			if(newData is DataProvider)
			{
				list=(newData as DataProvider)._itemList.slice();
			}
			else
			{
				list=newData as Array;
			}
			
			if(list==null)
			{
				throw (new TypeError("cannot convert 'newData' to Array or DataProvider"));
				return;
			}
			
			var index:uint=_itemList.length;
			
			var len:int=list.length;
			var numItems:int=_itemList.length;
			for(var i:int=0;i<len;i++)
			{
				var newItem:Object=list[i];
				for(var j:int=0;j<numItems;j++)
				{
					if(_itemList[j]===newItem)
					{
						list.splice(i,1);
						i--;
						len--;
						continue;
					}
				}
			}
			if(len>0)
			{
				dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.ADD,list,index,index+len-1));
				_itemList=_itemList.concat(list);
				dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.ADD,list,index,index+len-1));
			}
		}
		
		public function removeAll():void
		{
			var list:Array=_itemList.slice();
			var len:int=list.length;
			if(len>0)
			{
				dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.REMOVE_ALL,list,0,len-1));
				_itemList=[];
				dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.REMOVE_ALL,list,0,len-1));
			}
		}
		
		public function removeItem(item:Object):Object
		{
			var numItems:int=_itemList.length;
			for(var i:int=0;i<numItems;i++)
			{
				if(_itemList[i]==item)
				{
					dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.REMOVE,[item],i,i));
					_itemList.splice(i,1);
					dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.REMOVE,[item],i,i));
					return item;
				}
			}
			return null;
		}
		
		public function removeItemAt(index:uint):Object
		{
			if(index>_itemList.length)
			{
				throw (new RangeError("'index' is out of range"));
				return;
			}
			
			var item:Object=_itemList[index];
			dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.REMOVE,[item],index,index));
			_itemList.splice(index,1);
			dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.REMOVE,[item],index,index));
			return item;
		}
		
		public function replaceItem(newItem:Object,oldItem:Object):Object
		{
			var numItems:int=_itemList.length;
			for(var i:int=0;i<numItems;i++)
			{
				if(_itemList[i]==oldItem)
				{
					dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.REPLACE,[oldItem],i,i));
					_itemList.splice(i,1,newItem);
					dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.REPLACE,[oldItem],i,i));
					return oldItem;
				}
			}
			return null;
		}
		
		public function replaceItemAt(newItem:Object,index:uint):Object
		{
			if(index>_itemList.length)
			{
				throw (new RangeError("'index' is out of range"));
				return;
			}
			
			var oldItem:Object=_itemList[index];
			dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.REPLACE,[oldItem],index,index));
			_itemList.splice(index,1,newItem);
			dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.REPLACE,[oldItem],index,index));
			return oldItem;
		}
		
		public function sort(...sortArgs):void
		{
			var numItems:int=_itemList.length;
			if(numItems>0)
			{
				dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.SORT,_itemList.slice(),0,numItems-1));
				_itemList.sort.apply(null,sortArgs);
				dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.SORT,_itemList.slice(),0,numItems-1));
			}
		}
		
		public function sortOn(fieldName:Object,options:Object=null):void
		{
			var numItems:int=_itemList.length;
			if(numItems>0)
			{
				dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,DataChangeType.SORT,_itemList.slice(),0,numItems-1));
				_itemList.sortOn(fieldName,options);
				dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.SORT,_itemList.slice(),0,numItems-1));
			}
		}
		
		public function toArray():Array
		{
			return _itemList.slice();
		}
		
		public function toString():String
		{
			return "DataProvider ["+_itemList.join(" , ")+"]";
		}
		
	}
	
}