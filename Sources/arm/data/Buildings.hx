package arm.data;

import kha.Scheduler;
import arm.Bank;
import iron.object.Object;
import iron.Scene;

typedef Building = {
	var name:String;
	var object:Object;
	var type:BuildingType;
	var cost:BuildingCost;
	var produce:BuildingProduce;
	var timerID:Int;
}

typedef BuildingCost = {
	var money:Int;
	var wood:Int;
	var stone:Int;
	var electricity:Int;
}

typedef BuildingProduce = {
	var money:Int;
	var wood:Int;
	var stone:Int;
	var electricity:Int;
}

@:enum abstract BuildingType(Int) from Int to Int {
	var Community = 0;
	var Factory = 1;
	var Utility = 2;
	var Decoration = 3;
}

class Buildings{
	public static var communities: Array<Building> = [];
	public static var factories: Array<Building> = [];
	public static var utilities: Array<Building> = [];
	public static var decorations: Array<Building> = [];

	public static var total:Int = communities.length + factories.length + utilities.length + decorations.length;

	public static function createBuilding(building:Building, done:Building->Void) {
		if(costSatisfied(building)){
			depositCost(building);
			spawnBuildingAsset(building, done);
			getBuildingArray(building.type).push(building);
		}
	}

	public static function removeBuilding(building:Building, done:Void->Void){
		Scheduler.removeTimeTask(building.timerID);
		building.object.remove();
		removefromArray(building.name, getBuildingArray(building.type));
		done();
	}

	static function costSatisfied(building:Building):Bool{
		if(building.cost.money <= Bank.money &&
			building.cost.wood <= Bank.woods &&
			building.cost.stone <= Bank.stones &&
			building.cost.electricity <= Bank.electricity
		) return true;
		else return false;
	}

	static function depositCost(building:Building) {
		Bank.money -= building.cost.money;
		Bank.woods -= building.cost.wood;
		Bank.stones -= building.cost.stone;
		Bank.electricity -= building.cost.electricity;
	}

	static function harvestProduce(building:Building) {
		Bank.money += building.produce.money;
		Bank.woods += building.produce.wood;
		Bank.stones += building.produce.stone;
		Bank.electricity += building.produce.electricity;
	}

	static function spawnBuildingAsset(building:Building, done:Building->Void) {
		Scene.active.spawnObject(building.name, null, function(obj: Object){
			obj.name = building.name;
			building.object = obj;
			building.timerID = Scheduler.addTimeTask(function(){
				if(Bank.electricity > building.cost.electricity){
					Bank.electricity -= building.cost.electricity;
					harvestProduce(building);
				}
			}, 5, 5);
			done(building);
		});
	}

	static function getBuildingArray(type:BuildingType):Array<Building> {
		switch(type){
			case Community: return communities;
			case Factory: return factories;
			case Utility: return utilities;
			case Decoration: return decorations;
		}
		return [];
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
}
