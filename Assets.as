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
		/*****************
		 * B I T M A P S *
		 *****************/
		[Embed(source="_assets/bmp/hud/shop_back.png")]
		static public var bitmapShopBack:Class;
		
		[Embed(source="_assets/bmp/new mask.png")]
		static public var bitmapFadeMask:Class;
		
		/***************
		 * S O U N D S *
		 ***************/
		[Embed(source="_assets/snd/music/evilsun-original.mp3")]
		static public var musicMain:Class;
		
		// Bonus
		[Embed(source="_assets/snd/bounus.mp3")]
		static public var soundBonus:Class;
		
		[Embed(source="_assets/snd/pack/weapon-disabled.mp3")]
		static public var soundError:Class;
		
		[Embed(source="_assets/snd/explosion2.mp3")]
		static public var soundExplosion2:Class;
		
		[Embed(source="_assets/snd/fire.mp3")]
		static public var soundFire:Class;
		
		[Embed(source="_assets/snd/pack/shot-low.mp3")]
		static public var soundFireball:Class;
		
		[Embed(source="_assets/snd/pack/fly-trail.mp3")]
		static public var soundFireballFly:Class;
		
		[Embed(source="_assets/snd/hit.mp3")]
		static public var soundHit:Class;
		
		[Embed(source="_assets/snd/laser2.mp3")]
		static public var soundLaser2:Class;
		
		[Embed(source="_assets/snd/machine.mp3")]
		static public var soundMachineGun:Class;
		
		[Embed(source="_assets/snd/menu/click.mp3")]
		static public var soundMenuClick:Class;
		
		[Embed(source="_assets/snd/menu/hover.mp3")]
		static public var soundMenuHover:Class;
		
		// Rocket
		[Embed(source="_assets/snd/rocket.mp3")]
		static public var soundRocket:Class;
		
		[Embed(source="_assets/snd/pack/shot-high.mp3")]
		static public var soundRay:Class;
		
		// Shot
		[Embed(source="_assets/snd/shot.mp3")]
		static public var soundShot:Class;
		
		[Embed(source="_assets/snd/pack/shot-shotgun.mp3")]
		static public var soundShotgun:Class;
		
		[Embed(source="_assets/snd/start-game.mp3")]
		static public var soundStartGame:Class;
		
		// Strike
		[Embed(source="_assets/snd/strike.mp3")]
		static public var soundStrike:Class;
		
		[Embed(source="_assets/snd/upgrade.mp3")]
		static public var soundUpgdrade:Class;
		
		[Embed(source="_assets/snd/pack/weapon-select.mp3")]
		static public var soundWeaponSelect:Class;
		
		/********
		 * FONTS
		 ********/
		
		[Embed(source="_assets/fonts/AlphaFridgeMagnets.ttf",fontName='gameFont',mimeType="application/x-font",fontWeight="normal",fontStyle="normal",advancedAntiAliasing="true",embedAsCFF="false")]
		static public var gameFont1:Class;
	}
}