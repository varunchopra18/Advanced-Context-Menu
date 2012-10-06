package com.sprout.components
{
	import flash.display.DisplayObjectContainer;
	import flash.events.ContextMenuEvent;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.controls.Menu;
	import mx.core.UIComponent;
	import mx.events.MenuEvent;

	public class ContextMenuManager
	{
		public function ContextMenuManager(s:SF)
		{
		}
		
		private var _application:DisplayObjectContainer;
		
		private static var _instance:ContextMenuManager;
		
		public function set application(value:DisplayObjectContainer):void
		{
			_application = value;
		}
		
		public function hide():void
		{
			if(myMenu)
			{
				myMenu.hide();
			}
		}
		
		public function show():void
		{
			if(myMenu)
			{
				myMenu.show();
			}
		}

		public static function get instance():ContextMenuManager
		{
			if(!_instance)
			{
				_instance = new ContextMenuManager(new SF());
			}
			return _instance;
		}
		
		private var _menuViewMap:Object = {};
		private var myMenu:Menu;
		
		
		public function addContextMenu(view:UIComponent):void
		{
			try
			{
				var cmm:ContextMenu = new  ContextMenu();
				cmm.addContextMenu(view.contextMenu);
				_menuViewMap[view] = cmm;
				view.addEventListener(MouseEvent.RIGHT_CLICK,rightClickHandler);
			}
			catch(e:Error)
			{
				throw new Error(e.message);
			}
		}
		
		public function addContextMenuToView(view:IEventDispatcher,menu:ContextMenu):void
		{
			_menuViewMap[view] = menu;
			view.addEventListener(MouseEvent.RIGHT_CLICK,rightClickHandler);
		}
		
		private function rightClickHandler(event:MouseEvent):void
		{
			showMenu(event.target,_menuViewMap[event.currentTarget],event.stageX,event.stageY);
		}
		
		private function showMenu(view:Object,menu:ContextMenu,xPos:Number,yPos:Number):void 
		{
			if(myMenu)
			{
				myMenu.hide();
			}
			if(!menu.originalContextMenu)
			{
				return;
			}
			menu.originalContextMenu.dispatchEvent(new ContextMenuEvent(ContextMenuEvent.MENU_SELECT));
			myMenu = Menu.createMenu(_application, menu.menuDataProvider, false);
			myMenu.labelField = "caption";
			myMenu.variableRowHeight = true;
			myMenu.addEventListener(MenuEvent.ITEM_CLICK, menuHandler);
			myMenu.addEventListener(MouseEvent.RIGHT_CLICK, menuRightClickDummyHandler);
			
			myMenu.show(xPos, yPos);
			
			var menuYPosition:Number = myMenu.height + yPos;
			var menuXPosition:Number = myMenu.width + xPos;
			var newYPos:Number = menuYPosition > _application.height ? _application.height - myMenu.height -20 : yPos;
			var newXPos:Number = menuXPosition > _application.width ? _application.width - myMenu.width -20 : xPos;
			
			myMenu.move(newXPos,newYPos);
		}
		
		protected function menuRightClickDummyHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function menuHandler(event:MenuEvent):void
		{
			ContextMenuItem(event.item).dispatchEvent(new ContextMenuEvent(ContextMenuEvent.MENU_ITEM_SELECT));
		}
	}
}
class SF{}