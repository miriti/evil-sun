package Game.Rounds
{
	import flash.display.Bitmap;
	import flash.text.TextFormat;
	import Game.GameMain;
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
		
		protected var _roundName:String = "";
		protected var _textFormat:TextFormat = new TextFormat("gameFont", 35, 0x00cc00);
		protected var _timeTotal:Number = 0;
		protected var _creationEvents:Vector.<GameRoundCreationEvent> = new Vector.<GameRoundCreationEvent>();
		protected var _nextRound:Class = null;
		protected var _finishDelay:Number = 3000;
		protected var _finishDie:String = "Clear!";
		protected var _titleBitmap:Bitmap;
		
		[Embed(source="../../_assets/bmp/hud/wave-titles/clear.png")]
		private static var _clearBitmap:Class;
		
		[Embed(source="../../_assets/bmp/hud/wave-titles/excellent.png")]
		private static var _excelentBitmap:Class;
		private var _factoryHealth:Number;
		
		public function GameRound()
		{
			GameMain.Instance.deadMobs = 0;
			_factoryHealth = GameMain.Instance.factory.healthPoints;
		}
		
		public function addMobEvent(timeStamp:Number, mob:Mob):void
		{
			_creationEvents.push(new GameRoundCreationEvent(timeStamp, mob));
		}
		
		public function finish():void
		{
			// TODO MochiEvents on release
			//MochiEvents.trackEvent(_roundName + ' passed');				
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
						var _mob:Mob = _creationEvents[i].mob;
						_mob.x = Main.CONTENT_WIDTH + _mob.width / 2;
						_mob.y = GameMain.groundLevel - _mob.height / 2;
						GameMain.Instance.addMob(_mob);
						_creationEvents[i].done = true;
					}
				}
				
				if (GameMain.Instance.deadMobs == _creationEvents.length)
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
		
		public function get roundName():String
		{
			return _roundName;
		}
		
		public function set roundName(value:String):void
		{
			_roundName = value;
		}
		
		public function get running():Boolean
		{
			return _running;
		}
		
		public function set running(value:Boolean):void
		{
			_running = value;
		}
	}

}
import Game.Mobs.Mob;

class GameRoundCreationEvent
{
	private var _timestamp:Number;
	private var _mob:Mob;
	public var done:Boolean = false;
	
	function GameRoundCreationEvent(newTimeStamp:Number, newMob:Mob):void
	{
		_timestamp = newTimeStamp;
		_mob = newMob;
	}
	
	public function get timestamp():Number
	{
		return _timestamp;
	}
	
	public function set timestamp(value:Number):void
	{
		_timestamp = value;
	}
	
	public function get mob():Mob
	{
		return _mob;
	}
	
	public function set mob(value:Mob):void
	{
		_mob = value;
	}
}