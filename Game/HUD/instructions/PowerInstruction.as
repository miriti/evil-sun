package Game.HUD.instructions
{
	import flinjin.graphics.FjSprite;
	import Game.HUD.Instructions;
	import Game.Rounds.GameRound;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class PowerInstruction extends Instructions
	{
		[Embed(source="../../../_assets/bmp/hud/help/1/1_3.png")]
		private static var _bimapPower:Class;
		
		public function PowerInstruction(wave:GameRound)
		{
			super(wave);
		
		}
		
		override protected function initImages():void
		{
			super.initImages();
			addSprite(new FjSprite(new _bimapPower()));
		}
	}

}