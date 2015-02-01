(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var samples = {};
samples.Application = function() {
	this._lastTime = new Date();
	this._setDefaultValues();
};
samples.Application.prototype = {
	_setDefaultValues: function() {
		this.pixelRatio = 1;
		this.skipFrame = false;
		this.set_stats(false);
		this.backgroundColor = 16777215;
		this.width = window.innerWidth;
		this.height = window.innerHeight;
		this._skipFrame = false;
	}
	,start: function() {
		var _this = window.document;
		this._canvas = _this.createElement("canvas");
		this._canvas.style.width = this.width + "px";
		this._canvas.style.height = this.height + "px";
		this._canvas.style.position = "absolute";
		window.document.body.appendChild(this._canvas);
		console.log(PIXI.Stage);
	}
	,set_stats: function(val) {
		if(val) {
			var _container = window.document.createElement("div");
			window.document.body.appendChild(_container);
			this._stats = new Stats();
			this._stats.domElement.style.position = "absolute";
			this._stats.domElement.style.top = "2px";
			this._stats.domElement.style.right = "2px";
			_container.appendChild(this._stats.domElement);
			this._stats.begin();
		}
		return this.stats = val;
	}
};
samples.basics = {};
samples.basics.Main = function() {
	samples.Application.call(this);
	this._init();
};
samples.basics.Main.main = function() {
	new samples.basics.Main();
};
samples.basics.Main.__super__ = samples.Application;
samples.basics.Main.prototype = $extend(samples.Application.prototype,{
	_init: function() {
		this.set_stats(true);
		this.backgroundColor = 13158;
		this.onUpdate = $bind(this,this._onUpdate);
		this.resize = false;
		this.width = 800;
		this.height = 600;
		samples.Application.prototype.start.call(this);
	}
	,_onUpdate: function(elapsedTime) {
	}
});
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
samples.basics.Main.main();
})();

//# sourceMappingURL=basics.js.map