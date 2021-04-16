package mtasa.server;

import mtasa.server.classes.Player;
import mtasa.server.classes.Element;
import mtasa.server.classes.XMLNode;

@:native('_G')
extern class MapFunctions {
	/**
		This function is intended to load data from a loaded XML file into the element tree. This could be used for loading an external map, or part of another map.

		@param node The node that you wish to load into the element tree.
		@param parent The node you wish to be the parent of the new map data.
	**/
	static function loadMapData(node:XMLNode, parent:Element):Element;

	/**
		This function is used to reset the state of a player.  It is intended to restore a player to his default state as if he had just joined the server, without any scripts affecting him.
	**/
	static function resetMapInfo(?thePlayer:Player):Bool;

	/**
		This converts a set of elements in the element tree into XML. This is a format that can then be loaded as a map file. Each element represents a single XML node.

		@param node An existing node that should contain the contents of baseElement
		@param baseElement The first element to output to the XML tree. This element and all its children (and their children, etc) will be output.
		@param childrenOnly Defines if you want to only save children of the specified element.
	**/
	static function saveMapData(node:XMLNode, baseElement:Element, ?childrenOnly:Bool = false):Bool;
}
