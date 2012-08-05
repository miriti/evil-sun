package Game.Objects
{
	import flash.geom.Point;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Fire extends FjSprite
	{
		[Embed(source="../../_assets/bmp/objects/fire.png")]
		private static var _fireBitmap:Class;
		
		public function Fire()
		{
			super(new _fireBitmap(), new Point(40, 143), new Point(80, 143), new FjSpriteAnimation("fire", null, 50));
			animation.addEventListener(FlinjinSpriteEvent.ANIMATION_FINISHED, onAnimationFinished);
		}
		
		private function onAnimationFinished(e:FlinjinSpriteEvent):void
		{
			Delete();
		}
	
	}

}