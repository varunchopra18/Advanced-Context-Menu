Advanced-Context-Menu
=====================

## Incides ##

Internally we create a mx:Menu component and show it. Styling can also be applied to it.


## Dependencies ##

* user playerglobal.swc : 11.2 version
* add compiler argument "-swf-version=15"


## Usage ##

set application url:

```actionscript
ContextMenuManager.instance.application = this;
```

assign com.sprout.components.ContextMenuItem inplace of flash.ui.ContextMenuItem and use it in the same way:

```actionscript
var menu1:com.sprout.components.ContextMenuItem = new com.sprout.components.ContextMenuItem('menu 1');
this.contextMenu.customItems.push(menu1);
```

set component instance on which right click action will be done:

```actionscript
ContextMenuManager.instance.addContextMenu(this);
```

adding submenus:

```actionscript
var menu1:com.sprout.components.ContextMenuItem = new com.sprout.components.ContextMenuItem('menu 1');
  			
var menu2:com.sprout.components.ContextMenuItem = new com.sprout.components.ContextMenuItem('menu 2');

var submenu1:com.sprout.components.ContextMenuItem = new com.sprout.components.ContextMenuItem('sub menu1');
var submenu2:com.sprout.components.ContextMenuItem = new com.sprout.components.ContextMenuItem('sub menu2');

menu2.children = [submenu1,submenu2];

this.contextMenu.customItems.push(menu1);
this.contextMenu.customItems.push(menu2);;
```