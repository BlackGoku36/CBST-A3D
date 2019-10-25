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
			building.buildingContact();
		}

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
