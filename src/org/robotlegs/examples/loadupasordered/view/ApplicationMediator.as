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
	import org.robotlegs.utilities.loadup.events.ResourceEvent;
	
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
			
			eventMap.mapListener( eventDispatcher, CustomerService.LOADED, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, DebtorAccountService.LOADED, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, InvoiceService.LOADED, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, ProductService.LOADED, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, SalesOrderService.LOADED, handleServiceSpecificMessage );
			
			eventMap.mapListener( eventDispatcher, CustomerService.LOADING, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, DebtorAccountService.LOADING, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, InvoiceService.LOADING, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, ProductService.LOADING, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, SalesOrderService.LOADING, handleServiceSpecificMessage );

			eventMap.mapListener( eventDispatcher, CustomerService.LOAD_FAILED, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, DebtorAccountService.LOAD_FAILED, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, InvoiceService.LOAD_FAILED, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, ProductService.LOAD_FAILED, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, SalesOrderService.LOAD_FAILED, handleServiceSpecificMessage );

			eventMap.mapListener( eventDispatcher, CustomerService.LOAD_TIMED_OUT, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, DebtorAccountService.LOAD_TIMED_OUT, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, InvoiceService.LOAD_TIMED_OUT, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, ProductService.LOAD_TIMED_OUT, handleServiceSpecificMessage );
			eventMap.mapListener( eventDispatcher, SalesOrderService.LOAD_TIMED_OUT, handleServiceSpecificMessage );
		}
		
		protected function handleLoadupComplete(event:LoadupMonitorEvent):void
		{
			view.appendMessageText("loading is complete");
			view.loadResourcesButton.enabled = true;
			//event.monitor.destroy();
		}
		
		protected function handleServiceSpecificMessage(event:ResourceEvent):void
		{
			view.appendMessageText(event.type);
		}
	

		protected function handleLoadupProgress(event:LoadupMonitorEvent):void
		{
			view.progressBar.setProgress(Number(event.data), 100);
		}

		protected function handleLoadupFinishedIncomplete(event:LoadupMonitorEvent):void
		{
			view.appendMessageText("loading finished incomplete");
			view.loadResourcesButton.enabled = true;
			
			//event.monitor.destroy();
		}
	}
}