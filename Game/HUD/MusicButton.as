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
		
		public function MusicButton()
		{
			super(new _musicButtonBitmap(), null, new Point(67, 69));
		}
		
		override public function get state():Boolean
		{
			return super.state;
		}
		
		override public function set state(value:Boolean):void
		{
			super.state = value;
		}
	}

}