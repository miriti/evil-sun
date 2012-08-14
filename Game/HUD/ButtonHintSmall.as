package Game.HUD 
{
	import flash.display.Bitmap;
	import flash.text.TextFormat;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteText;
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ButtonHintSmall extends ButtonHint 
	{	
		[Embed(source="../../_assets/bmp/hud/hint-204x103.png")]
		private static var _backgroundImage:Class;
		
		private var _bgBmp:FjSprite = new FjSprite(new _backgroundImage());
		
		public function ButtonHintSmall(newHintText:String) 
		{
			super(_bgBmp.width, _bgBmp.height);
			addSprite(_bgBmp, null, null, 0);
			hintText = newHintText;
			setCenter(155, 100);
		}
		
	}

}