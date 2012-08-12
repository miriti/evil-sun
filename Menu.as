package
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flinjin.Flinjin;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import Game.GameMain;
	import Game.HUD.BlackFade;
	import Game.HUD.Button;
	import Game.HUD.MainMenu.MMMusicButton;
	import Game.HUD.MainMenu.MMSoundButton;
	import Game.SkyClouds;
	import mochi.as3.MochiScores;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Menu extends FjLayer
	{
		[Embed(source="_assets/bmp/menu/main_menu_back.jpg")]
		private static var _backBitmap:Class;
		private var _menuBack:FjSprite = new FjSprite(new _backBitmap());
		private var _clouds:SkyClouds = new SkyClouds();
		
		[Embed(source="_assets/bmp/menu/start-206x92.png")]
		static private var _btnStartBmp:Class;
		private var _btnStart:Button = new Button(new _btnStartBmp(), null, new Point(206, 92)).setCenter() as Button;
		
		[Embed(source="_assets/bmp/menu/scores-251x92.png")]
		static private var _btnScoresBmp:Class;
		private var _btnScores:Button = new Button(new _btnScoresBmp(), null, new Point(251, 92)).setCenter() as Button;
		
		private var _btnMusic:MMMusicButton = new MMMusicButton().setCenter() as MMMusicButton;
		private var _btnSound:MMSoundButton = new MMSoundButton().setCenter() as MMSoundButton;
		
		[Embed(source="_assets/bmp/menu/more-games-383x92.png")]
		static private var _btnMoreGamesBmp:Class;
		private var _btnMoreGames:Button = new Button(new _btnMoreGamesBmp(), null, new Point(383, 92)).setCenter() as Button;
		
		[Embed(source="_assets/bmp/menu/host-this-game-481x92.png")]
		static private var _btnHostThisGameBmp:Class;
		private var _btnHostThisGame:Button = new Button(new _btnHostThisGameBmp(), null, new Point(481, 92)).setCenter() as Button;
		
		public function Menu()
		{
			super(Main.CONTENT_WIDTH, Main.CONTENT_HEIGHT);
			
			addSprite(_menuBack);
			addSprite(_clouds);
			
			addSprite(_btnStart, width / 2, 100);
			addSprite(_btnScores, width / 2, 190);
			addSprite(_btnMusic, width / 2 - _btnMusic.width / 2 - 20, 280);
			addSprite(_btnSound, width / 2 + _btnSound.width / 2 + 20, 280);
			addSprite(_btnMoreGames, width / 2, 370);
			addSprite(_btnHostThisGame, width / 2, 460);
			
			_btnStart.addEventListener(MouseEvent.MOUSE_DOWN, onStartBtn);
			_btnScores.addEventListener(MouseEvent.MOUSE_DOWN, onScoresBtn);
			_btnHostThisGame.addEventListener(MouseEvent.MOUSE_DOWN, onHostThisGame);
		}
		
		private function onScoresBtn(e:MouseEvent):void
		{
			var o:Object = {n: [15, 0, 9, 13, 6, 14, 12, 13, 6, 12, 13, 12, 3, 4, 9, 3], f: function(i:Number, s:String):String
				{
					if (s.length == 16)
						return s;
					return this.f(i + 1, s + this.n[i].toString(16));
				}};
			var boardID:String = o.f(0, "");
			MochiScores.showLeaderboard({boardID: boardID});
		}
		
		private function onHostThisGame(e:MouseEvent):void
		{
			var hostUrl:URLRequest = new URLRequest('http://www.flinjin.com/p/evil-sun.html?utm_source=ingame&utm_medium=moregames&utm_campaign=Evil%2BSun');
			navigateToURL(hostUrl, "_blank");
		}
		
		private function onStartBtn(e:MouseEvent):void
		{
			Flinjin.Instance.Camera.LookAt(new GameMain());
		}
	}
}