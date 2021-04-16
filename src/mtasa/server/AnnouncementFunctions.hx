package mtasa.server;

@:native('_G')
extern class AnnouncementFunctions {
	/**
		This function retrieves the current gametype as set by setGameType. The game type is displayed in the server browser next to the server's name.Returns the gametype as a string. If no gametype is set it returns nil.
	**/
	static function getGameType():String;

	/**
		This function retrieves the current mapname as set by setMapName.Returns the mapname as a string. If no mapname is set it returns nil.
	**/
	static function getMapName():String;

	/**
		This function gets a rule value. A rule value is a string that can be viewed by server browsers and used for filtering the server list.

		@param key The name of the rule
	**/
	static function getRuleValue(key:String):String;

	/**
		This function removes a set rule value that can be viewed by server browsers.Returns true if the rule value was removed, false if it failed.

		@param key The name of the rule you wish to remove
	**/
	static function removeRuleValue(key:String):Bool;

	/**
		This function sets a string containing a name for the game type. This should be the game-mode that is active, for example "Capture The Flag" or "Deathmatch". This is then displayed in the server browser and external server browsers.It should be noted that mapmanager handles this automatically for gamemodes that utilise the map/gamemode system.

		@param gameType A string containing a name for the game mode, or false to clear it.
	**/
	static function setGameType(gameType:String):Bool;

	/**
		This function is used to set a map name that will be visible in the server browser. In practice you should generally rely on the mapmanager to do this for you.Returns true if map name was set successfully, false otherwise.

		@param mapName The name you wish the server browser to show.
	**/
	static function setMapName(mapName:String):Bool;

	/**
		This function sets a rule value that can be viewed by server browsers.Returns true if the rule value was set, false if invalid arguments were specified.

		@param key The name of the rule
		@param value The value you wish to set for the rule
	**/
	static function setRuleValue(key:String, value:String):Bool;
}
