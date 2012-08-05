package Game.HUD 
{
	import flinjin.graphics.FjSprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class PowerBarItem extends FjSprite 
	{
		[Embed(source="../../_assets/bmp/hud/power_bar.png")]
		private static var _barBitmap:Class;
		
		public function PowerBarItem() 
		{
			super(new _barBitmap());
		}
		
	}

}