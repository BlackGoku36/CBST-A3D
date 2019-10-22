package arm;

import armory.trait.physics.RigidBody;
import armory.trait.physics.PhysicsWorld;

import iron.Scene;
import iron.math.Vec4;
import iron.math.RayCaster;
import iron.system.Input;
import iron.object.Object;

import arm.WorldController;

typedef Building = {
	name: String,
	type: Int
}

class BuildingController extends iron.Trait {

	public static var buildings:Array<Building> = [];
	public static var buildingId = 0;

	//Mark: change selectedBuilding Type
	public static var selectedBuilding:Building = null;
	public static var isBuildingSelected = false;

	public static var buildingMove = false;

	public static var buildingInContact = false;
	public static var enoughResources = true;
	public static var enoughBuildings = true;

	public function new(){
		super();
	}

	public static function raySelectBuilding() {
		var rigidbody = getRaycastRigidBody(2).rigidbody;
		if(rigidbody != null && StringTools.startsWith(rigidbody.object.name, "bld")){
			//Mark: change selectedBuilding Type
			selectedBuilding = getBuildingFromString(rigidbody.object.name);
			isBuildingSelected = true;
		}else {
			selectedBuilding = null;
			isBuildingSelected = false;
		}
	}

	public static function unselectBuilding() {
		//Mark: change selectedBuilding Type
		selectedBuilding = null;
		isBuildingSelected = false;
		buildingMove = false;
	}

	public static function selectBuilding(name: String) {
		//Mark: change selectedBuilding Type
		selectedBuilding = getBuildingFromString(name);
		isBuildingSelected = true;
		buildingMove = true;
	}

	public static function moveBuilding() {
		var raycast = getRaycastRigidBody(1);
		if(raycast.rigidbody != null && raycast.rigidbody.object.name == "Ground"){
			//Mark: change selectedBuilding Type
			Scene.active.getChild(selectedBuilding.name).transform.loc.set(Math.floor(raycast.hit.pos.x), Math.floor(raycast.hit.pos.y), 0.2);
		}
	}

	public static function rotateBuilding() {
		//Mark: change selectedBuilding Type
		Scene.active.getChild(selectedBuilding.name).transform.rotate(Vec4.zAxis(), 1.57);
	}

	public static function spawnBuilding(type: Int) {
		var world = WorldController;
		checkResources(type);
		checkMaxBuilding(type);
		if(!enoughBuildings && enoughResources){
			Scene.active.spawnObject("bld_"+type, null, function(bld: Object){
				buildingId++;
				bld.transform.loc.set(0.0, 0.0, 0.0);
				bld.transform.buildMatrix();
				bld.name = "bld_"+type+"_"+buildingId;
				buildings.push({
					name: "bld_"+type+"_"+buildingId,
					type: type
				});
				recalculateResources(type);
				recalculateBuildings();
				unselectBuilding();
				selectBuilding(bld.name);
			});
		}

	}

	public static function removeBuilding() {
		//Mark: change selectedBuilding Type
		Scene.active.getChild(selectedBuilding.name).remove();
		//Mark: change selectedBuilding Type
		removefromArray(selectedBuilding.name, buildings);
		recalculateBuildings();
		unselectBuilding();
	}

