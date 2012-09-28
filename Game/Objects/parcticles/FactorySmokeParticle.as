package Game.Objects.parcticles
{
	import flinjin.particles.FjParticle;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class FactorySmokeParticle extends FjParticle
	{
		[Embed(source="../../../_assets/bmp/particles/smoke.png")]
		private static var _smokeBitmap:Class;
		static private const TIME_TO_LIVE:Number = 15000;
		private var _initialHeight:Number;
		private var _initialWidth:Number;
		private var _scale:Number;
		
		public function FactorySmokeParticle()
		{
			super(new _smokeBitmap());
			_initialWidth = width;
			_initialHeight = height;
			_timeToLive = TIME_TO_LIVE;
		}
		
		override public function update(deltaTime:Number):void
		{
			_scale = 1 - (_timeToLive / TIME_TO_LIVE) * 0.6;
			width = _initialWidth * _scale;
			height = _initialHeight * _scale;
			super.update(deltaTime);
		}
	}

}