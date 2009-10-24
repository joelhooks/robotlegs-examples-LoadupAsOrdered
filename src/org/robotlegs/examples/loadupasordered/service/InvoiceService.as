package org.robotlegs.examples.loadupasordered.service
{
	import flash.events.Event;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import net.digitalprimates.fluint.stubs.HTTPServiceStub;
	
	import org.robotlegs.mvcs.Service;
	import org.robotlegs.utilities.loadup.events.ResourceEvent;
	import org.robotlegs.utilities.loadup.interfaces.IResource;
	
	public class InvoiceService extends Service implements IResource
	{
		public static var LOADED:String = "invoiceServiceLoaded";
		public static var LOADING:String = "invoiceServiceLoading";
		public static var LOAD_FAILED:String = "invoiceServiceLoadFailed";
		
		protected var service:HTTPServiceStub;
		protected var probabilityOfFault:Number = .25;
		public function InvoiceService()
		{
			service = new HTTPServiceStub();
			if ( Math.random() <= probabilityOfFault )
				service.fault(this, "service fault", "service fault", "service fault");
		}
		
		public function load():void
		{
			var token:AsyncToken = service.send(this);
			var responder:Responder = new Responder(handleResult, handleFault);
			
			token.addResponder(responder);
			
			//this event is purely optional, and is used to let the framework know
			//that this specific service/resource is loaded and respond accordingly
			dispatch( new Event(InvoiceService.LOADING));		
		}
		
		public function handleResult(event:ResultEvent):void
		{
			dispatch( new Event(InvoiceService.LOADED));
			//notify the LoadupUtility that this service loaded.
			dispatch( new ResourceEvent(ResourceEvent.RESOURCE_LOADED, this));
		}
		
		public function handleFault(event:FaultEvent):void
		{
			dispatch( new Event(InvoiceService.LOAD_FAILED));
			//notify the LoadupUtility that this service failed.
			dispatch( new ResourceEvent(ResourceEvent.RESOURCE_LOAD_FAILED, this));
		}
	}
}