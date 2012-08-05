package Game.Objects.parcticles
{
	import flash.geom.Point;
	import flinjin.Flinjin;
	import flinjin.particles.Particle;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class BloodParticle extends ClumpsParticles
	{
		[Embed(source="../../../_assets/bmp/particles/blood_drop.png")]
		public static var bmpBloodParticle:Class;
		
		public function BloodParticle()
		{
			super(new bmpBloodParticle(), new Point(1, 1));
		}
	}
}