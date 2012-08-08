package Game.HUD.MainMenu 
{
	import flash.geom.Point;
	import Game.HUD.MusicButton;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class MMMusicButton extends MusicButton 
	{
		[Embed(source="../../../_assets/bmp/menu/music-81x83.png")]
		private var _buttonBmp:Class;
		
		public function MMMusicButton() 
		{
			_buttonBitmap = new _buttonBmp();
			_frameSize = new Point(81, 83);
			super();
		}
		
	}

}