package Game.Rounds
{
	import flash.display.Bitmap;
	import Game.Mobs.Baloon;
	import Game.Mobs.Paratrooper;
	import Game.Mobs.Plane;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Wave8 extends GameRound
	{
		[Embed(source="../../_assets/bmp/hud/wave-titles/WatchYourBack.png")]
		private static var _watchYourBackBmp:Class;
		
		public function Wave8()
		{
			_nextRound = WaveInfinitie;
			_titleBitmap = new _watchYourBackBmp() as Bitmap;
			
			for (var i:int = 0; i < 2; i++)
			{
				addEvent(22000 * i, Baloon);
			}
			
			for (var j:int = 0; j < 9; j++)
			{
				addEvent(6000 * j + 2000, Plane);
			}
			
			for (var k:int = 0; k < 3; k++)
			{
				addEvent(20000 * k + 6000, Paratrooper);
			}
		}
		
		override public function finish():void 
		{
			// http://gamesbutler.com/
			// aerostats defeated
			// Main.gb_api.gb_SubmitAchievement('evilsun_gb781CacvPgb58261051S');
			super.finish();
		}
	
	}

}