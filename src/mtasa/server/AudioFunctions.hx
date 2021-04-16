package mtasa.server;

import mtasa.server.classes.Player;

@:native('_G')
extern class AudioFunctions {
	/**
		This function plays a frontend sound for the specified player.

		@param thePlayer the player you want the sound to play for.
		@param sound a whole int specifying the sound id to play. 
	**/
	static function playSoundFrontEnd(thePlayer:Player, sound:Int):Bool;
}
