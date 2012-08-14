package Game.Rounds
{
	import flash.display.Bitmap;
	import flash.text.TextFormat;
	import flinjin.FjObjectPool;
	import Game.GameMain;
	import Game.HUD.Instructions;
	import Game.HUD.WaveTitleDie;
	import Game.Mobs.Mob;
	import mochi.as3.MochiEvents;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameRound
	{
		private var _finishDelayTime:Number = -1;
		private var _running:Boolean = true;
		
		protected var _textFormat:TextFormat = new TextFormat("gameFont", 35, 0x00cc00);
		protected var _timeTotal:Number = 0;
		protected var _creationEvents:Vector.<GameRoundCreationEvent> = new Vector.<GameRoundCreationEvent>();
		protected var _nextRound:Class = null;
		protected var _finishDelay:Number = 3000;
		protected var _titleBitmap:Bitmap;
		
		[Embed(source="../../_assets/bmp/hud/wave-titles/clear.png")]
		private static var _clearBitmap:Class;
		
		[Embed(source="../../_assets/bmp/hud/wave-titles/excellent.png")]
		private static var _excelentBitmap:Class;
		private var _factoryHealth:Number;
		private var _mobCount:int = 0;
		
		private static var _wavesPassed:int = 0;
		
		public function GameRound()
		{
			GameMain.Instance.deadMobs = 0;
			_factoryHealth = GameMain.Instance.factory.healthPoints;
		}
		
		public function addEvent(timeStamp:Number, mob:Class = null, help:Instructions = null):void
		{
			_creationEvents.push(new GameRoundCreationEvent(timeStamp, mob, help));
			
			if (mob != null)
				_mobCount++;
		}
		
		public function finish():void
		{
			_wavesPassed++;
			MochiEvents.trackEvent("wave_passed", _wavesPassed);
			if (_nextRound != null)
			{
				GameMain.Instance.scenario.startRound(new _nextRound());
			}
		}
		
		public function start():void
		{
			if (_titleBitmap != null)
			{
				new WaveTitleDie(_titleBitmap);
			}
		}
		
		public function update(deltaTime:Number):void
		{
			if (_running)
			{
				_timeTotal += deltaTime;
				
				for (var i:int = 0; i < _creationEvents.length; i++)
				{
					if ((_timeTotal >= _creationEvents[i].timestamp) && (!_creationEvents[i].done))
					{
						if (_creationEvents[i].mob != null)
						{
							var _mob:Mob = FjObjectPool.pull(_creationEvents[i].mob) as Mob;
							_mob.x = Main.CONTENT_WIDTH + _mob.width / 2;
							_mob.y = GameMain.groundLevel - _mob.height / 2;
							GameMain.Instance.addMob(_mob);
						}
						else if (_creationEvents[i].help != null)
						{
							var _help:Instructions = _creationEvents[i].help;
							_help.show();
						}
						_creationEvents[i].done = true;
					}
				}
				
				if (GameMain.Instance.deadMobs == _mobCount)
				{
					if (_finishDelayTime == -1)
					{
						_finishDelayTime = _timeTotal;
						
						if (_factoryHealth == GameMain.Instance.factory.healthPoints)
							new WaveTitleDie(new _excelentBitmap());
						else
							new WaveTitleDie(new _clearBitmap());
					}
					else
					{
						if (_timeTotal - _finishDelayTime >= _finishDelay)
						{
							finish();
						}
					}
				}
			}
		}
		
		public function get running():Boolean
		{
			return _running;
		}
		
		public function set running(value:Boolean):void
		{
			_running = value;
		}
		
		public static function resetWavesCount():void
		{
			_wavesPassed = 0;
		}
	}

}
import Game.HUD.Instructions;

class GameRoundCreationEvent
{
	private var _timestamp:Number;
	private var _mob:Class;
	private var _help:Instructions;
	public var done:Boolean = false;
	
	function GameRoundCreationEvent(newTimeStamp:Number, newMob:Class = null, newHelp:Instructions = null):void
	{
		_timestamp = newTimeStamp;
		_mob = newMob;
		_help = newHelp;
	}
	
	public function get timestamp():Number
	{
		return _timestamp;
	}
	
	public function set timestamp(value:Number):void
	{
		_timestamp = value;
	}
	
	public function get mob():Class
	{
		return _mob;
	}
	
	public function set mob(value:Class):void
	{
		_mob = value;
	}
	
	public function get help():Instructions
	{
		return _help;
	}
	
	public function set help(value:Instructions):void
	{
		_help = value;
	}
}