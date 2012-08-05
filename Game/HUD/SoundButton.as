package Game.HUD
{
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
		
		public function SoundButton()
		{
			super(new _buttonSoundBitmap(), null, new Point(83, 71));
		}
		
		override public function get state():Boolean
		{
			return super.state;
		}
		
		override public function set state(value:Boolean):void
		{
			super.state = value;
			if (value)
				FjSnd.enableTags(['sound']);
			else
				FjSnd.disableTags(['sound']);
		}
	
	}

}