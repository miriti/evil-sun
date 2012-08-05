package Game.Mobs
{
	import flash.geom.Point;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import flinjin.sound.FjSnd;
	import Game.Balance;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class BTR extends Mob
	{
		static public const SHOT_DELAY:Number = 500;
		[Embed(source="../../_assets/bmp/mobs/btr/btr-anim-73x48.png")]
		private static var _animBitmap:Class;
		
		private var _anim:FjSprite = new FjSprite(new _animBitmap(), null, new Point(73, 48), new FjSpriteAnimation("move", [0, 1, 2], 50, true));
		private var _shotDelay:Number = 0;
		
		public function BTR()
		{
			super(_anim.width, _anim.height);
			addSprite(_anim);
			_anim.addAnimation(new FjSpriteAnimation("fire", [0, 1, 3], 50, true));
			setCenter();
			_healthPoints = Balance.btrHealth;
			_healthPointsMax = Balance.btrHealth;
			_score = Balance.btrScore;
			_speed = Balance.btrSpeed;
			_attackDamage = Balance.btrAttackDamage;
			_explosionDamage = Balance.btrExplosionDamage;
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			if (x < Main.CONTENT_WIDTH / 2)
			{
				if (!GameMain.gameIsOver)
				{
					if (_shotDelay >= SHOT_DELAY)
					{
						_anim.currentFrame = 3;
						FjSnd.playSound("shot");
						GameMain.Instance.factory.Hit(Balance.btrAttackDamage, BTR);
						_shotDelay = 0;
					}
					else
					{
						_shotDelay += deltaTime;
					}
				}
			}
		
		}
	
	}

}