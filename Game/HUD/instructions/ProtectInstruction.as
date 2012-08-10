package Game.HUD.instructions
{
	import flinjin.graphics.FjSprite;
	import Game.GameMain;
	import Game.HUD.Instructions;
	import Game.HUD.WeaponChose;
	import Game.Rounds.GameRound;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ProtectInstruction extends Instructions
	{
		[Embed(source="../../../_assets/bmp/hud/help/1/1_1.png")]
		private static var _protectBitmap:Class;
		
		public function ProtectInstruction(wave:GameRound)
		{
			WeaponChose.weaponRay();
			GameMain.Instance.sun.weaponShotgun.recovery = -1;
			GameMain.Instance.sun.weaponFireball.recovery = -1;
			GameMain.Instance.sun.weaponApocalypce.recovery = -1;
			super(wave);
		}
		
		override protected function initImages():void
		{
			super.initImages();
			addSprite(new FjSprite(new _protectBitmap()));
		}
	
	}

}