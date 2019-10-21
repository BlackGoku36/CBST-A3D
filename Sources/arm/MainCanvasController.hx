package arm;

import armory.trait.internal.CanvasScript;

import iron.Scene;

import kha.Scheduler;

import arm.WorldController;

class MainCanvasController extends iron.Trait {

	static var canvas:CanvasScript;

	var world = WorldController;

	public function new() {
		super();

		notifyOnInit(function() {
			canvas = Scene.active.getTrait(CanvasScript);
		});

		notifyOnUpdate(updateCanvas);
	}

	function updateCanvas() {
		updatePB();
		updateAmount();
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
		canvas.getElement("electricitypb").progress_total = world.electricity[1];
		canvas.getElement("electricitypb").progress_at = world.electricity[0];
	}

	function updateAmount() {
		canvas.getElement("money-amt").text = world.money[0] + "/" + world.money[1];
		canvas.getElement("wood-amt").text = world.woods[0] + "/" + world.woods[1];
		canvas.getElement("stone-amt").text = world.stones[0] + "/" + world.stones[1];
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
}
