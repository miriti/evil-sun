package Game.Rounds
{
	import flash.events.MouseEvent;
	import flinjin.FjObjectPool;
	import Game.GameMain;
	import Game.GameMainScenario;
	import Game.HUD.Instructions;
	import Game.HUD.instructions.AimInstructions;
	import Game.HUD.instructions.DestroyInstruction;
	import Game.HUD.instructions.PowerInstruction;
	import Game.HUD.instructions.ProtectInstruction;
	import Game.HUD.WeaponChose;
	import Game.Mobs.Troop;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Wave0 extends GameRound
	{
		static private const NUM_MOBS:Number = 5;
		
		private var _done:Boolean = false;
		private var _doneTime:Number;
		private var _instProtect:ProtectInstruction;
		private var _destroyShown:Boolean = false;
		private var _instDestroy:DestroyInstruction;
		private var _aimShown:Boolean = false;
		private var _instAim:AimInstructions;
		private var _powerShown:Boolean = false;
		private var _instPower:PowerInstruction;
		
		[Embed(source="../../_assets/bmp/hud/wave-titles/warm up.png")]
		private static var _warmUp:Class;
		
		private var _protectTimeout:Number = 0;
		private var _protectShown:Boolean = false;
		
		public function Wave0()
		{
			super();
			_nextRound = Wave1;
			
			var _mobDelay:Number;
			
			if (!GameMainScenario.helpEnabled)
			{
				_titleBitmap = new _warmUp();
				GameMain.Instance.sun.weaponRay.recovery = 0;
				GameMain.Instance.sun.weaponShotgun.recovery = 0;
				GameMain.Instance.sun.weaponFireball.recovery = 0;
				GameMain.Instance.sun.weaponApocalypce.recovery = 0;
				_mobDelay = 1000;
			}
			else
			{				
				addEvent(0, null, new ProtectInstruction(this));
				addEvent(5000, null, new AimInstructions(this));
				addEvent(10000, null, new PowerInstruction(this));
				addEvent(18000, null, new DestroyInstruction(this));				
				
				_mobDelay = 17000;
			}
			
			for (var i:int = 0; i < NUM_MOBS; i++)
			{
				addEvent(_mobDelay + i * 4000, Troop);
			}
		}
	}

}