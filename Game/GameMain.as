package Game
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.ui.Keyboard;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.FjConsole;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import flinjin.sound.FjSnd;
	import Game.HUD.BlackFade;
	import Game.HUD.ScoreCounter;
	import Game.HUD.WeaponChose;
	import Game.Mobs.Mob;
	import Game.Objects.Factory;
	import Game.Objects.parcticles.FactoryExplosion;
	import mochi.as3.MochiEvents;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameMain extends FjLayer
	{
		public static var Instance:GameMain;
		
		public var ground:Ground = new Ground();
		public var sky:Sky = new Sky();
		public var sun:Sun;
		public var factory:Factory = new Factory();
		public var skyclouds:SkyClouds = new SkyClouds();
		public var weaponChose:WeaponChose;
		public var scenario:GameMainScenario;
		public var upgrades:Upgrades;
		
		private var _shopButton:ShopButton = new ShopButton();
		
		private static var _score:Number = 0;
		private static var _money:Number = 0;
		
		static public var groundLevel:Number = Main.CONTENT_HEIGHT;
		static public var scoreCounter:ScoreCounter;
		static public var gameIsOver:Boolean;
		static public var highScore:Number = 0;
		
		/** collection of created mobs **/
		public var mobsCollection:Vector.<Mob> = new Vector.<Mob>();
		public var deadMobs:Number = 0;
		public var fadeBlack:BlackFade = new BlackFade(false);
		private var _pause:Boolean = false;
		
		private var _fadeMaskSprite:FjSprite = new FjSprite(new (Assets.i().bitmapFadeMask));
		
		private var _raysMaskSprite:FjSprite = new FjSprite(new (Assets.i().bitmapRayMask));
		
		private var _upgragesMode:Boolean = false;
		
		static private const SUN_X:Number = 250;
		static private const SUN_Y:Number = 190;
		
		public function GameMain()
		{
			super(Main.CONTENT_WIDTH, Main.CONTENT_HEIGHT);
			GameMain.Instance = this;
			
			scoreCounter = new ScoreCounter();
			gameIsOver = false;
			
			_score = 0;
			_money = 0;
			
			var scoreSO:SharedObject = SharedObject.getLocal("gameScore");
			if (scoreSO.data.highScore != null)
			{
				highScore = Number(scoreSO.data.highScore);
				GameMainScenario.helpEnabled = scoreSO.data.helpEnabled == undefined ? true : scoreSO.data.helpEnabled;
				scoreSO.data.helpEnabled = false;
			}
			sun = new Sun();
			
			groundLevel = Main.CONTENT_HEIGHT - ground.height + 7;
			addSprite(sky, 0, 0, 1);
			addSprite(_raysMaskSprite, 0, 0, 2);
			
			addSprite(factory, factory.width / 2, Main.CONTENT_HEIGHT - factory.height / 2 - ground.height + 6, 8);
			addSprite(sun, SUN_X, SUN_Y, 5);
			addSprite(skyclouds, 0, 0, 9);
			addSprite(ground, 0, Main.CONTENT_HEIGHT - ground.height, 10);
			addSprite(_fadeMaskSprite, 0, 0, 30);
			
			weaponChose = new WeaponChose();
			
			addSprite(weaponChose, Main.CONTENT_WIDTH - weaponChose.width, groundLevel + 15, 40);
			addSprite(scoreCounter, 10, groundLevel + 25, 50);
			addSprite(_shopButton, (Main.CONTENT_WIDTH - _shopButton.width) / 2, groundLevel + 30, 50);
			
			scoreCounter.text = '$0';
			_shopButton.interactive = true;
			_shopButton.addEventListener(MouseEvent.MOUSE_DOWN, showUpgardes);
			
			scenario = new GameMainScenario();
			upgrades = new Upgrades();
			
			if (GameMainScenario.helpEnabled)
				_shopButton.visible = false;
			
			fadeBlack.interactive = true;
			fadeBlack.addEventListener(MouseEvent.MOUSE_DOWN, fadeBlackMouseDown);
			
			addSprite(fadeBlack, null, null, 99);
			addSprite(upgrades, (width - upgrades.width) / 2, -upgrades.height, 100);
			
			interactive = true;
			
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			MochiEvents.startPlay();
		}
		
		private function fadeBlackMouseDown(e:MouseEvent):void
		{
			upgragesMode = false;
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if ((e.keyCode == Keyboard.U) || (e.keyCode == Keyboard.BACKQUOTE))
			{
				upgragesMode = !upgragesMode;
			}
		}
		
		private function showUpgardes(e:MouseEvent):void
		{
			upgragesMode = true;
		}
		
		override public function Move(deltaTime:Number):void
		{
			if (!_upgragesMode)
			{
				if (!_pause)
				{
					super.Move(deltaTime);
				}
				scenario.update(deltaTime);
			}
			
			fadeBlack.Move(deltaTime);
			upgrades.Move(deltaTime);
			
			if (scoreCounter.alpha > 0.3)
			{
				scoreCounter.alpha -= (deltaTime / 1000) * 0.5;
			}
			
			if ((Instance.upgrades.avail()) && (!Instance.shopButton.avail))
			{
				FjSnd.playSound("upgrade");
				Instance.shopButton.avail = true;
			}
			else
			{
				if ((!Instance.upgrades.avail()) && (Instance.shopButton.avail))
				{
					Instance.shopButton.avail = false;
				}
			}
		}
		
		/**
		 *
		 * @param	e
		 */
		private function onDeleteMob(e:FlinjinSpriteEvent):void
		{
			var index:int;
			mobsCollection.splice(mobsCollection.indexOf(e.target), 1);
			deadMobs++;
		}
		
		public function addMob(mob:Mob):void
		{
			mobsCollection.push(mob);
			mob.addEventListener(FlinjinSpriteEvent.REMOVED_FROM_LAYER, onDeleteMob);
			addSprite(mob, null, null, 4 + mobsCollection.length);
		}
		
		/**
		 * Game over
		 * @todo Make good gameover
		 */
		public function onGameOver():void
		{
			scenario.running = false;
			gameIsOver = true;
			addSprite(new FactoryExplosion(), factory.x, factory.y, factory.zIndex);
			
			for (var i:int = mobsCollection.length - 1; i >= 0; i--)
			{
				mobsCollection[i].die();
			}
			
			if (_score > highScore)
			{
				var scoreSO:SharedObject = SharedObject.getLocal("gameScore");
				scoreSO.data.highScore = _score;
				highScore = _score;
			}
			fadeBlack.removeEventListener(MouseEvent.MOUSE_DOWN, fadeBlackMouseDown);
			fadeBlack.show();
			
			var _gameOverDie:GameOver = new GameOver();
			addSprite(_gameOverDie, (width - _gameOverDie.width) / 2, -_gameOverDie.height * 1.5, 1000);
		}
		
		static public function buy(howMutch:Number):Boolean
		{
			if (_money >= howMutch)
			{
				_money -= howMutch;
				scoreCounter.text = "$" + _money.toString();
				scoreCounter.alpha = 1;
				return true;
			}
			else
				return false;
		}
		
		static public function addScore(add:Number):void
		{
			_score += add;
			_money += add;
			
			scoreCounter.text = "$" + _money.toString();
			scoreCounter.alpha = 1;
		}
		
		public function get upgragesMode():Boolean
		{
			return _upgragesMode;
		}
		
		public function set upgragesMode(value:Boolean):void
		{
			if (value)
			{
				upgrades.show();
				fadeBlack.show();
			}
			else
			{
				upgrades.hide();
				fadeBlack.hide();
			}
			_upgragesMode = value;
		}
		
		public function get shopButton():ShopButton
		{
			return _shopButton;
		}
		
		public function get pause():Boolean
		{
			return _pause;
		}
		
		public function set pause(value:Boolean):void
		{
			_pause = value;
		}
		
		static public function get score():Number
		{
			return _score;
		}
		
		static public function get money():Number
		{
			return _money;
		}
	}
}
import flash.geom.Point;
import flinjin.graphics.FjSprite;
import flinjin.graphics.FjSpriteAnimation;

class ShopButton extends FjSprite
{
	[Embed(source="../_assets/bmp/hud/shop-button-141x60.png")]
	private static var _buttonBitmap:Class;
	
	private var _avail:Boolean = false;
	
	public function ShopButton():void
	{
		super(new _buttonBitmap(), null, new Point(141, 60), new FjSpriteAnimation());
		animation.stop();
		avail = false;
	}
	
	public function get avail():Boolean
	{
		return _avail;
	}
	
	public function set avail(value:Boolean):void
	{
		if (value)
			animation.play();
		else
		{
			animation.stop();
			currentFrame = 1;
		}
		_avail = value;
	}
}