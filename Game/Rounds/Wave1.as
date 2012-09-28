package Game.Rounds
{
	import flash.events.MouseEvent;
	import Game.GameMain;
	import Game.GameMainScenario;
	import Game.HUD.WeaponChose;
	import Game.Mobs.Tank;
	import Game.Mobs.Troop;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Wave1 extends GameRound
	{
		public function Wave1()
		{
			super();
			_nextRound = Wave2;
			
			for (var i:int = 0; i < 4; i++)
			{
				addEvent(i * 1500, Troop);
			}
		}
	}

}