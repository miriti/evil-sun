package Game.HUD.instructions
{
	import flinjin.graphics.FjSprite;
	import Game.HUD.Instructions;
	import Game.Rounds.GameRound;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ShotgunInstructions extends Instructions
	{
		[Embed(source="../../../_assets/bmp/hud/help/2/2_3.png")]
		private static var _image:Class;
		
		public function ShotgunInstructions(wave:GameRound)
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