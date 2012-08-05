package Game.HUD
{
	import flash.text.TextFormat;
	import flinjin.graphics.FjSpriteText;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameOverDie extends FjSpriteText
	{
		
		public function GameOverDie()
		{
			super('Game Over', new TextFormat('gameFont', '148', 0xff0000));
			setCenterInBitmapCenter();
		}
	
	}

}