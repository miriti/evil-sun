package Game
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.FjConsole;
	import flinjin.Flinjin;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import flinjin.FjInput;
	import flinjin.sound.FjSnd;
	import Game.HUD.HealthBar;
	import Game.HUD.PowerBar;
	import Game.HUD.PowerBarItem;
	import Game.HUD.SunPowerBar;
	import Game.Mobs.Mob;
	import Game.Objects.Factory;
	import Game.Weapons.Apocalypse;
	import Game.Weapons.Fireball;
	import Game.Weapons.Ray;
	import Game.Weapons.Shotgun;
	import Game.Weapons.Weapon;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Sun extends FjLayer
	{
		[Embed(source="../_assets/bmp/mobs/sun/sun.png")]
		private static var _sunfaceBitmap:Class;
		private var _sunface:FjSprite = new FjSprite(new _sunfaceBitmap());
		
		[Embed(source="../_assets/bmp/mobs/sun/sun-crown.png")]
		private static var _sunCrownBitmap:Class;
		private var _sunCrown:FjSprite = new FjSprite(new _sunCrownBitmap(), null, new Point(195, 195), new FjSpriteAnimation("rising", null, 50, true));
		
		[Embed(source="../_assets/bmp/mobs/sun/new_eye.png")]
		private static var _sunEyeBitmap:Class;
		private var _sunEye:FjSprite = new FjSprite(new _sunEyeBitmap(), null);
		
		public var weaponRay:Ray = new Ray();
		public var weaponShotgun:Shotgun = new Shotgun();
		public var weaponFireball:Fireball = new Fireball();
		public var weaponApocalypce:Apocalypse = new Apocalypse();
		
		private var _currentWeapon:Weapon = null;
		
		private var _powerBar:SunPowerBar;
		
		private var _shotPosition:Point = new Point();
		private var _mouseVector:Point = new Point();
		
		/**
		 * Angry and hot sun!
		 *
		 */
		public function Sun()
		{
			super(_sunCrown.width, _sunCrown.height);
			
			y = height / 2;
			
			_sunCrown.setCenter();
			_sunCrown.animation.stop();
			
			_sunface.setCenter();
			_sunEye.setCenter();
			
			addSprite(_sunCrown, width / 2, height / 2);
			addSprite(_sunface, width / 2, height / 2);
			addSprite(_sunEye, width / 2, height / 2);
			
			setCenter();
			
			weaponApocalypce.recovery = -1;
			weaponFireball.recovery = -1;
			weaponShotgun.recovery = -1;
			
			FjConsole.inspect(weaponFireball, "recovery", "Fireball recovery", true);
			FjConsole.inspect(weaponShotgun, "recovery", "Shotgun recovery", true);
			FjConsole.inspect(weaponApocalypce, "recovery", "Apocalypse recovery", true);
			
			currentWeapon = weaponRay;
			
			addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAdded);
		}
		
		private function onAdded(e:FlinjinSpriteEvent):void
		{
			_powerBar = new SunPowerBar();
			_powerBar.value = 0;
			_powerBar.visible = false;
			(parent as GameMain).addSprite(_powerBar, x, y + _sunface.height / 4, zIndex + 1);
			
			(parent as GameMain).addEventListener(MouseEvent.MOUSE_DOWN, onFireStart);
			(parent as GameMain).addEventListener(MouseEvent.MOUSE_UP, onFireEnd);
			(parent as GameMain).addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			(parent as GameMain).addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE)
				onFireStart(null);
		
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE)
				onFireEnd(null);
		}
		
		public function onFireStart(e:MouseEvent):void
		{
			if ((!(parent as GameMain).upgragesMode) && ((parent as GameMain).factory.healthPoints > 0) && (FjInput.mousePosition.y < GameMain.groundLevel))
			{
				_currentWeapon.powerStart();
			}
		}
		
		public function onFireEnd(e:MouseEvent):void
		{
			if (!(parent as GameMain).upgragesMode)
			{
				_currentWeapon.powerEnd();
			}
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			_sunCrown.currentFrame = 0;
			
			colorTransform.redMultiplier = 1;
			colorTransform.greenMultiplier = 1;
			colorTransform.blueMultiplier = 1;
			
			weaponRay.update(deltaTime);
			weaponApocalypce.update(deltaTime);
			weaponFireball.update(deltaTime);
			weaponShotgun.update(deltaTime);
			
			if ((_currentWeapon.powerInc) && (_currentWeapon.showBar))
			{
				if (!_powerBar.visible)
					_powerBar.visible = true;
				_powerBar.value = _currentWeapon.power;
			}
			else
			{
				if (_powerBar.visible)
					_powerBar.visible = false;
			}
			
			_sunCrown.angle += 0.01 + 0.3 * _currentWeapon.power * r(deltaTime);
			var _f:int = Math.floor((_currentWeapon.power) * 3);
			_sunCrown.currentFrame = _f == 3 ? 2 : _f;
			
			setColorMults(1, 1 - _currentWeapon.power / 2, 1 - _currentWeapon.power / 2);
			
			_shotPosition.setTo(mouseVector.x * 15, mouseVector.y * 15);
			
			_sunEye.x = width / 2 + _shotPosition.x;
			_sunEye.y = height / 2 + _shotPosition.y;
		}
		
		public function get mouseVector():Point
		{
			_mouseVector.setTo(FjInput.mousePosition.x - x, FjInput.mousePosition.y - y);
			var l:Number = _mouseVector.length;
			_mouseVector.x /= l;
			_mouseVector.y /= l;
			return _mouseVector;
		}
		
		public function get currentWeapon():Weapon
		{
			return _currentWeapon;
		}
		
		public function set currentWeapon(value:Weapon):void
		{
			if (_currentWeapon != null)
				_currentWeapon.current = false;
			_currentWeapon = value;
			_currentWeapon.current = true;
		}
		
		public function get shotPosition():Point
		{
			return _shotPosition;
		}
		
		public function set shotPosition(value:Point):void
		{
			_shotPosition = value;
		}
	}
}