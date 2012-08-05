package Game.Weapons
{
	import flash.geom.Point;
	import flinjin.FjInput;
	import flinjin.sound.FjSnd;
	import Game.Balance;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Fireball extends Weapon
	{
		private var _vector:Point;
		private var _speedVector:Point;
		
		/**
		 *
		 */
		public function Fireball()
		{
			super();
			upgrade(0);
			_recovery = _recoveryTime;
		}
		
		override public function upgrade(lvl:int):void
		{
			super.upgrade(lvl);
			_powerIncVal = Balance.fireballPowerInc[lvl];
			_recoveryTime = Balance.fireballRecovery[lvl];
			_upgradeCost = Balance.fireballUpgrageCost[lvl];
			_powerMin = Balance.fireballPowerMin[lvl];
			_autofire = Balance.fireballAutofire[lvl];
		}
		
		override protected function _fire():void
		{
			super._fire();
			var _newFireBall:FireballSprite = new FireballSprite();
			_newFireBall.level = _level;
			_newFireBall.power = _power;
			_newFireBall.vector = new Point(FjInput.mousePosition.x - GameMain.Instance.sun.x + GameMain.Instance.sun.shotPosition.x, FjInput.mousePosition.y - GameMain.Instance.sun.y + GameMain.Instance.sun.shotPosition.y);
			GameMain.Instance.addSprite(_newFireBall, GameMain.Instance.sun.x + GameMain.Instance.sun.shotPosition.x, GameMain.Instance.sun.y + GameMain.Instance.sun.shotPosition.y, GameMain.Instance.sun.zIndex + 10);
			FjSnd.playSound("fireball");
		}
	}

}
import flash.display.CapsStyle;
import flash.geom.Point;
import flinjin.events.FlinjinSpriteEvent;
import flinjin.FjObjectPool;
import flinjin.graphics.FjSpriteAnimation;
import flinjin.sound.FjSnd;
import Game.Balance;
import Game.GameMain;
import Game.Mobs.Mob;
import Game.Objects.BalisticSprite;
import Game.Objects.FadingTrail;
import Game.Objects.FireballExplosion;
import Game.Weapons.Fireball;

class FireballSprite extends BalisticSprite
{
	[Embed(source="../../_assets/bmp/weapons/fireball-anim-57x57.png")]
	private static var _fireballBitmap:Class;
	private var _exploded:Boolean = false;
	
	function FireballSprite()
	{
		super(new _fireballBitmap(), new Point(57 / 2, 57 / 2), new Point(57, 57), new FjSpriteAnimation("fly", [0, 1, 2]));
		_followDirection = false;
		setCenter();
		addAnimation(new FjSpriteAnimation("end", [3, 4, 5]));
	}
	
	override public function Move(deltaTime:Number):void
	{
		super.Move(deltaTime);
		
		var _trail:FireBallTrail = FjObjectPool.pull(FireBallTrail) as FireBallTrail;
		parent.addSprite(_trail, x, y, zIndex - 1);
		
		if (!_exploded)
		{
			if ((y > GameMain.groundLevel - 10) || (x < 0) || (x > Main.CONTENT_WIDTH))
			{
				if (y > GameMain.groundLevel - 10)
				{
					var dam:Number = Balance.fireballDamageMin[level] + (Balance.fireballDamageMax[level] - Balance.fireballDamageMin[level]) * _power;
					(parent as GameMain).addSprite(new FireballExplosion(), x, GameMain.groundLevel, zIndex);
					FjSnd.playSound("fire");
					
					for (var i:int = 0; i < GameMain.Instance.mobsCollection.length; i++)
					{
						var _m:Mob = GameMain.Instance.mobsCollection[i];
						var dis:Number = Math.floor(_m.x - x);
						
						if (dis <= Balance.fireballDamageRadius[level])
						{
							_m.Hit(dam, Fireball);
						}
					}
					_exploded = true;
					_speedVector.x = 0;
					_speedVector.y = 0;
					_gravity = 0;
					setAnimation("end");
					addEventListener(FlinjinSpriteEvent.ANIMATION_FINISHED, onAnimationFinished);
				}
				else
					Delete();
			}
		}
	}
	
	private function onAnimationFinished(e:FlinjinSpriteEvent):void
	{
		Delete();
	}
	
	override public function set vector(value:Point):void
	{
		if (value.length != 1)
		{
			var l:Number = value.length;
			value.x /= l;
			value.y /= l;
		}
		_vector = value;
		_speedVector = new Point(_vector.x * (Balance.fireballSpeed * _power), _vector.y * (Balance.fireballSpeed * _power));
	}
}

class FireBallTrail extends FadingTrail
{
	
	[Embed(source="../../_assets/bmp/weapons/fireball_mask.png")]
	private static var _trailBitmap:Class;
	
	function FireBallTrail():void
	{
		super(new _trailBitmap());
		setCenter();
	}
}