package arm;

import haxe.EnumTools.EnumValueTools;
import iron.object.Object;
import arm.data.Buildings;
import arm.data.Buildings.Building;
import arm.data.BuildingList;
import armory.trait.internal.CanvasScript;
import armory.system.Event;

import arm.WorldController;

enum MenuState {
	Opened;
	Closed;
}

enum SubMenuState {
	Settings;
	Layout;
	Community;
	Factory;
	None;
}

class MainCanvasController extends iron.Trait {

	static var maincanvas:CanvasScript;
	static var settingCanvas: CanvasScript;

	var world = WorldController;
	var bld = Buildings;

	var menuState: MenuState = Closed;

	var bldMenuState: SubMenuState = None;

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
			if (menuState == Closed){
				maincanvas.getElement("menu_empty").visible = true;
				menuState = Opened;
				bldMenuState = None;
			}else if (menuState == Opened){
				maincanvas.getElement("menu_empty").visible = false;
				menuState = Closed;
			}
		});

		Event.add("factory_btn", function(){
			bldMenuState == Factory ? bldMenuState = None : bldMenuState = Factory;
		});

		Event.add("community_btn", function(){
			bldMenuState == Community ? bldMenuState = None : bldMenuState = Community;
		});

		Event.add("setting_btn", function(){
			bldMenuState == Settings;
			settingCanvas.setCanvasVisibility(true);
			maincanvas.setCanvasVisibility(false);
		});

		Event.add("cancel_btn", function(){
			settingCanvas.setCanvasVisibility(false);
			maincanvas.setCanvasVisibility(true);
		});

		Event.add("bld_menu_btn_1", function(){
			switch (bldMenuState){
				case Community: bld.createBuilding(BuildingList.House, done);
				case Factory: bld.createBuilding(BuildingList.Sawmill, done);
				case _:
			}
		});

		Event.add("bld_menu_btn_2", function(){
			switch (bldMenuState){
				case Community: bld.createBuilding(BuildingList.Park, done);
				case Factory: bld.createBuilding(BuildingList.Quarry, done);
				case _:
			}
		});

		Event.add("bld_menu_btn_3", function(){
			switch (bldMenuState){
				case Factory: bld.createBuilding(BuildingList.Powerplant, done);
				case _:
			}
		});
		// Event.add("bld_menu_btn_4", function(){
		// });
	}

	function done(bld:Building) {
		BuildingController.selectBuilding(bld);
	}

	function updateCanvas() {
		updatePB();
		updateAmount();

		if(bldMenuState == Community || bldMenuState == Factory){
			maincanvas.getElement("bld_menu_text").text = bldMenuState.getName();
			maincanvas.getElement("bld_menu").visible = true;
		}
		if (bldMenuState == None || menuState == Closed){
			maincanvas.getElement("bld_menu").visible = false;
		}

		switch (bldMenuState){
			case Community:
				maincanvas.getElement("bld_menu_btn_1").text =  "House";
				maincanvas.getElement("bld_menu_btn_1").visible = true;
				maincanvas.getElement("bld_menu_btn_2").text =  "Park";
				maincanvas.getElement("bld_menu_btn_2").visible = true;
				maincanvas.getElement("bld_menu_btn_3").visible = false;
				maincanvas.getElement("bld_menu_btn_4").visible = false;
			case Factory:
				maincanvas.getElement("bld_menu_btn_1").text =  "Sawmill";
				maincanvas.getElement("bld_menu_btn_1").visible = true;
				maincanvas.getElement("bld_menu_btn_2").text =  "Quarry";
				maincanvas.getElement("bld_menu_btn_2").visible = true;
				maincanvas.getElement("bld_menu_btn_3").text =  "Powerplant";
				maincanvas.getElement("bld_menu_btn_3").visible = true;
				maincanvas.getElement("bld_menu_btn_4").visible = false;
			case _:
		}
	}

	function updatePB() {
		maincanvas.getElement("moneypb").progress_total = Bank.moneyCapacity;
		maincanvas.getElement("moneypb").progress_at = Bank.money;
		maincanvas.getElement("woodpb").progress_total = Bank.woodsCapacity;
		maincanvas.getElement("woodpb").progress_at = Bank.woods;
		maincanvas.getElement("stonepb").progress_total = Bank.stonesCapacity;
		maincanvas.getElement("stonepb").progress_at = Bank.stones;
		maincanvas.getElement("electricitypb").progress_total = Bank.electricityCapacity;
		maincanvas.getElement("electricitypb").progress_at = Bank.electricity;
	}

	function updateAmount() {
		maincanvas.getElement("money-amt").text = Bank.money + "/" + Bank.moneyCapacity;
		maincanvas.getElement("wood-amt").text = Bank.woods + "/" + Bank.woodsCapacity;
		maincanvas.getElement("stone-amt").text = Bank.stones + "/" + Bank.stonesCapacity;
		maincanvas.getElement("electricity-amt").text = Bank.electricity + "/" + Bank.electricityCapacity;
	}
}
