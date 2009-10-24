package org.robotlegs.examples.loadupasordered.controller
{
	import org.robotlegs.examples.loadupasordered.service.CustomerService;
	import org.robotlegs.examples.loadupasordered.service.DebtorAccountService;
	import org.robotlegs.examples.loadupasordered.service.InvoiceService;
	import org.robotlegs.examples.loadupasordered.service.ProductService;
	import org.robotlegs.examples.loadupasordered.service.SalesOrderService;
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.loadup.interfaces.ILoadupResource;
	import org.robotlegs.utilities.loadup.model.LoadupMonitor;
	
	public class LoadResourcesCommand extends Command
	{
		[Inject]
		public var customerService:CustomerService;
		
		[Inject]
		public var debtorService:DebtorAccountService;
		
		[Inject]
		public var invoiceService:InvoiceService;
		
		[Inject]
		public var productService:ProductService;
		
		[Inject]
		public var salesOrderService:SalesOrderService;
		
		override public function execute() : void
		{
			var loadupMonitor:LoadupMonitor = new LoadupMonitor(eventDispatcher);
			
			var customerResource:ILoadupResource = loadupMonitor.addResource( customerService );
			var debtorResource:ILoadupResource = loadupMonitor.addResource( debtorService );
			var invoiceResource:ILoadupResource = loadupMonitor.addResource( invoiceService );
			
			loadupMonitor.addResource(productService);
			loadupMonitor.addResource(salesOrderService);
			
			//required resources can be IResource or ILoadupResource
			customerResource.required = [productService];
			debtorResource.required = [invoiceResource];
			invoiceResource.required = [customerResource];
			
			loadupMonitor.startResourceLoading()
		}
	}
}