package mtasa.server;

import mtasa.server.classes.Player;

@:native('_G')
extern class CursorFunctions {
	/**
		This function is used to determine whether or not a player's cursor is showing.Returns true if the player's cursor is showing, false if it isn't or if invalid parameters were passed.

		@param thePlayer The player you want to get cursor state of.
	**/
	static function isCursorShowing(thePlayer:Player):Bool;

	/**
		This function is used to show or hide a player's cursor.NOTE: When using optional arguments, you might need to supply all arguments before the one you wish to use. For more information on optional arguments, see optional arguments.

		@param thePlayer The player you want to show or hide the cursor of.
		@param show A boolean value determining whether to show (true) or hide (false) the cursor.
		@param toggleControls A boolean value determining whether to disable controls whilst the cursor is showing. true implies controls are disabled, false implies controls remain enabled.
	**/
	static function showCursor(thePlayer:Player, show:Bool, ?toggleControls:Bool = true):Bool;
}
