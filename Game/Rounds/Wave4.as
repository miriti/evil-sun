package Game.Rounds
{
	import flinjin.graphics.FjSpriteText;
	import Game.GameMain;
	import Game.GameMainScenario;
	import Game.HUD.instructions.ArmagedonInstructions;
	import Game.HUD.instructions.SwitchWeaponsInstruction;
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
		static private const TANK_COUNT:Number = 6;
		static private const TANK_DELAY:Number = 3100;
		private var _upgradeHint:Boolean = false;
		static public const PLANE_COUNT:Number = 5;
		
		public function Wave4()
		{
			super();
			
			_nextRound = Wave5;
			
			for (var i:int = 0; i < TANK_COUNT; i++)
			{
				addEvent(i * TANK_DELAY, Tank);
			}
			
			for (var j:int = 0; j < PLANE_COUNT; j++)
			{
				addEvent(2000 + j * 3000, Plane);
			}
			
			if (GameMainScenario.helpEnabled)
			{
				addEvent(0, null, new ArmagedonInstructions(this));
				addEvent(7000, null, new SwitchWeaponsInstruction(this));
				
				GameMain.Instance.sun.weaponShotgun.recovery = 0;
				GameMain.Instance.sun.weaponFireball.recovery = 0;
				GameMain.Instance.sun.weaponApocalypce.recovery = GameMain.Instance.sun.weaponApocalypce.recoveryTime;
			}
		}
		
		override public function finish():void
		{
			// gamesbutler.com
			// Tutorial Finished
			Main.gb_api.gb_SubmitAchievement('evilsun_gb781CacvYgb62639359V');
			super.finish();
		}
	}
}