package Game.HUD.MainMenu 
{
	import flash.geom.Point;
	import Game.HUD.SoundButton;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class MMSoundButton extends SoundButton 
	{
		[Embed(source="../../../_assets/bmp/menu/sound-97x83.png")]
		private static var _bmp:Class;
		
		public function MMSoundButton() 
		{
			_buttonBitmap = new _bmp();
			_frameSize = new Point(97, 83);
			super();
		}
		
	}

}