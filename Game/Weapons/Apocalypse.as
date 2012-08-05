package Game.Weapons
{
	import flinjin.Flinjin;
	import Game.Balance;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Apocalypse extends Weapon
	{
		private var _infire:Boolean = false;
		private var _rise:Boolean = false;
		private var _mul:Number = 0;
		private var _firePower:Number;
		
		public function Apocalypse()
		{
			super();
			upgrade(0);
		}
		
		override protected function _fire():void
		{
			super._fire();
			_infire = true;
			_rise = true;
			_mul = 1;
			_firePower = _power;
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if (_infire)
			{
				if (_rise)
				{
					_mul += (deltaTime / (1000 / Flinjin.frameDelta));
					
					if (_mul >= 12)
					{
						_rise = false;
						var _hitPower:Number = Balance.apocalypseDamageMin[level] + (Balance.apocalypseDamageMax[level] - Balance.apocalypseDamageMin[level]) * _firePower;
						
						for (var i:int = 0; i < GameMain.Instance.mobsCollection.length; i++)
						{
							GameMain.Instance.mobsCollection[i].Hit(_hitPower, Apocalypse);
						}
					}
				}
				else
				{
					_mul -= (deltaTime / (1000 / Flinjin.frameDelta));
					
					if (_mul <= 1)
					{
						_infire = false;
						if (_mul < 1)
							_mul = 1;
					}
					
				}
				
				GameMain.Instance.colorTransform.redMultiplier = _mul;
				GameMain.Instance.colorTransform.greenMultiplier = _mul;
				GameMain.Instance.colorTransform.blueMultiplier = _mul;
			}
		}
		
		override public function upgrade(lvl:int):void
		{
			super.upgrade(lvl);
			_powerIncVal = Balance.apocalypseIncVal[lvl];
			_recoveryTime = Balance.apocalypseRecovery[lvl];
			_upgradeCost = Balance.apocalypseUpgradeCost[lvl];
		}
	}

}