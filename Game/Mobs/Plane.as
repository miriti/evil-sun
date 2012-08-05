package Game.Mobs
{
	import flash.geom.Point;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import flinjin.types.BoundingRect;
	import Game.Balance;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Plane extends Mob
	{
		[Embed(source="../../_assets/bmp/mobs/plane/plane-anim-78x55.png")]
		private var _animBitmap:Class;
		
		private var _anim:FjSprite = new FjSprite(new _animBitmap(), null, new Point(78, 55), new FjSpriteAnimation("fly", null, 100, true));
		private var _dead:Boolean = false;
		private var _initY:Number;
		private var _wave:Number = 0;
		private var _minX:Number;
		
		public function Plane()
		{
			super(_anim.width, _anim.height);
			addSprite(_anim);
			addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAdded);
			_healthPoints = Balance.planeHealth;
			_healthPointsMax = Balance.planeHealth;
			_speed = Balance.planeSpeed;
			_score = Balance.planeScore;
			_explosionDamage = Balance.planeDamage;
			setBoundingShape(new BoundingRect(this, width / 2, height / 2));
		}
		
		private function onAdded(e:FlinjinSpriteEvent):void
		{
			_initY = GameMain.groundLevel - 200 + 100 * Math.random();
			y = _initY;
			_wave = Math.random() * (Math.PI * 2);
			_minX = GameMain.Instance.factory.width * 0.7;
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			
			y = _initY + Math.sin(_wave) * 50;
			_wave += 0.05 * r(deltaTime);
		}
	
	}

}