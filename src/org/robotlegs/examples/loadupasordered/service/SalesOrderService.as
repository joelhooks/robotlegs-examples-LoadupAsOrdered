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
	import org.robotlegs.utilities.loadup.model.ResourceEventTypes;
	
	public class SalesOrderService extends Service implements IResource
	{
		public static var LOADED:String = "salesOrderServiceLoaded";
		public static var LOADING:String = "salesOrderServiceLoading";
		public static var LOAD_FAILED:String = "salesOrderServiceLoadFailed";
		public static var LOAD_TIMED_OUT:String = "salesOrderServiceLoadTimedOut";
		
		protected var service:HTTPServiceStub;
		
		public function SalesOrderService()
		{
			service = new HTTPServiceStub();
		}
		
		public function load():void
		{
			var token:AsyncToken = service.send();
			var responder:Responder = new Responder(handleResult, handleFault);
			
			token.addResponder(responder);
			
		}
		
		public function getResourceEventTypes(value:ResourceEventTypes):ResourceEventTypes
		{
			value.loading = LOADING;
			value.loaded = LOADED;
			value.loadingFailed = LOAD_FAILED;
			value.loadingTimedOut = LOAD_TIMED_OUT;
			return value;
		}
		
		public function handleResult(event:ResultEvent):void
		{
			//notify the LoadupUtility that this service loaded.
			dispatch( new ResourceEvent(ResourceEvent.RESOURCE_LOADED, this));
		}
		
		public function handleFault(event:FaultEvent):void
		{
			//notify the LoadupUtility that this service failed.
			dispatch( new ResourceEvent(ResourceEvent.RESOURCE_LOAD_FAILED, this));
		}
	}
}