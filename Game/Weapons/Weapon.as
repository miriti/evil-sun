package Game.Weapons
{
	import flinjin.FjInput;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Weapon
	{
		protected var _current:Boolean = false;
		protected var _power:Number = 0;
		protected var _powerMin:Number = 0;
		protected var _powerInc:Boolean = false;
		protected var _powerIncVal:Number = 0;
		protected var _recovery:Number = 0;
		protected var _recoveryTime:Number = 0;
		protected var _showBar:Boolean = true;
		protected var _level:int = 0;
		protected var _upgradeCost:Number = 0;
		protected var _autofire:Boolean = true;
		
		public function Weapon()
		{
		
		}
		
		protected function _fire():void
		{
			_recovery = 0;
		}
		
		public function fire():void
		{
			_fire();
		}
		
		public function powerStart():Boolean
		{
			if (_recovery >= _recoveryTime)
			{
				_powerInc = true;
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function powerEnd():void
		{
			if (_powerInc)
			{
				if (_power >= _powerMin)
					_fire();
			}
			
			_powerInc = false;
			_power = 0;
		}
		
		public function update(deltaTime:Number):void
		{
			if (_powerInc)
			{
				if (_power < 1)
				{
					_power += _powerIncVal * (deltaTime / 1000);
					
					if (_power > 1)
					{
						_power = 1;
						powerEnd();
					}
				}
				else
				{
					_power = 1;
					powerEnd();
				}
			}
			else
			{
				if ((_recovery < _recoveryTime) && (_recovery != -1))
				{
					_recovery += deltaTime;
					if (_recovery >= _recoveryTime)
					{
						_recovery = _recoveryTime;
						if ((FjInput.isMouseDown) && (_current) && (_autofire))
							powerStart();
					}
				}
			}
		}
		
		public function upgrade(lvl:int):void
		{
			_level = lvl;
		}
		
		public function get power():Number
		{
			return _power;
		}
		
		public function set power(value:Number):void
		{
			_power = value;
		}
		
		public function get powerInc():Boolean
		{
			return _powerInc;
		}
		
		public function set powerInc(value:Boolean):void
		{
			_powerInc = value;
		}
		
		public function get showBar():Boolean
		{
			return _showBar;
		}
		
		public function set showBar(value:Boolean):void
		{
			_showBar = value;
		}
		
		public function get recoveryTime():Number
		{
			return _recoveryTime;
		}
		
		public function get recovery():Number
		{
			return _recovery;
		}
		
		public function set recovery(value:Number):void
		{
			_recovery = value;
		}
		
		public function get current():Boolean
		{
			return _current;
		}
		
		public function set current(value:Boolean):void
		{
			_current = value;
		}
		
		public function get upgradeCost():Number
		{
			return _upgradeCost;
		}
		
		public function set upgradeCost(value:Number):void
		{
			_upgradeCost = value;
		}
		
		public function get level():int
		{
			return _level;
		}
		
		public function set level(value:int):void
		{
			_level = value;
			upgrade(value);
		}
		
		public function get powerMin():Number
		{
			return _powerMin;
		}
		
		public function set powerMin(value:Number):void
		{
			_powerMin = value;
		}
	}

}