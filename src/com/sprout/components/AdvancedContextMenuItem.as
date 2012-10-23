package com.sprout.components
{
	import flash.events.EventDispatcher;

	public class AdvancedContextMenuItem extends EventDispatcher
	{
		public var caption:String;
		public var separatorBefore:Boolean;
		public var item:Object;
		public var enabled:Boolean;
		public var visible:Boolean;
		public var children:Array;
		
		public function AdvancedContextMenuItem(caption:String,separatorBefore:Boolean = false,enabled:Boolean = true,visible:Boolean = true)
		{
			this.caption = caption;
			this.separatorBefore = separatorBefore;
			this.enabled = enabled;
			this.visible = visible;
		}
	}
}