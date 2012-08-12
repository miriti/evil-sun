package Game.HUD 
{
	import flash.text.TextFormat;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSpriteText;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ButtonHint extends FjLayer 
	{
		protected var _hintText:String;
		protected var _hintTextSprite:FjSpriteText;
		
		public function ButtonHint(layerWidth:uint, layerHeight:uint) 
		{
			super(layerWidth, layerHeight);			
			_hintTextSprite = new FjSpriteText("", new TextFormat("gameFont", 25, 0x503020));
			visible = false;
		}
		
		public function get hintText():String 
		{
			return _hintText;
		}
		
		public function set hintText(value:String):void 
		{
			_hintTextSprite.text = value;
			_hintText = value;
		}
	}
}