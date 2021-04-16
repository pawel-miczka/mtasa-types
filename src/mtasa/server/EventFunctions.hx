package mtasa.server;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;
import lua.Table;
import mtasa.server.classes.Element;
import mtasa.server.classes.Player;
import mtasa.shared.enums.LatentEventStatus;

@:native('_G')
extern class EventFunctions {
	/**
		This function allows you to register a custom event. Custom events function exactly like the built-in events. See event system for more information on the event system.Returns true if the event was added successfully, false if the event was already added.

		@param eventName The name of the event you wish to create.
		@param allowRemoteTrigger A boolean specifying whether this event can be called remotely using triggerClientEvent / triggerServerEvent or not.
	**/
	static function addEvent(eventName:String, ?allowRemoteTrigger:Bool = false):Bool;

	/**
		This function will add an event handler. An event handler is a function that will be called when the event it's attached to is triggered. See event system for more information on how the event system works.

		@param eventName The name of the event you want to attach the handler function to. Note: The maximum allowed length is 100 ASCII characters (that is, English letters and numerals)```
		@param attachedTo The element you wish to attach the handler to. The handler will only be called when the event it is attached to is triggered for this element, or one of its children. Often, this can be the root element (meaning the handler will be called when the event is triggered for any element).
		@param handlerFunction The handler function you wish to call when the event is triggered. This function will be passed all of the event's parameters as arguments, but it isn't required that it takes all of them.
		@param propagate A boolean representing whether the handler will be triggered if the event was propagated down or up the element tree (starting from the source), and not triggered directly on attachedTo (that is, handlers attached with this argument set to false will only be triggered if source == this). In GUI events you will probably want to set this to false.
	**/
	static function addEventHandler(eventName:String, attachedTo:Element, handlerFunction:Function, ?propagate:Bool = true, ?priority:String = "normal"):Bool;

	/**
		This function is used to stop the automatic internal handling of events, for example this can be used to prevent an item being given to a player when they walk over a pickup, by canceling the onPickupUse event.cancelEvent does not have an effect on all events, see the individual event's pages for information on what happens when the event is canceled. cancelEvent does not stop further event handlers from being called, as the order of event handlers being called is undefined in many cases. Instead, you can see if the currently active event has been cancelled using wasEventCancelled.


	**/
	static function cancelEvent(?cancel:Bool = true, ?reason:String):Bool;

	/**
		Stops a latent event from completingReturns a true if the latent event was successfully cancelled, or false if it was not

		@param thePlayer The player who is receiving the event.
		@param handle A handle previous got from getLatentEventHandles.
		@param handle A handle previous got from getLatentEventHandles.
	**/
	static function cancelLatentEvent(thePlayer:Player, handle:Int):Bool;

	/**
		Gets the reason for cancelling an event.None
	**/
	static function getCancelReason():String;

	/**
		This function gets the attached functions from the event and attached element from current lua script.Returns table with attached functions, empty table otherwise.

		@param eventName The name of the event. For example ( "onPlayerWasted" ).
		@param attachedTo The element attached to.
	**/
	static function getEventHandlers(eventName:String, attachedTo:Element):Table<Int, Function>;

	/**
		Gets the currently queued latent events. The last one in the table is always the latest event queued. Each returned handle can be used with getLatentEventStatus or cancelLatentEvent

		@param thePlayer The player who is receiving the events.
	**/
	static function getLatentEventHandles(thePlayer:Player):Table<Int, Function>;

	/**
		Gets the status of one queued latent event.Returns a table with the following info or false if invalid arguments were passed:

		@param thePlayer The player who is receiving the event.
		@param handle A handle previous got from getLatentEventHandles.
	**/
	static function getLatentEventStatus(thePlayer:Player, handle:Int):Map<LatentEventStatus, Int>;

	/**
		This functions removes a handler function from an event, so that the function is not called anymore when the event is triggered. See event system for more information on how the event system works.Returns true if the event handler was removed successfully. Returns false if the specified event handler could not be found or invalid parameters were passed.

		@param eventName The name of the event you want to detach the handler function from.
		@param attachedTo The element the handler was attached to.
		@param handler The handler function that was attached.
	**/
	static function removeEventHandler(eventName:String, attachedTo:Element, handler:Function):Bool;

	/**
		This function will trigger a named event on a specific element in the element tree. See event system for more information on how the event system works.You can use the value returned from this function to determine if the event was cancelled by one of the event handlers. You should determine what your response (if any) to this should be based on the event's purpose. Generally, cancelling an event should prevent any further code being run that is dependent on whatever triggered that event. For example, if you have an onFlagCapture event, cancelling it would be expected to prevent the flag being able to be captured. Similarly, if you have onPlayerKill as an event you trigger, canceling it would either be expected to prevent the player being killed from dying or at least prevent the player from getting a score for it.

		@param eventName The name of the event you wish to trigger
		@param baseElement The element you wish to trigger the event on. See event system for information on how this works.
	**/
	static function triggerEvent(eventName:String, baseElement:Element, arguments:Rest<Dynamic>):Bool;

	/**
		This function triggers an event previously registered on a client. This is the primary means of passing information between the server and the client. Clients have a similar triggerServerEvent function that can do the reverse. You can treat this function as if it was an asynchronous function call, using triggerServerEvent to pass back any returned information if necessary.Almost any data types can be passed as expected, including elements and complex nested tables. Non-element MTA data types like xmlNodes or resource pointers will not be able to be passed as they do not necessarily have a valid representation on the client.

		@param name The name of the event to trigger client side. You should register this event with addEvent and add at least one event handler using addEventHandler.
		@param sourceElement The element that is the source of the event.
	**/
	static function triggerClientEvent(?sendTo:EitherType<Table<Int, Player>, Element>, name:String, sourceElement:Element):Bool;

	/**
		This function is the same as triggerClientEvent  except the transmission rate of the data contained in the arguments can be limited
		and other network traffic is not blocked while the data is being transferred.Returns true if the event trigger has been sent, false if invalid arguments were specified.

		@param name The name of the event to trigger client side. You should register this event with addEvent and add at least one event handler using addEventHandler.
		@param theElement The element that is the source of the event. This could be another player, or if this isn't relevant, use the root element.
		@param sendTo The event will be sent to all players that are children of the specified element. By default this is the root element, and hence the event is sent to all players. If you specify a single player it will just be sent to that player. This argument can also be a table of player elements.
		@param bandwidth The bytes per second rate to send the data contained in the arguments.
		@param persist A bool indicating whether the transmission should be allowed to continue even after the resource that triggered it has since stopped.
	**/
	static function triggerLatentClientEvent(?sendTo:EitherType<Table<Int, Player>, Element>, name:String, ?bandwidth:Int = 50000, ?persist:Bool = false,
		theElement:Element, arguments:Rest<Dynamic>):Bool;

	/**
		This function checks if the last completed event was cancelled. This is mainly useful for custom events created by scripts.
	**/
	static function wasEventCancelled():Bool;
}
