package mtasa.server;

import mtasa.server.enums.ElementSyncMode;
import mtasa.server.classes.Marker;
import mtasa.shared.types.RootElement;
import mtasa.shared.classes.Matrix;
import mtasa.shared.returns.GetElementAttachedOffsets;
import lua.Table;
import mtasa.shared.classes.Vector3;
import mtasa.server.classes.Player;
import mtasa.server.classes.Element;

@:native('_G')
extern class ElementFunctions {
	/**
		This function subscribes a player to specific element data.
		This function is used together with setElementData in "subscribe" mode.

		@param theElement The element you wish to subscribe the player to.
		@param key The key you wish to subscribe the player to.
		@param thePlayer The player you wish to subscribe.
	**/
	static function addElementDataSubscriber(theElement:Element, key:String, thePlayer:Player):Bool;

	/**
		This function attaches one element to another, so that the first one follows the second whenever it moves.If an attempt is made to attach two elements that are already attached the opposite way (eg theElement becomes theAttachToElement and vice versa), the 1st attachment order is automatically detached in favor of the 2nd attachment order. For example, if carA was attached to carB, now carB is attached to carA. Also, an element cannot be attached to two separate elements at one time. For example, two cars can be attached to one single car, but one single car cannot be attached to two separate cars. If you attempt to do this, the existing attachment will automatically be dropped in favor of the new attachment. For example, if carA is asked to attached to carB then carC, it is only attached to carC.

		@param theElement The element to be attached.
		@param theAttachToElement The element to attach the first to.
	**/
	static function attachElements(theElement:Element, theAttachToElement:Element, offsetPosition:Vector3, offsetRotation:Vector3):Bool;

	/**
		This function clears any settings added by setElementVisibleTo and restores an element to its default visibility.  This does not work with all entities - vehicles, players and objects are exempt. This is because these objects are required for accurate sync (they're physical objects). This function is particularily useful for changing the visibility of markers, radar blips and radar areas.

		@param theElement The element in which you wish to restore to its default visibility
	**/
	static function clearElementVisibleTo(theElement:Element):Bool;

	/**
		This function clones (creates an exact copy of) an already existing element. 
		The root node, and player elements, cannot be cloned. 
		If a player element is a child of an element that is cloned, it will be skipped, 
		along with the elements that exist as a child to the player element.
		Players are not the only elements that cannot be cloned. 
		This list also includes remoteclients, and console elements.

		@param theElement The element that you wish to clone.
		@param position A position on map
		@param cloneChildren A boolean value representing whether or not the element's children will be cloned.
	**/
	static function cloneElement(theElement:Element, ?position:Vector3, ?cloneChildren:Bool):Element;

	/**
		This function is used to create a new dummy element in the element tree which do not necessarily represent an entity within the San Andreas world. A common use for this function is for creating custom elements, such as a Flag or a Base.Elements created using this function are placed in the element tree with their parent as the 'dynamic' map element.

		@param elementType The type of element being created.
		@param elementID The ID of the element being created.
	**/
	static function createElement(elementType:String, ?elementID:String):Element;

	/**
		This function destroys an element and all elements within it in the hierarchy (its children, the children of those children etc). Player elements cannot be destroyed using this function. A player can only be removed from the hierarchy when they quit or are kicked. The root element also cannot be destroyed, however, passing the root as an argument will wipe all elements from the server, except for the players and clients, which will become direct descendants of the root node, and other elements that cannot be destroyed, such as resource root elements.

		@param elementToDestroy The element you wish to destroy.
	**/
	static function destroyElement(elementToDestroy:Element):Bool;

	/**
		This function detaches attached elements from one another.

		@param theElement The element to be detached (the "child")
	**/
	static function detachElements(theElement:Element, ?theAttachToElement:Element):Bool;

	/**
		Returns a table of all element data of an element.

		@param theElement the element you want to get the element data of.
	**/
	static function getAllElementData(theElement:Element):Table<String, Dynamic>;

	/**
		This function returns a table of all the elements attached to the specified element

		@param theElement The element which you require the information from.
	**/
	static function getAttachedElements(theElement:Element):Table<Int, Element>;

	/**
		This function returns the alpha (transparency) value for the specified element. This can be a player, ped, object, vehicle or weapon.

		@param theElement The element whose alpha you want to retrieve.
	**/
	static function getElementAlpha(theElement:Element):Int;

	/**
		This function returns the offsets of an element that has been attached to another element using attachElements.

		@param theElement The attached element.
	**/
	static function getElementAttachedOffsets(theElement:Element):GetElementAttachedOffsets;

	/**
		This function determines the element that the specified element is attached to.

		@param theElement The element you require the information for.
	**/
	static function getElementAttachedTo(theElement:Element):Element;

	/**
		This function indicates if a specific element is set to have collisions disabled. An element without collisions does not interact with the physical environment and remains static.

		@param theElement The element for which you want to check whether collisions are enabled
	**/
	static function getElementCollisionsEnabled(theElement:Element):Bool;

	/**
		This function returns an element of the specified type with the specified index.

		@param theType the type of the element to be returned. Examples include "player", "vehicle", or a custom type.
		@param index the element's index (0 for the first element, 1 for the second, etc).
	**/
	static function getElementByIndex(theType:String, index:Int):Element;

	/**
		This function returns one of the child elements of a given parent element. The child element is selected by its index (0 for the first child, 1 for the second and so on).

		@param parent the element above the one to be returned in the hierarchy.
		@param index the element's index (0 for the first element, 1 for the second, etc).
	**/
	static function getElementChild(parent:Element, index:Int):Element;

	/**
		This function is used to retrieve a list of the child elements of a given parent element. Note that it will only return direct children and not elements that are further down the element tree.

		@param parent Supply this argument with the parent of the children you want returned.
		@param theType The type of element you want a list of.
	**/
	static function getElementChildren(parent:Element, ?theType:String):Table<Int, Element>;

	/**
		This function returns the number of children an element has. Note that only the direct children are counted and not elements that are further down the element tree.

		@param parent the parent element
	**/
	static function getElementChildrenCount(parent:Element):Int;

	/**
		This function retrieves element data attached to an element under a certain key.

		@param theElement This is the element with data you want to retrieve.
		@param key The name of the element data entry you want to retrieve. (Maximum 31 characters.)
		@param inherit - toggles whether or not the function should go up the hierarchy to find the requested key in case the specified element doesn't have it.
	**/
	static function getElementData(theElement:Element, key:String, ?inherit:Bool = true):Dynamic;

	/**
		This function allows you to retrieve the dimension of any element. The dimension determines what/who the element is visible to.

		@param theElement The element in which you'd like to retrieve the dimension of.
	**/
	static function getElementDimension(theElement:Element):Int;

	/**
		This function returns the current health for the specified element. This can be a player, a ped, a vehicle, or an object.

		@param theElement The player or vehicle whose health you want to check.
	**/
	static function getElementHealth(theElement:Element):Float;

	/**
		This function allows you to retrieve the interior of any element. An interior is the current loaded place, 0 being outside.

		@param theElement The element of which you'd like to retrieve the interior
	**/
	static function getElementInterior(theElement:Element):Int;

	/**
		This function gets an element's transform matrix. This contains 16 float values that multiplied to a point will give you the point transformed. It is most useful for matrix calculations such as calculating offsets. For further information, please refer to a tutorial of matrices in computer graphics programming.

		@param theElement The element which you wish to retrieve the matrix for.
		@param legacy Set to false to return correctly setup matrix (i.e. Last column in the first 3 rows set to zero).
	**/
	static function getElementMatrix(theElement:Element, ?legacy:Bool = true):Matrix;

	/**
		Returns the model ID of a given element. This can be a player/ped skin, a pickup model, an object model or a vehicle model.

		@param theElement the element to retrieve the model ID of.
	**/
	static function getElementModel(theElement:Element):Int;

	/**
		This function is used to determine the parent of an element.

		@param theElement The child of the parent element you want returned.
	**/
	static function getElementParent(theElement:Element):Element;

	/**
		The getElementPosition function allows you to retrieve the position coordinates of an element.  This can be any real world element, including:

		@param theElement The element which you'd like to retrieve the location of
	**/
	static function getElementPosition(theElement:Element):Vector3;

	/**
		Retrieve the rotation of elements.

		@param theElement The element whose rotation will be retrieved
		@param rotOrder A string representing the rotation order desired when returning the euler angles. If omitted, default value is "default".
	**/
	static function getElementRotation(theElement:Element, ?rotOrder:String = "default"):Float;

	/**
		This function gets the syncer of an element. The syncer is the player who is in control of the element.

		@param theElement The element to get the syncer of.
	**/
	static function getElementSyncer(theElement:Element):Element;

	/**
		This function is used to retrieve the type of an element.

		@param theElement The element you wish to get the type of.
	**/
	static function getElementType(theElement:Element):String;

	/**
		This function returns three floats containing the velocity (movement speeds) along the X, Y, and Z axis respectively. This means that velocity values can be positive and negative for each axis.

		@param theElement The element you wish to retrieve the velocity of.
	**/
	static function getElementVelocity(theElement:Element):Vector3;

	/**
		This function allows you to retrieve the zone name of an element (eg. Verdant Bluffs or Ocean Docks)

		@param theElement The element which you'd like to retrieve the zone name from
	**/
	static function getElementZoneName(theElement:Element, ?citiesonly:Bool = false):String;

	/**
		This function is used to retrieve a list of all elements of the specified type. This can be useful, as it disregards where in the element tree it is. It can be used with either the built in types (listed below) or with any custom type used in a .map file. For example, if there is an element of type "flag" (e.g. <flag />) in the .map file, the using "flag" as the type argument would find it.

		@param theType The type of element you want a list of. This is the same as the tag name in the .map file, so this can be used with a custom element type if desired. Built in types can be found here: Element
	**/
	static function getElementsByType(theType:String, ?startat:Element):Table<Int, Element>;

	/**
		This function returns the root node of the element tree, called root. This node contains every other element: all resource root elements, players and remote clients. It is never destroyed and cannot be destroyed using destroyElement.
	**/
	static function getRootElement():RootElement;

	/**
		This function checks if an element has element data available under a certain key.

		@param theElement This is the element with data you want to check.
		@param key The name of the element data entry you want to check for. (Maximum 31 characters.)
		@param inherit - toggles whether or not the function should go up the hierarchy to find the requested key in case the specified element doesn't have it.
	**/
	static function hasElementData(theElement:Element, key:String, ?inherit:Bool = true):Bool;

	/**
		This function returns whether a player is subscribed to specific element data.
		This function is used together with setElementData in "subscribe" mode.

		@param theElement The element you wish to check whether the player is subscribed to.
		@param key The key you wish to check whether the player is subscribed to.
		@param thePlayer The player you wish to check.
	**/
	static function hasElementDataSubscriber(theElement:Element, key:String, thePlayer:Player):Bool;

	/**
		This functions checks whether or not an element is attached to another element.

		@param theElement The element to check for attachment.
	**/
	static function isElementAttached(theElement:Element):Bool;

	/**
		This functions checks if certain element has call propagation enabled.

		@param theElement The element to check
	**/
	static function isElementCallPropagationEnabled(theElement:Element):Bool;

	/**
		This function checks whether an element is double-sided as set by setElementDoubleSided or not.

		@param theElement The element in which you'd like to check the double-sidedness of.
	**/
	static function isElementDoubleSided(theElement:Element):Bool;

	/**
		This function checks if element has been frozen.

		@param theElement the element whose freeze status we want to check.
	**/
	static function isElementFrozen(theElement:Element):Bool;

	/**
		This function checks whether an element is submerged in water.

		@param theElement The element to check.
	**/
	static function isElementInWater(theElement:Element):Bool;

	/**
		This checks if an element is visible to a player. This does not check if the player can literally see the element, just that they are aware that it exists. Some so-called per-player elements are able to be visible only to some players, as such this checks if this is the case for a particular element/player combination.

		@param theElement The element you want to check the visibility of
		@param visibleTo The player you want to check against
	**/
	static function isElementVisibleTo(theElement:Element, visibleTo:Element):Bool;

	/**
		This function is used to determine if an element is within a marker.

		@param theElement The element you're checking.
		@param theMarker The marker you're checking.
	**/
	static function isElementWithinMarker(theElement:Element, theMarker:Marker):Bool;

	/**
		This function removes the element data with the given key for that element. The element data removal is synced with all the clients.

		@param theElement The element you wish to remove the data from.
		@param key The key string you wish to remove.
	**/
	static function removeElementData(theElement:Element, key:String):Bool;

	/**
		This function unsubscribes a player from specific element data.
		This function is used together with setElementData in "subscribe" mode.

		@param theElement The element you wish to unsubscribe the player from.
		@param key The key you wish to unsubscribe the player from.
		@param thePlayer The player you wish to unsubscribe.
	**/
	static function removeElementDataSubscriber(theElement:Element, key:String, thePlayer:Player):Bool;

	/**
		This function sets the alpha (transparency) value for the specified element. This can be a player, ped, object, vehicle or weapon.

		@param theElement The element whose alpha you want to set.
		@param alpha The alpha value to set. Values are 0-255, where 255 is fully opaque and 0 is fully transparent.
	**/
	static function setElementAlpha(theElement:Element, alpha:Int):Bool;

	/**
		Sets the angular velocity of a specified, supported element (Applies a spin to it).

		@param theElement The element to apply the spin to. Can be either a player, ped, object, vehicle or a custom weapon.
		@param velocity Vector3 velocity
	**/
	static function setElementAngularVelocity(theElement:Element, velocity:Vector3):Bool;

	/**
		Gets the current angular velocity of a specified, supported element.

		@param theElement The element to retrieve the angular velocity from. Can be either a player, ped, object, vehicle or a custom weapon. Server side supports only vehicles currently.
	**/
	static function getElementAngularVelocity(theElement:Element):Vector3;

	/**
		This function updates the offsets of an element that has been attached to another element using attachElements.

		@param theElement The attached element.
	**/
	static function setElementAttachedOffsets(theElement:Element, ?offsetPosition:Vector3, ?offsetRotation:Vector3):Bool;

	/**
		This function enables/disables call propagation on a certain element. Look at the example for a practical application.

		@param theElement The element whose propagation behaviour you'd like to change
		@param enabled Whether propagation should be enabled or not
	**/
	static function setElementCallPropagationEnabled(theElement:Element, enabled:Bool):Bool;

	/**
		This function can disable or enable an element's collisions. An element without collisions does not interact with the physical environment and remains static.

		@param theElement The element you wish to set the collisions of
		@param enabled A boolean to indicate whether collisions are enabled (true) or disabled (false)
	**/
	static function setElementCollisionsEnabled(theElement:Element, enabled:Bool):Bool;

	/**
		This function stores element data under a certain key, attached to an element. Element data set using this is then synced with all clients and the server. The data can contain server created elements, but you should avoid passing data that is not able to be synced such as xmlnodes, acls, aclgroups etc.

		@param theElement The element you wish to attach the data to.
		@param key The key you wish to store the data under. (Maximum 128 characters.)
		@param value The value you wish to store. See element data for a list of acceptable datatypes.
		@param syncMode Synchronisation mode. 
	**/
	static function setElementData(theElement:Element, key:String, value:Dynamic, ?syncMode:ElementSyncMode = ElementSyncMode.BROADCAST):Bool;

	/**
		This function allows you to set the dimension of any element. The dimension determines what/who the element is visible to.

		@param theElement The element in which you'd like to set the dimension of.
		@param dimension An integer representing the dimension ID. You can also use -1 to make the element visible in all dimensions (only valid to objects). Valid values are 0 to 65535.
	**/
	static function setElementDimension(theElement:Element, dimension:Int):Bool;

	/**
		This function allows you to set the double-sidedness of an element's model. When an element's model is double-sided, it's back facing triangles become visible.

		@param theElement The element in which you'd like to set the double-sidedness of.
		@param enable  Set to true/false to enable/disable double-sidedness.
	**/
	static function setElementDoubleSided(theElement:Element, enable:Bool):Bool;

	/**
		This function freezes an element (stops it in its position and disables movement) or unfreezes it.

		@param theElement The element whose freeze status we want to change.
		@param freezeStatus A boolean denoting whether we want to freeze (true) or unfreeze (false) it.
	**/
	static function setElementFrozen(theElement:Element, freezeStatus:Bool):Bool;

	/**
		This function sets the health for the specified element. This can be a ped, object or a vehicle.

		@param theElement The ped, vehicle or object whose health you want to set.
		@param newHealth A float indicating the new health to set for the element.
	**/
	static function setElementHealth(theElement:Element, newHealth:Float):Bool;

	/**
		This function allows you to set the interior of any element. An interior is the current loaded place, 0 being outside.

		@param theElement The element in which you'd like to set the interior of.
		@param interior The interior you want to set the element to. Valid values are 0 to 255.
	**/
	static function setElementInterior(theElement:Element, interior:Int, ?position:Vector3):Bool;

	/**
		Sets the model of a given element. This allows you to change the model of a player (or ped), a vehicle or an object.

		@param theElement the element you want to change.
		@param model the model ID to set.
	**/
	static function setElementModel(theElement:Element, model:Int):Bool;

	/**
		This function is used for setting an element as the parent of another element.

		@param theElement The element that you wish to set the parent of.
		@param parent The element you wish to be the parent of theElement.
	**/
	static function setElementParent(theElement:Element, parent:Element):Bool;

	/**
		This function sets the position of an element to the specified coordinates.

		@param theElement A valid element to be moved.
		@param position New element position
		@param warp teleports players, resetting any animations they were doing. Setting this to false preserves the current animation.
	**/
	static function setElementPosition(theElement:Element, ?position:Vector3, ?warp:Bool = true):Bool;

	/**
		Sets the rotation of elements according to the world (does not work with players that are on the ground).

		@param theElement The element whose rotation will be set
		@param rotation The element's rotation 
		@param rotOrder A string representing the rotation order desired when interpreting the provided euler angles. If omitted, default value is "default". Allowed values are:
		@param conformPedRotation A bool which should be set to true to ensure the ped rotation is correctly set in all circumstances.
	**/
	static function setElementRotation(theElement:Element, rotation:Vector3, ?rotOrder:String = "default", ?conformPedRotation:Bool = false):Bool;

	/**
		This function can be used to change the syncer (player) of an element. The syncer is the player who is responsible for informing the server about the state of that element - it's position, orientation and other state information. The function can be also used to remove an element's syncer.

		@param theElement The element whose syncer you wish to change.
		@param thePlayer The player who should be the new syncer of the element. If set to false, this element will not have a syncer. If set to true, MTA will pick automatically the nearest or most relevant player to that element.
	**/
	static function setElementSyncer(theElement:Element, thePlayer:Player):Bool;

	/**
		This function sets the velocity (movement speeds) along each axis, for an element.

		@param theElement The element you wish to set the velocity of.
		@param speed A vector value determining the speed.
	**/
	static function setElementVelocity(theElement:Element, speed:Vector3):Bool;

	/**
		Does the order of setElementVisibleTo calls really not matter? Visibility seems to imply that the order does matter.

		@param theElement The element you want to control the visibility of.
		@param visibleTo The element you wish the element to be visible or invisible to. Any child elements that are players will also be able to see the element. See visibility.
		@param visible Whether you are making it visible or invisible to the player.
	**/
	static function setElementVisibleTo(theElement:Element, visibleTo:Element, visible:Bool):Bool;

	/**
		This function assigns a low LOD element to an element. The low LOD element is displayed when its associated element is not fully visible. If a low LOD element is assigned to several elements, it will be displayed when any of these elements are not fully visible.

		@param theElement The element whose low LOD version we want to change.
		@param lowLODElement  A low LOD element to display when the first element is not fully visible.
	**/
	static function setLowLODElement(theElement:Element, lowLODElement:Element):Bool;
}
