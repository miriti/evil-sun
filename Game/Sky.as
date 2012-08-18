package Game
{
	import flinjin.Flinjin;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Sky extends FjLayer
	{
		[Embed(source="../_assets/bmp/new_sky.jpg")]
		public static var _skyBitmap:Class;
		
		private var _skyTiles:Vector.<FjSprite> = new Vector.<FjSprite>();
		static private const SCROLL_SPEED:Number = 0.75;
		
		public function Sky()
		{
			_skyTiles[0] = new FjSprite(new _skyBitmap());
			_skyTiles[1] = new FjSprite(new _skyBitmap());
			
			super(Main.CONTENT_WIDTH, Main.CONTENT_HEIGHT);
			
			addSprite(_skyTiles[0], 0, -_skyTiles[0].height + Main.CONTENT_HEIGHT);
			addSprite(_skyTiles[1], 0, Main.CONTENT_HEIGHT);
		
		}
		
		override public function Move(deltaTime:Number):void
		{
			for (var i:int = 0; i < _skyTiles.length; i++)
			{
				_skyTiles[i].y += SCROLL_SPEED * (deltaTime / Flinjin.frameDelta);
				if (_skyTiles[i].y > _skyTiles[i].height)
				{
					_skyTiles[i].y = -_skyTiles[i].height + 1;
				}
			}
			super.Move(deltaTime);
		
		}
	
	}

}