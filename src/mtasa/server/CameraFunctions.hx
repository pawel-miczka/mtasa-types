package mtasa.server;

import mtasa.shared.classes.Vector3;
import mtasa.server.classes.Element;
import mtasa.shared.returns.GetCameraMatrix;
import mtasa.server.classes.Player;

@:native('_G')
extern class CameraFunctions {
	/**
		This function will fade a player's camera to a color or back to normal over a specified time period. This will also affect the sound volume for the player (50% faded = 50% volume, full fade = no sound). For clientside scripts you can perform 2 fade ins or fade outs in a row, but for serverside scripts you must use one then the other.

		@param thePlayer The player whose camera you wish to fade.
		@param fadeIn Should the camera be faded in or out? Pass true to fade the camera in, false to fade it out to a color.
		@param fadeIn Should the camera be faded in our out? Pass true to fade the camera in, false to fade it out to a color.
		@param timeToFade The number of seconds it should take to fade.
		@param red The amount of red in the color that the camera fades out to (0 - 255). Not required for fading in.
		@param green The amount of green in the color that the camera fades out to (0 - 255). Not required for fading in.
		@param blue The amount of blue in the color that the camera fades out to (0 - 255). Not required for fading in.
	**/
	static function fadeCamera(thePlayer:Player, fadeIn:Bool, ?timeToFade:Float = 1.0, ?red:Int = 0, ?green:Int = 0, ?blue:Int = 0):Bool;

	/**
		Returns the interior of the local camera (independent of the interior of the local player).OOP Syntax Help! I don't understand this!

		@param thePlayer The player whose camera interior you want to get.
	**/
	static function getCameraInterior(thePlayer:Player):Int;

	/**
		This function gets the position of the camera and the position of the point it is facing.

		@param thePlayer The player whose camera matrix is to be returned.
	**/
	static function getCameraMatrix(thePlayer:Player):GetCameraMatrix;

	/**
		This function returns an element that corresponds to the current target of the specified player's camera (i.e. what it is following).

		@param thePlayer The player whose camera you wish to receive the target of.
	**/
	static function getCameraTarget(thePlayer:Player):Element;

	/**
		Sets the interior of the local camera. Only the interior of the camera is changed, the local player stays in the interior he was in.OOP Syntax Help! I don't understand this!

		@param thePlayer the player whose camera interior will be set.
		@param interior the interior to place the camera in.
	**/
	static function setCameraInterior(thePlayer:Player, interior:Int):Bool;

	/**
		This function sets the camera's position and direction. The first three arguments are the point at which the camera lies, the last three are the point the camera faces (or the point it "looks at").OOP Syntax Help! I don't understand this!

		@param thePlayer The player whose camera is to be changed.
		@param position The Vector3 of the camera's position.
		@param lookAtPosition The Vector3 of the point the camera faces.
		@param roll The camera roll angle, -180 to 180. A value of 0 means the camera sits straight, positive values will turn it counter-clockwise and negative values will turn it clockwise. -180 or 180 means the camera is upside down.
		@param fov the field of view angle, 0.01 to 180. The higher this value is, the more you will be able to see what is to your sides.
	**/
	static function setCameraMatrix(thePlayer:Player, position:Vector3, ?lookAtPosition:Vector3, ?roll:Float = 0, ?fov:Float = 70):Bool;

	/**
		This function allows you to set a player's camera to follow other elements instead. Currently supported element type is:OOP Syntax Help! I don't understand this!

		@param thePlayer The player whose camera you wish to modify.
		@param target The player who you want the camera to follow. If none is specified, the camera will target the player.
	**/
	static function setCameraTarget(thePlayer:Player, ?target:Player):Bool;
}
