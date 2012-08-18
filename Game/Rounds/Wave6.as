package Game.Rounds
{
	import Game.Mobs.BTR;
	import Game.Mobs.Tank;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Wave6 extends GameRound
	{
		
		public function Wave6()
		{
			_nextRound = Wave7;
			
			for (var i:int = 0; i < 5; i++)
			{
				addEvent(3000 * i, BTR);
			}
		}
	
	}

}