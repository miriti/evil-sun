package
{
	import flinjin.graphics.FjSprite;
	
	/**
	 * Assets of the Game
	 *
	 * @author Michael Miriti
	 */
	public class Assets
	{
		private static var _instance:Assets = null;
		
		public static function i():Assets
		{
			if (_instance == null)
				_instance = new Assets();
			
			return _instance;
		}
		
		/*****************
		 * B I T M A P S *
		 *****************/
		[Embed(source="_assets/bmp/hud/shop/back-to-menu-238x51.png")]
		static public var bitmapBackmenuButton:Class;
		
		[Embed(source="_assets/bmp/hud/shop_back.png")]
		public var bitmapShopBack:Class;
		
		[Embed(source="_assets/bmp/new mask.png")]
		public var bitmapFadeMask:Class;
		
		[Embed(source="_assets/bmp/back-rays.png")]
		public var bitmapRayMask:Class;
		
		[Embed(source="_assets/bmp/hud/crosshair-79x78.png")]
		public var bitmapCrosshair:Class;
		
		[Embed(source="_assets/bmp/hud/paused.png")]
		public var bitmapPaused:Class;
		
		/***************
		 * S O U N D S *
		 ***************/
		[Embed(source="_assets/snd/music/evilsun-original.mp3")]
		public var musicMain:Class;
		
		// Bonus
		[Embed(source="_assets/snd/bounus.mp3")]
		public var soundBonus:Class;
		
		[Embed(source="_assets/snd/pack/weapon-disabled.mp3")]
		public var soundError:Class;
		
		[Embed(source="_assets/snd/explosion2.mp3")]
		public var soundExplosion2:Class;
		
		[Embed(source="_assets/snd/fire.mp3")]
		public var soundFire:Class;
		
		[Embed(source="_assets/snd/pack/shot-low.mp3")]
		public var soundFireball:Class;
		
		[Embed(source="_assets/snd/pack/fly-trail.mp3")]
		public var soundFireballFly:Class;
		
		[Embed(source="_assets/snd/hit.mp3")]
		public var soundHit:Class;
		
		[Embed(source="_assets/snd/laser2.mp3")]
		public var soundLaser2:Class;
		
		[Embed(source="_assets/snd/machine.mp3")]
		public var soundMachineGun:Class;
		
		[Embed(source="_assets/snd/menu/click.mp3")]
		public var soundMenuClick:Class;
		
		[Embed(source="_assets/snd/menu/hover.mp3")]
		public var soundMenuHover:Class;
		
		// Rocket
		[Embed(source="_assets/snd/rocket.mp3")]
		public var soundRocket:Class;
		
		[Embed(source="_assets/snd/pack/shot-high.mp3")]
		public var soundRay:Class;
		
		// Shot
		[Embed(source="_assets/snd/shot.mp3")]
		public var soundShot:Class;
		
		[Embed(source="_assets/snd/pack/shot-shotgun.mp3")]
		public var soundShotgun:Class;
		
		[Embed(source="_assets/snd/start-game.mp3")]
		public var soundStartGame:Class;
		
		// Strike
		[Embed(source="_assets/snd/strike.mp3")]
		public var soundStrike:Class;
		
		[Embed(source="_assets/snd/upgrade.mp3")]
		public var soundUpgdrade:Class;
		
		[Embed(source="_assets/snd/pack/weapon-select.mp3")]
		public var soundWeaponSelect:Class;
		
		/********
		 * FONTS
		 ********/
		
		[Embed(source="_assets/fonts/AlphaFridgeMagnets.ttf",fontName='gameFont',mimeType="application/x-font",fontWeight="normal",fontStyle="normal",advancedAntiAliasing="true",embedAsCFF="false")]
		public var gameFont1:Class;
	}
}