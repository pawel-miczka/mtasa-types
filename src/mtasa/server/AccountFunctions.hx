package mtasa.server;

import lua.Table;
import mtasa.server.classes.Player;
import mtasa.server.classes.Account;

@:native('_G')
extern class AccountFunctions {
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
}