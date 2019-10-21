package arm;

import iron.object.Object;
import iron.Scene;
import iron.system.Input;

import arm.BuildingController;

class PlayerController extends iron.Trait {

	var mouse = Input.getMouse();
	var kb = Input.getKeyboard();

	var building = BuildingController;
	var world = WorldController;
	var buildingType: Int = 1;


	public function new() {
		super();

		notifyOnUpdate(update);
	}

	function update() {

		if(!building.isBuildingSelected){
			hideInfoCard();
			if (mouse.started()){
				building.raySelectBuilding();
			}
			if (kb.started("p")){
				building.spawnBuilding(buildingType);
			}
		}else{
			showInfoCard();
			if (mouse.started("right")) {
				if (!building.buildingInContact){
					building.unselectBuilding();
				}
			}
			if (kb.started("m")){
				building.buildingMove = true;
			}else if (kb.started("f")){
				building.removeBuilding();
			}else if (kb.started("r")){
				building.rotateBuilding();
			}
		}

		if (building.buildingMove){
			building.moveBuilding();
			//Mark: fix doc
			building.buildingContact();
		}

		if (kb.started("1")) buildingType = 1;//(House)
		else if (kb.started("2")) buildingType = 2;//(Park)
		else if (kb.started("3")) buildingType = 3;//(Garden)
		else if (kb.started("4")) buildingType = 4;//(Sport court)
		else if (kb.started("5")) buildingType = 5;//(Sawmill)
		else if (kb.started("6")) buildingType = 6;//(Quarry)
		else if (kb.started("7")) buildingType = 7;//(Steelworks)
		else if (kb.started("8")) buildingType = 8;//(Powerplant)

	}

	function showInfoCard(){
		Scene.active.getChild("infocard").transform.loc.setFrom(Scene.active.getChild(building.selectedBuilding.name).transform.loc);
		Scene.active.getChild("infocard").transform.loc.addf(0.0, 0.0, 10.0);
		Scene.active.getChild("infocard").transform.buildMatrix();
	}

	function hideInfoCard() {
		Scene.active.getChild("infocard").transform.loc.set(0.0, 0.0, -10.0);
		Scene.active.getChild("infocard").transform.buildMatrix();
	}

}