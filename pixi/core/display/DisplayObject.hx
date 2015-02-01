package pixi.core.display;

import pixi.core.math.Matrix;
import pixi.core.math.shapes.Rectangle;
import pixi.core.math.Point;

@:native("PIXI.core.DisplayObject")
extern class DisplayObject {

	/**
	 * The base class for all objects that are rendered on the screen.
	 * This is an abstract class and should not be used on its own rather it should be extended.
	 *
	 * @class
	 * @namespace PIXI
	 */
	function new();

	/**
	 * Retrieves the bounds of the displayObject as a rectangle object
	 *
	 * @param matrix {Matrix}
	 * @return {Rectangle} the rectangular bounding area
	 */
	function getBounds(?matrix:Matrix):Rectangle;

	/**
	 * Retrieves the local bounds of the displayObject as a rectangle object
	 *
	 * @return {Rectangle} the rectangular bounding area
	 */
	function getLocalBounds():Rectangle;

	/**
	 * Calculates the global position of the display object
	 *
	 * @param position {Point} The world origin to calculate from
	 * @return {Point} A point object representing the position of this object
	 */
	function toGlobal(position:Point):Point;

	/**
	 * Calculates the local position of the display object relative to another point
	 *
	 * @param position {Point} The world origin to calculate from
	 * @param [from] {DisplayObject} The DisplayObject to calculate the global position from
	 * @return {Point} A point object representing the position of this object
	 */
	function toLocal(position:Point, ?frm:DisplayObject):Point;

	/**
	 * Generates and updates the cached sprite for this object.
	 *
	 * @method updateCache
	 */
	function updateCache():Void;

	/**
     * The coordinate of the object relative to the local coordinates of the parent.
     *
     * @member {Point}
     */
	var position:Point;

	/**
     * The scale factor of the object.
     *
     * @member {Point}
     */
	var scale:Point;

	/**
     * The pivot point of the displayObject that it rotates around
     *
     * @member {Point}
     */
	var pivot:Point;

	/**
     * The rotation of the object in radians.
     *
     * @member {Float}
     */
	var rotation:Float;

	/**
     * The opacity of the object.
     *
     * @member {Float}
     */
	var alpha:Float;

	/**
     * The visibility of the object. If false the object will not be drawn, and
     * the updateTransform function will not be called.
     *
     * @member {Bool}
     */
	var visible:Bool;

	/**
     * Can this object be rendered, if false the object will not be drawn but the updateTransform
     * methods will still be called.
     *
     * @member {Bool}
     */
	var renderable:Bool;

	/**
     * The display object container that contains this display object.
     *
     * @member {Container}
     * @readOnly
     */
	var parent:Container;

	/**
     * The multiplied alpha of the displayObject
     *
     * @member {Float}
     * @readOnly
     */
	var worldAlpha:Float;

	/**
     * Current transform of the object based on world (parent) factors
     *
     * @member {Matrix}
     * @readOnly
     */
	var worldTransform:Matrix;

	/**
     * The area the filter is applied to. This is used as more of an optimisation
     * rather than figuring out the dimensions of the displayObject each frame you can set this rectangle
     *
     * @member {Rectangle}
     */
	var filterArea:Rectangle;

	/**
     * The position of the displayObject on the x axis relative to the local coordinates of the parent.
     *
     * @member {Float}
     * @memberof DisplayObject#
     */
	var x:Float;

	/**
     * The position of the displayObject on the y axis relative to the local coordinates of the parent.
     *
     * @member {Float}
     * @memberof DisplayObject#
     */
	var y:Float;

	/**
     * Indicates if the sprite is globally visible.
     *
     * @member {Bool}
     * @memberof DisplayObject#
     * @readonly
     */
	var worldVisible:Bool;

	/**
     * Sets a mask for the displayObject. A mask is an object that limits the visibility of an object to the shape of the mask applied to it.
     * In PIXI a regular mask must be a PIXI.Graphics object. This allows for much faster masking in canvas as it utilises shape clipping.
     * To remove a mask, set this property to null.
     *
     * @member {Graphics}
     * @memberof DisplayObject#
     */
	var mask:Dynamic;

	/**
     * Sets the filters for the displayObject.
     * * IMPORTANT: This is a webGL only feature and will be ignored by the canvas renderer.
     * To remove filters simply set this property to 'null'
     *
     * @member {Filter[]}
     * @memberof DisplayObject#
     */
	var filters:Dynamic;
}