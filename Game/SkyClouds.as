package Game
{
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class SkyClouds extends FjLayer
	{
		[Embed(source="../_assets/bmp/sky-cloud.png")]
		private static var _skyCloud:Class;
		
		private var _clouds:Vector.<FjSprite> = new Vector.<FjSprite>();
		
		public function SkyClouds()
		{
			_clouds[0] = new FjSprite(new _skyCloud());
			_clouds[1] = new FjSprite(new _skyCloud());
			
			super(_clouds[0].width, _clouds[0].height);
			
			addSprite(_clouds[0]);
			addSprite(_clouds[1], -_clouds[1].width);
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			
			for (var i:int = 0; i < _clouds.length; i++)
			{
				_clouds[i].x += r(deltaTime) * 1.3;
				
				if (_clouds[i].x > width)
					_clouds[i].x = -width + (width - _clouds[i].x);
			}
		}
	
	}

}