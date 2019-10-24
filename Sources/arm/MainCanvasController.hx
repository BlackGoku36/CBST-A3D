package arm;

import armory.trait.internal.CanvasScript;
import armory.system.Event;

import iron.Scene;

import zui.Canvas.TElement;

import kha.Scheduler;

import arm.WorldController;

class MainCanvasController extends iron.Trait {

	static var canvas:CanvasScript;
	static var menuCanvas: CanvasScript;

	var world = WorldController;
	var bld = BuildingController;
	var selectedBtn = 0;

	var menuState = 0;
	var selectBldState = 0;

	// var startx = 1120.0;
	// var starty = 580.0;
	// var endx = 1120.0;
	// var endy = 280.0;
	// var x = 0.0;
	// var y = 0.0;
	// var c = [];
	// var cid = [];
	// var h = [];
	// var w = [];

	public function new() {
		super();

		notifyOnInit(init);
		notifyOnUpdate(updateCanvas);
	}

	function init() {
		canvas = Scene.active.getTrait(CanvasScript);
		menuCanvas = new CanvasScript("SettingCanvas");
		for (elem in menuCanvas.getElements()){
			elem.visible = false;
		}
		// x = startx;
		// y = starty;
		// c = canvas.getElement("menu_empty").children;

		// for( i in canvas.getElements()){
		// 	for(a in c){
		// 		if (i.id == a){
		// 			h.push(i.height);
		// 			w.push(i.width);
		// 			cid.push(i.id);
		// 		}
		// 	}
		// }
		Event.add("menu_btn", function(){
			if (menuState == 0){
				menuState = 1;
				//canvas.getElement("menu_empty").visible = true;
			}else if (menuState == 1){
				menuState = 0;
				//canvas.getElement("menu_empty").visible = false;
				selectedBtn = 0;
			}
		});
		Event.add("housebtn", function(){ selectedBtn = 3; selectBldState == 0 ||selectBldState == 4||selectBldState == 5 ? selectBldState = 3 : selectBldState = 0;});
		Event.add("factorybtn", function(){ selectedBtn = 4; selectBldState == 0 ||selectBldState == 3||selectBldState == 5 ? selectBldState = 4 : selectBldState = 0;});
		Event.add("communitybtn", function(){ selectedBtn = 5; selectBldState == 0 ||selectBldState == 3||selectBldState == 4 ? selectBldState = 5 : selectBldState = 0;});
		Event.add("setting_btn", function(){ 
			selectedBtn = 1;
			for (elem in menuCanvas.getElements()){
				elem.visible = true;
			}
			for (elem in canvas.getElements()){
				elem.visible = false;
			}
		});
		Event.add("cancelbtn", function(){ 
			selectedBtn = 1;
			for (elem in menuCanvas.getElements()){
				elem.visible = false;
			}
			for (elem in canvas.getElements()){
				elem.visible = true;
			}
		});

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
			selectBldState = 0;
		}
		else if (menuState == 1){
			canvas.getElement("menu_empty").visible = true;
		}
		if(selectedBtn == 3 || selectedBtn == 4 || selectedBtn == 5){
			canvas.getElement("select_bld_text").text = getTypeFromInt(selectedBtn);
			canvas.getElement("select_bld").visible = true;
		}
		if (selectBldState == 0){
			canvas.getElement("select_bld").visible = false;
		}else if (selectBldState == 3 || selectBldState == 4 || selectBldState == 5){
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

	// function resetAnim(element: TElement, sx:Float, sy:Float) {
	// 	startx = sx;
	// 	starty = sy;
	// 	x = 0.0;
	// 	y = 0.0;
	// 	c = [];
	// 	cid = [];
	// 	h = [];
	// 	w = [];

	// 	x = startx;
	// 	y = starty;
	// 	c = element.children;

	// 	for( i in canvas.getElements()){
	// 		for(a in c){
	// 			if (i.id == a){
	// 				h.push(i.height);
	// 				w.push(i.width);
	// 				cid.push(i.id);
	// 			}
	// 		}
	// 	}
		
	// }

	// function lerpelem(element: TElement, sx:Float, sy:Float, ex: Float, ey:Float, eh:Float, ew:Float):Bool {
	// 	var done = false;
	// 	element.x = x;
	// 	element.y = y;
	// 	for(c in cid){
	// 		for (elem in canvas.getElements()){
	// 			if (elem.id == c){
	// 				elem.height = h[c];
	// 				elem.width = w[c];
	// 				h[c] = Std.int(lerp(h[c], eh, 0.1));
	// 				w[c] = Std.int(lerp(w[c], ew, 0.1));
	// 			}
	// 		}
	// 	}
	// 	x = lerp(x, ex, 0.1);
	// 	y = lerp(y, ey, 0.1);
	// 	if (Math.round(element.x)-3 == Math.round(ex)-3 && Math.round(element.y)-3 == Math.round(ey)-3){
	// 		done = true;
	// 	}
	// 	return done;
	// }

	// function lerp(min: Float, max: Float, fraction: Float):Float{
    //    return (max-min)*fraction+min; 
    // }

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
