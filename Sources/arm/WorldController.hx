package arm;

import kha.Scheduler;

import arm.BuildingController;
import arm.MainCanvasController;

typedef BuildingProp = {
	at:Int, max:Int,
	costM:Int, costW:Int, costS:Int, costE:Int,
	prodM: Int, prodW:Int, prodS:Int, prodE:Int,
	prodH:Int, prodP:Int
}

class WorldController extends iron.Trait {

	public static var happiness:Array<Int> = [50, 100];

	public static var money:Array<Int> = [50, 100];
	public static var woods:Array<Int> = [50, 100];
	public static var stones:Array<Int> = [50, 100];
	public static var electricity:Array<Int> = [0, 100];

	static var paused:Bool = false;

	public static var houseProp: BuildingProp = { 
		at:0, max:2, costM: 0,costW:10, costS:10, costE:5, prodM: 5, prodW:0, prodS:0, prodE: 0, prodH:3, prodP:0
	};
	public static var parkProp: BuildingProp = {
		at:0, max:2, costM: 0,costW:10, costS:10, costE:5, prodM: 5, prodW:0, prodS:0, prodE: 0, prodH:5, prodP:0
	};
	public static var sawmillProp: BuildingProp = {
		at:0, max:2, costM: 10,costW:0, costS:0, costE:5, prodM: 0, prodW:5, prodS:0, prodE: 0, prodH:0, prodP:3
	};
	public static var quarryProp: BuildingProp = {
		at:0, max:2, costM: 10, costW:0, costS:0, costE:5, prodM: 0, prodW:0, prodS:5, prodE: 0, prodH:0, prodP:3
	};
	public static var powerplantProp: BuildingProp = {
		at:0, max:2, costM: 20, costW:0, costS:0, costE:0, prodM: 0, prodW:0, prodS:0, prodE: 10, prodH:0, prodP:5
	};

	public static var happinesstt = 0;
	public static var housett = 0;
	public static var parkstt = 0;
	public static var sawmilltt = 0;
	public static var quarrytt = 0;
	public static var powerplanttt = 0;

	public function new() {
		super();
		notifyOnInit(init);
		notifyOnUpdate(update);
	}

	function init() {
		var world = WorldController;
		var canvas = MainCanvasController;
		happinesstt = Scheduler.addTimeTask(function (){
			var houseH = houseProp.at * houseProp.prodH;
			var parkH = parkProp.at * parkProp.prodH;
			var sawmillP = sawmillProp.at * sawmillProp.prodP;
			var quarryP = quarryProp.at * quarryProp.prodP;
			var powerplantP = powerplantProp.at * powerplantProp.prodP;
			if (happiness[0] <= happiness[1]){
				happiness[0] += (houseH + parkH) - (sawmillP + quarryP + powerplantP);
			}
		}, 10, 10);
		housett = Scheduler.addTimeTask(function(){
			if (electricity[0] >= world.houseProp.costE){
				if (money[0] <= money[1]) money[0] += houseProp.at * houseProp.prodM;
				electricity[0] -= houseProp.at * houseProp.costE;
			}else{
				//canvas.setWarning("Out of Electricity!");
			}
		}, 5, 5);
		parkstt = Scheduler.addTimeTask(function(){
			if (electricity[0] >= world.parkProp.costE){
				if(money[0] <= money[1]) money[0] += parkProp.at * parkProp.prodM;
				electricity[0] -= parkProp.at * houseProp.costE;
			}else{
				//canvas.setWarning("Out of Electricity!");
			}
		}, 5, 5);
		sawmilltt = Scheduler.addTimeTask(function(){
			if (electricity[0] >= world.sawmillProp.costE){
				if(woods[0] <= woods[1]) woods[0] += sawmillProp.at * sawmillProp.prodW;
				electricity[0] -= sawmillProp.at * sawmillProp.costE;
			}else{
				//canvas.setWarning("Out of Electricity!");
			}
		}, 5, 5);
		quarrytt = Scheduler.addTimeTask(function(){
			if (electricity[0] >= world.quarryProp.costE){
				if(stones[0] <= stones[1]) stones[0] += quarryProp.at * quarryProp.prodS;
				electricity[0] -= quarryProp.at * quarryProp.costE;
			}else{
				//canvas.setWarning("Out of Electricity!");
			}
		}, 5, 5);
		powerplanttt = Scheduler.addTimeTask(function(){
			if(electricity[0] <= electricity[1]) electricity[0] += powerplantProp.at * powerplantProp.prodE;
		}, 5, 5);
	}

	function update() {
		// trace(money[0] + "" + houseProp.at);
	}

	public static function getTimeTaskbyBld(bld:Building):TimeTask {
		@:privateAccess
        //var tt = Scheduler.getTimeTask(world.)
		var timetask:TimeTask = null;
		switch(bld.type){
			case 1: @:privateAccess timetask = Scheduler.getTimeTask(housett);
			case 2: @:privateAccess timetask = Scheduler.getTimeTask(parkstt);
			case 3: timetask = null;
			case 4: timetask = null;
			case 5: @:privateAccess timetask = Scheduler.getTimeTask(sawmilltt);
			case 6: @:privateAccess timetask = Scheduler.getTimeTask(quarrytt);
			case 7: timetask = null;
			case 8: @:privateAccess timetask = Scheduler.getTimeTask(powerplanttt);
		}
		return timetask;
	}
}