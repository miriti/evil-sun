package Game
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flinjin.Flinjin;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import flinjin.graphics.FjSpriteText;
	import Game.HUD.Button;
	import mochi.as3.MochiScores;
	
	/**
	 * @author Michael Miriti
	 */
	public class GameOver extends FjLayer
	{
		private var _backSpt:FjSprite = new FjSprite(new (Assets.i().bitmapShopBack));
		
		[Embed(source="../_assets/bmp/hud/gameover/highscore-293x56.png")]
		private static var _bmpHighscore:Class;
		private var _highscoreButton:Button = new Button(new _bmpHighscore(), null, new Point(293, 56), new FjSpriteAnimation());
		
		[Embed(source="../_assets/bmp/hud/gameover/yourscore-293x56.png")]
		private static var _bmpYourScore:Class;
		private var _yourscoreButton:Button = new Button(new _bmpYourScore(), null, new Point(293, 56), new FjSpriteAnimation());
		
		[Embed(source="../_assets/bmp/hud/gameover/submit-168x56.png")]
		private static var _bmpSubmit:Class;
		private var _submitButton:Button = new Button(new _bmpSubmit(), null, new Point(168, 56), new FjSpriteAnimation());
		
		[Embed(source="../_assets/bmp/hud/shop/back-to-menu-238x51.png")]
		private static var _bmpBacktoMenu:Class;
		private var _backToMenuButton:Button = new Button(new _bmpBacktoMenu(), null, new Point(238, 51), new FjSpriteAnimation());
		
		[Embed(source="../_assets/bmp/hud/gameover/play-again-180x145.png")]
		private static var _bmpPlayAgain:Class;
		private var _playAgainButton:Button = new Button(new _bmpPlayAgain(), null, new Point(180, 145), new FjSpriteAnimation());
		
		private var _highScoretxt:FjSpriteText = new FjSpriteText("0", new TextFormat("gameFont", 52, 0xffe090));
		private var _yourScoretxt:FjSpriteText = new FjSpriteText("0", new TextFormat("gameFont", 50, 0xffe090));
		
		/**
		 *
		 */
		public function GameOver()
		{
			super(_backSpt.width, _backSpt.height);
			
			addSprite(_backSpt);
			
			_highscoreButton.setCenter();
			_highscoreButton.interactive = false;
			
			_yourscoreButton.setCenter();
			_yourscoreButton.interactive = false;
			
			if (GameMain.highScore == GameMain.score)
			{
				_submitButton.setCenter();
				_submitButton.inactiveFrame = 1;
				_submitButton.activeFrame = 0;
				_submitButton.addEventListener(MouseEvent.MOUSE_DOWN, onSubmit);
			}
			
			_backToMenuButton.setCenter();
			_backToMenuButton.addEventListener(MouseEvent.MOUSE_DOWN, onBackMenu);
			
			_playAgainButton.inactiveFrame = 1;
			_playAgainButton.activeFrame = 0;
			_playAgainButton.addEventListener(MouseEvent.MOUSE_DOWN, onPlayAgain);
			
			_highScoretxt.text = GameMain.highScore.toString();
			_highScoretxt.alpha = 0.5;
			
			_yourScoretxt.text = GameMain.score.toString();
			
			addSprite(_highscoreButton, 210, 80);
			addSprite(_highScoretxt, width / 2 + 20, 80 - _highScoretxt.height / 2);
			addSprite(_yourscoreButton, 210, 165);
			addSprite(_yourScoretxt, width / 2 + 20, 165 - _yourScoretxt.height / 2);
			if (GameMain.highScore == GameMain.score)
				addSprite(_submitButton, 210, 250);
			addSprite(_backToMenuButton, 210, 335);
			addSprite(_playAgainButton, width - _playAgainButton.width - 60, height - _playAgainButton.height - 60);
			
			interactive = true;
		}
		
		private function onPlayAgain(e:MouseEvent):void
		{
			GameMainScenario.helpEnabled = false;
			Flinjin.Instance.Camera.LookAt(new GameMain());
		}
		
		private function onBackMenu(e:MouseEvent):void
		{
			Mouse.show();
			Flinjin.Instance.Camera.LookAt(new Menu());
		}
		
		private function onSubmit(e:MouseEvent):void
		{
			var o:Object = {n: [15, 0, 9, 13, 6, 14, 12, 13, 6, 12, 13, 12, 3, 4, 9, 3], f: function(i:Number, s:String):String
				{
					if (s.length == 16)
						return s;
					return this.f(i + 1, s + this.n[i].toString(16));
				}};
			var boardID:String = o.f(0, "");
			MochiScores.showLeaderboard({boardID: boardID, score: GameMain.score});
			_submitButton.visible = false;
		}
		
		/**
		 *
		 * @param	deltaTime
		 */
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			var _gY:Number = (Main.CONTENT_HEIGHT - height) / 2;
			
			if (y < _gY)
			{
				y += s(deltaTime) * 500;
				
				if (y > _gY)
				{
					y = _gY;
					interactive = true;
				}
			}
		}
	}
}