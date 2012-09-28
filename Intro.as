package
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flinjin.Flinjin;
	import flinjin.graphics.Layer;
	import flinjin.graphics.Sprite;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Intro extends Layer
	{
		[Embed(source="bmp/intro/flinjin-logo.png")]
		private static var _FjLogoBitmap:Class;
		private static var _FjLogoSprite:Sprite = new Sprite(new _FjLogoBitmap());
		
		private var _counter:int = 0;
		
		public function Intro()
		{
			FillColor = 0xff000000;
			super(Flinjin.sceneWidth, Flinjin.sceneHeight);
			
			_FjLogoSprite.setCenterInBitmapCenter();
			_FjLogoSprite.alpha = 0;
			
			addSprite(_FjLogoSprite, width / 2, height / 2);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		override public function update():void
		{
			if (_counter >= 180)
			{
				startMenu();
				return;
			}
			
			if (_counter < 60)
			{
				_FjLogoSprite.alpha = _counter / 60;
			}
			
			if (_counter > 120)
			{
				_FjLogoSprite.alpha = 1 - ((_counter - 120) / 60);
			}
			
			_counter++;
			super.update();
		}
		
		private function startMenu():void
		{
			Flinjin.Instance.Camera.LookAt(new Menu());
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if ((e.keyCode = Keyboard.ENTER) || (e.keyCode = Keyboard.SPACE))
			{
				startMenu();
			}
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			var flinjinUrl:URLRequest = new URLRequest("http://www.flinjin.com/?utm_source=ingame&utm_medium=intro&utm_campaign=" + encodeURIComponent(Flinjin.applicationName));			
			navigateToURL(flinjinUrl);
		}
	
	}

}