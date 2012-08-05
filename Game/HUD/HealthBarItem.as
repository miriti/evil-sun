package Game.HUD 
{
	import flinjin.graphics.FjSprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class HealthBarItem extends FjSprite 
	{
		[Embed(source="../../_assets/bmp/hud/health_bar.png")]
		private static var _bar:Class;
		
		public function HealthBarItem() 
		{
			super(new _bar());
		}
		
	}

}