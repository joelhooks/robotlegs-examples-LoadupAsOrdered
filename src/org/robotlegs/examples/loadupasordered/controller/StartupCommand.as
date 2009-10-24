package org.robotlegs.examples.loadupasordered.controller
{
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.examples.loadupasordered.service.CustomerService;
	import org.robotlegs.examples.loadupasordered.service.DebtorAccountService;
	import org.robotlegs.examples.loadupasordered.service.InvoiceService;
	import org.robotlegs.examples.loadupasordered.service.ProductService;
	import org.robotlegs.examples.loadupasordered.service.SalesOrderService;
	import org.robotlegs.examples.loadupasordered.view.ApplicationMediator;
	import org.robotlegs.mvcs.Command;
	
	public class StartupCommand extends Command
	{
		override public function execute() : void
		{
			mediatorMap.mapView( LoadupAsOrdered, ApplicationMediator );
			
			injector.mapSingleton( CustomerService );
			injector.mapSingleton( DebtorAccountService );
			injector.mapSingleton( InvoiceService );
			injector.mapSingleton( ProductService );
			injector.mapSingleton( SalesOrderService );
			
			dispatch(new ContextEvent(ContextEvent.STARTUP_COMPLETE));
		}
	}
}