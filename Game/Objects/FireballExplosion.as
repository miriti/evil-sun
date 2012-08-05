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
	public class FireballExplosion extends FjSprite 
	{
		[Embed(source="../../_assets/bmp/weapons/fireball_explosion-177x89.png")]
		private static var _bitmapExplosionAnim:Class;
		
		public function FireballExplosion() 
		{
			super(new _bitmapExplosionAnim(), new Point(177 / 2, 89), new Point(177, 89), new FjSpriteAnimation("exp", null, 50, false, 1));
			addEventListener(FlinjinSpriteEvent.ANIMATION_FINISHED, onAnimationFinished);
		}
		
		private function onAnimationFinished(e:FlinjinSpriteEvent):void 
		{
			Delete();
		}
		
	}

}