package Game.Rounds
{
	import flash.events.MouseEvent;
	import Game.GameMain;
	import Game.HUD.WeaponChose;
	import Game.Mobs.Tank;
	import Game.Mobs.Troop;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Wave1 extends GameRound
	{
		private var _done:Boolean = false;
		private var _doneTime:Number = 0;
		static private const MOBS_COUNT:Number = 8;
		
		public function Wave1()
		{
			super();
			_roundName = "Wave 1";
			_nextRound = Wave2;
			
			addMobEvent(0, new Troop());
			addMobEvent(2000, new Tank());
			
			addMobEvent(6000, new Troop());
			addMobEvent(8000, new Tank());
			
			addMobEvent(11000, new Troop());
			addMobEvent(13000, new Tank());
			
			addMobEvent(16000, new Troop());
			addMobEvent(18000, new Troop());
		}
		
		override public function finish():void
		{
			super.finish();
			GameMain.Instance.sun.weaponFireball.recovery = GameMain.Instance.sun.weaponFireball.recoveryTime;
			WeaponChose.weaponFire();
		}
	}

}