	public static function buildingContact() {
		var physics = PhysicsWorld.active;
		var contact = physics.getContacts(Scene.active.getChild(selectedBuilding.name).getTrait(RigidBody));
		if (contact != null){
			buildingInContact = true;
		}else{
			buildingInContact = false;
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

	static function removefromArray(name: String, buildings: Array<Building>){
		var building:Building = null;
		for (i in buildings){
			if (i.name == name){
				building = i;
			}
		}
		var index = buildings.indexOf(building);
		if (index > -1){
			buildings.splice(index, 1);
		}
	}
	static function recalculateBuildings(){
		var world = WorldController;
		var buildingList = [0, 0, 0, 0, 0, 0, 0, 0];
		for(building in buildings){
			switch (building.type){
				case 1: buildingList[0] += 1;
				case 2: buildingList[1] += 1;
				case 3: buildingList[2] += 1;
				case 4: buildingList[3] += 1;
				case 5: buildingList[4] += 1;
				case 6: buildingList[5] += 1;
				case 7: buildingList[6] += 1;
				case 8: buildingList[7] += 1;
			}
		}
		world.houseProp.at = buildingList[0];
		world.parkProp.at = buildingList[1];
		world.gardenProp.at = buildingList[2];
		world.sportcourtProp.at = buildingList[3];
		world.sawmillProp.at = buildingList[4];
		world.quarryProp.at = buildingList[5];
		world.steelworksProp.at = buildingList[6];
		world.powerplantProp.at = buildingList[7];
	}
	static function checkResources(type:Int){
		var world = WorldController;
		switch(type){
			case 1: (world.woods[0] < world.houseProp.costW && world.stones[0] < world.houseProp.costSe && world.steels[0] < world.houseProp.costSl) ? enoughResources = false : enoughResources = true;
			case 2: (world.woods[0] < world.parkProp.costW && world.stones[0] < world.parkProp.costSe && world.steels[0] < world.parkProp.costSl) ? enoughResources = false : enoughResources = true;
			case 3: (world.woods[0] < world.gardenProp.costW && world.stones[0] < world.gardenProp.costSe && world.steels[0] < world.gardenProp.costSl) ? enoughResources = false : enoughResources = true;
			case 4: (world.woods[0] < world.sportcourtProp.costW && world.stones[0] < world.sportcourtProp.costSe && world.steels[0] < world.sportcourtProp.costSl) ? enoughResources = false : enoughResources = true;
			case 5: (world.money[0] < world.sawmillProp.costM) ? enoughResources = false : enoughResources = true;
			case 6: (world.money[0] < world.quarryProp.costM) ? enoughResources = false : enoughResources = true;
			case 7: (world.money[0] < world.steelworksProp.costM) ? enoughResources = false : enoughResources = true;
			case 8: (world.money[0] < world.powerplantProp.costM) ? enoughResources = false : enoughResources = true;
		}
	}
	static function recalculateResources(type:Int) {
		var world = WorldController;
		switch(type){
			case 1:
				world.woods[0] -= world.houseProp.costW;
				world.stones[0] -= world.houseProp.costSe;
				world.steels[0] -= world.houseProp.costSl;
			case 2:
				world.woods[0] -= world.parkProp.costW;
				world.stones[0] -= world.parkProp.costSe;
				world.steels[0] -= world.parkProp.costSl;
			case 3:
				world.woods[0] -= world.gardenProp.costW;
				world.stones[0] -= world.gardenProp.costSe;
				world.steels[0] -= world.gardenProp.costSl;
			case 4:
				world.woods[0] -= world.sportcourtProp.costW;
				world.stones[0] -= world.sportcourtProp.costSe;
				world.steels[0] -= world.sportcourtProp.costSl;
			case 5:
				world.money[0] -= world.sawmillProp.costM;
			case 6:
				world.money[0] -= world.quarryProp.costM;
			case 7:
				world.money[0] -= world.steelworksProp.costM;
			case 8:
				world.money[0] -= world.powerplantProp.costM;
		}
	}
	static function checkMaxBuilding(type:Int) {
		var world = WorldController;
		switch(type){
			case 1: world.houseProp.at == world.houseProp.max ? enoughBuildings = true : enoughBuildings = false;
			case 2: world.parkProp.at == world.parkProp.max ? enoughBuildings = true : enoughBuildings = false;
			case 3: world.gardenProp.at == world.gardenProp.max ? enoughBuildings = true : enoughBuildings = false;
			case 4: world.sportcourtProp.at == world.sportcourtProp.max ? enoughBuildings = true : enoughBuildings = false;
			case 5: world.sawmillProp.at == world.sawmillProp.max ? enoughBuildings = true : enoughBuildings = false;
			case 6: world.quarryProp.at == world.quarryProp.max ? enoughBuildings = true : enoughBuildings = false;
			case 7: world.steelworksProp.at == world.steelworksProp.max ? enoughBuildings = true : enoughBuildings = false;
			case 8: world.powerplantProp.at == world.powerplantProp.max ? enoughBuildings = true : enoughBuildings = false;
		}
	}
	//Mark: change selectedBuilding Type
	static function getBuildingFromString(name: String):Building {
		var building:Building = null;
		for(i in buildings){
			if (i.name == name) building = i;
		}
		return building;
	}
	//Mark: New
	public static function getStringBldType(type:Int):String {
		var stringType = "";
		switch(type){
			case 1: stringType = "House";
			case 2: stringType = "Amusement Park";
			case 3: stringType = "Garden";
			case 4: stringType = "Sport Court";
			case 5: stringType = "Sawmill";
			case 6: stringType = "Quarry";
			case 7: stringType = "Steelworks";
			case 8: stringType = "Powerplant";
		}
		return stringType;
	}
}
