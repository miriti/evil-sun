package Game.Mobs
{
	import flash.events.Event;
	import flinjin.events.FlinjinObjectPoolEvent;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.graphics.FjLayer;
	import flinjin.FjInput;
	import flinjin.sound.FjSnd;
	import flinjin.types.BoundingRect;
	import Game.GameMain;
	import Game.HUD.HealthBar;
	import Game.HUD.HealthBarItem;
	import Game.Objects.Factory;
	import Game.Objects.parcticles.CommonExplosion;
	import Game.Weapons.Weapon;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Mob extends FjLayer
	{
		protected var _healthBarShift:Number = 5;
		protected var _healthPoints:Number;
		protected var _healthPointsMax:Number;
		protected var _healthBar:HealthBar;
		protected var _explosionClass:Class = CommonExplosion;
		protected var _score:Number = 0;
		protected var _speed:Number = 0;
		protected var _explosionDamage:Number = 0;
		protected var _attackDamage:Number = 0;
		protected var _hitTheFactory:Boolean = true;
		protected var _healthBarPosition:int = 0;
		
		public function Mob(layerWidth:uint, layerHeight:uint)
		{
			super(layerWidth, layerHeight);
			setCenter();
			addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, initHealthBar);
			addEventListener(FlinjinSpriteEvent.REMOVED_FROM_LAYER, removedFromLayer);
		}
		
		protected function initMob():void
		{
		
		}
		
		private function removedFromLayer(e:FlinjinSpriteEvent):void
		{
			_healthBar.Delete();
		}
		
		private function initHealthBar(e:FlinjinSpriteEvent = null):void
		{
			_healthBar = new HealthBar(width, 1, HealthBarItem);
			(parent as GameMain).addSprite(_healthBar, null, null, zIndex);
		}
		
		protected function _explode():void
		{
			Delete(true);
			(parent as GameMain).addSprite(new _explosionClass(), x, y, zIndex);
			FjSnd.playSound("explosion", 1, -1 + (x / Main.CONTENT_WIDTH) * 2);
		}
		
		public function die():void
		{
			_explode();
		}
		
		override protected function restore(e:FlinjinObjectPoolEvent = null):void
		{
			super.restore(e);
			initMob();
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			x -= _speed * (deltaTime / 1000);
			
			if (colorTransform.redMultiplier > 1.0)
			{
				colorTransform.redMultiplier -= 0.1 * r(deltaTime);
				colorTransform.greenMultiplier -= 0.1 * r(deltaTime);
				colorTransform.blueMultiplier -= 0.1 * r(deltaTime);
			}
			else if (colorTransform.redMultiplier < 1)
			{
				colorTransform.redMultiplier = 1;
				colorTransform.greenMultiplier = 1;
				colorTransform.blueMultiplier = 1;
			}
			
			if (_healthBar.alpha > 0)
			{
				_healthBar.alpha -= 0.01;
			}
			else if (_healthBar.alpha < 0)
				_healthBar.alpha = 0;
			
			if (rect.containsPoint(FjInput.mousePosition))
			{
				_healthBar.alpha = 1;
			}
			
			_healthBar.x = x - width / 2;
			if (_healthBarPosition == 0)
				_healthBar.y = y - height / 2 - _healthBar.height - _healthBarShift;
			else if (_healthBarPosition == 1)
				_healthBar.y = y + height / 2 + _healthBar.height - _healthBarShift;
			
			_healthBar.zIndex = zIndex + 1;
			
			if (!(this is Factory) && (_hitTheFactory) && (!GameMain.gameIsOver))
			{
				if (x - width / 2 <= GameMain.Instance.factory.x + GameMain.Instance.factory.width / 2)
				{
					die();
					GameMain.Instance.factory.Hit(_explosionDamage, Mob);
				}
			}
			
			if (x + width <= 0)
			{
				Delete();
			}
		}
		
		public function Hit(val:Number, weapon:Class):void
		{
			colorTransform.redMultiplier = 2;
			colorTransform.greenMultiplier = 2;
			colorTransform.blueMultiplier = 2;
			healthPoints -= val;
			_healthBar.alpha = 1;
		}
		
		public function get healthPoints():Number
		{
			return _healthPoints;
		}
		
		public function set healthPoints(val:Number):void
		{
			_healthPoints = val;
			_healthBar.value = _healthPoints / _healthPointsMax;
			
			if (_healthPoints <= 0)
			{
				_healthPoints = 0;
				
				GameMain.addScore(_score);
				die();
			}
		}
		
		public function get healthPointsMax():Number
		{
			return _healthPointsMax;
		}
	
	}

}