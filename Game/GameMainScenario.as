package Game
{
	import Game.Rounds.GameRound;
	import Game.Rounds.Wave0;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameMainScenario
	{
		protected var _game:GameMain = null;
		protected var _totalTime:Number = 0;
		
		static public var helpEnabled:Boolean = true;
		
		static public const START_ROUND:Class = Wave0;
		
		public var gameRound:GameRound = null;
		
		private var _running:Boolean = true;
		
		public function GameMainScenario()
		{
			_game = GameMain.Instance;
		}
		
		public function update(deltaTime:Number):void
		{
			if (_running)
			{
				if (gameRound != null)
					gameRound.update(deltaTime);
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