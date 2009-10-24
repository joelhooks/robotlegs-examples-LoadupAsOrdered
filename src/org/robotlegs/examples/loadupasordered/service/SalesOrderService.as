package org.robotlegs.examples.loadupasordered.service
{
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Service;
	import org.robotlegs.utilities.async.AsyncStubService;
	import org.robotlegs.utilities.loadup.events.ResourceEvent;
	import org.robotlegs.utilities.loadup.interfaces.IResource;
	
	public class SalesOrderService extends Service implements IResource
	{
		public static var LOADED:String = "salesOrderServiceLoaded";
		public static var LOADING:String = "salesOrderServiceLoading";
		public static var LOAD_FAILED:String = "salesOrderServiceLoadFailed";
		
		protected var service:AsyncStubService;
		
		public function SalesOrderService()
		{
			service = new AsyncStubService();
		}
		
		public function load():void
		{
			service.asyncAction(handleResult, handleFault)
			
			//this event is purely optional, and is used to let the framework know
			//that this specific service/resource is loaded and respond accordingly
			dispatch( new Event(SalesOrderService.LOADING));		
		}
		
		public function handleResult():void
		{
			dispatch( new Event(SalesOrderService.LOADED));
			//notify the LoadupUtility that this service loaded.
			dispatch( new ResourceEvent(ResourceEvent.RESOURCE_LOADED, this));
		}
		
		public function handleFault():void
		{
			dispatch( new Event(SalesOrderService.LOAD_FAILED));
			//notify the LoadupUtility that this service failed.
			dispatch( new ResourceEvent(ResourceEvent.RESOURCE_LOAD_FAILED, this));
		}
	}
}