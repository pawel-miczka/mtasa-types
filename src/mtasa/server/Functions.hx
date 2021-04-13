package mtasa.server;

import mtasa.shared.enums.ClothesType;
import mtasa.shared.returns.GetClothesByTypeIndex;
import mtasa.shared.enums.BodyPart;
import mtasa.shared.returns.GetCameraMatrix;
import haxe.extern.EitherType;
import lua.Table;
import mtasa.server.classes.ACL;
import mtasa.server.classes.ACLGroup;
import mtasa.server.classes.Account;
import mtasa.server.classes.Ban;
import mtasa.server.classes.Blip;
import mtasa.server.classes.Element;
import mtasa.server.classes.Player;
import mtasa.shared.enums.BlipIcon;

@:native('_G')
extern class Functions {
	/**
		This function adds an account to the list of registered accounts of the current server.

		@param name The name of the account you wish to make, this normally is the player's name.
		@param pass The password to set for this account for future logins.
		@param allowCaseVariations Whether the username is case sensitive (if this is set to true, usernames "Bob" and "bob" will refer to different accounts)
	**/
	static function addAccount(name:String, pass:String, ?allowCaseVariations:Bool = false):Account;

	/**
		This function copies all of the data from one account to another.

		@param theAccount The account you wish to copy the data to.
		@param fromAccount The account you wish to copy the data from.
	**/
	static function copyAccountData(theAccount:Account, fromAccount:Account):Bool;

	/**
		This function returns an account for a specific user.

		@param username The username of the account you want to retrieve
	**/
	static function getAccount(username:String, ?password:String, ?caseSensitive:Bool = true):Account;

	/**
		This function retrieves a string that has been stored using setAccountData. 
		Data stored as account data is persistent across user's sessions and maps, unless they are logged into a guest account.

		@param theAccount The account you wish to retrieve the data from.
		@param key The key under which the data is stored
	**/
	static function getAccountData(theAccount:Account, key:String):String;

	/**
		This function retrieves the name of an account.

		@param theAccount The account you wish to get the name of.
	**/
	static function getAccountName(theAccount:Account):String;

	/**
		This function returns the player element that is currently using a specified account, i.e. is logged into it. Only one player can use an account at a time.

		@param theAccount The account you wish to get the player of.
	**/
	static function getAccountPlayer(theAccount:Account):Player;

	/**
		This function returns the last serial that logged onto the specified account.

		@param theAccount The account to get serial from
	**/
	static function getAccountSerial(theAccount:Account):String;

	/**
		This function returns a table over all the accounts that exist in the server internal.db file. (Note: accounts.xml is no longer used after version 1.0.4)OOP Syntax Help! I don't understand this!
	**/
	static function getAccounts():Table<Int, Account>;

	/**
		This function returns a table containing all accounts that were logged onto from specified serial. If the serial is empty string, it will return all accounts that were never logged onto.

		@param serial The serial to get accounts from
	**/
	static function getAccountsBySerial(serial:String):Table<Int, Account>;

	/**
		This function returns a table containing all the user data for the account providedOOP Syntax Help! I don't understand this!

		@param theAccount The account you wish to retrieve all data from.
	**/
	static function getAllAccountData(theAccount:Account):Table<Int, String>;

	/**
		This function returns the specified player's account object.OOP Syntax Help! I don't understand this!

		@param thePlayer The player element you want to get the account of.
	**/
	static function getPlayerAccount(thePlayer:Player):Account;

	/**
		This function checks to see if an account is a guest account. A guest account is an account automatically created for a user when they join the server and deleted when they quit or login to another account. Data stored in a guest account is not stored after the player has left the server. As a consequence, this function will check if a player is logged in or not.OOP Syntax Help! I don't understand this!

		@param theAccount The account you want to check to see if it is a guest account.
	**/
	static function isGuestAccount(theAccount:Account):Bool;

	/**
		This functions logs the given player in to the given account. You need to provide the password needed to log into that account.OOP Syntax Help! I don't understand this!

		@param thePlayer The player to log into an account
		@param theAccount The account to log the player into
		@param thePassword The password needed to sign into this account
	**/
	static function logIn(thePlayer:Player, theAccount:Account, thePassword:String):Bool;

	/**
		This function logs the given player out of his current account.OOP Syntax Help! I don't understand this!

		@param thePlayer The player to log out of his current account
	**/
	static function logOut(thePlayer:Player):Bool;

	/**
		This function is used to delete existing player accounts.

		@param theAccount The account you wish to remove
	**/
	static function removeAccount(theAccount:Account):Bool;

	/**
		This function sets a string to be stored in an account. This can then be retrieved using getAccountData. Data stored as account data is persistent across user's sessions and maps, unless they are logged into a guest account. Even if logged into a guest account, account data can be useful as a way to store a reference to your own account system, though it's persistence is equivalent to that of using setElementData on the player's element.

		@param theAccount The account you wish to retrieve the data from.
		@param key The key under which you wish to store the data
		@param value The value you wish to store. Set to false to remove the data. NOTE: you cannot store tables as values, but you can use toJSON strings.
	**/
	static function setAccountData(theAccount:Account, key:String, value:Dynamic):Bool;

	/**
		This function sets the password of the specified account.OOP Syntax Help! I don't understand this!

		@param theAccount the account whose password you want to set
		@param password the password
	**/
	static function setAccountPassword(theAccount:Account, password:String):Bool;

	/**
		This function returns a table containing all accounts with specified dataName and value (set with setAccountData).OOP Syntax Help! I don't understand this!

		@param dataName The name of the data
		@param value The value the dataName should have
	**/
	static function getAccountsByData(dataName:String, value:String):Table<Int, Account>;

	/**
		This function sets the name of an account.

		@param theAccount The account you wish to change the name.
		@param name The new name.
		@param allowCaseVariations Whether the username is case sensitive (if this is set to true, usernames "Bob" and "bob" will refer to different accounts)
	**/
	static function setAccountName(theAccount:Account, name:String, ?allowCaseVariations:Bool = false):Bool;

	/**
		This function creates an ACL entry in the Access Control List system with the specified name.OOP Syntax Help! I don't understand this!

		@param aclName The name of the ACL entry to add.
	**/
	static function aclCreate(aclName:String):ACL;

	/**
		This function creates a group in the ACL. An ACL group can contain objects like players and resources. They specify who has access to the ACL's in this group.OOP Syntax Help! I don't understand this!

		@param groupName The name of the group to create
	**/
	static function aclCreateGroup(groupName:String):ACLGroup;

	/**
		This function destroys the ACL passed. The destroyed ACL will no longer be valid.OOP Syntax Help! I don't understand this!

		@param theACL The ACL to destroy
	**/
	static function aclDestroy(theACL:ACL):Bool;

	/**
		This function destroys the given ACL group. The destroyed ACL group will no longer be valid.OOP Syntax Help! I don't understand this!

		@param aclGroup The aclgroup element to destroy
	**/
	static function aclDestroyGroup(aclGroup:ACLGroup):Bool;

	/**
		Get the ACL with the given name. If need to get most of the ACL's, you should consider using aclList to get a table of them all.OOP Syntax Help! I don't understand this!

		@param aclName The name to get the ACL belonging to
	**/
	static function aclGet(aclName:String):ACL;

	/**
		This function is used to get the ACL group with the given name. If you need most of the groups you should consider using aclGroupList instead to get a table containing them all.OOP Syntax Help! I don't understand this!

		@param groupName The name to get the ACL group from
	**/
	static function aclGetGroup(groupName:String):ACLGroup;

	/**
		Get the name of given ACL.OOP Syntax Help! I don't understand this!

		@param theACL The ACL to get the name of
	**/
	static function aclGetName(theAcl:ACL):String;

	/**
		This function returns whether the access for the given right is set to true or false in the ACL.OOP Syntax Help! I don't understand this!

		@param theAcl The ACL to get the right from
		@param rightName The right name to return the access value of.
	**/
	static function aclGetRight(theAcl:ACL, rightName:String):Bool;

	/**
		This function adds an object to the given ACL group. An object can be a player's account, specified as:Or a resource, specified as:

		@param theGroup The group to add the object name string too.
		@param theObjectName The object string to add to the given ACL.
	**/
	static function aclGroupAddObject(theGroup:ACLGroup, theObjectName:String):Bool;

	/**
		This function is used to get the name of the given ACL group.OOP Syntax Help! I don't understand this!

		@param aclGroup The ACL group to get the name of
	**/
	static function aclGroupGetName(aclGroup:ACLGroup):String;

	/**
		This function returns a table of all the ACL groups.OOP Syntax Help! I don't understand this!
	**/
	static function aclGroupList():Table<Int, ACLGroup>;

	/**
		This function returns a table over all the objects that exist in a given ACL group. 
		These are objects like players and resources.OOP Syntax Help! I don't understand this!

		@param theGroup The ACL group to get the objects from
	**/
	static function aclGroupListObjects(theGroup:ACLGroup):Table<Int, String>;

	/**
		This function removes the given object from the given ACL group. The object can be a resource or a player. See aclGroupAddObject for more details.OOP Syntax Help! I don't understand this!

		@param theGroup The ACL group to remove the object string from
		@param theObjectString The object to remove from the ACL group
	**/
	static function aclGroupRemoveObject(theGroup:ACLGroup, theObjectString:String):Bool;

	/**
		This function returns a list of all the ACLs.OOP Syntax Help! I don't understand this!
	**/
	static function aclList():Table<Int, ACL>;

	/**
		This function returns a table of all the rights that a given ACL has.OOP Syntax Help! I don't understand this!

		@param theACL The ACL to get the rights from
		@param allowedType The allowed right type. Possible values are general, function, resource and command
	**/
	static function aclListRights(theACL:ACL, allowedType:String):Table<Int, String>;

	/**
		This function reloads the ACL's and the ACL groups from the ACL XML file. All ACL and ACL group elements are invalid after a call to this and should not be used anymore.OOP Syntax Help! I don't understand this!
	**/
	static function aclReload():Bool;

	/**
		This function removes the given right (string) from the given ACL.OOP Syntax Help! I don't understand this!

		@param theAcl The ACL to remove the right from
		@param rightName The ACL name to remove from the right from
	**/
	static function aclRemoveRight(theAcl:ACL, rightName:String):Bool;

	/**
		The ACL XML file is automatically saved whenever the ACL is modified, but the automatic save can be delayed by up to 10 seconds for performance reasons. Calling this function will force an immediate save.OOP Syntax Help! I don't understand this!
	**/
	static function aclSave():Bool;

	/**
		This functions changes or adds the given right in the given ACL. The access can be true or false and specifies whether the ACL gives access to the right or not.OOP Syntax Help! I don't understand this!

		@param theAcl The ACL to change the right of
		@param rightName The right to add/change the access property of
		@param hasAccess Whether the access should be set to true or false
	**/
	static function aclSetRight(theAcl:ACL, rightName:String, hasAccess:Bool):Bool;

	/**
		This function returns whether or not the given object has access to perform the given action.Scripts frequently wish to limit access to features to particular users. The naïve way to do this would be to check if the player who is attempting to perform an action is in a particular group (usually the Admin group). The main issue with doing this is that the Admin group is not guaranteed to exist. It also doesn't give the server admin any flexibility. He might want to allow his 'moderators' access to the function you're limiting access to, or he may want it disabled entirely.

		@param theObject The object to test if has permission to. This can be a client element (ie. a player), a resource or a string in the form "user.<name>" or "resource.<name>".
		@param theAction The action to test if the given object has access to. Ie. "function.kickPlayer".
		@param defaultPermission defaultPermission: The default permission if none is specified in either of the groups the given object is a member of. If this is left to true, the given object will have permissions to perform the action unless the opposite is explicitly specified in the ACL. If false, the action will be denied by default unless explicitly approved by the Access Control List.
	**/
	static function hasObjectPermissionTo(theObject:EitherType<String, Element>, theAction:String, ?defaultPermission:Bool = true):Bool;

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

	/**
		This function plays a frontend sound for the specified player.

		@param thePlayer the player you want the sound to play for.
		@param sound a whole int specifying the sound id to play. 
	**/
	static function playSoundFrontEnd(thePlayer:Player, sound:Int):Bool;

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

	/**
		This function creates a blip element, which is displayed as an icon on the client's radar.OOP Syntax Help! I don't understand this!

		@param x The x position of the blip, in world coordinates.
		@param y The y position of the blip, in world coordinates.
		@param z The z position of the blip, in world coordinates.
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
	static function createBlip(x:Float, y:Float, z:Float, ?icon:Int = 0, ?size:Int = 2, ?r:Int = 255, ?g:Int = 0, ?b:Int = 0, ?a:Int = 255, ?ordering:Int = 0,
		?visibleDistance:Float = 16383.0, ?visibleTo:Element):Blip;

	/**
		This function creates a blip that is attached to an element. This blip is displayed as an icon on the client's radar and will 'follow' the element that it is attached to around.OOP Syntax Help! I don't understand this!

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
		This function gets the Z ordering value of a blip. The Z ordering determines if a blip appears on top of or below other blips. Blips with a higher Z ordering value appear on top of blips with a lower value. The default value for all blips is 0.OOP Syntax Help! I don't understand this!

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
		This function will let you change the color of a blip. This color is only applicable to the default blip icon. All other icons will ignore this.OOP Syntax Help! I don't understand this!

		@param theBlip The blip who's color you wish to set.
		@param red The amount of red in the blip's color (0 - 255).
		@param green The amount of green in the blip's color (0 - 255).
		@param blue The amount of blue in the blip's color (0 - 255).
		@param alpha The amount of alpha in the blip's color (0 - 255).  Alpha decides transparancy where 255 is opaque and 0 is transparent.
	**/
	static function setBlipColor(theBlip:Blip, red:Int, green:Int, blue:Int, alpha:Int):Bool;

	/**
		This function sets the icon for an existing blip element.OOP Syntax Help! I don't understand this!

		@param theBlip The blip you wish to set the icon of.
		@param icon A number indicating the icon you wish to change it do. Valid values are listed on the Radar Blips page.
	**/
	static function setBlipIcon(theBlip:Blip, icon:BlipIcon):Bool;

	/**
		This function sets the Z ordering of a blip. It allows you to make a blip appear on top of or below other blips.OOP Syntax Help! I don't understand this!

		@param theBlip the blip whose Z ordering to change.
		@param ordering the new Z ordering value. Blips with higher values will appear on top of blips with lower values. Possible range: -32767 to 32767. Default: 0.
	**/
	static function setBlipOrdering(theBlip:Blip, ordering:Int):Bool;

	/**
		This function sets the size of a blip's icon.OOP Syntax Help! I don't understand this!

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
		@param positionX The x coordinate of the camera's position.
		@param positionY The y coordinate of the camera's position.
		@param positionZ The z coordinate of the camera's position.
		@param lookAtX The x coordinate of the point the camera faces.
		@param lookAtY The y coordinate of the point the camera faces.
		@param lookAtZ The z coordinate of the point the camera faces.
		@param roll The camera roll angle, -180 to 180. A value of 0 means the camera sits straight, positive values will turn it counter-clockwise and negative values will turn it clockwise. -180 or 180 means the camera is upside down.
		@param fov the field of view angle, 0.01 to 180. The higher this value is, the more you will be able to see what is to your sides.
	**/
	static function setCameraMatrix(thePlayer:Player, positionX:Float, positionY:Float, positionZ:Float, ?lookAtX:Float, ?lookAtY:Float, ?lookAtZ:Float,
		?roll:Float = 0, ?fov:Float = 70):Bool;

	/**
		This function allows you to set a player's camera to follow other elements instead. Currently supported element type is:OOP Syntax Help! I don't understand this!

		@param thePlayer The player whose camera you wish to modify.
		@param target The player who you want the camera to follow. If none is specified, the camera will target the player.
	**/
	static function setCameraTarget(thePlayer:Player, ?target:Player):Bool;

	/**
		This function is used to get the name of a body part on a player.

		@param bodyPartID An integer representing the body part ID you wish to retrieve the name of.
	**/
	static function getBodyPartName(bodyPartID:BodyPart):String;

	/**
		This function is used to get the texture and model of clothes by the clothes type and index.
		(Scans through the list of clothes for the specific type).This function returns 2 strings, a texture and model respectively, false if invalid arguments were passed to the function.

		@param clothesType An integer representing the clothes slot/type to scan through.
		@param clothesIndex An integer representing the index (0 based) set of clothes in the list you wish to retrieve. Each type has a different number of valid indexes.
	**/
	static function getClothesByTypeIndex(clothesType:ClothesType, clothesIndex:Int):GetClothesByTypeIndex;

	/**
		This function is used to get the name of a certain clothes type.This function returns a string (the name of the clothes type) if found, false otherwise.

		@param clothesType An integer determining the type of clothes you want to get the clothes of.
	**/
	static function getClothesTypeName(clothesType:ClothesType):String;

	/**
		This function is used to get the clothes type and index from the texture and model.
		(Scans through the list of clothes for the specific type).

		@param clothesTexture A string determining the clothes texture that you wish to retrieve the type and index from. See the clothes catalog.
		@param clothesModel A string determining the corresponding clothes model that you wish to retrieve the type and index from. See the clothes catalog.
	**/
	static function getTypeIndexFromClothes(clothesTexture:String, clothesModel:String):Int;

	// [addColPolygonPoint]
	// [createColCircle]
	// [createColCuboid]
	// [createColPolygon]
	// [createColRectangle]
	// [createColSphere]
	// [createColTube]
	// [getColPolygonHeight]
	// [getColPolygonPoints]
	// [getColPolygonPointPosition]
	// [getColShapeType]
	// [getColShapeRadius]
	// [getColShapeSize]
	// [getElementColShape]
	// [getElementsWithinColShape]
	// [isElementWithinColShape]
	// [isInsideColShape]
	// [removeColPolygonPoint]
	// [setColPolygonHeight]
	// [setColPolygonPointPosition]
	// [setColShapeRadius]
	// [setColShapeSize]
	// [isCursorShowing]
	// [showCursor]
	// [addElementDataSubscriber]
	// [attachElements]
	// [clearElementVisibleTo]
	// [cloneElement]
	// [createElement]
	// [destroyElement]
	// [detachElements]
	// [getAllElementData]
	// [getAttachedElements]
	// [getElementAlpha]
	// [getElementAttachedOffsets]
	// [getElementAttachedTo]
	// [getElementCollisionsEnabled]
	// [getElementByIndex]
	// [getElementChild]
	// [getElementChildren]
	// [getElementChildrenCount]
	// [getElementData]
	// [getElementDimension]
	// [getElementHealth]
	// [getElementInterior]
	// [getElementMatrix]
	// [getElementModel]
	// [getElementParent]
	// [getElementPosition]
	// [getElementRotation]
	// [getElementSyncer]
	// [getElementType]
	// [getElementVelocity]
	// [getElementZoneName]
	// [getElementsByType]
	// [getRootElement]
	// [hasElementData]
	// [hasElementDataSubscriber]
	// [isElementAttached]
	// [isElementCallPropagationEnabled]
	// [isElementDoubleSided]
	// [isElementFrozen]
	// [isElementInWater]
	// [isElementVisibleTo]
	// [isElementWithinMarker]
	// [removeElementData]
	// [removeElementDataSubscriber]
	// [setElementAlpha]
	// [setElementAngularVelocity]
	// [getElementAngularVelocity]
	// [setElementAttachedOffsets]
	// [setElementCallPropagationEnabled]
	// [setElementCollisionsEnabled]
	// [setElementData]
	// [setElementDimension]
	// [setElementDoubleSided]
	// [setElementFrozen]
	// [setElementHealth]
	// [setElementInterior]
	// [setElementModel]
	// [setElementParent]
	// [setElementPosition]
	// [setElementRotation]
	// [setElementSyncer]
	// [setElementVelocity]
	// [setElementVisibleTo]
	// [addEvent]
	// [addEventHandler]
	// [cancelEvent]
	// [cancelLatentEvent]
	// [getCancelReason]
	// [getEventHandlers]
	// [getLatentEventHandles]
	// [getLatentEventStatus]
	// [removeEventHandler]
	// [triggerEvent]
	// [triggerClientEvent]
	// [triggerLatentClientEvent]
	// [wasEventCancelled]
	// [createExplosion]
	// [fileClose]
	// [fileCopy]
	// [fileCreate]
	// [fileDelete]
	// [fileExists]
	// [fileFlush]
	// [fileGetPath]
	// [fileGetPos]
	// [fileGetSize]
	// [fileOpen]
	// [fileRead]
	// [fileRename]
	// [fileSetPos]
	// [fileWrite]
	// [httpClear]
	// [httpRequestLogin]
	// [httpSetResponseCode]
	// [httpSetResponseCookie]
	// [httpSetResponseHeader]
	// [httpWrite]
	// [addCommandHandler]
	// [bindKey]
	// [executeCommandHandler]
	// [getCommandHandlers]
	// [getControlState]
	// [getFunctionsBoundToKey]
	// [getKeyBoundToFunction]
	// [isControlEnabled]
	// [isKeyBound]
	// [removeCommandHandler]
	// [setControlState]
	// [toggleAllControls]
	// [toggleControl]
	// [unbindKey]
	// [loadMapData]
	// [resetMapInfo]
	// [saveMapData]
	// [createMarker]
	// [getMarkerColor]
	// [getMarkerCount]
	// [getMarkerIcon]
	// [getMarkerSize]
	// [getMarkerTarget]
	// [getMarkerType]
	// [setMarkerColor]
	// [setMarkerIcon]
	// [setMarkerSize]
	// [setMarkerTarget]
	// [setMarkerType]
	// [getLoadedModules]
	// [getModuleInfo]
	// [createObject]
	// [getObjectScale]
	// [setObjectScale]
	// [stopObject]
	// [clearChatBox]
	// [outputChatBox]
	// [outputConsole]
	// [outputDebugString]
	// [outputServerLog]
	// [showChat]
	// [addPedClothes]
	// [createPed]
	// [getPedAmmoInClip]
	// [getPedArmor]
	// [getPedClothes]
	// [getPedContactElement]
	// [getPedFightingStyle]
	// [getPedGravity]
	// [getPedOccupiedVehicle]
	// [getPedOccupiedVehicleSeat]
	// [getPedStat]
	// [getPedTarget]
	// [getPedTotalAmmo]
	// [getPedWalkingStyle]
	// [getPedWeapon]
	// [getPedWeaponSlot]
	// [getValidPedModels]
	// [isPedChoking]
	// [isPedDead]
	// [isPedDoingGangDriveby]
	// [isPedDucked]
	// [isPedHeadless]
	// [isPedInVehicle]
	// [isPedOnFire]
	// [isPedOnGround]
	// [isPedWearingJetpack]
	// [killPed]
	// [reloadPedWeapon]
	// [removePedClothes]
	// [removePedFromVehicle]
	// [setPedAnimation]
	// [setPedAnimationProgress]
	// [setPedAnimationSpeed]
	// [setPedArmor]
	// [setPedChoking]
	// [setPedDoingGangDriveby]
	// [setPedFightingStyle]
	// [setPedGravity]
	// [setPedHeadless]
	// [setPedOnFire]
	// [setPedStat]
	// [setPedWalkingStyle]
	// [setPedWeaponSlot]
	// [setPedWearingJetpack]
	// [warpPedIntoVehicle]
	// [createPickup]
	// [getPickupAmmo]
	// [getPickupAmount]
	// [getPickupRespawnInterval]
	// [getPickupType]
	// [getPickupWeapon]
	// [isPickupSpawned]
	// [setPickupRespawnInterval]
	// [setPickupType]
	// [usePickup]
	// [forcePlayerMap]
	// [getAlivePlayers]
	// [getDeadPlayers]
	// [getPlayerAnnounceValue]
	// [getPlayerBlurLevel]
	// [getPlayerCount]
	// [getPlayerFromName]
	// [getPlayerIdleTime]
	// [getPlayerMoney]
	// [getPlayerName]
	// [getPlayerNametagColor]
	// [getPlayerNametagText]
	// [getPlayerPing]
	// [getPlayerScriptDebugLevel]
	// [getPlayerSerial]
	// [getPlayerTeam]
	// [getPlayerVersion]
	// [getPlayerWantedLevel]
	// [getRandomPlayer]
	// [givePlayerMoney]
	// [isPlayerMapForced]
	// [isPlayerMuted]
	// [isPlayerNametagShowing]
	// [isVoiceEnabled]
	// [redirectPlayer]
	// [resendPlayerModInfo]
	// [setPlayerAnnounceValue]
	// [setPlayerBlurLevel]
	// [setPlayerHudComponentVisible]
	// [setPlayerMoney]
	// [setPlayerMuted]
	// [setPlayerName]
	// [setPlayerNametagColor]
	// [setPlayerNametagShowing]
	// [setPlayerNametagText]
	// [setPlayerScriptDebugLevel]
	// [setPlayerTeam]
	// [setPlayerVoiceBroadcastTo]
	// [setPlayerVoiceIgnoreFrom]
	// [setPlayerWantedLevel]
	// [spawnPlayer]
	// [takePlayerMoney]
	// [takePlayerScreenShot]
	// [detonateSatchels]
	// [createRadarArea]
	// [getRadarAreaColor]
	// [getRadarAreaSize]
	// [isInsideRadarArea]
	// [isRadarAreaFlashing]
	// [setRadarAreaColor]
	// [setRadarAreaFlashing]
	// [setRadarAreaSize]
	// [addResourceConfig]
	// [addResourceMap]
	// [callRemote]
	// [copyResource]
	// [createResource]
	// [deleteResource]
	// [fetchRemote]
	// [getResourceConfig]
	// [getResourceDynamicElementRoot]
	// [getResourceExportedFunctions]
	// [getResourceFromName]
	// [getResourceInfo]
	// [getResourceLastStartTime]
	// [getResourceLoadFailureReason]
	// [getResourceLoadTime]
	// [getResourceMapRootElement]
	// [getResourceName]
	// [getResourceOrganizationalPath]
	// [getResourceRootElement]
	// [getResourceState]
	// [getResources]
	// [getThisResource]
	// [isResourceArchived]
	// [isResourceProtected]
	// [refreshResources]
	// [removeResourceFile]
	// [renameResource]
	// [restartResource]
	// [setResourceInfo]
	// [stopResource]
	// [getRemoteRequests]
	// [getRemoteRequestInfo]
	// [abortRemoteRequest]
	// [getMaxPlayers]
	// [getServerHttpPort]
	// [getServerName]
	// [getServerPassword]
	// [getServerPort]
	// [getVersion]
	// [isGlitchEnabled]
	// [isTransferBoxVisible]
	// [setGlitchEnabled]
	// [setMaxPlayers]
	// [setServerPassword]
	// [setTransferBoxVisible]
	// [dbConnect]
	// [dbExec]
	// [dbFree]
	// [dbPoll]
	// [dbPrepareString]
	// [dbQuery]
	// [countPlayersInTeam]
	// [createTeam]
	// [getPlayersInTeam]
	// [getTeamColor]
	// [getTeamFriendlyFire]
	// [getTeamFromName]
	// [getTeamName]
	// [setTeamColor]
	// [setTeamFriendlyFire]
	// [setTeamName]
	// [textCreateDisplay]
	// [textCreateTextItem]
	// [textDestroyDisplay]
	// [textDestroyTextItem]
	// [textDisplayAddObserver]
	// [textDisplayAddText]
	// [textDisplayGetObservers]
	// [textDisplayIsObserver]
	// [textDisplayRemoveObserver]
	// [textDisplayRemoveText]
	// [textItemGetColor]
	// [textItemGetPosition]
	// [textItemGetPriority]
	// [textItemGetScale]
	// [textItemGetText]
	// [textItemSetColor]
	// [textItemSetPosition]
	// [textItemSetPriority]
	// [textItemSetScale]
	// [textItemSetText]
	// [addDebugHook]
	// [bitAnd]
	// [bitNot]
	// [bitOr]
	// [bitXor]
	// [bitTest]
	// [bitArShift]
	// [bitExtract]
	// [bitReplace]
	// [debugSleep]
	// [decodeString]
	// [encodeString]
	// [getColorFromString]
	// [getDevelopmentMode]
	// [getEasingValue]
	// [getNetworkStats]
	// [getNetworkUsageData]
	// [getPerformanceStats]
	// [getRealTime]
	// [getServerConfigSetting]
	// [getTickCount]
	// [getTimerDetails]
	// [getTimers]
	// [getUserdataType]
	// [interpolateBetween]
	// [isTimer]
	// [killTimer]
	// [passwordHash]
	// [passwordVerify]
	// [pregFind]
	// [pregMatch]
	// [pregReplace]
	// [removeDebugHook]
	// [resetTimer]
	// [setDevelopmentMode]
	// [setServerConfigSetting]
	// [teaDecode]
	// [teaEncode]
	// [utfChar]
	// [utfCode]
	// [utfLen]
	// [utfSeek]
	// [utfSub]
	// [addVehicleSirens]
	// [addVehicleUpgrade]
	// [attachTrailerToVehicle]
	// [blowVehicle]
	// [createVehicle]
	// [detachTrailerFromVehicle]
	// [fixVehicle]
	// [getModelHandling]
	// [getOriginalHandling]
	// [getTrainDirection]
	// [getTrainPosition]
	// [getTrainSpeed]
	// [getVehicleColor]
	// [getVehicleCompatibleUpgrades]
	// [getVehicleController]
	// [getVehicleDoorOpenRatio]
	// [getVehicleDoorState]
	// [getVehicleEngineState]
	// [getVehicleHandling]
	// [getVehicleHeadLightColor]
	// [getVehicleLandingGearDown]
	// [getVehicleLightState]
	// [getVehicleMaxPassengers]
	// [getVehicleModelFromName]
	// [getVehicleName]
	// [getVehicleNameFromModel]
	// [getVehicleOccupant]
	// [getVehicleOccupants]
	// [getVehicleOverrideLights]
	// [getVehiclePaintjob]
	// [getVehiclePanelState]
	// [getVehiclePlateText]
	// [getVehicleRespawnPosition]
	// [getVehicleRespawnRotation]
	// [getVehicleSirenParams]
	// [getVehicleSirens]
	// [getVehicleSirensOn]
	// [getVehicleTowedByVehicle]
	// [getVehicleTowingVehicle]
	// [getVehicleTurretPosition]
	// [getVehicleType]
	// [getVehicleUpgradeOnSlot]
	// [getVehicleUpgradeSlotName]
	// [getVehicleUpgrades]
	// [getVehicleVariant]
	// [getVehicleWheelStates]
	// [getVehiclesOfType]
	// [isTrainDerailable]
	// [isTrainDerailed]
	// [isVehicleBlown]
	// [isVehicleDamageProof]
	// [isVehicleFuelTankExplodable]
	// [isVehicleLocked]
	// [isVehicleOnGround]
	// [isVehicleTaxiLightOn]
	// [removeVehicleSirens]
	// [removeVehicleUpgrade]
	// [resetVehicleExplosionTime]
	// [resetVehicleIdleTime]
	// [respawnVehicle]
	// [setModelHandling]
	// [setTrainDerailable]
	// [setTrainDerailed]
	// [setTrainDirection]
	// [setTrainPosition]
	// [setTrainSpeed]
	// [setVehicleColor]
	// [setVehicleDamageProof]
	// [setVehicleDoorOpenRatio]
	// [setVehicleDoorState]
	// [setVehicleDoorsUndamageable]
	// [setVehicleEngineState]
	// [setVehicleFuelTankExplodable]
	// [setVehicleHandling]
	// [setVehicleHeadLightColor]
	// [setVehicleIdleRespawnDelay]
	// [setVehicleLandingGearDown]
	// [setVehicleLightState]
	// [setVehicleLocked]
	// [setVehicleOverrideLights]
	// [setVehiclePaintjob]
	// [setVehiclePanelState]
	// [setVehiclePlateText]
	// [setVehicleRespawnDelay]
	// [setVehicleRespawnPosition]
	// [setVehicleRespawnRotation]
	// [setVehicleSirens]
	// [setVehicleSirensOn]
	// [setVehicleTaxiLightOn]
	// [setVehicleTurretPosition]
	// [setVehicleVariant]
	// [setVehicleWheelStates]
	// [toggleVehicleRespawn]
	// [createWater]
	// [getWaterColor]
	// [getWaterVertexPosition]
	// [getWaveHeight]
	// [resetWaterColor]
	// [resetWaterLevel]
	// [setWaterVertexPosition]
	// [setWaveHeight]
	// [getOriginalWeaponProperty]
	// [getSlotFromWeapon]
	// [getWeaponProperty]
	// [giveWeapon]
	// [setWeaponAmmo]
	// [setWeaponProperty]
	// [takeAllWeapons]
	// [takeWeapon]
	// [areTrafficLightsLocked]
	// [getAircraftMaxVelocity]
	// [getCloudsEnabled]
	// [getFarClipDistance]
	// [getFogDistance]
	// [getGameSpeed]
	// [getGravity]
	// [getHeatHaze]
	// [getJetpackMaxHeight]
	// [getJetpackWeaponEnabled]
	// [getMinuteDuration]
	// [getMoonSize]
	// [getOcclusionsEnabled]
	// [getRainLevel]
	// [getSkyGradient]
	// [getSunColor]
	// [getSunSize]
	// [getTrafficLightState]
	// [getWeather]
	// [getWindVelocity]
	// [getZoneName]
	// [isGarageOpen]
	// [removeWorldModel]
	// [resetFarClipDistance]
	// [resetFogDistance]
	// [resetHeatHaze]
	// [resetMoonSize]
	// [resetRainLevel]
	// [resetSkyGradient]
	// [resetSunColor]
	// [resetSunSize]
	// [resetWindVelocity]
	// [restoreAllWorldModels]
	// [restoreWorldModel]
	// [setAircraftMaxVelocity]
	// [setCloudsEnabled]
	// [setGameSpeed]
	// [setGarageOpen]
	// [setGravity]
	// [setInteriorSoundsEnabled]
	// [setJetpackWeaponEnabled]
	// [setMinuteDuration]
	// [setOcclusionsEnabled]
	// [setTrafficLightState]
	// [setTrafficLightsLocked]
	// [setWeather]
	// [setWeatherBlended]
	// [xmlCopyFile]
	// [xmlCreateChild]
	// [xmlCreateFile]
	// [xmlDestroyNode]
	// [xmlFindChild]
	// [xmlLoadFile]
	// [xmlLoadString]
	// [xmlNodeGetAttribute]
	// [xmlNodeGetAttributes]
	// [xmlNodeGetChildren]
	// [xmlNodeGetName]
	// [xmlNodeGetParent]
	// [xmlNodeGetValue]
	// [xmlNodeSetAttribute]
	// [xmlNodeSetName]
	// [xmlNodeSetValue]
	// [xmlSaveFile]
	// [xmlUnloadFile]
}
