package mtasa.server;

import mtasa.shared.returns.GetMarkerColor;
import mtasa.server.classes.Element;
import mtasa.shared.enums.MarkerType;
import mtasa.shared.classes.Vector3;
import mtasa.shared.enums.MarkerIcon;
import mtasa.server.classes.Marker;

@:native('_G')
extern class MarkerFunctions {
	/**
		This function creates a marker. A marker is a 3D model in the world that can highlight a particular point or area, often used to instruct players where to go to perform actions such as entering buildings.

		@param position Vector3 marker position
		@param theType The visual type of the marker to be created.
		@param size The diameter of the marker to be created, in meters.
		@param r An integer number representing the amount of red to use in the colouring of the marker (0 - 255).
		@param g An integer number representing the amount of green to use in the colouring of the marker (0 - 255).
		@param b An integer number representing the amount of blue to use in the colouring of the marker (0 - 255).
		@param a An integer number representing the amount of alpha to use in the colouring of the marker (0 - 255 where 0 is transparent and 255 is opaque).
		@param visibleTo This defines which elements can see the marker. Defaults to visible to everyone.
	**/
	static function createMarker(position:Vector3, ?theType:MarkerType, ?size:Float = 4.0, ?r:Int = 0, ?g:Int = 0, ?b:Int = 255, ?a:Int = 255,
		?visibleTo:Element):Marker;

	/**
		This function returns the color and transparency for a marker element. Not all marker types support transparency.OOP Syntax Help! I don't understand this!

		@param theMarker The marker that you wish to retrieve the color of.
	**/
	static function getMarkerColor(theMarker:Marker):GetMarkerColor;

	/**
		Returns the number of markers that currently exist in the world.
	**/
	static function getMarkerCount():Int;

	/**
		This function returns the icon name for a marker.OOP Syntax Help! I don't understand this!

		@param theMarker A marker element referencing the specified marker.
	**/
	static function getMarkerIcon(theMarker:Marker):MarkerIcon;

	/**
		This function returns a float containing the size of the specified marker.OOP Syntax Help! I don't understand this!

		@param myMarker The marker that you wish to retrieve the size of.
	**/
	static function getMarkerSize(myMarker:Marker):Float;

	/**
		This function returns the position of the specified marker's target, the position it points to. This only works for checkpoint markers and ring markers. For checkpoints it returns the position the arrow is pointing to, for ring markers it returns the position the ring is facing. You can set this target with setMarkerTarget.OOP Syntax Help! I don't understand this!

		@param theMarker The marker you wish to retrieve the target position of.
	**/
	static function getMarkerTarget(theMarker:Marker):Float;

	/**
		This function returns a marker's type.OOP Syntax Help! I don't understand this!

		@param theMarker A marker element referencing the specified marker.
	**/
	static function getMarkerType(theMarker:Marker):MarkerType;

	/**
		This function sets the color of the specified marker by modifying the values for red, green, blue and alpha.OOP Syntax Help! I don't understand this!

		@param theMarker The marker that you wish to set the color of.
		@param r The amount of red in the final color (0 to 255).
		@param g The amount of green in the final color (0 to 255).
		@param b The amount of blue in the final color (0 to 255).
		@param a The amount of alpha in the final color (0 to 255).
	**/
	static function setMarkerColor(theMarker:Marker, r:Int, g:Int, b:Int, a:Int):Bool;

	/**
		This function allows changing the icon of a checkpoint marker.

		@param theMarker The marker to change the visual style of
		@param icon A string referring to the type of icon, acceptable values are:
	**/
	static function setMarkerIcon(theMarker:Marker, icon:MarkerIcon):Bool;

	/**
		This function sets the size of the specified marker.Setting negative value will "flip" the marker, do nothing or make it invisible:

		@param theMarker The marker that you wish to set the size of.
		@param size A float representing new size of the marker.
	**/
	static function setMarkerSize(theMarker:Marker, size:Float):Bool;

	/**
		This function sets the 'target' for a marker. Only the checkpoint and ring marker types can have a target.

		@param theMarker The marker to set the target of
		@param coordinates The target coordinates
	**/
	static function setMarkerTarget(theMarker:Marker, coordinates:Vector3):Bool;

	/**
		This function changes a marker's type. The type controls how the marker is displayed in the game. It's important that you use marker types that users are used to from the single player game. For example, checkpoints are used in races, rings are used for aircraft races, arrows are used for entering buildings etc.OOP Syntax Help! I don't understand this!

		@param theMarker A marker element referencing the specified marker.
		@param markerType A string denoting the marker type. Valid values are:
	**/
	static function setMarkerType(theMarker:Marker, markerType:MarkerType):Bool;
}
