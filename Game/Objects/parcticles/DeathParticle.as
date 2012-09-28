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
		[Embed(source="../../../_assets/bmp/particles/death-10x10.png")]
		private static var _particleBitmap:Class;
		
		public function DeathParticle()
		{
			super(new _particleBitmap(), null, new Point(10, 10), new FjSpriteAnimation("anim", null, 200));
		}
		
		override public function update(deltaTime:Number):void 
		{
			super.update(deltaTime);
			alpha = timeToLive / TIME_TO_LIVE;
		}
		
		override protected function restore(e:FlinjinObjectPoolEvent = null):void 
		{
			super.restore(e);
			currentFrame = 0;
		}
	}

}