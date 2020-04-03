package arm;

import armory.trait.physics.RigidBody;
import armory.trait.physics.PhysicsWorld;

import iron.Scene;
import iron.math.Vec4;
import iron.math.RayCaster;
import iron.system.Input;
import iron.object.Object;

import arm.data.Buildings;

class BuildingController extends iron.Trait {

	public static var selectedBuilding:Building = null;

	public static var buildingMove = false;

	public static var buildingInContact = false;
	public static var enoughResources = true;
	public static var enoughBuildings = true;

	public function new(){
		super();
	}

	public static function raySelectBuilding() {
		var rigidbody = getRaycastRigidBody(2).rigidbody;
		if(rigidbody != null){
			selectBuilding(getBuildingFromObject(rigidbody.object));
		}else {
			unselectBuilding();
		}
	}

	public static function unselectBuilding() {
		selectedBuilding = null;
		buildingMove = false;
	}

	public static function selectBuilding(building:Building) {
		selectedBuilding = building;
		buildingMove = true;
	}

	public static function moveBuilding() {
		var raycast = getRaycastRigidBody(1);
		if(raycast.rigidbody != null && raycast.rigidbody.object.name == "Ground"){
			selectedBuilding.object.transform.loc.set(Math.floor(raycast.hit.pos.x), Math.floor(raycast.hit.pos.y), 0.2);
		}
	}

	public static function rotateBuilding() {
		selectedBuilding.object.transform.rotate(Vec4.zAxis(), 1.57);
	}

	public static function buildingContact() {
		var physics = PhysicsWorld.active;
		var contact = physics.getContacts(selectedBuilding.object.getTrait(RigidBody));
		if(contact != null){
			// trace("ok");
			for (c in contact){
				trace(c.object.name);
				if(c.object.name != "Ground") buildingInContact = true;
				else buildingInContact = false;
			}
		}
	}

	static function getRaycastRigidBody(group:Int){
		var physics = PhysicsWorld.active;
		var mouse = Input.getMouse();
		var start = new Vec4();
		var end = new Vec4();
		var camera = Scene.active.getCamera("Camera");
		RayCaster.getDirection(start, end, mouse.x, mouse.y, camera);
		var hit = physics.rayCast(camera.transform.world.getLoc(), end, group);
		var rigidbody = (hit != null) ? hit.rb : null;
		return{
			rigidbody: rigidbody,
			hit: hit
		};
	}

	static function getBuildingFromObject(obj: Object):Building {
		var building:Building = null;
		var type = obj.name.split("_")[1];
		switch(type){
			case "Community": for(bld in Buildings.communities) if(bld.object == obj) building = bld;
			case "Factory": for(bld in Buildings.factories) if(bld.object == obj) building = bld;
			case "Utility": for(bld in Buildings.utilities) if(bld.object == obj) building = bld;
			case "Decoration": for(bld in Buildings.decorations) if(bld.object == obj) building = bld;
		}
		return building;
	}
}
