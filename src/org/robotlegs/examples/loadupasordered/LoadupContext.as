package org.robotlegs.examples.loadupasordered
{
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.IContext;
	import org.robotlegs.examples.loadupasordered.controller.LoadResourcesCommand;
	import org.robotlegs.examples.loadupasordered.controller.StartupCommand;
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.utilities.loadup.events.LoadupEvent;
	
	public class LoadupContext extends Context implements IContext, IEventDispatcher
	{
		public function LoadupContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup() : void
		{
			commandMap.mapEvent( ContextEvent.STARTUP, StartupCommand, ContextEvent, true );
			
			commandMap.mapEvent( LoadupEvent.LOAD_RESOURCES, LoadResourcesCommand );
			
			dispatchEvent( new ContextEvent(ContextEvent.STARTUP));
		}
	}
}