package Game.Objects.parcticles
{
	import flash.geom.Rectangle;
	import flinjin.sound.FjSnd;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class FactoryExplosion extends Explosion
	{
		public function FactoryExplosion()
		{
			super([DeathParticle], new Rectangle(-20, -20, 20, 20));
			_particlesPerEmmit = 30;
			_emmitCount = 10;
			_emmitInterval = 300;
		}
		
		override protected function _emmit():void
		{
			super._emmit();
			FjSnd.playSound("explosion");
			x += -100 + Math.random() * 200;
			y += -100 + Math.random() * 200;
		}
	
	}

}