package com.sprout.components
{
	import flash.ui.ContextMenu;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Menu;

	public class ContextMenu
	{
		private var myMenu:Menu;
		public function ContextMenu()
		{
			_menuDataProvider = new ArrayCollection();
		}
		
		private var _menuDataProvider:ArrayCollection;
		private var _originalContextMenu:flash.ui.ContextMenu;
		
		public function get originalContextMenu():flash.ui.ContextMenu
		{
			return _originalContextMenu;
		}
		
		public function get menuDataProvider():ArrayCollection
		{
			_menuDataProvider = new ArrayCollection();
			if(_originalContextMenu)
			{
				return makeCustomeContextMenu(_originalContextMenu);
			}
			return new ArrayCollection();
		}
		
		private function makeCustomeContextMenu(contextMenu:flash.ui.ContextMenu):ArrayCollection
		{
			for each(var menuItem:ContextMenuItem in contextMenu.customItems)
			{
				if(menuItem.separatorBefore)
				{
					addSeparator();
				}
				
				_menuDataProvider.addItem(menuItem);
			}
			return _menuDataProvider;
		}
		
		public function addContextMenu(contextMenu:flash.ui.ContextMenu):void
		{
			_originalContextMenu = contextMenu;
		}
		
		private function addSeparator():void
		{
			_menuDataProvider.addItem(createSparator())
		}
		
		private function createSparator():Object
		{
			var obj:Object = {};
			obj.type = "separator";
			return obj;
		}
	}
}