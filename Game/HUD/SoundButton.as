package Game.HUD
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flinjin.sound.FjSnd;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class SoundButton extends ButtonSwitch
	{
		[Embed(source="../../_assets/bmp/menu/sound-83x71.png")]
		private static var _buttonSoundBitmap:Class;
		protected static var _soundOn:Boolean = true;
		
		protected var _buttonBitmap:Bitmap;
		protected var _frameSize:Point;
		
		public function SoundButton()
		{
			if (_buttonBitmap == null)
				_buttonBitmap = new _buttonSoundBitmap();
			if (_frameSize == null)
				_frameSize = new Point(83, 71);
			super(_buttonBitmap, null, _frameSize);
			
			if (!_soundOn)
				hitSwitch();
		}
		
		override public function get state():Boolean
		{
			return super.state;
		}
		
		override public function set state(value:Boolean):void
		{
			super.state = value;
			_soundOn = value;
			
			if (value)
				FjSnd.enableTags(['sound']);
			else
				FjSnd.disableTags(['sound']);
		}
	
	}

}