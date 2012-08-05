package
{
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import Game.GameMain;
	import Game.HUD.BlackFade;
	import Game.Rounds.MenuDummyRound;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Menu extends FjLayer
	{
		private var _dummyGame:GameMain;
		private var _fade:BlackFade = new BlackFade(false);
		private var _menuLayer:MenuLayer = new MenuLayer();
		
		public function Menu()
		{
			super(Main.CONTENT_WIDTH, Main.CONTENT_HEIGHT);
			_dummyGame = new GameMain();
			_dummyGame.interactive = false;
			_dummyGame.scenario.startRound(new MenuDummyRound());
			
			addSprite(_dummyGame);
			addSprite(_fade);
			addSprite(_menuLayer, (width - _menuLayer.width) / 2, (height - _menuLayer.height) / 2);
			
			_fade.show();
		}
	}
}
import flash.events.MouseEvent;
import flash.geom.Point;
import flinjin.algorithms.camera.Dissolve;
import flinjin.Flinjin;
import flinjin.graphics.FjLayer;
import flinjin.graphics.FjSprite;
import Game.HUD.Button;
import Game.HUD.ButtonSwitch;
import Game.HUD.MusicButton;
import Game.HUD.SoundButton;

class MenuLayer extends FjLayer
{
	[Embed(source="_assets/bmp/menu/start-140x57.png")]
	private static var _bitmapStart:Class;
	
	[Embed(source="_assets/bmp/menu/scores-176x57.png")]
	private static var _bitmapScores:Class;
	
	[Embed(source="_assets/bmp/menu/more-games-272x57.png")]
	private static var _bitmapMoreGames:Class;
	
	[Embed(source="_assets/bmp/menu/music-67x69.png")]
	private static var _bitmapMusic:Class;
	
	[Embed(source="_assets/bmp/menu/sound-83x71.png")]
	private static var _bitmapSound:Class;
	
	private var _buttonStart:Button = new Button(new _bitmapStart(), null, new Point(140, 57));
	private var _buttonScores:Button = new Button(new _bitmapScores(), null, new Point(176, 57));
	private var _buttonMoreGames:Button = new Button(new _bitmapMoreGames(), null, new Point(272, 57));
	
	private var _buttonMusc:ButtonSwitch = new MusicButton();
	private var _buttonSound:ButtonSwitch = new SoundButton();
	
	private var _menuBg:FjSprite = new FjSprite(new Assets.bitmapShopBack());
	private var _gotoStart:Boolean = false;
	
	function MenuLayer():void
	{
		super(_menuBg.width, _menuBg.height);
		interactive = true;
		addSprite(_menuBg);
		
		addSprite(_buttonStart, (width - _buttonStart.width) / 2, 50);
		addSprite(_buttonScores, (width - _buttonScores.width) / 2, 120);
		
		addSprite(_buttonMusc, (width / 2) - _buttonMusc.width - 20, 220);
		addSprite(_buttonSound, (width / 2) + 20, 220);
		
		addSprite(_buttonMoreGames, (width - _buttonMoreGames.width) / 2, height - 107);
		
		_buttonStart.addEventListener(MouseEvent.MOUSE_DOWN, onStartMouseDown);
	}
	
	private function onStartMouseDown(e:MouseEvent):void
	{
		if (!_gotoStart)
		{
			interactive = false;
			_gotoStart = true;
		}
		//Flinjin.Instance.Camera.LookAt(new Game.GameMain());
	}
	
	override public function Move(deltaTime:Number):void
	{
		super.Move(deltaTime);
		
		if (_gotoStart)
		{
			if (y >= Main.CONTENT_HEIGHT)
			{
				Flinjin.Instance.Camera.LookAt(new Game.GameMain());
				return;
			}
			y += 600 * s(deltaTime);
		}
	}
}