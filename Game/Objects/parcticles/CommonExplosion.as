package Game.Objects.parcticles
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class CommonExplosion extends Explosion
	{
		
		public function CommonExplosion()
		{
			super([DeathParticle], new Rectangle(0, 0, 1, 1));
			_particlesPerEmmit = 15;
		}
	
	}

}