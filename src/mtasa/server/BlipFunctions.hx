package mtasa.server;

import mtasa.shared.classes.Vector3;
import mtasa.server.classes.Element;
import mtasa.shared.enums.BlipIcon;
import mtasa.server.classes.Blip;

@:native('_G')
extern class BlipFunctions {
	/**
		This function creates a blip element, which is displayed as an icon on the client's radar.

		@param worldPosition The position of the blip, in world coordinates.
		@param icon The icon that the radar blips should be. Valid values can be seen at Radar Blips
		@param size The size of the radar blip. Only applicable to the Marker icon. Default is 2. Maximum is 25.
		@param r The amount of red in the blip's color (0–255). Only applicable to the Marker icon. Default is 255.
		@param g The amount of green in the blip's color (0–255). Only applicable to the Marker icon. Default is 0.
		@param b The amount of blue in the blip's color (0–255). Only applicable to the Marker icon. Default is 0.
		@param a The amount of alpha in the blip's color (0–255). Only applicable to the Marker icon. Default is 255.
		@param ordering This defines the blip's Z-level ordering (-32768–32767). Default is 0.
		@param visibleDistance The maximum distance from the camera at which the blip is still visible (0–65535).
		@param visibleTo This defines which elements can see the blip. Defaults to visible to everyone. See visibility.
	**/
	static function createBlip(worldPosition:Vector3, ?icon:Int = 0, ?size:Int = 2, ?r:Int = 255, ?g:Int = 0, ?b:Int = 0, ?a:Int = 255, ?ordering:Int = 0,
		?visibleDistance:Float = 16383.0, ?visibleTo:Element):Blip;

	/**
		This function creates a blip that is attached to an element. This blip is displayed as an icon on the client's radar and will 'follow' the element that it is attached to around.

		@param elementToAttachTo The element to attach the blip to.
		@param icon The icon that the radar blips should be. Valid values can be seen at Radar Blips
		@param size The size of the radar blip. Only applicable to the Marker icon. Default value is 2. Maximum is 25.
		@param r The amount of red in the blip's color (0 - 255). Only applicable to the Marker icon. Default is 255.
		@param g The amount of green in the blip's color (0 - 255). Only applicable to the Marker icon. Default is 0.
		@param b The amount of blue in the blip's color (0 - 255). Only applicable to the Marker icon. Default is 0.
		@param a The amount of alpha in the blip's color (0 - 255). Only applicable to the Marker icon. Default is 255.
		@param ordering This defines the blip's Z-level ordering (-32768 - 32767). Default is 0.
		@param visibleDistance The maximum distance from the camera at which the blip is still visible (0-65535)
		@param visibleTo What elements can see the blip. Defaults to visible to everyone. See visibility.
	**/
	static function createBlipAttachedTo(elementToAttachTo:Element, ?icon:Int = 0, ?size:Int = 2, ?r:Int = 255, ?g:Int = 0, ?b:Int = 0, ?a:Int = 255,
		?ordering:Int = 0, ?visibleDistance:Float = 16383.0, ?visibleTo:Element):Blip;

	/**
		This function will tell you what color a blip is. This color is only applicable to the default blip icon (,  or ). All other icons will ignore this.

		@param theBlip The blip whose color you wish to get.
	**/
	static function getBlipColor(theBlip:Blip):Int;

	/**
		This function returns the icon a blip currently has.

		@param theBlip the blip we're getting the icon number of.
	**/
	static function getBlipIcon(theBlip:Blip):BlipIcon;

	/**
		This function gets the Z ordering value of a blip. The Z ordering determines if a blip appears on top of or below other blips. Blips with a higher Z ordering value appear on top of blips with a lower value. The default value for all blips is 0.

		@param theBlip the blip to retrieve the Z ordering value of.
	**/
	static function getBlipOrdering(theBlip:Blip):Int;

	/**
		This function gets the size of a blip..

		@param theBlip The blip you wish to get the size of.
	**/
	static function getBlipSize(theBlip:Blip):Int;

	/**
		This function will tell you what visible distance a blip has.

		@param theBlip The blip whose visible distance you wish to get.
	**/
	static function getBlipVisibleDistance(theBlip:Blip):Float;

	/**
		This function will let you change the color of a blip. This color is only applicable to the default blip icon. All other icons will ignore this.

		@param theBlip The blip who's color you wish to set.
		@param red The amount of red in the blip's color (0 - 255).
		@param green The amount of green in the blip's color (0 - 255).
		@param blue The amount of blue in the blip's color (0 - 255).
		@param alpha The amount of alpha in the blip's color (0 - 255).  Alpha decides transparancy where 255 is opaque and 0 is transparent.
	**/
	static function setBlipColor(theBlip:Blip, red:Int, green:Int, blue:Int, alpha:Int):Bool;

	/**
		This function sets the icon for an existing blip element.

		@param theBlip The blip you wish to set the icon of.
		@param icon A number indicating the icon you wish to change it do. Valid values are listed on the Radar Blips page.
	**/
	static function setBlipIcon(theBlip:Blip, icon:BlipIcon):Bool;

	/**
		This function sets the Z ordering of a blip. It allows you to make a blip appear on top of or below other blips.

		@param theBlip the blip whose Z ordering to change.
		@param ordering the new Z ordering value. Blips with higher values will appear on top of blips with lower values. Possible range: -32767 to 32767. Default: 0.
	**/
	static function setBlipOrdering(theBlip:Blip, ordering:Int):Bool;

	/**
		This function sets the size of a blip's icon.

		@param theBlip The blip you wish to get the size of.
		@param iconSize The size you wish the icon to be. 2 is the default value. 25 is the maximum value. Value gets clamped between 0 and 25.
	**/
	static function setBlipSize(theBlip:Blip, iconSize:Int):Bool;

	/**
		This function will set the visible distance of a blip.

		@param theBlip The blip whose visible distance you wish to get.
		@param theDistance The distance you want the blip to be visible for. Value gets clamped between 0 and 65535.
	**/
	static function setBlipVisibleDistance(theBlip:Blip, theDistance:Float):Bool;
}
