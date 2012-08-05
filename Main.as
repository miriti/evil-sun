package
{
	import flinjin.algorithms.camera.Dissolve;
	import flinjin.events.FlinjinEvent;
	import flinjin.Flinjin;
	import flinjin.FjLog;
	import flinjin.graphics.FjSprite;
	import flinjin.sound.FjSnd;
	import flinjin.sound.FjSndItem;
	import Game.GameMain;
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
		static public const MOCHI_BOT_ID:String = "6c617154";
		
		/**
		 * Application entry point
		 *
		 */
		public function Main():void
		{
			super(SCENE_WIDTH, SCENE_HEIGHT);
			contextMenuAddItem("Credits", _showCredits);
			FjSprite.SharpBlitting = false;
			FjSprite.Smoothing = true;
			
			_initSounds();
			addEventListener(FlinjinEvent.ENGINE_STARTUP, onEngineStartup);
		
			// TODO add on release
			//MochiBot.track(this, MOCHI_BOT_ID);
		}
		
		private function _showCredits():void
		{
			if (!(Camera.scene is CreditsScreen))
				Camera.LookAt(new CreditsScreen());
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
		 * Init sounds
		 *
		 */
		private function _initSounds():void
		{
			FjSnd.addSound(new Assets.soundBonus,			'bonus',		['sound']);
			FjSnd.addSound(new Assets.soundError,			'error',		['sound']);
			FjSnd.addSound(new Assets.soundExplosion2,		'explosion',	['sound']);
			FjSnd.addSound(new Assets.soundFire,			'fire',			['sound']);
			FjSnd.addSound(new Assets.soundFireball,		'fireball',		['sound']);
			FjSnd.addSound(new Assets.soundHit,			'hit',			['sound']);
			FjSnd.addSound(new Assets.soundLaser2,			'laser',		['sound']);
			FjSnd.addSound(new Assets.soundMachineGun,		'machine-gun',	['sound']);
			FjSnd.addSound(new Assets.soundMenuItem,		'menu-item',	['sound']);
			FjSnd.addSound(new Assets.soundRay,			'ray',			['sound']);
			FjSnd.addSound(new Assets.soundRocket,			'rocket',		['sound']);
			FjSnd.addSound(new Assets.soundShot,			'shot',			['sound']);
			FjSnd.addSound(new Assets.soundShotgun,		'shotgun',		['sound']);
			FjSnd.addSound(new Assets.soundStrike,			'strike',		['sound']);
			FjSnd.addSound(new Assets.soundStartGame,		'start-game',	['sound']);
			FjSnd.addSound(new Assets.soundUpgdrade,		'upgrade',		['sound']);
		}
		
		/**
		 * Engine startup
		 *
		 * @param	e
		 */
		private function onEngineStartup(e:FlinjinEvent):void
		{
			// connect to Mochi Service
			// TODO add on release
			// MochiServices.connect(MOCHI_GAME_ID, stage, onMochiConnectError);
			
			// TODO Change to Intro (if present) it in release
			
			Camera.zoom = SCENE_WIDTH / CONTENT_WIDTH;
			Camera.LookAt(new Menu());
		}
	}
}