package Game.Objects.parcticles
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flinjin.particles.FjEmitter;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Explosion extends FjEmitter
	{
		static private const MAX_CLUMP_SPEED:Number = 17;
		
		public function Explosion(samples:Array, rect:Rectangle)
		{
			super(samples, rect);
			_emmitCount = 1;
			_particlesPerEmmit = 20;
		}
		
		override protected function _pickNewParticleVector(iteration:int = 0):Point
		{
			var _a:Number = (2 * Math.PI / _particlesPerEmmit) * iteration;
			var _sp:Number = 3 + Math.random() * MAX_CLUMP_SPEED;
			return new Point(Math.sin(_a) * _sp / 2, Math.cos(_a) * _sp);
		}
		
		override protected function _pickNewParticlePosition(iteration:int = 0):Point
		{
			var _a:Number = (2 * Math.PI / _particlesPerEmmit) * iteration;
			var _sp:Number = Math.random() * MAX_CLUMP_SPEED;
			return new Point(Math.random() * _emmitRect.width + Math.sin(_a) * _sp, Math.random() * _emmitRect.height + Math.cos(_a) * _sp);
		}
	}

}