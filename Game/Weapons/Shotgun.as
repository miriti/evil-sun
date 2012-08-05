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
	public class Shotgun extends Weapon
	{
		static private const RAYTRACE_STEP:Number = 2;
		
		private var _shotPosition:Point = new Point();
		private var _targetPoint:Point = new Point();
		private var _bulletsCount:int = 1;
		
		public function Shotgun()
		{
			super();
			upgrade(0);
			_recovery = _recoveryTime;
		}
		
		override protected function _fire():void
		{			
			super._fire();
			
			var _mainAngle:Number = Math.atan2(FjInput.mousePosition.y - _shotPosition.y, FjInput.mousePosition.x - _shotPosition.x);
			
			for (var i:int = 0; i < _bulletsCount; i++)
			{
				var _newAngle:Number = _mainAngle + (-Balance.shotgunAngleDisp[_level] + Balance.shotgunAngleDisp[_level] * (Math.random() * 2));
				var _newBullet:ShotgunBullet = new ShotgunBullet();
				_newBullet.toangle = _newAngle;
				_newBullet.level = _level;
				GameMain.Instance.addSprite(_newBullet, _shotPosition.x, _shotPosition.y, GameMain.Instance.sun.zIndex + i);
			}
			FjSnd.playSound("shotgun", 0.4);
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			_shotPosition.x = GameMain.Instance.sun.x + GameMain.Instance.sun.shotPosition.x;
			_shotPosition.y = GameMain.Instance.sun.y + GameMain.Instance.sun.shotPosition.y;
		}
		
		override public function upgrade(lvl:int):void
		{
			super.upgrade(lvl);
			_powerMin = Balance.shotgunPowerMin[lvl];
			_powerIncVal = Balance.shotgunPowerInc[lvl];
			_recoveryTime = Balance.shotgunRecovery[lvl];
			_upgradeCost = Balance.shotgunUpdateCost[lvl];
			_bulletsCount = Balance.shotgunBulletCount[lvl];
			_autofire = Balance.shotgunAutofire[lvl];
		}
	}
}
import flash.geom.Point;
import flinjin.graphics.FjSprite;
import flinjin.graphics.FjSpriteAnimation;
import Game.Balance;
import Game.GameMain;
import Game.Mobs.Baloon;
import Game.Mobs.Mob;
import Game.Mobs.Plane;
import Game.Weapons.Shotgun;

class ShotgunBullet extends FjSprite
{
	[Embed(source="../../_assets/bmp/weapons/shotgun-anim-28x28.png")]
	private static var _bulletBitmap:Class;
	
	private var _toangle:Number = 0;
	private var _vector:Point;
	private var _level:int = 0;
	static private const BULLET_SPEED:Number = 1500;
	static private const TRACE_DEEP:Number = 10;
	
	public function ShotgunBullet():void
	{
		super(new _bulletBitmap(), null, new Point(28, 28), new FjSpriteAnimation());
		setCenter();
	}
	
	override public function Move(deltaTime:Number):void
	{
		super.Move(deltaTime);
		
		if ((x < 0) || (x > Main.CONTENT_WIDTH) || (y < 0) || (y > GameMain.groundLevel))
		{
			Delete(true);
			return;
		}
		
		addPositionVector(_vector, s(deltaTime) * BULLET_SPEED);
		
		var _sp:Point = _prevPosition.clone();
		var _tp:Point = _position.clone();
		var _cp:Point = _sp.clone();
		var _v:Point = new Point(_tp.x - _sp.x, _tp.y - _sp.y);
		var l:Number = _v.length;
		_v.normalize(1);
		var _cv:Point = new Point();
		
		while (_cv.length < l)
		{
			for (var i:int = 0; i < GameMain.Instance.mobsCollection.length; i++)
			{
				var m:Mob = GameMain.Instance.mobsCollection[i];
				if (m.collisionShape.containPoint(_cp))
				{
					var dam:Number = Balance.shotgunDamageMax[_level];
					m.Hit(dam, Shotgun);
					Delete(true);
					return;
				}
			}
			
			_cv.x += _v.x * TRACE_DEEP;
			_cv.y += _v.y * TRACE_DEEP;
			
			_cp.x += _v.x * TRACE_DEEP;
			_cp.y += _v.y * TRACE_DEEP;
		}
	}
	
	public function get toangle():Number
	{
		return _toangle;
	}
	
	public function set toangle(value:Number):void
	{
		_toangle = value;
		_vector = new Point(Math.cos(_toangle), Math.sin(_toangle));
	}
	
	public function get level():int
	{
		return _level;
	}
	
	public function set level(value:int):void
	{
		_level = value;
	}
}