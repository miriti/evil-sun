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
			
			for (var i:int = 0; i < 7; i++)
			{
				addEvent(2000 * i, BTR);
			}
			
			for (var j:int = 0; j < 7; j++) 
			{
				addEvent(1500 * j, Tank);
			}
		}
	
	}

}