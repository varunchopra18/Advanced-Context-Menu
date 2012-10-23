package com.sprout.components
{
	import flash.ui.ContextMenu;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Menu;

	public class AdvancedContextMenu
	{
		private var myMenu:Menu;
		public function AdvancedContextMenu()
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
				return makeCustomContextMenu(_originalContextMenu);
			}
			return new ArrayCollection();
		}
		
		private function makeCustomContextMenu(contextMenu:flash.ui.ContextMenu):ArrayCollection
		{
			for each(var menuItem:Object in contextMenu.customItems)
			{
				if(menuItem.separatorBefore)
				{
					addSeparator();
				}
				
				addItem(menuItem);
				
			}
			return _menuDataProvider;
		}
		
		private function addItem(item:Object):void
		{
			if(item is flash.ui.ContextMenuItem)
			{
				_menuDataProvider.addItem(convertObject(item as flash.ui.ContextMenuItem));
			}
			else
			{
				_menuDataProvider.addItem(item);
			}
		}
		
		private function convertObject(contextMenuItem:flash.ui.ContextMenuItem):AdvancedContextMenuItem
		{
			return new AdvancedContextMenuItem(contextMenuItem.caption,contextMenuItem.separatorBefore,contextMenuItem.enabled,contextMenuItem.visible);
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