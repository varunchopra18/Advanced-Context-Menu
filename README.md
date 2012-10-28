Advanced-Context-Menu
=====================

## Incides ##

Internally we create a mx:Menu component and show it. Styling can also be applied to it.


## Dependencies ##

* user playerglobal.swc : 11.2 version
* add compiler argument "-swf-version=15"


## Usage ##

set application instance:

```actionscript
ContextMenuManager.instance.application = this;
```

use com.sprout.components.AdvancedContextMenuItem inplace of flash.ui.ContextMenuItem for sub-menus, it can be used in hybrid form. Use AdvancedContextMenuItem when you need sub menus and ContextMenuItem in other places :

```actionscript
var menu1:ContextMenuItem = new ContextMenuItem('menu 1');
var menu2:AdvancedContextMenuItem = new AdvancedContextMenuItem('menu 2');
this.contextMenu.customItems.push(menu1);
this.contextMenu.customItems.push(menu2);
```

set component instance on which right click action will show the advanced context menu:

```actionscript
ContextMenuManager.instance.addContextMenu(this);
```

adding submenus:

```actionscript
var menu1:ContextMenuItem = new ContextMenuItem('menu 1');
  			
var menu2:AdvancedContextMenuItem = new AdvancedContextMenuItem('menu 2');

var submenu1:ContextMenuItem = new ContextMenuItem('sub menu1');
var submenu2:ContextMenuItem = new ContextMenuItem('sub menu2');

menu2.children = [submenu1,submenu2];

this.contextMenu.customItems.push(menu1);
this.contextMenu.customItems.push(menu2);
```