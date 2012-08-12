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
			_nextRound = WaveInfinitie;
			for (var i:int = 0; i < 4; i++)
			{
				addEvent(16000 * i, Baloon);
			}
			
			for (var j:int = 0; j < 20; j++)
			{
				addEvent(4000 * j, Plane);
				addEvent(4000 * j + 500, Plane);
				addEvent(4000 * j + 1000, Plane);
				addEvent(4000 * j + 1500, Plane);
			}
		}
	
	}

}