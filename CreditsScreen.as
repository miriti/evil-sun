package
{
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flinjin.algorithms.camera.Dissolve;
	import flinjin.Flinjin;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteText;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class CreditsScreen extends FjLayer
	{
		[Embed(source="_assets/bmp/credits.jpg")]
		static private var _titlesBitmap:Class;
		
		private var _titlesSprite:FjSprite = new FjSprite(new _titlesBitmap());
		
		public function CreditsScreen()
		{
			super(Main.CONTENT_WIDTH, Main.CONTENT_HEIGHT);

			addSprite(_titlesSprite);
			
			interactive = true;
			
			addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
				{
					Flinjin.Instance.Camera.LookBack();
				});
		}
	
	}

}