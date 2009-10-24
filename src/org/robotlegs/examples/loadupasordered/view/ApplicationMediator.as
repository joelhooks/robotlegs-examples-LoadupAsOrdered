package org.robotlegs.examples.loadupasordered.view
{
	import flash.events.Event;
	
	import org.robotlegs.examples.loadupasordered.service.CustomerService;
	import org.robotlegs.examples.loadupasordered.service.DebtorAccountService;
	import org.robotlegs.examples.loadupasordered.service.InvoiceService;
	import org.robotlegs.examples.loadupasordered.service.ProductService;
	import org.robotlegs.examples.loadupasordered.service.SalesOrderService;
	import org.robotlegs.mvcs.Mediator;
	import org.robotlegs.utilities.loadup.events.LoadupEvent;
	import org.robotlegs.utilities.loadup.events.LoadupMonitorEvent;
	
	public class ApplicationMediator extends Mediator
	{
		[Inject]
		public var view:LoadupAsOrdered;
		
		public function ApplicationMediator()
		{
		}
		
		override public function onRegister() : void
		{
			//relay the load event to the framework
			eventMap.mapListener( view, LoadupEvent.LOAD_RESOURCES, dispatch );
			
			eventMap.mapListener( eventDispatcher, LoadupMonitorEvent.LOADING_COMPLETE, handleLoadupComplete );
			eventMap.mapListener( eventDispatcher, LoadupMonitorEvent.LOADING_PROGRESS, handleLoadupProgress );
			eventMap.mapListener( eventDispatcher, LoadupMonitorEvent.LOADING_FINISHED_INCOMPLETE, handleLoadupFinishedIncomplete );
			
			eventMap.mapListener( eventDispatcher, CustomerService.LOADED, handleServiceLoaded );
			eventMap.mapListener( eventDispatcher, DebtorAccountService.LOADED, handleServiceLoaded );
			eventMap.mapListener( eventDispatcher, InvoiceService.LOADED, handleServiceLoaded );
			eventMap.mapListener( eventDispatcher, ProductService.LOADED, handleServiceLoaded );
			eventMap.mapListener( eventDispatcher, SalesOrderService.LOADED, handleServiceLoaded );
		}
		
		protected function handleLoadupComplete(event:LoadupMonitorEvent):void
		{
			view.displayText += "loading is complete";
			view.loadResourcesButton.enabled = true;
			//event.monitor.destroy();
		}

		protected function handleLoadupProgress(event:LoadupMonitorEvent):void
		{
			view.progressBar.setProgress(Number(event.data), 100);
		}

		protected function handleLoadupFinishedIncomplete(event:LoadupMonitorEvent):void
		{
			view.displayText += "loading finished incomplete\n";
			view.loadResourcesButton.enabled = true;
			
			//event.monitor.destroy();
		}
		
		protected function handleServiceLoaded(event:Event):void
		{
			view.displayText += event.type + "\n";
		}
	}
}