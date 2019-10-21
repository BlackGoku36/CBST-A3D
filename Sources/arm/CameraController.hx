package arm;

import iron.Scene;
import iron.system.Input;
import iron.math.Vec4;

class CameraController extends iron.Trait {

	var cameraEmpty = Scene.active.getEmpty("CameraEmpty").transform;
	var mouse = Input.getMouse();

	@prop
	var viewMin = 1.0;
	@prop
	var viewMax = 2.8;

	public function new() {
		super();

		notifyOnUpdate(update);
	}
	
	function update() {
		if(mouse.down("right")){
			cameraEmpty.rotate(new Vec4(0, 0, 1), -mouse.movementX / 200);
			cameraEmpty.buildMatrix();
			cameraEmpty.rotate(object.transform.world.right(), -mouse.movementY / 200);
			cameraEmpty.buildMatrix();
		}
		if (mouse.wheelDelta != 0){
			cameraEmpty.scale.add(new Vec4(mouse.wheelDelta/30, mouse.wheelDelta/30, mouse.wheelDelta/30));
			cameraEmpty.scale.clamp(viewMin, viewMax);
			cameraEmpty.buildMatrix();
		}
	}
}
