package Game.Rounds
{
	import flinjin.graphics.FjSpriteText;
	import Game.GameMain;
	import Game.Mobs.Plane;
	import Game.Mobs.Tank;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Wave4 extends GameRound
	{
		private var _tankDelay:Number = 0;
		private var _producedTanks:Number = 0;
		private var _hintText:FjSpriteText;
		private var _hint:Boolean = false;
		private var _hintDone:Boolean = false;
		static private const TANK_COUNT:Number = 15;
		static private const TANK_DELAY:Number = 1500;
		private var _upgradeHint:Boolean = false;
		static public const PLANE_COUNT:Number = 7;
		
		public function Wave4()
		{
			super();
			
			_roundName = "Wave 4: Real Deal";
			_nextRound = Wave5;
			
			for (var i:int = 0; i < TANK_COUNT; i++)
			{
				addMobEvent(i * TANK_DELAY, new Tank());
			}
			
			for (var j:int = 0; j < PLANE_COUNT; j++)
			{
				addMobEvent(2000 + j * 2000, new Plane());
			}
			
			GameMain.Instance.sun.weaponShotgun.recovery = 0;
			GameMain.Instance.sun.weaponFireball.recovery = 0;
			GameMain.Instance.sun.weaponApocalypce.recovery = GameMain.Instance.sun.weaponApocalypce.recoveryTime / 2;
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
		}
	}
}