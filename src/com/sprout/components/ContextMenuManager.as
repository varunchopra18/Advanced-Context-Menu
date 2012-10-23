package com.sprout.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
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
			var cmm:AdvancedContextMenu = new  AdvancedContextMenu();
			cmm.addContextMenu(view.contextMenu);
			_menuViewMap[view] = cmm;
			view.addEventListener(MouseEvent.RIGHT_CLICK,rightClickHandler,true);
		}
		
		public function addContextMenuToView(view:IEventDispatcher,menu:AdvancedContextMenu):void
		{
			_menuViewMap[view] = menu;
			view.addEventListener(MouseEvent.RIGHT_CLICK,rightClickHandler,true);
		}
		
		private function rightClickHandler(event:MouseEvent):void
		{
			var targetObj:Object = _menuViewMap[event.target] ?  event.target : event.currentTarget;
			if(_menuViewMap[targetObj])
			{
				showMenu(targetObj,_menuViewMap[targetObj],event.stageX,event.stageY,event.target);
			}
		}
		
		private function showMenu(view:Object,menu:AdvancedContextMenu,xPos:Number,yPos:Number,target:Object):void 
		{
			if(myMenu)
			{
				myMenu.hide();
			}
			menu.addContextMenu(view.contextMenu);
			if(!menu.originalContextMenu)
			{
				return;
			}
			menu.originalContextMenu.dispatchEvent(new ContextMenuEvent(ContextMenuEvent.MENU_SELECT));
			myMenu = Menu.createMenu(_application, menu.menuDataProvider, false);
			myMenu.labelField = "caption";
			myMenu.variableRowHeight = true;
			myMenu.addEventListener(MenuEvent.ITEM_CLICK, 
				function menuHandler(event:MenuEvent):void
				{
					IEventDispatcher(event.item).dispatchEvent(
						new ContextMenuEvent(ContextMenuEvent.MENU_ITEM_SELECT,false,false,target as InteractiveObject));
				}

			
			);
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
		}
		
		protected function menuHandler(event:MenuEvent):void
		{
			IEventDispatcher(event.item).dispatchEvent(new ContextMenuEvent(ContextMenuEvent.MENU_ITEM_SELECT));
		}
	}
}
class SF{}