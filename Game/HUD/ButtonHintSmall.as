package Game.HUD 
{
	import flash.text.TextFormat;
	import flinjin.graphics.FjSpriteText;
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ButtonHintSmall extends ButtonHint 
	{			
		public function ButtonHintSmall(newHintText:String) 
		{
			super(140, 103);
			_hintText.text = newHintText;
		}
		
	}

}