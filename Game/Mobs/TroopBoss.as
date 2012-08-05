package Game.Mobs
{
	import flash.geom.Point;
	import flinjin.graphics.Sprite;
	import flinjin.graphics.SpriteAnimation;
	import flinjin.sound.FlinjinSoundCollection;
	import Game.Balance;
	import Game.GameMain;
	import Game.Objects.parcticles.HippieExplosion;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class TroopBoss extends Mob
	{
		static public const ANIM_SCALE:Number = 3;
		[Embed(source="../../_assets/bmp/mobs/troop/troop_anim.png")]
		private static var _animBitmap:Class;
		
		private var _anim:Sprite = new Sprite(new _animBitmap(), null, new Point(39, 67), new SpriteAnimation("moving", null, 100, true))
		private var _dead:Boolean;
		
		public function TroopBoss()
		{
			super(_anim.width * ANIM_SCALE, _anim.height * ANIM_SCALE);
			_anim.scale = ANIM_SCALE;
			_anim.animation.speed = 300;
			addSprite(_anim);
			_healthPoints = Balance.troopBossHealth;
			_healthPointsMax = Balance.troopBossHealth;
			_speed = Balance.troopBossSpeed;
			_score = Balance.troopBossScore;
			_explosionDamage = Balance.troopBossExplosionDamage;
		}
		
		override protected function _explode():void
		{
			(parent as GameMain).addSprite(new HippieExplosion(), x - width / 3, y - height / 3, zIndex);
			(parent as GameMain).addSprite(new HippieExplosion(), x + width / 3, y - height / 3, zIndex);
			(parent as GameMain).addSprite(new HippieExplosion(), x + width / 3, y + height / 3, zIndex);
			(parent as GameMain).addSprite(new HippieExplosion(), x - width / 3, y + height / 3, zIndex);
			(parent as GameMain).addSprite(new HippieExplosion(), x, y, zIndex);
			FlinjinSoundCollection.playSound("explosion");
			Delete();
		}
	}

}