package Game.Mobs
{
	import flash.geom.Point;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.FjObjectPool;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import Game.Balance;
	import Game.GameMain;
	import Game.Weapons.Fireball;
	import Game.Weapons.Shotgun;
	
	public class Baloon extends Mob
	{
		[Embed(source="../../_assets/bmp/mobs/baloon/baloon-anim-63x118.png")]
		private static var _baloonAnimBitmap:Class;
		
		private var _baloonAnim:FjSprite = new FjSprite(new _baloonAnimBitmap(), null, new Point(63, 118), new FjSpriteAnimation("release", null, 200, true, 1));
		private var _bombSprite:BombSprite = new BombSprite();
		private var _phase:Number = 0;
		
		private const SWING:Number = Math.PI / 16;
		private var _bombDropped:Boolean = false;
		
		public function Baloon()
		{
			super(_baloonAnim.width, _baloonAnim.height + _bombSprite.height);
			_baloonAnim.animation.stop();
			addSprite(_baloonAnim, 0, 0);
			addSprite(_bombSprite, 30, 115);
			addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAdded);
			
			initMob();
		}
		
		override protected function initMob():void
		{
			super.initMob();
			_healthPoints = Balance.baloonHealth;
			_healthPointsMax = Balance.baloonHealth;
			_score = Balance.baloonScore;
			_speed = Balance.baloonSpeed;
			_attackDamage = Balance.baloonBombDamage;
			_healthBarPosition = 1;
			_hitTheFactory = false;
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			
			if ((x > GameMain.Instance.factory.width + 100) || ((x <= GameMain.Instance.factory.width + 100) && (GameMain.gameIsOver)))
			{
				angle = Math.sin(_phase) * SWING;
				_phase += deltaTime / 1000;
			}
			else
			{
				if (angle > 0)
				{
					angle -= (deltaTime / 1000) * 0.3;
					if (angle < 0)
						angle = 0;
				}
				else if (angle < 0)
				{
					angle += (deltaTime / 1000) * 0.3;
					if (angle < 0)
						angle = 0;
				}
				
				if ((x <= GameMain.Instance.factory.x) && (!_bombDropped))
				{
					_dropTheBomb();
					_bombDropped = true;
				}
			}
		}
		
		override public function Hit(val:Number, weapon:Class):void
		{
			if (weapon == Shotgun)
				val *= 2;
			
			if (weapon == Fireball)
				return;
			
			super.Hit(val, weapon);
		}
		
		private function _dropTheBomb():void
		{
			_baloonAnim.animation.play();
			_bombSprite.Delete();
			var newBomb:BombSprite = FjObjectPool.pull(BombSprite) as BombSprite;
			newBomb.damage = _attackDamage;
			newBomb.fall = true;
			GameMain.Instance.addSprite(newBomb, x, y + (height / 2 - newBomb.height), zIndex + 1);
		}
		
		private function onAdded(e:FlinjinSpriteEvent):void
		{
			y = 70;
			zIndex = GameMain.Instance.skyclouds.zIndex + 1;
		}
	}
}
import flash.geom.Point;
import flinjin.graphics.FjSprite;
import flinjin.sound.FjSnd;
import Game.Balance;
import Game.GameMain;
import Game.Mobs.Baloon;
import Game.Objects.parcticles.CommonExplosion;

class BombSprite extends FjSprite
{
	[Embed(source="../../_assets/bmp/mobs/baloon/bomb.png")]
	private static var _bombBitmap:Class;
	
	private var _fall:Boolean = false;
	private var _damage:Number = 0;
	private var _fallSpeed:Number = 0;
	
	public function BombSprite()
	{
		super(new _bombBitmap(), new Point(5, 0));
	}
	
	override public function Move(deltaTime:Number):void
	{
		super.Move(deltaTime);
		
		if (_fall)
		{
			if (y >= GameMain.Instance.factory.y)
			{
				Delete(true);
				GameMain.Instance.factory.Hit(_damage, Baloon);
				(parent as GameMain).addSprite(new CommonExplosion(), x, y, zIndex);
				FjSnd.playSound("explosion");
			}
			else
			{
				x -= Balance.baloonSpeed * s(deltaTime);
				y += _fallSpeed;
				_fallSpeed += s(deltaTime) * 5;
			}
		}
	}
	
	public function get fall():Boolean
	{
		return _fall;
	}
	
	public function set fall(value:Boolean):void
	{
		_fall = value;
	}
	
	public function get damage():Number
	{
		return _damage;
	}
	
	public function set damage(value:Number):void
	{
		_damage = value;
	}
}