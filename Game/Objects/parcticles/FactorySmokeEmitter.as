package Game.Objects.parcticles
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flinjin.particles.FjEmitter;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class FactorySmokeEmitter extends FjEmitter
	{
		
		public function FactorySmokeEmitter()
		{
			super(new Array(FactorySmokeParticle), new Rectangle(0, 0, 1, 1));
			_emmitCount = -1;
			_emmitInterval = 5000;
			_particlesPerEmmit = 1;
			_active = false;
		}
		
		override protected function _pickNewParticleVector(iteration:int = 0):Point
		{
			return new Point(-0.1, -0.5);
		}
	}

}