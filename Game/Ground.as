package Game 
{
	import flinjin.graphics.FjSprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Ground extends FjSprite 
	{
		[Embed(source="../_assets/bmp/ground.png")]
		private static var _groundBitmap:Class;
		
		public function Ground() 
		{
			super(new _groundBitmap());
		}
		
	}

}