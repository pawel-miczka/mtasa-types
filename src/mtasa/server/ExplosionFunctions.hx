package mtasa.server;

import mtasa.server.classes.Player;
import mtasa.shared.enums.ExplosionType;
import mtasa.shared.classes.Vector3;

@:native('_G')
extern class ExplosionFunctions {
	/**
		Creates an explosion of a certain type at a specified point in the world. If creator is specified, the explosion will occur only in its dimension.

		@param position position where the explosion is created at.
		@param theType an integer specifying the explosion type. Valid types are:
		@param creator the explosion's simulated creator, the player responsible for it.
	**/
	static function createExplosion(position:Vector3, theType:ExplosionType, ?creator:Player):Bool;
}
