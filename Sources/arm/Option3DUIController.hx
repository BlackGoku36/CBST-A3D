package arm;

import iron.Scene;
import iron.system.Input;

import zui.*;
import zui.Canvas;

import kha.Scheduler;

import arm.BuildingController;
import arm.WorldController;

class Option3DUIController extends iron.Trait {

	var ui:Zui;
    var rt:kha.Image; // Render target for UI
    var uiWidth = 240;
    var uiHeight = 55;
    var opened = false;
    var building = BuildingController;
    var world = WorldController;

    var mouse = Input.getMouse();

	var canvas:TCanvas = {"name":"untitled","x":0,"y":0,"width":240,"height":55,"elements":[{"id":0,"type":2,"name":"Button","event":"","x":0,"y":0,"width":60,"height":44,"rotation":0,"text":"Y","asset":"","color":-12105913,"color_text":-1513499,"color_hover":-1,"color_press":-14935012,"color_progress":-1513499,"progress_at":0,"progress_total":100,"strength":1,"anchor":0,"parent":null,"children":[],"visible":true},{"id":1,"type":2,"name":"remove_btn","event":"","x":60,"y":0,"width":60,"height":44,"rotation":0,"text":"R","asset":"","color":-12040120,"color_text":-1513499,"color_hover":-12895429,"color_press":-15000805,"color_progress":-1513499,"progress_at":0,"progress_total":100,"strength":1,"anchor":0,"parent":null,"children":[],"visible":true},{"id":2,"type":2,"name":"Button","event":"","x":120,"y":0,"width":60,"height":44,"rotation":0,"text":"M","asset":"","color":-12040120,"color_text":-1513499,"color_hover":-12895429,"color_press":-15000805,"color_progress":-1513499,"progress_at":0,"progress_total":100,"strength":1,"anchor":0,"parent":null,"children":[],"visible":true},{"id":3,"type":2,"name":"Button","event":"","x":180,"y":0,"width":60,"height":44,"rotation":0,"text":"!","asset":"","color":-12040120,"color_text":-1513499,"color_hover":-12895429,"color_press":-15000805,"color_progress":-1513499,"progress_at":0,"progress_total":100,"strength":1,"anchor":0,"parent":null,"children":[],"visible":true}],"assets":[]};
    public function new() {
		super();

		iron.data.Data.getFont("font_default.ttf", function(f:kha.Font) {
            ui = new Zui({font: f, autoNotifyInput: false});
            iron.Scene.active.notifyOnInit(sceneInit);
        });
	}

	function sceneInit() {

        rt = kha.Image.createRenderTarget(canvas.width, canvas.height);

        // We will use empty texture slot in attached material to render UI
        var mat:iron.data.MaterialData = cast(object, iron.object.MeshObject).materials[0];
        mat.contexts[0].textures[0] = rt; // Override diffuse texture

        notifyOnRender(render);
        notifyOnUpdate(update);
    }

	function render(g:kha.graphics4.Graphics) {
        rt.g2.begin();
		Canvas.draw(ui, canvas, rt.g2);
		rt.g2.end();
    }

	function update() {

        // We need to figure out if user clicked on the UI plane
        // Get plane UV
        var uv = iron.math.RayCaster.getPlaneUV(cast object, mouse.x, mouse.y, iron.Scene.active.camera);
        trace(mouse.x+", "+mouse.y);
        // trace("ui.x: "+ui.+", ui.y: "+uv.y);
        if (uv == null) return;
        trace("uv.x: "+uv.x+", uv.y: "+uv.y);

        // Pixel coords
        var px = Std.int(uv.x * canvas.width);
        var py = Std.int(uv.y * canvas.height);
        trace(px+", "+py);

        // Send input events
        if (mouse.started()) ui.onMouseDown(0, px, py);
        else if (mouse.released()) ui.onMouseUp(0, px, py);
        if (mouse.movementX != 0 || mouse.movementY != 0) ui.onMouseMove(px, py, 0, 0);
    }
}
