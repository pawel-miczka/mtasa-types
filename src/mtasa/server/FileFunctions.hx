package mtasa.server;

import haxe.extern.Rest;
import mtasa.shared.classes.File;

@:native('_G')
extern class FileFunctions {
	/**
		Closes a file handle obtained by fileCreate or fileOpen.OOP Syntax Help! I don't understand this!

		@param theFile The file handle to close.
	**/
	static function fileClose(theFile:File):Bool;

	/**
		This function copies a file.

		@param filePath The path of the file you want to copy.
		@param copyToFilePath Where to copy the specified file to.
		@param overwrite If set to true it will overwrite a file that already exists at copyToFilePath.
	**/
	static function fileCopy(filePath:String, copyToFilePath:String, ?overwrite:Bool = false):Bool;

	/**
		Creates a new file in a directory of a resource. If there already exists a file with the specified name, it is overwritten with an empty file.

		@param filePath The filepath of the file to be created in the following format: ":resourceName/path". 'resourceName' is the name of the resource the file is in, and 'path' is the path from the root directory of the resource to the file.
	**/
	static function fileCreate(filePath:String):File;

	/**
		Deletes the specified file.OOP Syntax Help! I don't understand this!

		@param filePath The filepath of the file to delete in the following format: ":resourceName/path". 'resourceName' is the name of the resource the file is in, and 'path' is the path from the root directory of the resource to the file.
	**/
	static function fileDelete(filePath:String):Bool;

	/**
		This functions checks whether a specified file exists inside a resource.OOP Syntax Help! I don't understand this!

		@param filePath The filepath of the file, whose existence is going to be checked, in the following format: ":resourceName/path". 'resourceName' is the name of the resource the file is checked to be in, and 'path' is the path from the root directory of the resource to the file.
	**/
	static function fileExists(filePath:String):Bool;

	/**
		Forces pending disk writes to be executed. fileWrite doesn't directly write to the hard disk but places the data in a temporary buffer; only when there is enough data in the buffer it is actually written to disk. Call this function if you need the data written right now without closing the file. This is useful for log files that might want to be read while the resource is still executing. fileFlush can be called after each log entry is written. Without this, the file may appear empty or outdated to the user.

		@param theFile The file handle of the file you wish to flush.
	**/
	static function fileFlush(theFile:File):Bool;

	/**
		This function retrieves the path of the given file.Returns a string representing the file path, false if invalid file was provided.

		@param theFile The file you want to get the path.
	**/
	static function fileGetPath(theFile:File):String;

	/**
		Returns the current read/write position in the given file.

		@param theFile the file handle you wish to get the position of.
	**/
	static function fileGetPos(theFile:File):Int;

	/**
		Returns the total size in bytes of the given file.

		@param theFile the file handle you wish to get the size of.
	**/
	static function fileGetSize(theFile:File):Int;

	/**
		Opens an existing file for reading and writing.OOP Syntax Help! I don't understand this!

		@param filePath The filepath of the file in the following format: ":resourceName/path". 'resourceName' is the name of the resource the file is in, and 'path' is the path from the root directory of the resource to the file.
		@param readOnly By default, the file is opened with reading and writing access. You can specify true for this parameter if you only need reading access.
	**/
	static function fileOpen(filePath:String, ?readOnly:Bool = false):File;

	/**
		Reads the specified number of bytes from the given file starting at its current read/write position, and returns them as a string.

		@param theFile A handle to the file you wish to read from. Use fileOpen to obtain this handle.
		@param count The number of bytes you wish to read.
	**/
	static function fileRead(theFile:File, count:Int):String;

	/**
		Renames the specified file.

		@param filePath The filepath of the source file in the following format: ":resourceName/path". 'resourceName' is the name of the resource the file is in, and 'path' is the path from the root directory of the resource to the file. If the file is in the current resource, only the file path is necessary.
		@param newFilePath Destination filepath for the specified source file in the same format.
	**/
	static function fileRename(filePath:String, newFilePath:String):Bool;

	/**
		Sets the current read/write position in the file.

		@param theFile The file handle of which you want to change the read/write position.
		@param offset The new position. This is the number of bytes from the beginning of the file. If this value is larger than the file size, it is limited to 52,428,800 bytes (50 MB).
	**/
	static function fileSetPos(theFile:File, offset:Int):Int;

	/**
		Writes one or more strings to a given file, starting at the current read/write position. Advances the position over the number of bytes that were written.OOP Syntax Help! I don't understand this!

		@param theFile A handle to the file you wish to write to. The file must have been opened with write access, i.e. the file handle must be a result of fileCreate or fileOpen with the readonly parameter set to false.
		@param firstString The string to write.
	**/
	static function fileWrite(theFile:File, firstString:String, strings:Rest<String>):Int;
}
