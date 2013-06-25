package
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	import flinjin.algorithms.camera.Dissolve;
	import flinjin.FjInput;
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
					if ((FjInput.mousePosition.y >= 170) && (FjInput.mousePosition.y <= 260))
					{
						navigateToURL(new URLRequest("http://blog.miriti.ru/?utm_source=fromgame&utm_medium=credits&utm_campaign=Evil%2BSun"));
					}
					else if ((FjInput.mousePosition.y >= 340) && (FjInput.mousePosition.y <= 425))
					{
						navigateToURL(new URLRequest("http://philsitumorang.com/"));
					}
					else
						Flinjin.Instance.Camera.LookBack();
				});
			
			addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void
				{
					Flinjin.Instance.Camera.LookBack();
				});
		}
	
	}

}