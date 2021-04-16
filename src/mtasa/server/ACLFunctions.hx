package mtasa.server;

import haxe.extern.EitherType;
import lua.Table;
import mtasa.server.classes.ACL;
import mtasa.server.classes.ACLGroup;
import mtasa.server.classes.Element;

@:native('_G')
extern class ACLFunctions {
	/**
		This function creates an ACL entry in the Access Control List system with the specified name.

		@param aclName The name of the ACL entry to add.
	**/
	static function aclCreate(aclName:String):ACL;

	/**
		This function creates a group in the ACL. An ACL group can contain objects like players and resources. They specify who has access to the ACL's in this group.

		@param groupName The name of the group to create
	**/
	static function aclCreateGroup(groupName:String):ACLGroup;

	/**
		This function destroys the ACL passed. The destroyed ACL will no longer be valid.

		@param theACL The ACL to destroy
	**/
	static function aclDestroy(theACL:ACL):Bool;

	/**
		This function destroys the given ACL group. The destroyed ACL group will no longer be valid.

		@param aclGroup The aclgroup element to destroy
	**/
	static function aclDestroyGroup(aclGroup:ACLGroup):Bool;

	/**
		Get the ACL with the given name. If need to get most of the ACL's, you should consider using aclList to get a table of them all.

		@param aclName The name to get the ACL belonging to
	**/
	static function aclGet(aclName:String):ACL;

	/**
		This function is used to get the ACL group with the given name. If you need most of the groups you should consider using aclGroupList instead to get a table containing them all.

		@param groupName The name to get the ACL group from
	**/
	static function aclGetGroup(groupName:String):ACLGroup;

	/**
		Get the name of given ACL.

		@param theACL The ACL to get the name of
	**/
	static function aclGetName(theAcl:ACL):String;

	/**
		This function returns whether the access for the given right is set to true or false in the ACL.

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
		This function is used to get the name of the given ACL group.

		@param aclGroup The ACL group to get the name of
	**/
	static function aclGroupGetName(aclGroup:ACLGroup):String;

	/**
		This function returns a table of all the ACL groups.
	**/
	static function aclGroupList():Table<Int, ACLGroup>;

	/**
		This function returns a table over all the objects that exist in a given ACL group. 
		These are objects like players and resources.

		@param theGroup The ACL group to get the objects from
	**/
	static function aclGroupListObjects(theGroup:ACLGroup):Table<Int, String>;

	/**
		This function removes the given object from the given ACL group. The object can be a resource or a player. See aclGroupAddObject for more details.

		@param theGroup The ACL group to remove the object string from
		@param theObjectString The object to remove from the ACL group
	**/
	static function aclGroupRemoveObject(theGroup:ACLGroup, theObjectString:String):Bool;

	/**
		This function returns a list of all the ACLs.
	**/
	static function aclList():Table<Int, ACL>;

	/**
		This function returns a table of all the rights that a given ACL has.

		@param theACL The ACL to get the rights from
		@param allowedType The allowed right type. Possible values are general, function, resource and command
	**/
	static function aclListRights(theACL:ACL, allowedType:String):Table<Int, String>;

	/**
		This function reloads the ACL's and the ACL groups from the ACL XML file. All ACL and ACL group elements are invalid after a call to this and should not be used anymore.
	**/
	static function aclReload():Bool;

	/**
		This function removes the given right (string) from the given ACL.

		@param theAcl The ACL to remove the right from
		@param rightName The ACL name to remove from the right from
	**/
	static function aclRemoveRight(theAcl:ACL, rightName:String):Bool;

	/**
		The ACL XML file is automatically saved whenever the ACL is modified, but the automatic save can be delayed by up to 10 seconds for performance reasons. Calling this function will force an immediate save.
	**/
	static function aclSave():Bool;

	/**
		This functions changes or adds the given right in the given ACL. The access can be true or false and specifies whether the ACL gives access to the right or not.

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
		This function is used to determine if an object is in a group.

		@param theObject the name of the object to check. Examples: "resource.ctf", "user.Jim".
		@param theGroup the ACL group pointer of the group from which the object should be found.
	**/
	static function isObjectInACLGroup(theObject:String, theGroup:ACLGroup):Bool;
}
