package arm;

import arm.data.Buildings;
import iron.object.Object;
import iron.Scene;
import iron.system.Input;

class PlayerController extends iron.Trait {

	var mouse = Input.getMouse();
	var kb = Input.getKeyboard();

	var building = BuildingController;

	public function new() {
		super();
		notifyOnUpdate(update);
	}

	function update() {

		if(building.selectedBuilding == null){
			if (mouse.started()){
				building.raySelectBuilding();
			}
		}else{
			if (mouse.started("right")) {
				//TODO: Fix building contact
				if (!building.buildingInContact){
					building.unselectBuilding();
				}
			}
			if (kb.started("m")){
				building.buildingMove = true;
			}else if (kb.started("f")){
				Buildings.removeBuilding(building.selectedBuilding, building.unselectBuilding);
			}else if (kb.started("r")){
				building.rotateBuilding();
			}
		}

		if (building.buildingMove){
			building.moveBuilding();
			building.buildingContact();
		}

	}

}
