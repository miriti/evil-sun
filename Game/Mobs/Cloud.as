package Game.Mobs
{
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.Flinjin;
	import flinjin.FjLog;
	import flinjin.graphics.FjSprite;
	import flinjin.sound.FjSnd;
	import Game.Balance;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Cloud extends FjSprite
	{
		[Embed(source="../../_assets/bmp/mobs/cloud/cloud_body.png")]
		private static var _bmpCloud:Class;
		
		[Embed(source="../../_assets/bmp/mobs/cloud/cloud_strike.png")]
		private static var _bmpStrike:Class;
		
		/** strike **/
		private var _strike:FjSprite = new FjSprite(new _bmpStrike());
		
		private var _targetMob:Mob = null;
		
		private var _xSpeed:Number = 0;
		static private const ACC:Number = 0.5;
		static private const STRIKE_DELAY:Number = 60;
		static private const TIME_TO_LIVE:Number = 1000;
		private var _strikeDelay:Number = STRIKE_DELAY;
		private var _timeToLive:Number = TIME_TO_LIVE;
		
		/**
		 * Cloud
		 *
		 */
		public function Cloud()
		{
			super(new _bmpCloud());
			setCenter();
			_strike.setCenter(_strike.width / 2, 0);
			_strike.alpha = 0;
			
			addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAddedToLayer);
		}
		
		private function onAddedToLayer(e:FlinjinSpriteEvent):void
		{
			(parent as GameMain).addSprite(_strike, x, y, zIndex + 1);
		}
		
		/**
		 *
		 */
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			
			if (_strike.alpha > 0)
			{
				_strike.alpha -= 0.2;
			}
			else
			{
				_strike.alpha = 0;
			}
			
			alpha = _timeToLive / TIME_TO_LIVE;
			
			if (y < 70)
			{
				y += 2;
			}
			else
			{
				if (_targetMob != null)
				{
					if ((_targetMob.healthPoints <= 0) || (_targetMob.x > Main.CONTENT_HEIGHT))
					{
						_targetMob = _pickTarget();
					}
					else
					{
						if (x < _targetMob.position.x - _targetMob.width / 2)
						{
							_xSpeed += ACC;
						}
						else if (x > _targetMob.position.x)
						{
							_xSpeed -= ACC;
						}
						else
						{
							fireStrike();
						}
					}
				}
				else
				{
					_targetMob = _pickTarget();
				}
			}
			
			if (Math.abs(_xSpeed) > 5)
			{
				if (_xSpeed < 0)
					_xSpeed = -5;
				else
					_xSpeed = 5;
			}
			
			x += _xSpeed;
			
			if (x > Main.CONTENT_WIDTH - width / 2)
			{
				_xSpeed = 0;
				x = Main.CONTENT_WIDTH - width / 2;
			}
			
			if (x < width / 2)
			{
				_xSpeed = 0;
				x = width / 2;
			}
			
			_strike.x = x;
			_strike.y = y;
			
			if (_strikeDelay > 0)
				_strikeDelay--;
			
			_timeToLive--;
			if (_timeToLive <= 0)
			{
				_strike.Delete();
				Delete();
			}
		}
		
		/**
		 * Fire strike
		 *
		 */
		private function fireStrike():void
		{
			if (_strikeDelay == 0)
			{
				_targetMob.Hit(Balance.cloudStrikePower, null);
				_strike.alpha = 1;
				_strikeDelay = STRIKE_DELAY;
				FjSnd.playSound('strike');
			}
		}
		
		/**
		 *
		 * @return
		 */
		protected function _pickTarget():Mob
		{
			if ((parent as GameMain).mobsCollection.length > 0)
			{
				return (parent as GameMain).mobsCollection[Math.floor(Math.random() * (parent as GameMain).mobsCollection.length)];
			}
			else
			{
				return null;
			}
		}
	
	}

}