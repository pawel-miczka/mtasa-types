package mtasa.server;

import haxe.extern.Rest;
import mtasa.shared.enums.ColShapeType;
import lua.Table;
import mtasa.shared.enums.BasicElementType;
import haxe.extern.EitherType;
import mtasa.server.classes.Element;
import mtasa.shared.classes.Vector3;
import mtasa.shared.classes.Vector2;
import mtasa.server.classes.ColShape;

@:native('_G')
extern class CollisionShapeFunctions {
	/**
		This function is used to add a new point to an existing colshape polygon.

		@param shape The colshape polygon you wish add a point to.
		@param position The Vector2 position of the new bound point.
		@param index index: The index where the new point will be inserted in the polygon. The points are indexed in order, with 1 being the first bound point. Passing 0 will insert the point as the last one in the polygon.
	**/
	static function addColPolygonPoint(shape:ColShape, position:Vector2, ?index:Int = 0):Bool;

	/**
		This function creates a collision circle. This is a shape that has a position and a radius and infinite height that you can use to detect a player's presence. Events will be triggered when a player enters or leaves it.OOP Syntax Help! I don't understand this!

		@param center The collision circle's center point
		@param radius The radius of the collision circle. Can not be smaller than 0.1
	**/
	static function createColCircle(center:Vector2, radius:Float):ColShape;

	/**
		This function creates a collision cuboid. This is a shape that has a position, width, depth and height. See Wikipedia for a definition of a cuboid. The XYZ of the col starts at the southwest bottom corner of the shape.OOP Syntax Help! I don't understand this!

		@param position The position of the collision cuboid's western, southern and lowest side
		@param fWidth The collision cuboid's width
		@param fDepth The collision cuboid's depth
		@param fHeight The collision cuboid's height
	**/
	static function createColCuboid(position:Vector3, fWidth:Float, fDepth:Float, fHeight:Float):ColShape;

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
}
