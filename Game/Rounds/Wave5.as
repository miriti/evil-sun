package Game.Rounds
{
	import Game.GameMain;
	import Game.Mobs.TroopGroup;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Wave5 extends GameRound
	{
		static public const MOB_INTERVAL:Number = 1700;
		static public const MOB_NUM:Number = 7;
		private var _lastCreationTime:Number = 0;
		private var _createdCont:Number = 0;
		
		public function Wave5()
		{
			_nextRound = Wave6;
			
			for (var i:int = 0; i < 6; i++)
			{
				addEvent(i * 2500, new TroopGroup());
			}
		}
	}

}