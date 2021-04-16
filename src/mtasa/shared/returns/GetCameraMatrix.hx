package mtasa.shared.returns;

import mtasa.shared.classes.Vector3;

@:multiReturn extern class GetCameraMatrix {
	var position:Vector3;
	var lookAtPosition:Vector3;
	var roll:Float;
	var fov:Float;
}
