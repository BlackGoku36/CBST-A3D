package arm;

import kha.Scheduler;

import arm.MainCanvasController;

class WorldController extends iron.Trait {

	static var paused:Bool = false;

	public function new() {
		super();
		notifyOnInit(init);
	}

	function init() {
		var world = WorldController;
		var canvas = MainCanvasController;
		// houseProp.tt = Scheduler.addTimeTask(function(){
		// 	if (electricity[0] >= world.houseProp.costE && money[0] < money[1]){
		// 		money[0] += houseProp.at * houseProp.prodM;
		// 		if (money[0] > money[1]) money[0] = money[1];
		// 		electricity[0] -= houseProp.at * houseProp.costE;
		// 	}else{
		// 		//canvas.setWarning("Out of Electricity!");
		// 	}
		// }, 5, 5);
		// parkProp.tt = Scheduler.addTimeTask(function(){
		// 	if (electricity[0] >= world.parkProp.costE && money[0] < money[1]){
		// 		money[0] += parkProp.at * parkProp.prodM;
		// 		if (money[0] > money[1]) money[0] = money[1];
		// 		electricity[0] -= parkProp.at * houseProp.costE;
		// 	}else{
		// 		//canvas.setWarning("Out of Electricity!");
		// 	}
		// }, 5, 5);
		// gardenProp.tt = Scheduler.addTimeTask(function(){
		// 	// if (electricity[0] >= world.houseProp.costE){
		// 	// 	if (money[0] <= money[1]) money[0] += houseProp.at * houseProp.prodM;
		// 	// 	electricity[0] -= houseProp.at * houseProp.costE;
		// 	// }else{
		// 	// 	//canvas.setWarning("Out of Electricity!");
		// 	// }
		// }, 5, 5);
		// sportcourtProp.tt = Scheduler.addTimeTask(function(){
		// 	// if (electricity[0] >= world.houseProp.costE){
		// 	// 	if (money[0] <= money[1]) money[0] += houseProp.at * houseProp.prodM;
		// 	// 	electricity[0] -= houseProp.at * houseProp.costE;
		// 	// }else{
		// 	// 	//canvas.setWarning("Out of Electricity!");
		// 	// }
		// }, 5, 5);
		// sawmillProp.tt = Scheduler.addTimeTask(function(){
		// 	if (electricity[0] >= world.sawmillProp.costE && woods[0] < woods[1]){
		// 		woods[0] += sawmillProp.at * sawmillProp.prodW;
		// 		if (woods[0] > woods[1]) woods[0] = woods[1];
		// 		electricity[0] -= sawmillProp.at * sawmillProp.costE;
		// 	}else{
		// 		//canvas.setWarning("Out of Electricity!");
		// 	}
		// }, 5, 5);
		// quarryProp.tt = Scheduler.addTimeTask(function(){
		// 	if (electricity[0] >= world.quarryProp.costE && stones[0] < stones[1]){
		// 		stones[0] += quarryProp.at * quarryProp.prodSe;
		// 		if (stones[0] > stones[1]) stones[0] = stones[1];
		// 		electricity[0] -= quarryProp.at * quarryProp.costE;
		// 	}else{
		// 		//canvas.setWarning("Out of Electricity!");
		// 	}
		// }, 5, 5);
		// steelworksProp.tt = Scheduler.addTimeTask(function(){
		// 	if (electricity[0] >= world.steelworksProp.costE && steels[0] < steels[1]){
		// 		steels[0] += steelworksProp.at * steelworksProp.prodSl;
		// 		if (steels[0] > steels[1]) steels[0] = steels[1];
		// 		electricity[0] -= steelworksProp.at * steelworksProp.costE;
		// 	}else{
		// 		//canvas.setWarning("Out of Electricity!");
		// 	}
		// }, 5, 5);
		// powerplantProp.tt = Scheduler.addTimeTask(function(){
		// 	if(electricity[0] <= electricity[1]) electricity[0] += powerplantProp.at * powerplantProp.prodE;
		// }, 5, 5);
	}
}
