package Game.HUD.instructions
{
	import flinjin.graphics.FjSprite;
	import Game.HUD.Instructions;
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
			super(wave);
		}
		
		override protected function initImages():void
		{
			super.initImages();
			addSprite(new FjSprite(new _protectBitmap()));
		}
	
	}

}