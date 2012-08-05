package Game.Rounds
{
	import Game.Balance;
	import Game.Mobs.Baloon;
	import Game.Mobs.BTR;
	import Game.Mobs.Plane;
	import Game.Mobs.Tank;
	import Game.Mobs.Troop;
	import Game.Mobs.TroopGroup;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class WaveInfinitie extends GameRound
	{
		private static var _waveNum:int = 9;
		
		private static var _troopCount:int = 18;
		private static var _troopGroupCount:int = 15;
		private static var _tankCount:int = 15;
		private static var _btrCOunt:int = 10;
		private static var _planeCount:int = 10;
		private static var _planeGroupCount:int = 2;
		private static var _baloonCount:int = 2;
		
		public function WaveInfinitie()
		{
			_roundName = "Wave " + _waveNum;
			_nextRound = WaveInfinitie;
			_waveNum++;
			
			for (var i:int = 0; i < _troopCount; i++)
			{
				addMobEvent(1500 * i, new Troop());
			}
			
			for (var j:int = 0; j < _troopGroupCount; j++)
			{
				addMobEvent(5000 + j * 2000, new TroopGroup());
			}
			
			for (var k:int = 0; k < _tankCount; k++)
			{
				addMobEvent(8000 + k * 2000, new Tank());
			}
			
			for (var l:int = 0; l < _btrCOunt; l++)
			{
				addMobEvent(30000 + l * 3000, new BTR());
			}
			
			for (var m:int = 0; m < _planeCount; m++)
			{
				for (var n:int = 0; n < _planeGroupCount; n++)
				{
					addMobEvent(15000 + m * 5000 + 500 * n, new Plane());
				}
			}
			
			for (var o:int = 0; o < _baloonCount; o++)
			{
				addMobEvent(15000 + o * 15000, new Baloon());
			}
			
			_troopCount *= 1.5;
			_troopGroupCount *= 1.5;
			_tankCount *= 1.5;
			_btrCOunt *= 0.2;
			_planeCount *= 1.2;
			_baloonCount++;
			
			Balance.troopHealth *= 1.2;
			Balance.troopGroupHealth *= 1.2;
			Balance.planeHealth *= 1.1;
			Balance.btrHealth *= 1.1;
			Balance.baloonHealth *= 1.2;
			
			Balance.troopSpeed *= 1.1;
			Balance.troopGroupSpeed *= 1.1;
			Balance.tankSpeed *= 1.1;
			Balance.baloonSpeed *= 1.1;
		}
	
	}

}