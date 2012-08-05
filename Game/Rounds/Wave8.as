package Game.Rounds
{
	import Game.Mobs.Baloon;
	import Game.Mobs.Plane;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Wave8 extends GameRound
	{
		
		public function Wave8()
		{
			_roundName = "Wave 8: Occupy Sky";
			_nextRound = WaveInfinitie;
			for (var i:int = 0; i < 4; i++)
			{
				addMobEvent(16000 * i, new Baloon());
			}
			
			for (var j:int = 0; j < 20; j++)
			{
				addMobEvent(4000 * j, new Plane());
				addMobEvent(4000 * j + 500, new Plane());
				addMobEvent(4000 * j + 1000, new Plane());
				addMobEvent(4000 * j + 1500, new Plane());
			}
		}
	
	}

}