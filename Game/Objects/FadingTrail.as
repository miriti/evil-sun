package Game.Objects
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flinjin.events.FlinjinObjectPoolEvent;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class FadingTrail extends FjSprite
	{
		
		public function FadingTrail(spriteBmp:Bitmap, rotationCenter:Point = null, frameSize:Point = null, spriteAnimation:FjSpriteAnimation = null)
		{
			super(spriteBmp, rotationCenter, frameSize, spriteAnimation);
		}
		
		override protected function restore(e:FlinjinObjectPoolEvent = null):void 
		{
			super.restore(e);
			alpha = 1;
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			alpha -= s(deltaTime) * 3;
			
			if (alpha <= 0)
			{
				Delete(true);
			}
		}
	
	}

}