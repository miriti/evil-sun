package
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flinjin.Flinjin;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import Game.GameMain;
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
		
		/*[Embed(source="_assets/bmp/menu/more-games-383x92.png")]
		   static private var _btnMoreGamesBmp:Class;
		 private var _btnMoreGames:Button = new Button(new _btnMoreGamesBmp(), null, new Point(383, 92)).setCenter() as Button;*/
		
		[Embed(source="_assets/bmp/menu/achievements-443x92.png")]
		static private var _btnAchievementsBmp:Class;
		private var _btnAchievemtns:Button = new Button(new _btnAchievementsBmp(), null, new Point(443, 92)).setCenter() as Button;
		
		[Embed(source="_assets/bmp/menu/credits-270x92.png")]
		static private var _btnCreditsBmp:Class;
		private var _btnCredits:Button = new Button(new _btnCreditsBmp(), null, new Point(270, 92)).setCenter() as Button;
		
		public function Menu()
		{
			super(Main.CONTENT_WIDTH, Main.CONTENT_HEIGHT);
			
			addSprite(_menuBack);
			addSprite(_clouds);
			
			addSprite(new FjSprite(new (Assets.i().bitmapFadeMask)));
			
			addSprite(_btnStart, width / 2, 100);
			addSprite(_btnScores, width / 2, 190);
			addSprite(_btnMusic, width / 2 - _btnMusic.width / 2 - 20, 280);
			addSprite(_btnSound, width / 2 + _btnSound.width / 2 + 20, 280);
			//addSprite(_btnMoreGames, width / 2, 370);
			addSprite(_btnAchievemtns, width / 2, 370);
			addSprite(_btnCredits, width / 2, 460);
			
			_btnStart.addEventListener(MouseEvent.MOUSE_DOWN, onStartBtn);
			_btnScores.addEventListener(MouseEvent.MOUSE_DOWN, onScoresBtn);
			_btnAchievemtns.addEventListener(MouseEvent.MOUSE_DOWN, onAchievementsBtn);
			_btnCredits.addEventListener(MouseEvent.MOUSE_DOWN, onCreditsBtn);
		}
		
		private function onAchievementsBtn(e:MouseEvent):void
		{
			Main.gb_api.gb_ShowAchievements(function():void
				{
				});
		}
		
		private function onCreditsBtn(e:MouseEvent):void
		{
			_btnCredits.mouseDown = false;
			if (!(Flinjin.Instance.Camera.scene is CreditsScreen))
				Flinjin.Instance.Camera.LookAt(new CreditsScreen());
		}
		
		private function mochiScores():void
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
		
		private function gameButlersScores():void
		{
			Main.gb_api.gb_ShowScores("evilsun_gb781CbdSgb76829854G", function():void
				{
				});
		}
		
		private function onScoresBtn(e:MouseEvent):void
		{
			gameButlersScores();
		}
		
		private function onHostThisGame(e:MouseEvent):void
		{
			var hostUrl:URLRequest = new URLRequest('http://www.flinjin.com/p/evil-sun.html?utm_source=ingame&utm_medium=hostthisgame&utm_campaign=Evil%2BSun');
			navigateToURL(hostUrl, "_blank");
		}
		
		private function onStartBtn(e:MouseEvent):void
		{
			Mouse.hide();
			Flinjin.Instance.Camera.LookAt(new GameMain());
		}
	}
}