package Game.HUD
{
	import flash.geom.Point;
	import flinjin.graphics.FjSprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class SunPowerBar extends FjSprite
	{
		[Embed(source="../../_assets/bmp/mobs/sun/power-bar-95x92.png")]
		private static var _barBitmap:Class;
		
		private var _value:Number = 0;
		
		public function SunPowerBar()
		{
			super(new _barBitmap(), null, new Point(95, 92));
			setCenter();
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function set value(val:Number):void
		{
			_value = val;
			
			if (_value < 0)
				_value = 0;
			if (_value > 1)
				_value = 1;
			
			currentFrame = Math.floor(totalFrames * _value);
		}
	}

}