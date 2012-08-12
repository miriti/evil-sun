package Game.Rounds
{
	import Game.GameMain;
	import Game.GameMainScenario;
	import Game.HUD.instructions.ShotgunInstructions;
	import Game.HUD.WeaponChose;
	import Game.Mobs.Plane;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Wave3 extends GameRound
	{
		private var _done:Boolean = false;
		private var _doneTime:Number;
		private var _finishedTime:Number = -1;
		private var _createdPlanes:Number = 0;
		private var _createDelay:Number = 0;
		
		private static const PLANE_NUM:Number = 5;
		private var _upgradeHint:Boolean = false;
		
		[Embed(source="../../_assets/bmp/hud/wave-titles/watchTheSky.png")]
		private static var _titleBmp:Class;
		
		public function Wave3()
		{
			super();
			
			_nextRound = Wave4;
			_titleBitmap = new _titleBmp();
			
			for (var i:int = 0; i < PLANE_NUM; i++)
			{
				addEvent(i * 3000, Plane);
			}
			
			addEvent(500, null, new ShotgunInstructions(this));
			
			if (GameMainScenario.helpEnabled)
			{
				GameMain.Instance.sun.weaponShotgun.recovery = GameMain.Instance.sun.weaponShotgun.recoveryTime;
				WeaponChose.weaponShotgun();
			}
		}
	}
}