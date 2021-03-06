/* Helper class that can be used by any pixi application
 *
 * @author Adi Reddy Mora
 * http://adireddy.github.io
 * @license MIT
 * @copyright 2015
 */

package pixi;

import js.html.Event;
import js.html.CanvasElement;
import js.Browser;
import pixi.renderers.webgl.WebGLRenderer;
import pixi.utils.Detector;
import pixi.display.Stage;
import pixi.utils.Stats;

class Application {

	/*
	 * Sets the pixel ratio of the application
	 * @default 1
	 */
	public var pixelRatio(null, default):Float;

	/*
	 * Default frame rate is 60 FPS and this can be set to true to get 30 FPS
	 * @default false
	 */
	public var skipFrame(null, default):Bool;

	/*
	 * Width of the application
	 * @default Browser.window.innerWidth
	 */
	public var width(null, default):Float;

	/*
	 * Height of the application
	 * @default Browser.window.innerHeight
	 */
	public var height(null, default):Float;

	/*
	 * Whether you want to resize the canvas and renderer on browser resize
	 * Should be set to false when custom width and height are used for the application
	 * @default true
	 */
	public var resize(null, default):Bool;

	/*
	 * Enable/disable stats for the application
	 * Note that stats.js is not part of pixi so don't forget to include it you html page
	 * Can be found in libs folder - <script type="text/javascript" src="libs/stats.min.js"></script>
	 * @default false
	 */
	public var stats(null, set):Bool;

	/*
	 * Sets the background color of the stage
	 * @default 0xFFFFFF
	 */
	public var backgroundColor(null, default):Int;

	/*
	 * Update listener function
	 */
	public var onUpdate:Float -> Void;

	/*
	 * Windo resize listener function
	 */
	public var onResize:Void -> Void;

	/*
	 * Pixi stage
	 * Read-only
	 */
	var _stage(default, null):Stage;

	var _canvas:CanvasElement;
	var _renderer:WebGLRenderer;
	var _stats:Stats;

	var _lastTime:Date;
	var _currentTime:Date;
	var _elapsedTime:Float;
	var _skipFrame:Bool;

	public function new() {
		_lastTime = Date.now();
		_setDefaultValues();
	}

	function _setDefaultValues() {
		pixelRatio = 1;
		skipFrame = false;
		stats = false;
		backgroundColor = 0xFFFFFF;
		width = Browser.window.innerWidth;
		height = Browser.window.innerHeight;
		_skipFrame = false;
	}

	public function start() {
		_canvas = Browser.document.createCanvasElement();
		_canvas.style.width = width + "px";
		_canvas.style.height = height + "px";
		_canvas.style.position = "absolute";
		Browser.document.body.appendChild(_canvas);

		_stage = new Stage(backgroundColor);

		var renderingOptions:RenderingOptions = {};
		renderingOptions.view = _canvas;
		renderingOptions.resolution = pixelRatio;

		_renderer = Detector.autoDetectRenderer(width, height, renderingOptions);
		Browser.document.body.appendChild(_renderer.view);
		Browser.window.onresize = _onWindowResize;
		Browser.window.requestAnimationFrame(cast _onRequestAnimationFrame);
		_lastTime = Date.now();
	}

	function _onWindowResize(event:Event) {
		width = Browser.window.innerWidth;
		height = Browser.window.innerHeight;
		_renderer.resize(width, height);
		_canvas.style.width = width + "px";
		_canvas.style.height = height + "px";
		if (onResize != null) onResize();
	}

	function _onRequestAnimationFrame() {
		if (skipFrame && _skipFrame) _skipFrame = false;
		else {
			_skipFrame = true;
			_calculateElapsedTime();
			if (onUpdate != null) onUpdate(_elapsedTime);
			_renderer.render(_stage);
		}
		Browser.window.requestAnimationFrame(cast _onRequestAnimationFrame);
		if (_stats != null) _stats.update();
	}

	function _calculateElapsedTime() {
		_currentTime = Date.now();
		_elapsedTime = _currentTime.getTime() - _lastTime.getTime();
		_lastTime = _currentTime;
	}

	function set_stats(val:Bool):Bool {
		if (val) {
			var _container = Browser.document.createElement("div");
			Browser.document.body.appendChild(_container);
			_stats = new Stats();
			_stats.domElement.style.position = "absolute";
			_stats.domElement.style.top = "2px";
			_stats.domElement.style.right = "2px";
			_container.appendChild(_stats.domElement);
			_stats.begin();
		}
		return stats = val;
	}
}