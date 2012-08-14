package Game.Objects
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.FjObjectPool;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class BalisticSprite extends FjSprite
	{
		protected var _gravity:Number = 300;
		protected var _followDirection:Boolean = true;
		protected var _level:int = 0;
		protected var _speed:Number = 0;
		protected var _vector:Point = new Point();
		protected var _speedVector:Point = new Point();
		protected var _power:Number = 0;
		protected var _trailClass:Class = null;
		protected var _trailLength:Number = 10;
		
		private var _lastTrailPos:Point = new Point();
		
		public function BalisticSprite(spriteBmp:Bitmap, rotationCenter:Point = null, frameSize:Point = null, spriteAnimation:FjSpriteAnimation = null)
		{
			super(spriteBmp, rotationCenter, frameSize, spriteAnimation);
			
			addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAdded);
		}
		
		private function _trail():void
		{
			var _trail:FadingTrail = FjObjectPool.pull(_trailClass) as FadingTrail;
			parent.addSprite(_trail, x, y, zIndex - 1);
			_lastTrailPos.setTo(x, y);
		}
		
		private function onAdded(e:FlinjinSpriteEvent):void
		{
			_lastTrailPos.setTo(x, y);
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			
			if (_trailClass != null)
			{
				if (new Point(x - _lastTrailPos.x, y - _lastTrailPos.y).length >= _trailLength)
					_trail();
			}
			
			x += _speedVector.x * (deltaTime / 1000);
			y += _speedVector.y * (deltaTime / 1000);
			
			if (_followDirection)
				angle = Math.atan2(y - _prevPosition.y, x - _prevPosition.x);
			
			_speedVector.y += (deltaTime / 1000) * _gravity;
			if (_speedVector.x > 0)
			{
				_speedVector.x -= (deltaTime / 1000) * 10;
				if (_speedVector.x < 0)
					_speedVector.x = 0;
			}
			else if (_speedVector.x < 0)
			{
				_speedVector.x += (deltaTime / 1000) * 10;
				if (_speedVector.x > 0)
					_speedVector.x = 0;
			}
		}
		
		public function get level():int
		{
			return _level;
		}
		
		public function set level(value:int):void
		{
			_level = value;
		}
		
		public function get speed():Number
		{
			return _speed;
		}
		
		public function set speed(value:Number):void
		{
			_speed = value;
		}
		
		public function get vector():Point
		{
			return _vector;
		}
		
		public function set vector(value:Point):void
		{
			_vector = value;
		}
		
		public function get speedVector():Point
		{
			return _speedVector;
		}
		
		public function set speedVector(value:Point):void
		{
			_speedVector = value;
		}
		
		public function get power():Number
		{
			return _power;
		}
		
		public function set power(value:Number):void
		{
			_power = value;
		}
	
	}

}