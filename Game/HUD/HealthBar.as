package Game.HUD
{
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class HealthBar extends FjLayer
	{
		private var _maxValue:Number;
		private var _maxBars:Number;
		private var _value:Number;
		
		protected var _bars:Vector.<FjSprite> = new Vector.<FjSprite>();
		
		/**
		 *
		 * @param	maxBars
		 * @param	maxValue
		 * @param	maxWidth
		 * @param	barClass
		 */
		public function HealthBar(maxWidth:Number, maxValue:Number, barClass:Class)
		{
			var _sampleBar:FjSprite = new barClass();
			
			_maxBars = Math.floor(maxWidth / _sampleBar.width);
			
			for (var i:int = 0; i < _maxBars; i++)
			{
				_bars[i] = new barClass();
				_bars[i].x = i * _bars[i].width;
			}
			
			super(_bars[0].width * _bars.length, _bars[0].height);
			
			for (var j:int = 0; j < _bars.length; j++)
			{
				addSprite(_bars[j]);
			}
			
			_maxValue = maxValue;
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function set value(val:Number):void
		{
			_value = val;
			
			for (var i:int = 0; i < _bars.length; i++)
			{
				_bars[i].alpha = 0.2;
			}
			
			var _shownBars:Number = Math.floor((val / _maxValue) * _maxBars);
			
			for (i = 0; i < _shownBars; i++)
			{
				_bars[i].alpha = 1;
			}
		}
	}

}