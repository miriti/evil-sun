package Game.Mobs 
{
	import flash.geom.Point;
	import flinjin.graphics.FjSprite;
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Paratrooper extends Mob 
	{
		[Embed(source="../../_assets/bmp/mobs/paratrooper/drop-103x126.png")]
		private static var _paratroopBitmap:Class;
		
		private var _paratrooperSprite:FjSprite = new FjSprite(new _paratroopBitmap());
		
		public function Paratrooper() 
		{
			super(_paratrooperSprite.width, _paratrooperSprite.height);
			setCenter(51.5, 15);
		}
		
		override public function Move(deltaTime:Number):void 
		{
			super.Move(deltaTime);
		}
		
	}

}