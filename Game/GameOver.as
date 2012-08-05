package Game
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flinjin.Flinjin;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import Game.HUD.Button;
	
	/**
	 * @author Michael Miriti
	 */
	public class GameOver extends FjLayer
	{
		private var _backSpt:FjSprite = new FjSprite(new Assets.bitmapShopBack());
		
		[Embed(source="../_assets/bmp/hud/gameover/highscore-293x56.png")]
		private static var _bmpHighscore:Class;
		private var _highscoreButton:Button = new Button(new _bmpHighscore(), null, new Point(293, 56), new FjSpriteAnimation());
		
		[Embed(source="../_assets/bmp/hud/gameover/yourscore-293x56.png")]
		private static var _bmpYourScore:Class;
		private var _yourscoreButton:Button = new Button(new _bmpYourScore(), null, new Point(293, 56), new FjSpriteAnimation());
		
		[Embed(source="../_assets/bmp/hud/gameover/submit-168x56.png")]
		private static var _bmpSubmit:Class;
		private var _submitButton:Button = new Button(new _bmpSubmit(), null, new Point(168, 56), new FjSpriteAnimation());
		
		[Embed(source="../_assets/bmp/hud/gameover/back-menu-249x57.png")]
		private static var _bmpBacktoMenu:Class;
		private var _backToMenuButton:Button = new Button(new _bmpBacktoMenu(), null, new Point(249, 57), new FjSpriteAnimation());
		
		[Embed(source="../_assets/bmp/hud/gameover/play-again-180x145.png")]
		private static var _bmpPlayAgain:Class;
		private var _playAgainButton:Button = new Button(new _bmpPlayAgain(), null, new Point(180, 145), new FjSpriteAnimation());
		
		/**
		 * 
		 */
		public function GameOver()
		{
			super(_backSpt.width, _backSpt.height);
			
			interactive = true;
			
			addSprite(_backSpt);
			
			_highscoreButton.setCenter();
			_highscoreButton.interactive = false;
			
			_yourscoreButton.setCenter();
			_yourscoreButton.interactive = false;
			
			_submitButton.setCenter();
			_submitButton.inactiveFrame = 1;
			_submitButton.activeFrame = 0;
			_submitButton.addEventListener(MouseEvent.MOUSE_DOWN, onSubmit);
			
			_backToMenuButton.setCenter();
			_backToMenuButton.inactiveFrame = 1;
			_backToMenuButton.activeFrame = 0;
			_backToMenuButton.addEventListener(MouseEvent.MOUSE_DOWN, onBackMenu);
			
			_playAgainButton.inactiveFrame = 1;
			_playAgainButton.activeFrame = 0;
			_playAgainButton.addEventListener(MouseEvent.MOUSE_DOWN, onPlayAgain);
			
			addSprite(_highscoreButton, 210, 80);
			addSprite(_yourscoreButton, 210, 165);
			addSprite(_submitButton, 210, 250);
			addSprite(_backToMenuButton, 210, 335);
			addSprite(_playAgainButton, width - _playAgainButton.width - 60, height - _playAgainButton.height - 60);
		}
		
		private function onPlayAgain(e:MouseEvent):void 
		{
			Flinjin.Instance.Camera.LookAt(new GameMain());
		}
		
		private function onBackMenu(e:MouseEvent):void 
		{
			Flinjin.Instance.Camera.LookAt(new Menu());
		}
		
		private function onSubmit(e:MouseEvent):void 
		{
			// TODO submit to mochi
			trace("TODO");
		}
		
		/**
		 * 
		 * @param	deltaTime
		 */
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			
			var _gY:Number = (Main.CONTENT_HEIGHT - height) / 2;
			
			if (y < _gY)
			{
				y += s(deltaTime) * 1000;
				
				if (y > _gY)
					y = _gY;
			}
		}
	}
}