package mtasa.server;

import mtasa.shared.enums.BodyPart;
import mtasa.shared.returns.GetClothesByTypeIndex;
import mtasa.shared.enums.ClothesType;

@:native('_G')
extern class ClothesBodyFunctions {
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
}
