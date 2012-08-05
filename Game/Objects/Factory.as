package Game.Objects
{
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.Flinjin;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteText;
	import Game.Balance;
	import Game.GameMain;
	import Game.Objects.parcticles.FactorySmokeEmitter;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Factory extends GameObject
	{
		[Embed(source="../../_assets/bmp/objects/factory/factory-base.png")]
		static public var _factoryBaseBitmap:Class;
		
		public var factoryBaseSprite:FjSprite = new FjSprite(new Factory._factoryBaseBitmap);
		public var factoryStalkSprites:Vector.<FactoryStalk> = new Vector.<FactoryStalk>();
		
		private var _smokeEmitter1:FactorySmokeEmitter = new FactorySmokeEmitter();
		private var _smokeEmitter2:FactorySmokeEmitter = new FactorySmokeEmitter();
		
		private var _repairPrice:Number = 500;
		
		public function Factory()
		{
			factoryStalkSprites[0] = new FactoryStalk();
			factoryStalkSprites[0].dir = FactoryStalk.DOWN;
			factoryStalkSprites[0].emitter = _smokeEmitter1;
			
			factoryStalkSprites[1] = new FactoryStalk();
			factoryStalkSprites[1].dir = FactoryStalk.UP;
			factoryStalkSprites[1].emitter = _smokeEmitter2;
			
			super(factoryBaseSprite.width, factoryBaseSprite.height + factoryStalkSprites[0].height);
			
			addSprite(factoryBaseSprite, 0, height - factoryBaseSprite.height, 1);
			addSprite(factoryStalkSprites[0], 65, factoryBaseSprite.y - factoryStalkSprites[0].height + 26, 0);
			addSprite(factoryStalkSprites[1], 130, factoryStalkSprites[0].y + 26, 0);
			
			_healthPoints = Balance.factoryHealth;
			_healthPointsMax = Balance.factoryHealth;
			
			addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAddedToLayer);
			addEventListener(FlinjinSpriteEvent.REMOVED_FROM_LAYER, onRemoved);
		}
		
		private function onRemoved(e:FlinjinSpriteEvent):void
		{
			_smokeEmitter1.Delete();
			_smokeEmitter2.Delete();
		}
		
		private function onAddedToLayer(e:FlinjinSpriteEvent):void
		{
			var _game:GameMain = (parent as GameMain);
			_game.addSprite(_smokeEmitter1, factoryStalkSprites[0].x + factoryStalkSprites[0].width / 2, y - height / 2 + 35, zIndex - 1);
			_game.addSprite(_smokeEmitter2, factoryStalkSprites[1].x + factoryStalkSprites[1].width / 2, y - height / 2 + 35, zIndex - 1);
		}
		
		override public function get healthPoints():Number
		{
			return super.healthPoints;
		}
		
		override public function set healthPoints(value:Number):void
		{
			super.healthPoints = value;
			if (_healthPoints <= 0)
			{
				(parent as GameMain).onGameOver();
			}
		}
		
		public function get repairPrice():Number
		{
			return _repairPrice;
		}
		
		public function repair():void
		{
			healthPoints = Balance.factoryHealth;
			_repairPrice *= 2;
		}
	}

}
import flinjin.events.FlinjinSpriteEvent;
import flinjin.graphics.FjSprite;
import Game.Objects.Factory;
import Game.Objects.parcticles.FactorySmokeEmitter;

class FactoryStalk extends FjSprite
{
	static public const UP:int = -1;
	static public const DOWN:int = 1;
	static public const MV_SPD:Number = 8;
	static public const MV_INC:Number = 1.5;
	
	[Embed(source="../../_assets/bmp/objects/factory/factory-chimney-stalk.png")]
	private static var _stalkBitmap:Class;
	
	private var _swingSpeed:Number = MV_SPD;
	private var _stalkMinY:Number;
	private var _stalkMaxY:Number;
	private var _dir:int = UP;
	
	private var _emitter:FactorySmokeEmitter;
	
	public function FactoryStalk()
	{
		super(new _stalkBitmap());
		
		addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAddedToLayer);
	}
	
	private function onAddedToLayer(e:FlinjinSpriteEvent):void
	{
		_stalkMinY = (parent as Factory).factoryBaseSprite.y - height + 26;
		_stalkMaxY = _stalkMinY + 26;
	}
	
	override public function Move(deltaTime:Number):void
	{
		super.Move(deltaTime);
		
		if (_dir == UP)
		{
			_swingSpeed *= MV_INC;
		}
		
		y += _dir * ((deltaTime / 1000) * _swingSpeed);
		
		if (y < _stalkMinY)
		{
			y = _stalkMinY;
			_dir = DOWN;
			_swingSpeed = MV_SPD;
			_emitter.emmit();
		}
		
		if (y > _stalkMaxY)
		{
			y = _stalkMaxY;
			_dir = UP;
		}
	
	}
	
	public function get dir():int
	{
		return _dir;
	}
	
	public function set dir(value:int):void
	{
		_dir = value;
	}
	
	public function get emitter():FactorySmokeEmitter
	{
		return _emitter;
	}
	
	public function set emitter(value:FactorySmokeEmitter):void
	{
		_emitter = value;
	}
}