package Game.HUD.instructions
{
	import flinjin.graphics.FjSprite;
	import Game.HUD.Instructions;
	import Game.Rounds.GameRound;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class SwitchWeaponsInstruction extends Instructions
	{
		[Embed(source="../../../_assets/bmp/hud/help/3/3_1.png")]
		private static var _image:Class;
		
		public function SwitchWeaponsInstruction(wave:GameRound)
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