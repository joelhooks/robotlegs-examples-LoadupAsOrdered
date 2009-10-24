package org.robotlegs.examples.loadupasordered.service
{
	import flash.events.Event;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import net.digitalprimates.fluint.stubs.HTTPServiceStub;
	
	import org.robotlegs.mvcs.Service;
	import org.robotlegs.utilities.async.AsyncStubService;
	import org.robotlegs.utilities.loadup.events.ResourceEvent;
	import org.robotlegs.utilities.loadup.interfaces.IResource;
	
	public class CustomerService extends Service implements IResource
	{
		public static var LOADED:String = "customerServiceLoaded";
		public static var LOADING:String = "customerServiceLoading";
		public static var LOAD_FAILED:String = "customerServiceLoadFailed";
		
		protected var service:AsyncStubService;
		
		public function CustomerService()
		{
			service = new AsyncStubService();
		}
		
		public function load():void
		{
			service.asyncAction(handleResult, handleFault)
			
			//this event is purely optional, and is used to let the framework know
			//that this specific service/resource is loaded and respond accordingly
			dispatch( new Event(CustomerService.LOADING));		
		}
		
		public function handleResult():void
		{
			//this event is purely optional, and is used to let the framework know
			//that this specific service/resource is loaded and respond accordingly
			dispatch( new Event(CustomerService.LOADED));
			//notify the LoadupUtility that this service loaded.
			dispatch( new ResourceEvent(ResourceEvent.RESOURCE_LOADED, this));
		}
		
		public function handleFault():void
		{
			//this event is purely optional, and is used to let the framework know
			//that this specific service/resource is loaded and respond accordingly
			dispatch( new Event(CustomerService.LOAD_FAILED));	
			//notify the LoadupUtility that this service failed.
			dispatch( new ResourceEvent(ResourceEvent.RESOURCE_LOAD_FAILED, this));
		}
		
		
	}
}