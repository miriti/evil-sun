package Game.HUD
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flinjin.graphics.FjSprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class BlackFade extends FjSprite
	{
		private var _hiding:Boolean = false;
		private var _showing:Boolean = false;
		
		public function BlackFade(vis:Boolean)
		{
			super(new Bitmap(new BitmapData(Main.CONTENT_WIDTH, Main.CONTENT_HEIGHT, true, 0xff000000)));
			visible = vis;
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if (_showing)
			{
				alpha += s(deltaTime) * 2;
				if (alpha >= 0.8)
				{
					alpha = 0.8;
					_showing = false;
				}
			}
			
			if (_hiding)
			{
				alpha -= s(deltaTime) * 2;
				if (alpha <= 0)
				{
					_hiding = false;
					visible = false;
				}
			}
		}
		
		public function show():void
		{
			_showing = true;
			_hiding = false;
			visible = true;
			alpha = 0;
		}
		
		public function hide():void
		{
			_hiding = true;
			_showing = false;
		}
	}

}