package arm;

import iron.Scene;
import zui.*;
import zui.Canvas;

import kha.Scheduler;

import arm.BuildingController;
import arm.WorldController;

class Info3DUIController extends iron.Trait {

	var ui:Zui;
    var rt:kha.Image; // Render target for UI
    var uiWidth = 512;
    var uiHeight = 512;
    var opened = false;
    var building = BuildingController;
    var world = WorldController;

	var canvas:TCanvas = {"name":"untitled","x":0,"y":0,"width":1280,"height":720,"elements":[{"id":11,"type":12,"name":"Filled_Rectangle","event":"","x":0,"y":0,"width":220,"height":140,"rotation":0,"text":"My Filled_Rectangle","asset":"","color":-2368549,"color_text":-1513499,"color_hover":-12895429,"color_press":-15000805,"color_progress":-1513499,"progress_at":0,"progress_total":100,"anchor":0,"parent":null,"children":[],"visible":true},{"id":0,"type":0,"name":"type","event":"","x":0,"y":0,"width":140,"height":20,"rotation":0,"text":"Type:","asset":"","color":-12040120,"color_text":-16777216,"color_hover":-12895429,"color_press":-15000805,"color_progress":-1513499,"progress_at":0,"progress_total":100,"anchor":0,"parent":null,"children":[],"visible":true},{"id":1,"type":0,"name":"bldtype","event":"","x":60,"y":0,"width":150,"height":20,"rotation":0,"text":"<BuildingType>","asset":"","color":-12040120,"color_text":-16777216,"color_hover":-12895429,"color_press":-15000805,"color_progress":-1513499,"progress_at":0,"progress_total":100,"anchor":0,"parent":null,"children":[],"visible":true},{"id":7,"type":18,"name":"Progress_bar","event":"","x":20,"y":100,"width":160,"height":20,"rotation":0,"text":"My Progress_bar","asset":"","color":-9276814,"color_text":-1513499,"color_hover":-12895429,"color_press":-15000805,"color_progress":-5439598,"progress_at":50,"progress_total":100,"anchor":0,"parent":null,"children":[],"visible":true,"strength":2},{"id":9,"type":0,"name":"deployed","event":"","x":0,"y":40,"width":100,"height":20,"rotation":0,"text":"Deployed:","asset":"","color":-12040120,"color_text":-16777216,"color_hover":-12895429,"color_press":-15000805,"color_progress":-1513499,"progress_at":0,"progress_total":100,"anchor":0,"parent":null,"children":[],"visible":true},{"id":10,"type":0,"name":"amt","event":"","x":100,"y":40,"width":120,"height":20,"rotation":0,"text":"<at>/<max>","asset":"","color":-12040120,"color_text":-16777216,"color_hover":-12895429,"color_press":-15000805,"color_progress":-1513499,"progress_at":0,"progress_total":100,"anchor":0,"parent":null,"children":[],"visible":true}],"assets":[]};


    public function new() {
        super();

        // Load font for UI labels
        iron.data.Data.getFont("font_default.ttf", function(f:kha.Font) {
            ui = new Zui({font: f, autoNotifyInput: false});
            iron.Scene.active.notifyOnInit(sceneInit);
        });
    }

    function sceneInit() {

        rt = kha.Image.createRenderTarget(uiWidth, uiHeight);

        // We will use empty texture slot in attached material to render UI
        var mat:iron.data.MaterialData = cast(object, iron.object.MeshObject).materials[0];
        mat.contexts[0].textures[0] = rt; // Override diffuse texture

        notifyOnRender(render);
        //getElement("timepb") = world.getTimeTaskbyBld(building.selectedBuilding)
        notifyOnUpdate(function (){
            if (building.selectedBuilding != null){
                var prop = building.getPropByType(building.selectedBuilding.type);
                getElement("bldtype").text = building.getStringBldType(building.selectedBuilding.type);
                getElement("amt").text = prop.at + " / " + prop.max;
            }
        });
    }

    function render(g:kha.graphics4.Graphics) {
		rt.g2.begin();
		Canvas.draw(ui, canvas, rt.g2);
		rt.g2.end();
    }

    function getElement(name:String):TElement {
		for (e in canvas.elements) if (e.name == name) return e;
		return null;
	}
	
}
