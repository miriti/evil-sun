package Game.HUD.instructions 
{
	import flinjin.graphics.FjSprite;
	import Game.HUD.Instructions;
	import Game.Rounds.GameRound;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class AimInstructions extends Instructions 
	{
		
		[Embed(source="../../../_assets/bmp/hud/help/1/1_2.png")]
		private static var _bimapAim:Class;
		
		public function AimInstructions(wave:GameRound) 
		{
			super(wave);
			
		}
		
		override protected function initImages():void 
		{
			super.initImages();
			addSprite(new FjSprite(new _bimapAim()));
		}
	}

}