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
			_roundName = "Wave 7";
			_nextRound = Wave8;
			
			for (var i:int = 0; i < 20; i++) 
			{
				addMobEvent(1000 * i, new Troop());
			}
			
			for (var j:int = 0; j < 20; j++) 
			{
				addMobEvent(2000 + 2000 * j, new TroopGroup());
			}
			
			for (var k:int = 0; k < 20; k++) 
			{
				addMobEvent(4000 + 1300 * k, new Plane());
			}
		}
		
	}

}