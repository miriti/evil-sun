package Game.Rounds 
{
	import Game.Mobs.Plane;
	import Game.Mobs.Troop;
	import Game.Mobs.TroopGroup;
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Wave7 extends GameRound 
	{
		
		public function Wave7() 
		{
			_nextRound = Wave8;
			
			for (var i:int = 0; i < 10; i++) 
			{
				addEvent(2000 * i, Troop);
			}
			
			for (var j:int = 0; j < 10; j++) 
			{
				addEvent(4000 + 4000 * j, TroopGroup);
			}
			
			for (var k:int = 0; k < 10; k++) 
			{
				addEvent(6000 + 2000 * k, Plane);
			}
		}
		
	}

}