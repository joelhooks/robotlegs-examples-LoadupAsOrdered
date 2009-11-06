package org.robotlegs.examples.loadupasordered.events
{
	import flash.events.Event;
	
	public class CustomerServiceEvent extends Event
	{
		public function CustomerServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}