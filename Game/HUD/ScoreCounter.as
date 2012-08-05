package Game.HUD
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flinjin.graphics.FjSpriteText;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ScoreCounter extends FjSpriteText
	{
		
		public function ScoreCounter()
		{
			super('0', new TextFormat('gameFont', 54, 0xffe28b, null, null, null, null, null, TextFormatAlign.RIGHT));
		}
	}

}