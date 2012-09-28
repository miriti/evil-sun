package Game.HUD
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flinjin.graphics.FjSpriteAnimation;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class MusicButton extends ButtonSwitch
	{
		[Embed(source="../../_assets/bmp/menu/music-67x69.png")]
		private static var _musicButtonBitmap:Class;
		
		protected var _buttonBitmap:Bitmap;
		protected var _frameSize:Point;
		
		public static var musicEnabled:Boolean = true;
		
		public function MusicButton()
		{
			if (_buttonBitmap == null)
				_buttonBitmap = new _musicButtonBitmap();
			if (_frameSize == null)
				_frameSize = new Point(67, 69);
			super(_buttonBitmap, null, _frameSize);
			
			if (!musicEnabled)
				hitSwitch();
		}
		
		override public function get state():Boolean
		{
			return super.state;
		}
		
		override public function set state(value:Boolean):void
		{
			super.state = value;
			musicEnabled = value;
			
			if (value)
				Main.Music.play();
			else
				Main.Music.stop();
		}
	}

}