package mtasa.server;

import mtasa.shared.enums.ExplosionType;
import mtasa.shared.enums.LatentEventStatus;
import haxe.Constraints.Function;
import mtasa.server.enums.ElementSyncMode;
import mtasa.server.classes.Marker;
import haxe.Rest;
import haxe.extern.EitherType;
import lua.Table;
import mtasa.server.classes.ACL;
import mtasa.server.classes.ACLGroup;
import mtasa.server.classes.Account;
import mtasa.server.classes.Ban;
import mtasa.server.classes.Blip;
import mtasa.server.classes.ColShape;
import mtasa.server.classes.Element;
import mtasa.server.classes.Player;
import mtasa.shared.classes.Matrix;
import mtasa.shared.classes.Vector2;
import mtasa.shared.classes.Vector3;
import mtasa.shared.enums.BasicElementType;
import mtasa.shared.enums.BlipIcon;
import mtasa.shared.enums.BodyPart;
import mtasa.shared.enums.ClothesType;
import mtasa.shared.enums.ColShapeType;
import mtasa.shared.returns.GetCameraMatrix;
import mtasa.shared.returns.GetClothesByTypeIndex;
import mtasa.shared.returns.GetElementAttachedOffsets;
import mtasa.shared.types.RootElement;

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

	/**
		This function is used to add a new point to an existing colshape polygon.

		@param shape The colshape polygon you wish add a point to.
		@param fX The X position of the new bound point.
		@param fY The Y position of the new bound point.
		@param index index: The index where the new point will be inserted in the polygon. The points are indexed in order, with 1 being the first bound point. Passing 0 will insert the point as the last one in the polygon.
	**/
	static function addColPolygonPoint(shape:ColShape, fX:Float, fY:Float, ?index:Int = 0):Bool;

	/**
		This function creates a collision circle. This is a shape that has a position and a radius and infinite height that you can use to detect a player's presence. Events will be triggered when a player enters or leaves it.OOP Syntax Help! I don't understand this!

		@param fX The collision circle's center point's X axis position
		@param fY The collision circle's center point's Y axis position
		@param radius The radius of the collision circle. Can not be smaller than 0.1
	**/
	static function createColCircle(fX:Float, fY:Float, radius:Float):ColShape;

	/**
		This function creates a collision cuboid. This is a shape that has a position, width, depth and height. See Wikipedia for a definition of a cuboid. The XYZ of the col starts at the southwest bottom corner of the shape.OOP Syntax Help! I don't understand this!

		@param fX The X position of the collision cuboid's western side
		@param fY The Y position of the collision cuboid's southern side
		@param fZ The Z position of the collision cuboid's lowest side
		@param fWidth The collision cuboid's width
		@param fDepth The collision cuboid's depth
		@param fHeight The collision cuboid's height
	**/
	static function createColCuboid(fX:Float, fY:Float, fZ:Float, fWidth:Float, fDepth:Float, fHeight:Float):ColShape;

	/**
		This function creates a collision polygon. See Wikipedia for a definition of a polygon. The first set of X Y of this shape is not part of the colshape bounds, so can set anywhere in the game world, however for performance, place it as close to the centre of the polygon as you can. It should be noted this shape is 2D. There should be at least 3 bound points set.

		@param center The Vector2 position of the collision polygon's position - the position that will be returned from getElementPosition.
		@param x1 The 1st Vector2 position of the collision polygon's bound point
		@param x2 The 2nd Vector2 position of the collision polygon's bound point
		@param x3 The 3rd Vector2 position of the collision polygon's bound point
	**/
	static function createColPolygon(center:Vector2, x1:Vector2, x2:Vector2, x3:Vector2, positions:Rest<Vector2>):ColShape;

	/**
		This function creates a collision rectangle. This is a shape that has a position and a width and a depth. See Rectangle for a definition of a rectangle. XY marks on the south west corner of the colshape.OOP Syntax Help! I don't understand this!

		@param start The Vector2 position of the collision rectangle's south west side
		@param size The collision rectangle's width and height
	**/
	static function createColRectangle(start:Vector2, size:Vector2):ColShape;

	/**
		This function creates a collision sphere. This is a shape that has a position and a radius. See Wikipedia for a definition of a sphere.OOP Syntax Help! I don't understand this!

		@param center The collision sphere's center point
		@param radius The collision sphere's radius
	**/
	static function createColSphere(center:Vector3, radius:Float):ColShape;

	/**
		This function creates a collision tube. This is a shape that has a position and a 2D (X/Y) radius and a height. See Cylinder for a definition of a tube. A tube is similar to a colcircle, except that it has a limited height, this means you can limit the distance above the position defined by (fX, fY, fZ) that the collision is detected.OOP Syntax Help! I don't understand this!

		@param center The position of the base of the tube's center
		@param radius The collision tube's radius
		@param height The collision tube's height
	**/
	static function createColTube(center:Vector3, radius:Float, height:Float):ColShape;

	/**
		This function is used to get the height of an existing colshape polygon. By default, a colshape polygon is infinitely tall.

		@param shape The colshape polygon
	**/
	static function getColPolygonHeight(shape:ColShape):Float;

	/**
		This function is used to get all bound points in a colshape polygon.

		@param shape The colshape polygon you wish to get the points of.
	**/
	static function getColPolygonPoints(shape:ColShape):Table<Int, Vector2>;

	/**
		This function is used to get the position of a bound point in a colshape polygon.

		@param shape The colshape polygon you wish to change.
		@param index The index of the point you wish to retrieve. The points are indexed in order, with 1 being the first bound point.
	**/
	static function getColPolygonPointPosition(shape:ColShape, index:Int):Float;

	/**
		This function is used to retrieve the type of an colshape.

		@param shape The colshape you wish to get the type of.
	**/
	static function getColShapeType(shape:ColShape):ColShapeType;

	/**
		This function is used to get the radius of a colshape. Valid types are circle, sphere and tube.

		@param shape The colshape you wish to get the radius of.
	**/
	static function getColShapeRadius(shape:ColShape):Float;

	/**
		This function is used to get the size of a colshape. Valid types are rectangle, cuboid and tube.

		@param shape The colshape you wish to get the size of.
	**/
	static function getColShapeSize(shape:ColShape):Float;

	/**
		Some elements have an associated colshape, for example Marker and Pickup. This function is used to get the associated colshape.

		@param theElement The element you want to get the colshape of
	**/
	static function getElementColShape(theElement:Element):ColShape;

	/**
		This function is used to retrieve a list of all elements in a colshape, of the specified type.

		@param theShape The colshape you want to get the elements from.
		@param elemType The type of element you want a list of.
	**/
	static function getElementsWithinColShape(theShape:ColShape, ?elemType:EitherType<String, BasicElementType>):Table<Int, Element>;

	/**
		This function is used to determine if an element is within a collision shape. Please note that for legacy reasons, a colshape created on the client does not collide with elements already existing at that location until they first move. Please also note that before 1.0.3, this did not function correctly when moving a colshape.

		@param theElement The element you're checking.
		@param theShape The colshape you're checking
	**/
	static function isElementWithinColShape(theElement:Element, theShape:ColShape):Bool;

	/**
		This function checks if a 3D position is inside a colshape or not.OOP Syntax Help! I don't understand this!

		@param theShape The colshape you're checking the position against.
		@param position The colshape you're checking the position against.
	**/
	static function isInsideColShape(theShape:ColShape, position:Vector3):Bool;

	/**
		This function is used to remove a point from an existing colshape polygon.

		@param shape The colshape polygon you wish to remove a point from.
		@param index The index of the point you wish to remove. The points are indexed in order, with 1 being the first bound point. You can't remove the last 3 points.
	**/
	static function removeColPolygonPoint(shape:ColShape, index:Int):Bool;

	/**
		OOP Syntax Help! I don't understand this!

		@param shape The colshape polygon
		@param floor The polygon floor (lowest Z coordinate). Parse false to reset this value to 0.
		@param ceil The polygon ceiling (highest Z coordinate). Parse false to reset this value to infinitely tall.
	**/
	static function setColPolygonHeight(shape:ColShape, floor:Float, ceil:Float):Bool;

	/**
		This function is used to set the position of a bound point in a colshape polygon.

		@param shape The colshape polygon you wish to change.
		@param index The index of the point you wish to change. The points are indexed in order, with 1 being the first bound point.
		@param position The position of the bound point.
	**/
	static function setColPolygonPointPosition(shape:ColShape, index:Int, position:Vector2):Bool;

	/**
		This function is used to set the radius of a colshape. Valid types are circle, sphere and tube.

		@param shape The colshape you wish to change the radius of.
		@param radius The radius you want to set.
	**/
	static function setColShapeRadius(shape:ColShape, radius:Float):Bool;

	/**
		This function is used to set the size of a colshape. Valid types are rectangle, cuboid and tube. 

		@param shape The colshape you wish to change the radius of.
	**/
	@:overload(function(shape:ColShape, height:Float):Bool {})
	@:overload(function(shape:ColShape, width:Float, height:Float):Bool {})
	static function setColShapeSize(shape:ColShape, width:Float, depth:Float, height:Float):Bool;

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

	/**
		This function subscribes a player to specific element data.
		This function is used together with setElementData in "subscribe" mode.

		@param theElement The element you wish to subscribe the player to.
		@param key The key you wish to subscribe the player to.
		@param thePlayer The player you wish to subscribe.
	**/
	static function addElementDataSubscriber(theElement:Element, key:String, thePlayer:Player):Bool;

	/**
		This function attaches one element to another, so that the first one follows the second whenever it moves.If an attempt is made to attach two elements that are already attached the opposite way (eg theElement becomes theAttachToElement and vice versa), the 1st attachment order is automatically detached in favor of the 2nd attachment order. For example, if carA was attached to carB, now carB is attached to carA. Also, an element cannot be attached to two separate elements at one time. For example, two cars can be attached to one single car, but one single car cannot be attached to two separate cars. If you attempt to do this, the existing attachment will automatically be dropped in favor of the new attachment. For example, if carA is asked to attached to carB then carC, it is only attached to carC.

		@param theElement The element to be attached.
		@param theAttachToElement The element to attach the first to.
	**/
	static function attachElements(theElement:Element, theAttachToElement:Element, offsetPosition:Vector3, offsetRotation:Vector3):Bool;

	/**
		This function clears any settings added by setElementVisibleTo and restores an element to its default visibility.  This does not work with all entities - vehicles, players and objects are exempt. This is because these objects are required for accurate sync (they're physical objects). This function is particularily useful for changing the visibility of markers, radar blips and radar areas.OOP Syntax Help! I don't understand this!

		@param theElement The element in which you wish to restore to its default visibility
	**/
	static function clearElementVisibleTo(theElement:Element):Bool;

	/**
		This function clones (creates an exact copy of) an already existing element. 
		The root node, and player elements, cannot be cloned. 
		If a player element is a child of an element that is cloned, it will be skipped, 
		along with the elements that exist as a child to the player element.
		Players are not the only elements that cannot be cloned. 
		This list also includes remoteclients, and console elements.

		@param theElement The element that you wish to clone.
		@param position A position on map
		@param cloneChildren A boolean value representing whether or not the element's children will be cloned.
	**/
	static function cloneElement(theElement:Element, ?position:Vector3, ?cloneChildren:Bool):Element;

	/**
		This function is used to create a new dummy element in the element tree which do not necessarily represent an entity within the San Andreas world. A common use for this function is for creating custom elements, such as a Flag or a Base.Elements created using this function are placed in the element tree with their parent as the 'dynamic' map element.

		@param elementType The type of element being created.
		@param elementID The ID of the element being created.
	**/
	static function createElement(elementType:String, ?elementID:String):Element;

	/**
		This function destroys an element and all elements within it in the hierarchy (its children, the children of those children etc). Player elements cannot be destroyed using this function. A player can only be removed from the hierarchy when they quit or are kicked. The root element also cannot be destroyed, however, passing the root as an argument will wipe all elements from the server, except for the players and clients, which will become direct descendants of the root node, and other elements that cannot be destroyed, such as resource root elements.

		@param elementToDestroy The element you wish to destroy.
	**/
	static function destroyElement(elementToDestroy:Element):Bool;

	/**
		This function detaches attached elements from one another.OOP Syntax Help! I don't understand this!

		@param theElement The element to be detached (the "child")
	**/
	static function detachElements(theElement:Element, ?theAttachToElement:Element):Bool;

	/**
		Returns a table of all element data of an element.

		@param theElement the element you want to get the element data of.
	**/
	static function getAllElementData(theElement:Element):Table<String, Dynamic>;

	/**
		This function returns a table of all the elements attached to the specified element

		@param theElement The element which you require the information from.
	**/
	static function getAttachedElements(theElement:Element):Table<Int, Element>;

	/**
		This function returns the alpha (transparency) value for the specified element. This can be a player, ped, object, vehicle or weapon.

		@param theElement The element whose alpha you want to retrieve.
	**/
	static function getElementAlpha(theElement:Element):Int;

	/**
		This function returns the offsets of an element that has been attached to another element using attachElements.OOP Syntax Help! I don't understand this!

		@param theElement The attached element.
	**/
	static function getElementAttachedOffsets(theElement:Element):GetElementAttachedOffsets;

	/**
		This function determines the element that the specified element is attached to.

		@param theElement The element you require the information for.
	**/
	static function getElementAttachedTo(theElement:Element):Element;

	/**
		This function indicates if a specific element is set to have collisions disabled. An element without collisions does not interact with the physical environment and remains static.

		@param theElement The element for which you want to check whether collisions are enabled
	**/
	static function getElementCollisionsEnabled(theElement:Element):Bool;

	/**
		This function returns an element of the specified type with the specified index.OOP Syntax Help! I don't understand this!

		@param theType the type of the element to be returned. Examples include "player", "vehicle", or a custom type.
		@param index the element's index (0 for the first element, 1 for the second, etc).
	**/
	static function getElementByIndex(theType:String, index:Int):Element;

	/**
		This function returns one of the child elements of a given parent element. The child element is selected by its index (0 for the first child, 1 for the second and so on).OOP Syntax Help! I don't understand this!

		@param parent the element above the one to be returned in the hierarchy.
		@param index the element's index (0 for the first element, 1 for the second, etc).
	**/
	static function getElementChild(parent:Element, index:Int):Element;

	/**
		This function is used to retrieve a list of the child elements of a given parent element. Note that it will only return direct children and not elements that are further down the element tree.OOP Syntax Help! I don't understand this!

		@param parent Supply this argument with the parent of the children you want returned.
		@param theType The type of element you want a list of.
	**/
	static function getElementChildren(parent:Element, ?theType:String):Table<Int, Element>;

	/**
		This function returns the number of children an element has. Note that only the direct children are counted and not elements that are further down the element tree.OOP Syntax Help! I don't understand this!

		@param parent the parent element
	**/
	static function getElementChildrenCount(parent:Element):Int;

	/**
		This function retrieves element data attached to an element under a certain key.OOP Syntax Help! I don't understand this!

		@param theElement This is the element with data you want to retrieve.
		@param key The name of the element data entry you want to retrieve. (Maximum 31 characters.)
		@param inherit - toggles whether or not the function should go up the hierarchy to find the requested key in case the specified element doesn't have it.
	**/
	static function getElementData(theElement:Element, key:String, ?inherit:Bool = true):Dynamic;

	/**
		This function allows you to retrieve the dimension of any element. The dimension determines what/who the element is visible to.OOP Syntax Help! I don't understand this!

		@param theElement The element in which you'd like to retrieve the dimension of.
	**/
	static function getElementDimension(theElement:Element):Int;

	/**
		This function returns the current health for the specified element. This can be a player, a ped, a vehicle, or an object.

		@param theElement The player or vehicle whose health you want to check.
	**/
	static function getElementHealth(theElement:Element):Float;

	/**
		This function allows you to retrieve the interior of any element. An interior is the current loaded place, 0 being outside.OOP Syntax Help! I don't understand this!

		@param theElement The element of which you'd like to retrieve the interior
	**/
	static function getElementInterior(theElement:Element):Int;

	/**
		This function gets an element's transform matrix. This contains 16 float values that multiplied to a point will give you the point transformed. It is most useful for matrix calculations such as calculating offsets. For further information, please refer to a tutorial of matrices in computer graphics programming.

		@param theElement The element which you wish to retrieve the matrix for.
		@param legacy Set to false to return correctly setup matrix (i.e. Last column in the first 3 rows set to zero).
	**/
	static function getElementMatrix(theElement:Element, ?legacy:Bool = true):Matrix;

	/**
		Returns the model ID of a given element. This can be a player/ped skin, a pickup model, an object model or a vehicle model.

		@param theElement the element to retrieve the model ID of.
	**/
	static function getElementModel(theElement:Element):Int;

	/**
		This function is used to determine the parent of an element.

		@param theElement The child of the parent element you want returned.
	**/
	static function getElementParent(theElement:Element):Element;

	/**
		The getElementPosition function allows you to retrieve the position coordinates of an element.  This can be any real world element, including:

		@param theElement The element which you'd like to retrieve the location of
	**/
	static function getElementPosition(theElement:Element):Vector3;

	/**
		Retrieve the rotation of elements.

		@param theElement The element whose rotation will be retrieved
		@param rotOrder A string representing the rotation order desired when returning the euler angles. If omitted, default value is "default".
	**/
	static function getElementRotation(theElement:Element, ?rotOrder:String = "default"):Float;

	/**
		This function gets the syncer of an element. The syncer is the player who is in control of the element.OOP Syntax Help! I don't understand this!

		@param theElement The element to get the syncer of.
	**/
	static function getElementSyncer(theElement:Element):Element;

	/**
		This function is used to retrieve the type of an element.

		@param theElement The element you wish to get the type of.
	**/
	static function getElementType(theElement:Element):String;

	/**
		This function returns three floats containing the velocity (movement speeds) along the X, Y, and Z axis respectively. This means that velocity values can be positive and negative for each axis.

		@param theElement The element you wish to retrieve the velocity of.
	**/
	static function getElementVelocity(theElement:Element):Vector3;

	/**
		This function allows you to retrieve the zone name of an element (eg. Verdant Bluffs or Ocean Docks)

		@param theElement The element which you'd like to retrieve the zone name from
	**/
	static function getElementZoneName(theElement:Element, ?citiesonly:Bool = false):String;

	/**
		This function is used to retrieve a list of all elements of the specified type. This can be useful, as it disregards where in the element tree it is. It can be used with either the built in types (listed below) or with any custom type used in a .map file. For example, if there is an element of type "flag" (e.g. <flag />) in the .map file, the using "flag" as the type argument would find it.

		@param theType The type of element you want a list of. This is the same as the tag name in the .map file, so this can be used with a custom element type if desired. Built in types can be found here: Element
	**/
	static function getElementsByType(theType:String, ?startat:Element):Table<Int, Element>;

	/**
		This function returns the root node of the element tree, called root. This node contains every other element: all resource root elements, players and remote clients. It is never destroyed and cannot be destroyed using destroyElement.
	**/
	static function getRootElement():RootElement;

	/**
		This function checks if an element has element data available under a certain key.OOP Syntax Help! I don't understand this!

		@param theElement This is the element with data you want to check.
		@param key The name of the element data entry you want to check for. (Maximum 31 characters.)
		@param inherit - toggles whether or not the function should go up the hierarchy to find the requested key in case the specified element doesn't have it.
	**/
	static function hasElementData(theElement:Element, key:String, ?inherit:Bool = true):Bool;

	/**
		This function returns whether a player is subscribed to specific element data.
		This function is used together with setElementData in "subscribe" mode.

		@param theElement The element you wish to check whether the player is subscribed to.
		@param key The key you wish to check whether the player is subscribed to.
		@param thePlayer The player you wish to check.
	**/
	static function hasElementDataSubscriber(theElement:Element, key:String, thePlayer:Player):Bool;

	/**
		This functions checks whether or not an element is attached to another element.

		@param theElement The element to check for attachment.
	**/
	static function isElementAttached(theElement:Element):Bool;

	/**
		This functions checks if certain element has call propagation enabled.

		@param theElement The element to check
	**/
	static function isElementCallPropagationEnabled(theElement:Element):Bool;

	/**
		This function checks whether an element is double-sided as set by setElementDoubleSided or not.

		@param theElement The element in which you'd like to check the double-sidedness of.
	**/
	static function isElementDoubleSided(theElement:Element):Bool;

	/**
		This function checks if element has been frozen.

		@param theElement the element whose freeze status we want to check.
	**/
	static function isElementFrozen(theElement:Element):Bool;

	/**
		This function checks whether an element is submerged in water.OOP Syntax Help! I don't understand this!

		@param theElement The element to check.
	**/
	static function isElementInWater(theElement:Element):Bool;

	/**
		This checks if an element is visible to a player. This does not check if the player can literally see the element, just that they are aware that it exists. Some so-called per-player elements are able to be visible only to some players, as such this checks if this is the case for a particular element/player combination.

		@param theElement The element you want to check the visibility of
		@param visibleTo The player you want to check against
	**/
	static function isElementVisibleTo(theElement:Element, visibleTo:Element):Bool;

	/**
		This function is used to determine if an element is within a marker.

		@param theElement The element you're checking.
		@param theMarker The marker you're checking.
	**/
	static function isElementWithinMarker(theElement:Element, theMarker:Marker):Bool;

	/**
		This function removes the element data with the given key for that element. The element data removal is synced with all the clients.

		@param theElement The element you wish to remove the data from.
		@param key The key string you wish to remove.
	**/
	static function removeElementData(theElement:Element, key:String):Bool;

	/**
		This function unsubscribes a player from specific element data.
		This function is used together with setElementData in "subscribe" mode.

		@param theElement The element you wish to unsubscribe the player from.
		@param key The key you wish to unsubscribe the player from.
		@param thePlayer The player you wish to unsubscribe.
	**/
	static function removeElementDataSubscriber(theElement:Element, key:String, thePlayer:Player):Bool;

	/**
		This function sets the alpha (transparency) value for the specified element. This can be a player, ped, object, vehicle or weapon.

		@param theElement The element whose alpha you want to set.
		@param alpha The alpha value to set. Values are 0-255, where 255 is fully opaque and 0 is fully transparent.
	**/
	static function setElementAlpha(theElement:Element, alpha:Int):Bool;

	/**
		Sets the angular velocity of a specified, supported element (Applies a spin to it).OOP Syntax Help! I don't understand this!

		@param theElement The element to apply the spin to. Can be either a player, ped, object, vehicle or a custom weapon.
		@param velocity Vector3 velocity
	**/
	static function setElementAngularVelocity(theElement:Element, velocity:Vector3):Bool;

	/**
		Gets the current angular velocity of a specified, supported element.OOP Syntax Help! I don't understand this!

		@param theElement The element to retrieve the angular velocity from. Can be either a player, ped, object, vehicle or a custom weapon. Server side supports only vehicles currently.
	**/
	static function getElementAngularVelocity(theElement:Element):Vector3;

	/**
		This function updates the offsets of an element that has been attached to another element using attachElements.OOP Syntax Help! I don't understand this!

		@param theElement The attached element.
	**/
	static function setElementAttachedOffsets(theElement:Element, ?offsetPosition:Vector3, ?offsetRotation:Vector3):Bool;

	/**
		This function enables/disables call propagation on a certain element. Look at the example for a practical application.OOP Syntax Help! I don't understand this!

		@param theElement The element whose propagation behaviour you'd like to change
		@param enabled Whether propagation should be enabled or not
	**/
	static function setElementCallPropagationEnabled(theElement:Element, enabled:Bool):Bool;

	/**
		This function can disable or enable an element's collisions. An element without collisions does not interact with the physical environment and remains static.

		@param theElement The element you wish to set the collisions of
		@param enabled A boolean to indicate whether collisions are enabled (true) or disabled (false)
	**/
	static function setElementCollisionsEnabled(theElement:Element, enabled:Bool):Bool;

	/**
		This function stores element data under a certain key, attached to an element. Element data set using this is then synced with all clients and the server. The data can contain server created elements, but you should avoid passing data that is not able to be synced such as xmlnodes, acls, aclgroups etc.

		@param theElement The element you wish to attach the data to.
		@param key The key you wish to store the data under. (Maximum 128 characters.)
		@param value The value you wish to store. See element data for a list of acceptable datatypes.
		@param syncMode Synchronisation mode. 
	**/
	static function setElementData(theElement:Element, key:String, value:Dynamic, ?syncMode:ElementSyncMode = ElementSyncMode.BROADCAST):Bool;

	/**
		This function allows you to set the dimension of any element. The dimension determines what/who the element is visible to.

		@param theElement The element in which you'd like to set the dimension of.
		@param dimension An integer representing the dimension ID. You can also use -1 to make the element visible in all dimensions (only valid to objects). Valid values are 0 to 65535.
	**/
	static function setElementDimension(theElement:Element, dimension:Int):Bool;

	/**
		This function allows you to set the double-sidedness of an element's model. When an element's model is double-sided, it's back facing triangles become visible.

		@param theElement The element in which you'd like to set the double-sidedness of.
		@param enable  Set to true/false to enable/disable double-sidedness.
	**/
	static function setElementDoubleSided(theElement:Element, enable:Bool):Bool;

	/**
		This function freezes an element (stops it in its position and disables movement) or unfreezes it.OOP Syntax Help! I don't understand this!

		@param theElement The element whose freeze status we want to change.
		@param freezeStatus A boolean denoting whether we want to freeze (true) or unfreeze (false) it.
	**/
	static function setElementFrozen(theElement:Element, freezeStatus:Bool):Bool;

	/**
		This function sets the health for the specified element. This can be a ped, object or a vehicle.

		@param theElement The ped, vehicle or object whose health you want to set.
		@param newHealth A float indicating the new health to set for the element.
	**/
	static function setElementHealth(theElement:Element, newHealth:Float):Bool;

	/**
		This function allows you to set the interior of any element. An interior is the current loaded place, 0 being outside.

		@param theElement The element in which you'd like to set the interior of.
		@param interior The interior you want to set the element to. Valid values are 0 to 255.
	**/
	static function setElementInterior(theElement:Element, interior:Int, ?position:Vector3):Bool;

	/**
		Sets the model of a given element. This allows you to change the model of a player (or ped), a vehicle or an object.

		@param theElement the element you want to change.
		@param model the model ID to set.
	**/
	static function setElementModel(theElement:Element, model:Int):Bool;

	/**
		This function is used for setting an element as the parent of another element.

		@param theElement The element that you wish to set the parent of.
		@param parent The element you wish to be the parent of theElement.
	**/
	static function setElementParent(theElement:Element, parent:Element):Bool;

	/**
		This function sets the position of an element to the specified coordinates.OOP Syntax Help! I don't understand this!

		@param theElement A valid element to be moved.
		@param position New element position
		@param warp teleports players, resetting any animations they were doing. Setting this to false preserves the current animation.
	**/
	static function setElementPosition(theElement:Element, ?position:Vector3, ?warp:Bool = true):Bool;

	/**
		Sets the rotation of elements according to the world (does not work with players that are on the ground).

		@param theElement The element whose rotation will be set
		@param rotation The element's rotation 
		@param rotOrder A string representing the rotation order desired when interpreting the provided euler angles. If omitted, default value is "default". Allowed values are:
		@param conformPedRotation A bool which should be set to true to ensure the ped rotation is correctly set in all circumstances.
	**/
	static function setElementRotation(theElement:Element, rotation:Vector3, ?rotOrder:String = "default", ?conformPedRotation:Bool = false):Bool;

	/**
		This function can be used to change the syncer (player) of an element. The syncer is the player who is responsible for informing the server about the state of that element - it's position, orientation and other state information. The function can be also used to remove an element's syncer.

		@param theElement The element whose syncer you wish to change.
		@param thePlayer The player who should be the new syncer of the element. If set to false, this element will not have a syncer. If set to true, MTA will pick automatically the nearest or most relevant player to that element.
	**/
	static function setElementSyncer(theElement:Element, thePlayer:Player):Bool;

	/**
		This function sets the velocity (movement speeds) along each axis, for an element.

		@param theElement The element you wish to set the velocity of.
		@param speed A vector value determining the speed.
	**/
	static function setElementVelocity(theElement:Element, speed:Vector3):Bool;

	/**
		Does the order of setElementVisibleTo calls really not matter? Visibility seems to imply that the order does matter.

		@param theElement The element you want to control the visibility of.
		@param visibleTo The element you wish the element to be visible or invisible to. Any child elements that are players will also be able to see the element. See visibility.
		@param visible Whether you are making it visible or invisible to the player.
	**/
	static function setElementVisibleTo(theElement:Element, visibleTo:Element, visible:Bool):Bool;

	/**
		This function allows you to register a custom event. Custom events function exactly like the built-in events. See event system for more information on the event system.Returns true if the event was added successfully, false if the event was already added.

		@param eventName The name of the event you wish to create.
		@param allowRemoteTrigger A boolean specifying whether this event can be called remotely using triggerClientEvent / triggerServerEvent or not.
	**/
	static function addEvent(eventName:String, ?allowRemoteTrigger:Bool = false):Bool;

	/**
		This function will add an event handler. An event handler is a function that will be called when the event it's attached to is triggered. See event system for more information on how the event system works.

		@param eventName The name of the event you want to attach the handler function to. Note: The maximum allowed length is 100 ASCII characters (that is, English letters and numerals)```
		@param attachedTo The element you wish to attach the handler to. The handler will only be called when the event it is attached to is triggered for this element, or one of its children. Often, this can be the root element (meaning the handler will be called when the event is triggered for any element).
		@param handlerFunction The handler function you wish to call when the event is triggered. This function will be passed all of the event's parameters as arguments, but it isn't required that it takes all of them.
		@param propagate A boolean representing whether the handler will be triggered if the event was propagated down or up the element tree (starting from the source), and not triggered directly on attachedTo (that is, handlers attached with this argument set to false will only be triggered if source == this). In GUI events you will probably want to set this to false.
	**/
	static function addEventHandler(eventName:String, attachedTo:Element, handlerFunction:Function, ?propagate:Bool = true, ?priority:String = "normal"):Bool;

	/**
		This function is used to stop the automatic internal handling of events, for example this can be used to prevent an item being given to a player when they walk over a pickup, by canceling the onPickupUse event.cancelEvent does not have an effect on all events, see the individual event's pages for information on what happens when the event is canceled. cancelEvent does not stop further event handlers from being called, as the order of event handlers being called is undefined in many cases. Instead, you can see if the currently active event has been cancelled using wasEventCancelled.


	**/
	static function cancelEvent(?cancel:Bool = true, ?reason:String):Bool;

	/**
		Stops a latent event from completingReturns a true if the latent event was successfully cancelled, or false if it was not

		@param thePlayer The player who is receiving the event.
		@param handle A handle previous got from getLatentEventHandles.
		@param handle A handle previous got from getLatentEventHandles.
	**/
	static function cancelLatentEvent(thePlayer:Player, handle:Int):Bool;

	/**
		Gets the reason for cancelling an event.None
	**/
	static function getCancelReason():String;

	/**
		This function gets the attached functions from the event and attached element from current lua script.Returns table with attached functions, empty table otherwise.

		@param eventName The name of the event. For example ( "onPlayerWasted" ).
		@param attachedTo The element attached to.
	**/
	static function getEventHandlers(eventName:String, attachedTo:Element):Table<Int, Function>;

	/**
		Gets the currently queued latent events. The last one in the table is always the latest event queued. Each returned handle can be used with getLatentEventStatus or cancelLatentEvent

		@param thePlayer The player who is receiving the events.
	**/
	static function getLatentEventHandles(thePlayer:Player):Table<Int, Function>;

	/**
		Gets the status of one queued latent event.Returns a table with the following info or false if invalid arguments were passed:

		@param thePlayer The player who is receiving the event.
		@param handle A handle previous got from getLatentEventHandles.
	**/
	static function getLatentEventStatus(thePlayer:Player, handle:Int):Map<LatentEventStatus, Int>;

	/**
		This functions removes a handler function from an event, so that the function is not called anymore when the event is triggered. See event system for more information on how the event system works.Returns true if the event handler was removed successfully. Returns false if the specified event handler could not be found or invalid parameters were passed.

		@param eventName The name of the event you want to detach the handler function from.
		@param attachedTo The element the handler was attached to.
		@param handler The handler function that was attached.
	**/
	static function removeEventHandler(eventName:String, attachedTo:Element, handler:Function):Bool;

	/**
		This function will trigger a named event on a specific element in the element tree. See event system for more information on how the event system works.You can use the value returned from this function to determine if the event was cancelled by one of the event handlers. You should determine what your response (if any) to this should be based on the event's purpose. Generally, cancelling an event should prevent any further code being run that is dependent on whatever triggered that event. For example, if you have an onFlagCapture event, cancelling it would be expected to prevent the flag being able to be captured. Similarly, if you have onPlayerKill as an event you trigger, canceling it would either be expected to prevent the player being killed from dying or at least prevent the player from getting a score for it.

		@param eventName The name of the event you wish to trigger
		@param baseElement The element you wish to trigger the event on. See event system for information on how this works.
	**/
	static function triggerEvent(eventName:String, baseElement:Element, arguments:Rest<Dynamic>):Bool;

	/**
		This function triggers an event previously registered on a client. This is the primary means of passing information between the server and the client. Clients have a similar triggerServerEvent function that can do the reverse. You can treat this function as if it was an asynchronous function call, using triggerServerEvent to pass back any returned information if necessary.Almost any data types can be passed as expected, including elements and complex nested tables. Non-element MTA data types like xmlNodes or resource pointers will not be able to be passed as they do not necessarily have a valid representation on the client.

		@param name The name of the event to trigger client side. You should register this event with addEvent and add at least one event handler using addEventHandler.
		@param sourceElement The element that is the source of the event.
	**/
	static function triggerClientEvent(?sendTo:EitherType<Table<Int, Player>, Element>, name:String, sourceElement:Element):Bool;

	/**
		This function is the same as triggerClientEvent  except the transmission rate of the data contained in the arguments can be limited
		and other network traffic is not blocked while the data is being transferred.Returns true if the event trigger has been sent, false if invalid arguments were specified.

		@param name The name of the event to trigger client side. You should register this event with addEvent and add at least one event handler using addEventHandler.
		@param theElement The element that is the source of the event. This could be another player, or if this isn't relevant, use the root element.
		@param sendTo The event will be sent to all players that are children of the specified element. By default this is the root element, and hence the event is sent to all players. If you specify a single player it will just be sent to that player. This argument can also be a table of player elements.
		@param bandwidth The bytes per second rate to send the data contained in the arguments.
		@param persist A bool indicating whether the transmission should be allowed to continue even after the resource that triggered it has since stopped.
	**/
	static function triggerLatentClientEvent(?sendTo:EitherType<Table<Int, Player>, Element>, name:String, ?bandwidth:Int = 50000, ?persist:Bool = false,
		theElement:Element, arguments:Rest<Dynamic>):Bool;

	/**
		This function checks if the last completed event was cancelled. This is mainly useful for custom events created by scripts.
	**/
	static function wasEventCancelled():Bool;

	/**
		Creates an explosion of a certain type at a specified point in the world. If creator is specified, the explosion will occur only in its dimension.

		@param position position where the explosion is created at.
		@param theType an integer specifying the explosion type. Valid types are:
		@param creator the explosion's simulated creator, the player responsible for it.
	**/
	static function createExplosion(position:Vector3, theType:ExplosionType, ?creator:Player):Bool;

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
