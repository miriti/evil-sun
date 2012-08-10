package Game.HUD.instructions
{
	import flinjin.graphics.FjSprite;
	import Game.HUD.Instructions;
	import Game.Rounds.GameRound;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class UpgrageInstructions extends Instructions
	{
		[Embed(source="../../../_assets/bmp/hud/help/2/2_4.png")]
		private static var _image:Class;
		
		public function UpgrageInstructions(wave:GameRound)
		{
			super(wave);
		}
		
		override protected function initImages():void
		{
			super.initImages();
			addSprite(new FjSprite(new _image()));
		}
	
	}

}