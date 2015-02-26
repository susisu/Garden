package garden.managers.windows_like.content_managers
{
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedSuperclassName;
	
	import garden.widgets.contents.*;
	
	public class ContentManagerDictionary extends Object
	{
		
		private static const _dictionary:Dictionary=new Dictionary();
		
		public static function assign(contentClass:Class,managerClass:Class):void
		{
			_dictionary[contentClass]=managerClass;
		}
		
		public static function getManagerClassByContent(content:Content):Class
		{
			var contentClass:Class=content.getClass();
			do
			{
				if(_dictionary[contentClass])
				{
					return _dictionary[contentClass];
				}
				else
				{
					contentClass=getDefinitionByName(getQualifiedSuperclassName(contentClass)) as Class;
				}
			}while(contentClass!=Content)
			return ContentManager;
		}
		
		public static function init():void
		{
			assign(Button,ButtonManager);
			assign(Content,ContentManager);
			assign(Container,ContainerManager);
			assign(ImageBox,ImageBoxManager);
			assign(MovieBox,MovieBoxManager);
			assign(Panel,PanelManager);
		}
		
		public function ContentManagerDictionary()
		{
			
		}
		
	}
	
}