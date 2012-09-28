package Game.HUD
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class WaveTitleDie extends FjSprite
	{
		private var _state:Number = 0;
		private var _time:Number = 0;
		
		public static var showTime:Number = 2000;
		
		public function WaveTitleDie(spriteBmp:Bitmap)
		{
			super(spriteBmp);
			setCenter();
			alpha = 0;
			GameMain.Instance.addSprite(this, Main.CONTENT_WIDTH / 2, Main.CONTENT_HEIGHT / 2, 99);
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			if (_state == 0)
			{
				if (alpha < 1)
				{
					alpha += 0.05;
				}
				else
				{
					_state = 1;
					if (alpha > 1)
						alpha = 1;
				}
			}
			else if (_state == 1)
			{
				if (_time >= showTime)
				{
					_state = 2;
					_time = 0;
				}
				_time += deltaTime;
			}
			else if (_state == 2)
			{
				if (alpha > 0)
				{
					alpha -= 0.05;
				}
				else if (alpha < 0)
					alpha = 0;
			}
		
		}
	}

}