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
	public class Tank extends Mob
	{
		[Embed(source="../../_assets/bmp/mobs/tank/anim.png")]
		private static var _tankAnimBitamp:Class;
		
		private var _tankAnim:FjSprite = new FjSprite(new _tankAnimBitamp(), null, new Point(67, 58), new FjSpriteAnimation("anim", [0, 1]));
		private var _shotDelay:Number = 0;
		
		private static var _level:int = 0;
		
		public function Tank()
		{
			super(_tankAnim.width, _tankAnim.height);
			addSprite(_tankAnim);
			
			_healthPoints = Balance.tankHealth;
			_healthPointsMax = Balance.tankHealth;
			_score = Balance.tankScore;
			_speed = Balance.tankSpeed;
			_attackDamage = Balance.tankGunDamage;
			_explosionDamage = Balance.tankExplosionPower;
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			
			if (x < Main.CONTENT_WIDTH / 2)
			{
				if (!GameMain.gameIsOver)
				{
					if (_shotDelay >= Balance.tankShotDelay)
					{
						if ((parent as GameMain).factory != null)
						{
							(parent as GameMain).factory.Hit(Balance.tankGunDamage);
							FjSnd.playSound("shot");
							_tankAnim.currentFrame = 2;
						}
						
						_shotDelay = (_shotDelay - Balance.tankShotDelay);
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