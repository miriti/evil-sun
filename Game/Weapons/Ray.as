package Game.Weapons
{
	import flash.geom.Point;
	import flinjin.FjInput;
	import flinjin.sound.FjSnd;
	import Game.Balance;
	import Game.GameMain;
	import Game.Sun;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Ray extends Weapon
	{
		private var _bulletCount:Number = 0;
		
		public function Ray()
		{
			super();
			_autofire = true;
			upgrade(0);
			_recovery = _recoveryTime;
		}
		
		override protected function _fire():void
		{
			super._fire();
			var _s:Sun = GameMain.Instance.sun;
			var _mainAngle:Number = Math.atan2(FjInput.mousePosition.y - (_s.y + _s.shotPosition.y), FjInput.mousePosition.x - (_s.x - _s.shotPosition.x));
			var _angleMin:Number = _mainAngle - Math.PI / 16;
			var _angleMax:Number = _mainAngle + Math.PI / 16;
			var da:Number = _angleMax - _angleMin;
			
			for (var i:int = 0; i < _bulletCount; i++)
			{
				var v:Point = new Point();
				
				if (_bulletCount == 1)
				{
					v.x = Math.cos(_mainAngle);
					v.y = Math.sin(_mainAngle);
				}
				else
				{
					v.x = Math.cos(_angleMin + da * (i / _bulletCount));
					v.y = Math.sin(_angleMin + da * (i / _bulletCount));
				}
				
				var _r:LaserRaySprite = new LaserRaySprite();
				_r.level = level;
				_r.power = power;
				_r.vector = v;
				GameMain.Instance.addSprite(_r, _s.x + _s.shotPosition.x, _s.y + _s.shotPosition.y, _s.zIndex + 1);
			}
			FjSnd.playSound('ray');
		}
		
		override public function upgrade(lvl:int):void
		{
			super.upgrade(lvl);
			_bulletCount = Balance.rayBulletCount[lvl];
			_powerMin = Balance.rayPowerMin[lvl];
			_powerIncVal = Balance.rayPowerInc[lvl];
			_recoveryTime = Balance.rayRecovery[lvl];
			_upgradeCost = Balance.rayUpgrageCost[lvl];
			_autofire = Balance.rayAutofire[lvl];
		}
	}
}

import flash.geom.Point;
import flinjin.events.FlinjinSpriteEvent;
import flinjin.FjObjectPool;
import flinjin.graphics.FjSpriteAnimation;
import Game.Balance;
import Game.GameMain;
import Game.Mobs.Mob;
import Game.Objects.BalisticSprite;
import Game.Objects.FadingTrail;
import Game.Weapons.Ray;

class LaserRaySprite extends BalisticSprite
{
	[Embed(source="../../_assets/bmp/weapons/shot-anim-31x31.png")]
	private static var _rayLaserBitmap:Class;
	private var _exploded:Boolean = false;
	
	public function LaserRaySprite()
	{
		super(new _rayLaserBitmap(), new Point(31 / 2, 31 / 2), new Point(31, 31), new FjSpriteAnimation("fly", [0, 1, 2]));
		setCenter();
		addAnimation(new FjSpriteAnimation("exp", [3, 4, 5], 50));
		_followDirection = false;
	}
	
	private function _exp():void
	{
		_speedVector.setTo(0, 0);
		_gravity = 0;
		_exploded = true;
		setAnimation("exp");
		addEventListener(FlinjinSpriteEvent.ANIMATION_FINISHED, onExpAnimationFinished);
	}
	
	private function onExpAnimationFinished(e:FlinjinSpriteEvent):void
	{
		Delete();
	}
	
	override public function Move(deltaTime:Number):void
	{
		super.Move(deltaTime);
		
		var _trail:ShotTrail = FjObjectPool.pull(ShotTrail) as ShotTrail;
		parent.addSprite(_trail, x, y, zIndex);
		
		if (!_exploded)
		{
			if ((y > GameMain.groundLevel) || (x < 0) || (x > Main.CONTENT_WIDTH))
			{
				_exp();
			}
			else
			{
				var _g:GameMain = GameMain.Instance;
				
				for (var i:int = 0; i < _g.mobsCollection.length; i++)
				{
					var _m:Mob = _g.mobsCollection[i];
					
					if (_m.collisionShape.containPoint(position))
					{
						_m.Hit(Balance.rayDamage[_level], Ray);
						_exp();
					}
				}
			}
		}
	}
	
	override public function set vector(value:Point):void
	{
		_vector = value;
		_vector.normalize(1);
		_speedVector.setTo(_vector.x * _speed, _vector.y * _speed);
	}
	
	override public function set power(value:Number):void
	{
		_power = value;
		_speed = Balance.raySpeed[_level] * value;
	}
}

class ShotTrail extends FadingTrail
{
	[Embed(source="../../_assets/bmp/weapons/shot_mask.png")]
	private static var _trailBitmap:Class;
	
	public function ShotTrail():void
	{
		super(new _trailBitmap());
		setCenter();
	}
}