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
		private var _done:Boolean = false;
		private var _doneTime:Number;
		static private const NUM_MOBS:Number = 5;
		private var _instProtect:ProtectInstruction;
		private var _firstTroop:Troop;
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
			_roundName = "Warm Up";
			_nextRound = Wave1;
			_titleBitmap = new _warmUp();
			
			for (var i:int = 0; i < NUM_MOBS; i++)
			{
				var _newTroop:Troop = FjObjectPool.pull(Troop) as Troop;
				
				if (i == 0)
					_firstTroop = _newTroop;
				
				addMobEvent(4000 + i * 4000, _newTroop);
			}
			
			WeaponChose.weaponRay();
			
			GameMain.Instance.sun.weaponRay.recovery = 0;
			if (GameMainScenario.helpEnabled)
			{
				GameMain.Instance.sun.weaponShotgun.recovery = -1;
				GameMain.Instance.sun.weaponFireball.recovery = -1;
				GameMain.Instance.sun.weaponApocalypce.recovery = -1;
			}else {
				GameMain.Instance.sun.weaponShotgun.recovery = 0;
				GameMain.Instance.sun.weaponFireball.recovery = 0;
				GameMain.Instance.sun.weaponApocalypce.recovery = 0;
			}
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if ((_protectTimeout >= 4000) && (!_protectShown))
			{
				_instProtect = new ProtectInstruction(this);
				_instProtect.show();
				_protectShown = true;
			}
			else
			{
				_protectTimeout += deltaTime;
			}
			
			if (!_destroyShown)
			{
				if ((_firstTroop.x <= 930) && (_firstTroop.parent != null))
				{
					_instDestroy = new DestroyInstruction(this);
					_instDestroy.show();
					_destroyShown = true;
				}
			}
			else
			{
				if (!_aimShown)
				{
					_instAim = new AimInstructions(this);
					_instAim.show();
					_aimShown = true;
				}
				else
				{
					if (!_powerShown)
					{
						_instPower = new PowerInstruction(this);
						_instPower.show();
						_powerShown = true;
					}
				}
			}
		}
	
	}

}