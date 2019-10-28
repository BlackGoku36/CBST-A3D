package arm;

import armory.trait.internal.CanvasScript;
import armory.system.Event;

import arm.WorldController;

class MainCanvasController extends iron.Trait {

	static var maincanvas:CanvasScript;
	static var settingCanvas: CanvasScript;

	var world = WorldController;
	var bld = BuildingController;

	var menuState = 0;

	var bldMenuBtn = 0;
	var bldMenuState = 0;

	public function new() {
		super();

		notifyOnInit(init);
		notifyOnUpdate(updateCanvas);
	}

	function init() {
		maincanvas = new CanvasScript("MainCanvas", "Big_shoulders_text.ttf");
		settingCanvas = new CanvasScript("SettingCanvas", "Big_shoulders_text.ttf");

		settingCanvas.setCanvasVisibility(false);
		maincanvas.setCanvasVisibility(true);
		maincanvas.getElement("menu_empty").visible = false;

		Event.add("menu_btn", function(){
			if (menuState == 0){
				maincanvas.getElement("menu_empty").visible = true;
				menuState = 1;
				bldMenuState = 0;
			}else if (menuState == 1){
				maincanvas.getElement("menu_empty").visible = false;
				menuState = 0;
			}
		});

		Event.add("house_btn", function(){ bldMenuBtn = 3; bldMenuState == 0 ||bldMenuState == 4||bldMenuState == 5 ? bldMenuState = 3 : bldMenuState = 0;});
		Event.add("factory_btn", function(){ bldMenuBtn = 4; bldMenuState == 0 ||bldMenuState == 3||bldMenuState == 5 ? bldMenuState = 4 : bldMenuState = 0;});
		Event.add("community_btn", function(){ bldMenuBtn = 5; bldMenuState == 0 ||bldMenuState == 3||bldMenuState == 4 ? bldMenuState = 5 : bldMenuState = 0;});
		Event.add("setting_btn", function(){
			bldMenuBtn = 1;
			settingCanvas.setCanvasVisibility(true);
			maincanvas.setCanvasVisibility(false);
		});
		Event.add("cancel_btn", function(){
			bldMenuBtn = 1;
			settingCanvas.setCanvasVisibility(false);
			maincanvas.setCanvasVisibility(true);
		});

		Event.add("bld_menu_btn_1", function(){
			switch (bldMenuBtn){
				case 3: bld.spawnBuilding(1);
				case 4: bld.spawnBuilding(5);
				case 5: bld.spawnBuilding(2);
			}
		});
		Event.add("bld_menu_btn_2", function(){
			switch (bldMenuBtn){
				case 4: bld.spawnBuilding(6);
				case 5: bld.spawnBuilding(3);
			}
		});
		Event.add("bld_menu_btn_3", function(){
			switch (bldMenuBtn){
				case 4: bld.spawnBuilding(7);
				case 5: bld.spawnBuilding(4);
			}
		});
		Event.add("bld_menu_btn_4", function(){
			switch (bldMenuBtn){
				case 4: bld.spawnBuilding(8);
			}
		});
	}

	function updateCanvas() {
		updatePB();
		updateAmount();

		if(bldMenuBtn == 3 || bldMenuBtn == 4 || bldMenuBtn == 5){
			maincanvas.getElement("bld_menu_text").text = getCategoryFromInt(bldMenuBtn);
			maincanvas.getElement("bld_menu").visible = true;
		}
		if (bldMenuState == 0 || menuState == 0){
			maincanvas.getElement("bld_menu").visible = false;
		}
		switch (bldMenuBtn){
			case 3:
				maincanvas.getElement("bld_menu_btn_1").text =  "House";
				maincanvas.getElement("bld_menu_btn_1").visible = true;
				maincanvas.getElement("bld_menu_btn_2").visible = false;
				maincanvas.getElement("bld_menu_btn_3").visible = false;
				maincanvas.getElement("bld_menu_btn_4").visible = false;
			case 4:
				maincanvas.getElement("bld_menu_btn_1").text =  "Sawmill";
				maincanvas.getElement("bld_menu_btn_1").visible = true;
				maincanvas.getElement("bld_menu_btn_2").text =  "Quarry";
				maincanvas.getElement("bld_menu_btn_2").visible = true;
				maincanvas.getElement("bld_menu_btn_3").text =  "Steelworks";
				maincanvas.getElement("bld_menu_btn_3").visible = true;
				maincanvas.getElement("bld_menu_btn_4").text =  "Powerplant";
				maincanvas.getElement("bld_menu_btn_4").visible = true;
			case 5:
				maincanvas.getElement("bld_menu_btn_1").text =  "Park";
				maincanvas.getElement("bld_menu_btn_1").visible = true;
				maincanvas.getElement("bld_menu_btn_2").text =  "Garden";
				maincanvas.getElement("bld_menu_btn_2").visible = true;
				maincanvas.getElement("bld_menu_btn_3").text =  "Sport.C.";
				maincanvas.getElement("bld_menu_btn_3").visible = true;
				maincanvas.getElement("bld_menu_btn_4").visible = false;
		}
	}

	function updatePB() {
		// maincanvas.getElement("happinesspb").progress_total = world.happiness[1];
		// maincanvas.getElement("happinesspb").progress_at = world.happiness[0];
		maincanvas.getElement("moneypb").progress_total = world.money[1];
		maincanvas.getElement("moneypb").progress_at = world.money[0];
		maincanvas.getElement("woodpb").progress_total = world.woods[1];
		maincanvas.getElement("woodpb").progress_at = world.woods[0];
		maincanvas.getElement("stonepb").progress_total = world.stones[1];
		maincanvas.getElement("stonepb").progress_at = world.stones[0];
		maincanvas.getElement("steelpb").progress_total = world.steels[1];
		maincanvas.getElement("steelpb").progress_at = world.steels[0];
		maincanvas.getElement("electricitypb").progress_total = world.electricity[1];
		maincanvas.getElement("electricitypb").progress_at = world.electricity[0];
	}

	function updateAmount() {
		maincanvas.getElement("money-amt").text = world.money[0] + "/" + world.money[1];
		maincanvas.getElement("wood-amt").text = world.woods[0] + "/" + world.woods[1];
		maincanvas.getElement("stone-amt").text = world.stones[0] + "/" + world.stones[1];
		maincanvas.getElement("steel-amt").text = world.steels[0] + "/" + world.steels[1];
		maincanvas.getElement("electricity-amt").text = world.electricity[0] + "/" + world.electricity[1];
		// maincanvas.getElement("happiness-amt").text = world.happiness[0] + "/" + world.happiness[1];
	}

	static function getCategoryFromInt(int: Int):String {
		var type = "";
		switch (int){
			case 3: type = "House";
			case 4: type = "Factory";
			case 5: type = "Community";
		}
		return type;
	}
}
