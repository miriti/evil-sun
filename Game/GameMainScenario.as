package Game
{
	import Game.HUD.instructions.UpgrageInstructions;
	import Game.Rounds.GameRound;
	import Game.Rounds.Wave0;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameMainScenario
	{
		protected var _totalTime:Number = 0;
		
		static public var helpEnabled:Boolean = true;
		
		static public const START_ROUND:Class = Wave0;
		
		public var gameRound:GameRound = null;
		
		private var _running:Boolean = true;
		private var _upgradeHintShown:Boolean = false;
		
		public function GameMainScenario()
		{
			GameRound.resetWavesCount();
		}
		
		public function update(deltaTime:Number):void
		{
			if (_running)
			{
				if (gameRound != null)
				{
					gameRound.update(deltaTime);
					if ((helpEnabled) && (!_upgradeHintShown) && (GameMain.Instance.upgrades.avail()))
					{
						if (!GameMain.Instance.shopButton.visible)
							GameMain.Instance.shopButton.visible = true;
						else
						{
							var _upgradeHint:UpgrageInstructions = new UpgrageInstructions(gameRound);
							_upgradeHint.show();
							_upgradeHintShown = true;
						}
					}
				}
				else
				{
					if (_totalTime >= 1500)
					{
						startRound(new START_ROUND());
					}
				}
				_totalTime += deltaTime;
			}
		}
		
		public function startRound(round:GameRound):void
		{
			gameRound = round;
			gameRound.start();
		}
		
		public function get running():Boolean
		{
			return _running;
		}
		
		public function set running(value:Boolean):void
		{
			_running = value;
			if (gameRound != null)
				gameRound.running = value;
		}
	}
}