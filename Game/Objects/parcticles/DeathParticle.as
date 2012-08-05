package Game.Objects.parcticles 
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flinjin.events.FlinjinObjectPoolEvent;
	import flinjin.graphics.FjSpriteAnimation;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class DeathParticle extends ClumpsParticles 
	{
		[Embed(source="../../../_assets/bmp/particles/death-13x13.png")]
		private static var _particleBitmap:Class;
		
		public function DeathParticle()
		{
			super(new _particleBitmap(), null, new Point(13, 13), new FjSpriteAnimation("anim", null, 200));
		}
		
		override protected function restore(e:FlinjinObjectPoolEvent = null):void 
		{
			super.restore(e);
			currentFrame = 0;
		}
	}

}