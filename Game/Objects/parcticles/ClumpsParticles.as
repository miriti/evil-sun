package Game.Objects.parcticles
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flinjin.events.FlinjinObjectPoolEvent;
	import flinjin.Flinjin;
	import flinjin.graphics.FjSpriteAnimation;
	import flinjin.particles.FjParticle;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ClumpsParticles extends FjParticle
	{
		private var _scale:Number;
		public static const GRAVITY:Number = 0.3;
		public static const X_ACC:Number = 0.07;
		public static const INITIAL_SCALE:Number = 1;
		public static const TIME_TO_LIVE:Number = 1500;
		
		public function ClumpsParticles(spriteBmp:Bitmap, rotationCenter:Point = null, frameSize:Point = null, spriteAnimation:FjSpriteAnimation = null)
		{
			super(spriteBmp, rotationCenter, frameSize, spriteAnimation);
			restore();
		}
		
		override protected function restore(e:FlinjinObjectPoolEvent = null):void
		{
			super.restore(e);
			_timeToLive = TIME_TO_LIVE;
			width = originalWidth * INITIAL_SCALE;
			height = originalHeight * INITIAL_SCALE;
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			
			//alpha = _timeToLive / TIME_TO_LIVE;
			
			if (y > GameMain.groundLevel)
			{
				_speedVector.y = -_speedVector.y * (r(deltaTime) * 0.8);
				y = GameMain.groundLevel;
			}
			
			_speedVector.y += GRAVITY;
			
			if (_speedVector.x < 0)
			{
				_speedVector.x += X_ACC * r(deltaTime);
				if (_speedVector.x > 0)
					_speedVector.x = 0;
			}
			
			if (_speedVector.x > 0)
			{
				_speedVector.x -= X_ACC * r(deltaTime);
				if (_speedVector.x < 0)
					_speedVector.x = 0;
			}
		}
	
	}

}