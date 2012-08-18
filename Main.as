package
{
	import flash.events.Event;
	import flash.net.LocalConnection;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flinjin.events.FlinjinEvent;
	import flinjin.FjLog;
	import flinjin.Flinjin;
	import flinjin.graphics.FjSprite;
	import flinjin.sound.FjSnd;
	import flinjin.sound.FjSndItem;
	import mochi.as3.MochiServices;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	[Frame(factoryClass="Preloader")]
	
	public class Main extends Flinjin
	{
		static public const CONTENT_WIDTH:Number = 1024;
		static public const CONTENT_HEIGHT:Number = 576;
		
		static public const SCENE_WIDTH:Number = 1024;
		static public const SCENE_HEIGHT:Number = 576;
		
		static public const MOCHI_GAME_ID:String = "d8ba1df8df94d299";
		static public const MOCHI_BOARD_ID:String = "f09d6ecd6cdc3493";
		static public const MOCHI_BOT_ID:String = "6c617154";
		
		static public var Music:FjSndItem = new FjSndItem(new (Assets.i().musicMain));
		
		private static var _lockedDomains:Array = ['miriti.ru', 'fgl.com', 'www.fgl.com', 'flashgamelicense.com', 'www.flashgamelicense.com'];
		private var _lockedState:Boolean = false;
		
		/**
		 * Application entry point
		 *
		 */
		public function Main():void
		{
			super(SCENE_WIDTH, SCENE_HEIGHT);
			
			var nc:LocalConnection = new LocalConnection();
			
			FjLog.l("domain: " + nc.domain);
			
			if (_lockedDomains.indexOf(nc.domain) != -1)
			{
				contextMenuAddItem("Credits", _showCredits);
				FjSprite.SharpBlitting = false;
				FjSprite.Smoothing = true;
				
				_initSounds();
				addEventListener(FlinjinEvent.ENGINE_STARTUP, onEngineStartup);
			}
			else
			{
				_lockedState = true;
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var _locked:TextField = new TextField();
			_locked.text = "You can not run game on this domain. Sorry.";
			_locked.autoSize = TextFieldAutoSize.LEFT;
			_locked.setTextFormat(new TextFormat(null, 40, 0xff0000, true));
			_locked.x = (width - _locked.width) / 2;
			_locked.y = (height - _locked.height) / 2;
			addChild(_locked);
		}
		
		private function _showCredits():void
		{
			if (!(Camera.scene is CreditsScreen))
				Camera.LookAt(new CreditsScreen());
		}
		
		/**
		 * Init sounds
		 *
		 */
		private function _initSounds():void
		{
			FjSnd.addSound(new (Assets.i().soundBonus), 'bonus', ['sound']);
			FjSnd.addSound(new (Assets.i().soundError), 'error', ['sound']);
			FjSnd.addSound(new (Assets.i().soundExplosion2), 'explosion', ['sound']);
			FjSnd.addSound(new (Assets.i().soundFire), 'fire', ['sound']);
			FjSnd.addSound(new (Assets.i().soundFireball), 'fireball', ['sound']);
			FjSnd.addSound(new (Assets.i().soundFireballFly), 'fireball-fly', ['sound']);
			FjSnd.addSound(new (Assets.i().soundHit), 'hit', ['sound']);
			FjSnd.addSound(new (Assets.i().soundLaser2), 'laser', ['sound']);
			FjSnd.addSound(new (Assets.i().soundMachineGun), 'machine-gun', ['sound']);
			FjSnd.addSound(new (Assets.i().soundMenuHover), 'menu-hover', ['sound']);
			FjSnd.addSound(new (Assets.i().soundMenuClick), 'menu-click', ['sound']);
			FjSnd.addSound(new (Assets.i().soundRay), 'ray', ['sound']);
			FjSnd.addSound(new (Assets.i().soundRocket), 'rocket', ['sound']);
			FjSnd.addSound(new (Assets.i().soundShot), 'shot', ['sound']);
			FjSnd.addSound(new (Assets.i().soundShotgun), 'shotgun', ['sound']);
			FjSnd.addSound(new (Assets.i().soundStrike), 'strike', ['sound']);
			FjSnd.addSound(new (Assets.i().soundStartGame), 'start-game', ['sound']);
			FjSnd.addSound(new (Assets.i().soundUpgdrade), 'upgrade', ['sound']);
			FjSnd.addSound(new (Assets.i().soundWeaponSelect), 'weapon-select', ['sound']);
		}
		
		/**
		 * Something wrong with Mochi connection
		 *
		 * @param	status
		 */
		private function onMochiConnectError(status:String):void
		{
			FjLog.l("Mochi connection error: " + status);
		}
		
		/**
		 * Engine startup
		 *
		 * @param	e
		 */
		private function onEngineStartup(e:FlinjinEvent):void
		{
			MochiServices.connect(Main.MOCHI_GAME_ID, root, onMochiConnectError);
			Camera.LookAt(new Menu());
			Music.loop = true;
			Music.volume = 0.3;
			Music.play();
		}
	}
}