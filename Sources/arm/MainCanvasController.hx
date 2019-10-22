package arm;

import armory.trait.internal.CanvasScript;
import armory.system.Event;

import iron.Scene;

import kha.Scheduler;

import arm.WorldController;

class MainCanvasController extends iron.Trait {

	static var canvas:CanvasScript;

	var world = WorldController;
	var bld = BuildingController;
	var selectedBtn = 0;

	var menuState = 0;

	public function new() {
		super();

		notifyOnInit(init);
		notifyOnUpdate(updateCanvas);
	}

	function init() {
		canvas = Scene.active.getTrait(CanvasScript);
		Event.add("menu_btn", function(){
			if (menuState == 0){
				menuState = 1;
				canvas.getElement("menu_empty").visible = true;
			}else if (menuState == 1){
				menuState = 0;
				canvas.getElement("menu_empty").visible = false;
				selectedBtn = 0;
			}
		});
		Event.add("housebtn", function(){ selectedBtn = 3; });
		Event.add("factorybtn", function(){ selectedBtn = 4; });
		Event.add("communitybtn", function(){ selectedBtn = 5; });

		Event.add("selectbldbtn1", function(){
			switch (selectedBtn){
				case 3: bld.spawnBuilding(1);
				case 4: bld.spawnBuilding(5);
				case 5: bld.spawnBuilding(2);
			}
		});
		Event.add("selectbldbtn2", function(){
			switch (selectedBtn){
				case 4: bld.spawnBuilding(6);
				case 5: bld.spawnBuilding(3);
			}
		});
		Event.add("selectbldbtn3", function(){
			switch (selectedBtn){
				case 4: bld.spawnBuilding(7);
				case 5: bld.spawnBuilding(4);
			}
		});
		Event.add("selectbldbtn4", function(){
			switch (selectedBtn){
				case 4: bld.spawnBuilding(8);
			}
		});
	}

	function updateCanvas() {
		updatePB();
		updateAmount();
		if (menuState == 0){
			canvas.getElement("menu_empty").visible = false;
			canvas.getElement("select_bld").visible = false;
		}
		if(selectedBtn == 3 || selectedBtn == 4 || selectedBtn == 5){
			canvas.getElement("select_bld_text").text = getTypeFromInt(selectedBtn);
			canvas.getElement("select_bld").visible = true;
		}
		switch (selectedBtn){
			case 3:
				canvas.getElement("select_bld_btn_1").text =  "House";
				canvas.getElement("select_bld_btn_1").visible = true;
				canvas.getElement("select_bld_btn_2").visible = false;
				canvas.getElement("select_bld_btn_3").visible = false;
				canvas.getElement("select_bld_btn_4").visible = false;
			case 4:
				canvas.getElement("select_bld_btn_1").text =  "Sawmill";
				canvas.getElement("select_bld_btn_1").visible = true;
				canvas.getElement("select_bld_btn_2").text =  "Quarry";
				canvas.getElement("select_bld_btn_2").visible = true;
				canvas.getElement("select_bld_btn_3").text =  "Steelworks";
				canvas.getElement("select_bld_btn_3").visible = true;
				canvas.getElement("select_bld_btn_4").text =  "Powerplant";
				canvas.getElement("select_bld_btn_4").visible = true;
			case 5:
				canvas.getElement("select_bld_btn_1").text =  "Park";
				canvas.getElement("select_bld_btn_1").visible = true;
				canvas.getElement("select_bld_btn_2").text =  "Garden";
				canvas.getElement("select_bld_btn_2").visible = true;
				canvas.getElement("select_bld_btn_3").text =  "Sport Court";
				canvas.getElement("select_bld_btn_3").visible = true;
				canvas.getElement("select_bld_btn_4").visible = false;
		}
	}

	function updatePB() {
		// canvas.getElement("happinesspb").progress_total = world.happiness[1];
		// canvas.getElement("happinesspb").progress_at = world.happiness[0];
		canvas.getElement("moneypb").progress_total = world.money[1];
		canvas.getElement("moneypb").progress_at = world.money[0];
		canvas.getElement("woodpb").progress_total = world.woods[1];
		canvas.getElement("woodpb").progress_at = world.woods[0];
		canvas.getElement("stonepb").progress_total = world.stones[1];
		canvas.getElement("stonepb").progress_at = world.stones[0];
		canvas.getElement("steelpb").progress_total = world.steels[1];
		canvas.getElement("steelpb").progress_at = world.steels[0];
		canvas.getElement("electricitypb").progress_total = world.electricity[1];
		canvas.getElement("electricitypb").progress_at = world.electricity[0];
	}

	function updateAmount() {
		canvas.getElement("money-amt").text = world.money[0] + "/" + world.money[1];
		canvas.getElement("wood-amt").text = world.woods[0] + "/" + world.woods[1];
		canvas.getElement("stone-amt").text = world.stones[0] + "/" + world.stones[1];
		canvas.getElement("steel-amt").text = world.steels[0] + "/" + world.steels[1];
		canvas.getElement("electricity-amt").text = world.electricity[0] + "/" + world.electricity[1];
		// canvas.getElement("happiness-amt").text = world.happiness[0] + "/" + world.happiness[1];
	}

	// public static function setWarning(text: String) {
	// 	canvas.getElement("warning").visible = true;
	// 	canvas.getElement("warning").text = text;
	// 	var warningtt = Scheduler.addTimeTask(function(){
	// 		canvas.getElement("warning").visible = false;
	// 	}, 5, 5, 1);
	// }

	static function getTypeFromInt(int: Int):String {
		var type = "";
		switch (int){
			case 3: type = "House";
			case 4: type = "Factory";
			case 5: type = "Community";
		}
		return type;
	}
}
