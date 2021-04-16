package mtasa.server;

import lua.Table;

@:native('_G')
extern class ModuleFunctions {
	/**
		This function returns all the currently loaded modules of the server.Returns a table of all the currently loaded modules. If no modules are loaded, the table will be empty.
	**/
	static function getLoadedModules():Table<Int, String>;

	/**
		This function returns information about the specified module.Returns a table containing information about module. These keys are present in the table:

		@param moduleName A string containing the module you wish to get information of e.g. "hashing.dll"
	**/
	static function getModuleInfo(moduleName:String):{version:String, name:String, author:String};
}
