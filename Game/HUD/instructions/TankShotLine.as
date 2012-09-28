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
	public class TankShotLine extends Instructions
	{
		[Embed(source="../../../_assets/bmp/hud/help/2/2_1.png")]
		private static var _image:Class;
		
		public function TankShotLine(wave:GameRound)
		{
			super(wave);
		}
		
		override public function show():void
		{			
			super.show();
		}
		
		override protected function initImages():void
		{
			super.initImages();
			addSprite(new FjSprite(new _image()));
		}
	}

}