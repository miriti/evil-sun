package Game.HUD.instructions 
{
	import flinjin.graphics.FjSprite;
	import Game.HUD.Instructions;
	import Game.Rounds.GameRound;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class DestroyInstruction extends Instructions 
	{		
		[Embed(source="../../../_assets/bmp/hud/help/1/1_4.png")]
		private static var _bimapDestroy:Class;
		
		public function DestroyInstruction(wave:GameRound) 
		{
			super(wave);			
		}
		
		override protected function initImages():void 
		{
			super.initImages();
			addSprite(new FjSprite(new _bimapDestroy()));
		}
	}

}