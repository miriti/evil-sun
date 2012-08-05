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
			_roundName = "Wave 6: More tanks?!";
			_nextRound = Wave7;
			
			for (var i:int = 0; i < 7; i++)
			{
				addMobEvent(2000 * i, new BTR());
			}
			
			for (var j:int = 0; j < 7; j++) 
			{
				addMobEvent(1500 * j, new Tank());
			}
		}
	
	}

}