package mtasa.server;

import lua.Table;
import mtasa.server.classes.Player;
import mtasa.server.classes.Ban;

@:native('_G')
extern class AdminFunctions {
	/**
		This function will add a ban for the specified IP/username/serial to the server.OOP Syntax Help! I don't understand this!

		@param ip The IP to be banned. If you don't want to ban by IP, set this to null.
		@param username The MTA Community username to be banned (now obsolete). If you don't want to ban by username, set this to null.
		@param serial The serial to be banned. If you don't want to ban by serial, set this to null.
		@param responsibleElement The element that is responsible for banning the ip/username/serial. This can be a player or the root (getRootElement()).
		@param reason The reason the IP/username/serial will be banned from the server.
		@param seconds The amount of seconds the player will be banned from the server for. This can be 0 for an infinite amount of time.
	**/
	static function addBan(?ip:String, ?username:String, ?serial:String, ?responsibleElement:Player, ?reason:String, ?seconds:Int = 0):Ban;

	/**
		This function will ban the specified player by either IP, serial or usernameOOP Syntax Help! I don't understand this!

		@param bannedPlayer The player that will be banned from the server.
	**/
	static function banPlayer(bannedPlayer:Player, ?IP:Bool = true, ?Username:Bool = false, ?Serial:Bool = false, ?responsiblePlayer:Player, ?reason:String,
		?seconds:Int = 0):Ban;

	/**
		This function will return the responsible admin (nickname of the admin) of the specified ban.OOP Syntax Help! I don't understand this!

		@param theBan The ban you want to return the admin of.
	**/
	static function getBanAdmin(theBan:Ban):String;

	/**
		This function will return the nickname (nickname that the player had when he was banned) of the specified ban.OOP Syntax Help! I don't understand this!

		@param theBan The ban element which nickname you want to return.
	**/
	static function getBanNick(theBan:Ban):String;

	/**
		This function will return the ban reason of the specified ban.OOP Syntax Help! I don't understand this!

		@param theBan The ban in which you want to return the reason of.
	**/
	static function getBanReason(theBan:Ban):String;

	/**
		This function will return the serial of the specified ban.OOP Syntax Help! I don't understand this!

		@param theBan The ban you want to retrieve the serial of.
	**/
	static function getBanSerial(theBan:Ban):String;

	/**
		This function will return the time the specified ban was created, in seconds.OOP Syntax Help! I don't understand this!

		@param theBan The ban of which you wish to retrieve the time of.
	**/
	static function getBanTime(theBan:Ban):Int;

	/**
		This function will return the username of the specified ban.Returns a string of the username if everything was successful, false if invalid arguments are specified if there was no username specified for the ban.

		@param theBan The ban in which you wish to retrieve the username of.
	**/
	static function getBanUsername(theBan:Ban):String;

	/**
		This function will return a table containing all the bans present in the server's banlist.xml.OOP Syntax Help! I don't understand this!


	**/
	static function getBans():Table<Int, Ban>;

	/**
		This function will return the unbanning time of the specified ban in seconds.OOP Syntax Help! I don't understand this!

		@param theBan The ban in which you wish to retrieve the unban time of.
	**/
	static function getUnbanTime(theBan:Ban):Int;

	/**
		This function checks whether the passed value is valid ban or not.Returns true if the value is a ban, false otherwise.

		@param theBan The value to check
	**/
	static function isBan(theBan:Ban):Bool;

	/**
		This function will kick the specified player from the server.

		@param kickedPlayer The player that will be kicked from the server
		@param responsiblePlayer The player that is responsible for the event. Note: If left out as in the second syntax, responsible player for the kick will be "Console" (Maximum 30 characters if using a string).
		@param reason The reason for the kick. (Maximum 64 characters before 1.5.8, Maximum 128 characters after 1.5.8)
	**/
	static function kickPlayer(kickedPlayer:Player, ?responsiblePlayer:Player, ?reason:String):Bool;

	/**
		This function sets a new admin for a ban.OOP Syntax Help! I don't understand this!

		@param theBan The ban you want to change the admin of.
		@param theAdmin The new admin.
	**/
	static function setBanAdmin(theBan:Ban, theAdmin:String):Bool;

	/**
		This function sets a new nick for a ban.

		@param theBan The ban you want to change the nick of.
		@param theNick A string representing the nick you want to set the ban to.
	**/
	static function setBanNick(theBan:Ban, theNick:String):Bool;

	/**
		This function sets the reason for the specified ban. 

		@param theBan The ban that you wish to set the reason of.
		@param theReason the new reason (max 60 characters).
	**/
	static function setBanReason(theBan:Ban, theReason:String):Bool;

	/**
		This function sets a new unban time of a given ban using unix timestamp (seconds since Jan 01 1970).

		@param theBan The ban of which to change the unban time of
		@param theTime the new unban time
	**/
	static function setUnbanTime(theBan:Ban, theTime:Int):Bool;

	/**
		This function will reload the server ban list file.OOP Syntax Help! I don't understand this!
	**/
	static function reloadBans():Bool;

	/**
		This function will remove a specific ban.OOP Syntax Help! I don't understand this!

		@param theBan The ban to be removed.
	**/
	static function removeBan(theBan:Ban, ?responsibleElement:Player):Bool;
}
