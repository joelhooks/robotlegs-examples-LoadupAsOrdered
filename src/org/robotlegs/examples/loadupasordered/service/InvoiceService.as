package org.robotlegs.examples.loadupasordered.service
{
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Service;
	import org.robotlegs.utilities.async.AsyncStubService;
	import org.robotlegs.utilities.loadup.events.ResourceEvent;
	import org.robotlegs.utilities.loadup.interfaces.IResource;
	
	public class InvoiceService extends Service implements IResource
	{
		public static var LOADED:String = "invoiceServiceLoaded";
		public static var LOADING:String = "invoiceServiceLoading";
		public static var LOAD_FAILED:String = "invoiceServiceLoadFailed";
		
		protected var service:AsyncStubService;
		protected var probabilityOfFault:Number = .25;
		public function InvoiceService()
		{
			service = new AsyncStubService();
		}
		
		public function load():void
		{
			service.asyncAction(handleResult, handleFault)
			
			//this event is purely optional, and is used to let the framework know
			//that this specific service/resource is loaded and respond accordingly
			dispatch( new Event(InvoiceService.LOADING));		
		}
		
		public function handleResult():void
		{
			dispatch( new Event(InvoiceService.LOADED));
			//notify the LoadupUtility that this service loaded.
			dispatch( new ResourceEvent(ResourceEvent.RESOURCE_LOADED, this));
		}
		
		public function handleFault():void
		{
			dispatch( new Event(InvoiceService.LOAD_FAILED));
			//notify the LoadupUtility that this service failed.
			dispatch( new ResourceEvent(ResourceEvent.RESOURCE_LOAD_FAILED, this));
		}
	}
}