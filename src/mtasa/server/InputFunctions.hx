package mtasa.server;

import haxe.extern.Rest;
import lua.Table;
import mtasa.server.classes.Resource;
import haxe.extern.EitherType;
import haxe.Constraints.Function;
import mtasa.shared.enums.KeyState;
import mtasa.shared.enums.Control;
import mtasa.server.classes.Player;

@:native('_G')
extern class InputFunctions {
	/**
		This function will attach a scripting function (handler) to a console command, so that whenever a player or administrator uses the command the function is called.

		@param commandName This is the name of the command you wish to attach a handler to. This is what must be typed into the console to trigger the function.
		@param handlerFunction This is the function that you want the command to trigger, which has to be defined before you add the handler. This function can take two parameters, playerSource and commandName, followed by as many parameters as you expect after your command (see below). These are all optional.
		@param restricted Specify whether or not this command should be restricted by default.
		@param caseSensitive Specifies if the command handler will ignore the case for this command name.
	**/
	static function addCommandHandler(commandName:String, handlerFunction:Function, ?restricted:Bool = false, ?caseSensitive:Bool = true):Bool;

	/**
		Binds a player's key to a handler function or command, which will be called when the key is pressed. 

		@param thePlayer The player you wish to bind the key of.
		@param key The key or control you wish to bind to the command. See key names for a list of possible keys and control names for a list of possible controls.
		@param keyState key state 
		@param handleFunction The function that will be triggered when the player's key is pressed.
	**/
	static function bindKey(thePlayer:Player, key:String, keyState:KeyState, handlerFunction:Function, arguments:Rest<Dynamic>):Bool;

	/**
		This function will call all the attached functions of an existing console command, for a specified player.

		@param commandName The name of the command you wish to execute. This is what must be typed into the console to trigger the function.
		@param thePlayer The player that will be presented as executer of the command to the handler function(s) of the command.
		@param args Additional parameters that will be passed to the handler function(s) of the command that is called, separated by spaces.
	**/
	static function executeCommandHandler(commandName:String, thePlayer:Player, ?args:String):Bool;

	/**
		This function is used to retrieve a list of all the registered command handlers of a given resource (or of all resources).

		@param theResource The resource from which you wish to retrieve all command handlers. Or leave it empty to retrieve command handlers of all resources.
	**/
	static function getCommandHandlers(?theResource:Resource):EitherType<Table<Int, String>,
		Table<Int, Table<Int, EitherType<String, Resource>>>>; // TODO this must be tested

	/**
		This function will check if a player is pressing a particular control. Controls are those that affect GTA. If you wish to get the state of another key, use bindKey and a command function.

		@param thePlayer The player you wish to get the control state of. Do not use this parameter when scripting for client.
		@param controlName The control that you want to get the state of. See control names for a list of possible controls.
	**/
	static function getControlState(thePlayer:Player, controlName:Control):Bool;

	/**
		Gets the functions bound to a key. To bind a function to a key use the bindKey function

		@param thePlayer The player to get the functions from a key.
		@param theKey The key you wish to check the functions from.
		@param keyState A string that has one of the following values:
	**/
	static function getFunctionsBoundToKey(thePlayer:Player, key:String, keyState:KeyState):Table<Int, Function>;

	/**
		getKeyBoundToFunction allows retrieval of the first key bound to a function.Returns a string of the first key the function was bound to.

		@param thePlayer The player you are checking the function bound to a key
		@param theFunction The function in which you would like to check the bound key
	**/
	static function getKeyBoundToFunction(thePlayer:Player, theFunction:Function):String;

	/**
		Checks whether a GTA control is enabled or disabled for a certain player.

		@param thePlayer The player you wish the control status of.
		@param control The control you wish to check. See control names for a list of possible controls.
	**/
	static function isControlEnabled(thePlayer:Player, control:Control):Bool;

	/**
		This function can be used to find out if a key has already been bound. If you do not specify a keyState or handler, any instances of key being bound will cause isKeyBound to return true.

		@param thePlayer The player you're checking.
		@param key The key you're checking. See Key names for a list of valid key names.
		@param keyState Is the state of the key when it calls the function, Can be either:
		@param handler The function you're checking against
	**/
	static function isKeyBound(thePlayer:Player, key:String, ?keyState:KeyState, ?handler:Function):Bool;

	/**
		This function removes a command handler, that is one that has been added using addCommandHandler. This function can only remove command handlers that were added by the resource that it is called in.

		@param commandName the name of the command you wish to remove.
		@param handler the specific handler function to remove. If not specified, all handler functions for the command (from the calling resource) will be removed. This argument is only available in the server.
	**/
	static function removeCommandHandler(commandName:String, ?handler:Function):Bool;

	/**
		Sets a state of a specified player's control, as if they pressed or released it.

		@param thePlayer The player you wish to set the control state of.
		@param control The control that you want to set the state of. See control names for a list of possible controls.
		@param state A boolean value representing whether or not the key will be set to pressed or not.
	**/
	static function setControlState(thePlayer:Player, control:Control, state:Bool):Bool;

	/**
		Enables or disables the use of all GTA controls for a specified player.NOTE: When using optional arguments, you might need to supply all arguments before the one you wish to use. For more information on optional arguments, see optional arguments.

		@param thePlayer The player you wish to toggle the control ability of.
		@param enabled A boolean value representing whether or not the controls will be usable.
		@param gtaControls A boolean deciding whether the enabled parameter will affect GTA's internal controls.
		@param mtaControls A boolean deciding whether the enabled parameter will affect MTA's own controls., e.g. chatbox.
	**/
	static function toggleAllControls(thePlayer:Player, enabled:Bool, ?gtaControls:Bool = true, ?mtaControls:Bool = true):Bool;

	/**
		Enables or disables the use of a GTA control for a specific player.This function true if the control was set successfully, false otherwise.

		@param thePlayer The player you wish to toggle the control ability of.
		@param control The control that you want to toggle the ability of. See control names for a list of possible controls.
		@param enabled A boolean value representing whether or not the key will be usable or not.
	**/
	static function toggleControl(thePlayer:Player, control:Control, enabled:Bool):Bool;

	/**
		Removes an existing key bind from the specified player.Note: If you do not specify handler, any instances of key being bound will be unbound, whatever function they are bound to.

		@param thePlayer The player you wish to unbind the key of.
		@param key The key you wish to unbind. See Key names for a list of valid key names.
		@param keyState key state
		@param command command to unbind
		@param handler handler to unbind
	**/
	@:overload(function(thePlayer:Player, key:String, ?keyState:KeyState, ?handler:Function):Bool {})
	static function unbindKey(thePlayer:Player, key:String, keyState:KeyState, command:String):Bool;
}
