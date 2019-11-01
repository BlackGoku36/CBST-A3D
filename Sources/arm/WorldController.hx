package arm;

import kha.Scheduler;

import arm.MainCanvasController;

typedef BuildingProp = {
	at:Int, max:Int,
	costM:Int, costW:Int, costSe:Int, costSl:Int, costE:Int,
	prodM: Int, prodW:Int, prodSe:Int, prodSl:Int, prodE:Int,
	prodH:Int, prodP:Int, tt:Int
}

class WorldController extends iron.Trait {

	// public static var happiness:Array<Int> = [50, 100];

	public static var money:Array<Int> = [50, 100];
	public static var woods:Array<Int> = [50, 100];
	public static var stones:Array<Int> = [50, 100];
	public static var steels:Array<Int> = [50, 100];
	public static var electricity:Array<Int> = [0, 100];

	static var paused:Bool = false;

	public static var houseProp: BuildingProp = {
		at:0, max:2, costM:0, costW:10, costSe:10, costSl:10, costE:5, prodM: 5, prodW:0, prodSe:0, prodSl:0, prodE: 0, prodH:3, prodP:0,
		tt: 0
	};
	public static var parkProp: BuildingProp = {
		at:0, max:2, costM: 0, costW:20, costSe:20, costSl:20, costE:5, prodM: 5, prodW:0, prodSe:0, prodSl: 0, prodE: 0, prodH:5, prodP:0,
		tt: 0
	};
	public static var gardenProp: BuildingProp = {
		at:0, max:2, costM: 0, costW:20, costSe:20, costSl:20, costE:5, prodM: 5, prodW:0, prodSe:0, prodSl: 0, prodE: 0, prodH:5, prodP:0,
		tt: 0
	};
	public static var sportcourtProp: BuildingProp = {
		at:0, max:2, costM: 0, costW:20, costSe:20, costSl:20, costE:5, prodM: 5, prodW:0, prodSe:0, prodSl: 0, prodE: 0, prodH:5, prodP:0,
		tt: 0
	};
	public static var sawmillProp: BuildingProp = {
		at:0, max:2, costM: 10, costW:0, costSe:0, costSl:0, costE:5, prodM: 0, prodW:5, prodSe:0, prodSl: 0, prodE: 0, prodH:0, prodP:3,
		tt: 0
	};
	public static var quarryProp: BuildingProp = {
		at:0, max:2, costM: 10, costW:0, costSe:0, costSl:0, costE:5, prodM: 0, prodW:0, prodSe:5, prodSl: 0, prodE: 0, prodH:0, prodP:3,
		tt: 0
	};
	public static var steelworksProp: BuildingProp = {
		at:0, max:2, costM: 10, costW:0, costSe:0, costSl:0, costE:5, prodM: 0, prodW:0, prodSe:0, prodSl: 5, prodE: 0, prodH:0, prodP:3,
		tt: 0
	};
	public static var powerplantProp: BuildingProp = {
		at:0, max:2, costM: 20, costW:0, costSe:0, costSl:0, costE:0, prodM: 0, prodW:0, prodSe:0, prodSl: 0, prodE: 10, prodH:0, prodP:5,
		tt: 0
	};

	// public static var happinesstt = 0;

	public function new() {
		super();
		notifyOnInit(init);
	}

	function init() {
		var world = WorldController;
		var canvas = MainCanvasController;
		houseProp.tt = Scheduler.addTimeTask(function(){
			if (electricity[0] >= world.houseProp.costE && money[0] < money[1]){
				money[0] += houseProp.at * houseProp.prodM;
				if (money[0] > money[1]) money[0] = money[1];
				electricity[0] -= houseProp.at * houseProp.costE;
			}else{
				//canvas.setWarning("Out of Electricity!");
			}
		}, 5, 5);
		parkProp.tt = Scheduler.addTimeTask(function(){
			if (electricity[0] >= world.parkProp.costE && money[0] < money[1]){
				money[0] += parkProp.at * parkProp.prodM;
				if (money[0] > money[1]) money[0] = money[1];
				electricity[0] -= parkProp.at * houseProp.costE;
			}else{
				//canvas.setWarning("Out of Electricity!");
			}
		}, 5, 5);
		gardenProp.tt = Scheduler.addTimeTask(function(){
			// if (electricity[0] >= world.houseProp.costE){
			// 	if (money[0] <= money[1]) money[0] += houseProp.at * houseProp.prodM;
			// 	electricity[0] -= houseProp.at * houseProp.costE;
			// }else{
			// 	//canvas.setWarning("Out of Electricity!");
			// }
		}, 5, 5);
		sportcourtProp.tt = Scheduler.addTimeTask(function(){
			// if (electricity[0] >= world.houseProp.costE){
			// 	if (money[0] <= money[1]) money[0] += houseProp.at * houseProp.prodM;
			// 	electricity[0] -= houseProp.at * houseProp.costE;
			// }else{
			// 	//canvas.setWarning("Out of Electricity!");
			// }
		}, 5, 5);
		sawmillProp.tt = Scheduler.addTimeTask(function(){
			if (electricity[0] >= world.sawmillProp.costE && woods[0] < woods[1]){
				woods[0] += sawmillProp.at * sawmillProp.prodW;
				if (woods[0] > woods[1]) woods[0] = woods[1];
				electricity[0] -= sawmillProp.at * sawmillProp.costE;
			}else{
				//canvas.setWarning("Out of Electricity!");
			}
		}, 5, 5);
		quarryProp.tt = Scheduler.addTimeTask(function(){
			if (electricity[0] >= world.quarryProp.costE && stones[0] < stones[1]){
				stones[0] += quarryProp.at * quarryProp.prodSe;
				if (stones[0] > stones[1]) stones[0] = stones[1];
				electricity[0] -= quarryProp.at * quarryProp.costE;
			}else{
				//canvas.setWarning("Out of Electricity!");
			}
		}, 5, 5);
		steelworksProp.tt = Scheduler.addTimeTask(function(){
			if (electricity[0] >= world.steelworksProp.costE && steels[0] < steels[1]){
				steels[0] += steelworksProp.at * steelworksProp.prodSl;
				if (steels[0] > steels[1]) steels[0] = steels[1];
				electricity[0] -= steelworksProp.at * steelworksProp.costE;
			}else{
				//canvas.setWarning("Out of Electricity!");
			}
		}, 5, 5);
		powerplantProp.tt = Scheduler.addTimeTask(function(){
			if(electricity[0] <= electricity[1]) electricity[0] += powerplantProp.at * powerplantProp.prodE;
		}, 5, 5);
	}
	//Mark: New
	public static function getPropByType(type:Int):BuildingProp{
		var prop = null;
		switch(type){
			case 1: prop = houseProp;
			case 2: prop = parkProp;
			case 3: prop = gardenProp;
			case 4: prop = sportcourtProp;
			case 5: prop = sawmillProp;
			case 6: prop = quarryProp;
			case 7: prop = steelworksProp;
			case 8: prop = powerplantProp;
		}
		return prop;
	}
}
