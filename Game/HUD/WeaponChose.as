package Game.HUD
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.FjInput;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import flinjin.sound.FjSnd;
	import flinjin.sound.FjSnd;
	import Game.Balance;
	import Game.GameMain;
	import Game.Sun;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class WeaponChose extends FjLayer
	{
		private var _buttons:Vector.<WeaponButton> = new Vector.<WeaponButton>();
		private var _shines:Vector.<WeaponButtonShining> = new Vector.<WeaponButtonShining>();
		
		[Embed(source="../../_assets/bmp/hud/weapon-buttons/apacalypse-92x87.png")]
		private static var _bitmapApocalypse:Class;
		
		[Embed(source="../../_assets/bmp/hud/weapon-buttons/fireball-92x87.png")]
		private static var _bitmapFireball:Class;
		
		[Embed(source="../../_assets/bmp/hud/weapon-buttons/ray-92x87.png")]
		private static var _bitmapRay:Class;
		
		[Embed(source="../../_assets/bmp/hud/weapon-buttons/shotgun-92x87.png")]
		private static var _bitmapShotgun:Class;
		
		static private var _sun:Sun;
		
		public static var I:WeaponChose;
		
		public function WeaponChose()
		{
			I = this;
			_sun = GameMain.Instance.sun;
			_buttons.push(new WeaponButton(new _bitmapRay(), _sun.weaponRay));
			_buttons.push(new WeaponButton(new _bitmapFireball(), _sun.weaponFireball));
			_buttons.push(new WeaponButton(new _bitmapShotgun(), _sun.weaponShotgun));
			_buttons.push(new WeaponButton(new _bitmapApocalypse(), _sun.weaponApocalypce));
			
			super(_buttons.length * (_buttons[0].width * 0.85), _buttons[0].height);
			
			_buttons[0].callback = weaponRay;
			_buttons[1].callback = weaponFire;
			_buttons[2].callback = weaponShotgun;
			_buttons[3].callback = weaponApocalypse;
			
			for (var i:int = 0; i < _buttons.length; i++)
			{
				var nx:Number = i * _buttons[i].width * 0.8;
				
				_shines[i] = new WeaponButtonShining();
				_shines[i].visible = false;
				addSprite(_buttons[i], nx, 0);
				addSprite(_shines[i], nx, 0, 1);
			}
			
			interactive = true;
			
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function deactivateAll():void
		{
			for (var i:int = 0; i < _buttons.length; i++)
			{
				_buttons[i].active = false;
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.NUMBER_1: 
					weaponRay();
					break;
				case Keyboard.NUMBER_2: 
					weaponFire();
					break;
				case Keyboard.NUMBER_3: 
					weaponShotgun();
					break;
				case Keyboard.NUMBER_4: 
					weaponApocalypse();
					break;
			}
		}
		
		static public function weaponRay():void
		{
			if (_sun.weaponRay.recovery >= _sun.weaponRay.recoveryTime)
			{
				_sun.currentWeapon = _sun.weaponRay;
				if (FjInput.isMouseDown)
					_sun.currentWeapon.powerStart();
				I.deactivateAll();
				I.buttons[0].active = true;
			}
			else
				FjSnd.playSound("error");
		}
		
		static public function weaponShotgun():void
		{
			if (_sun.weaponShotgun.recovery >= _sun.weaponShotgun.recoveryTime)
			{
				_sun.currentWeapon = _sun.weaponShotgun;
				if (FjInput.isMouseDown)
					_sun.currentWeapon.powerStart();
				I.deactivateAll();
				I.buttons[2].active = true;
			}
			else
				FjSnd.playSound("error");
		}
		
		static public function weaponFire():void
		{
			if (_sun.weaponFireball.recovery >= _sun.weaponFireball.recoveryTime)
			{
				_sun.currentWeapon = _sun.weaponFireball;
				if (FjInput.isMouseDown)
					_sun.currentWeapon.powerStart();
				I.deactivateAll();
				I.buttons[1].active = true;
			}
			else
				FjSnd.playSound("error");
		}
		
		static public function weaponApocalypse():void
		{
			if (_sun.weaponApocalypce.recovery >= _sun.weaponApocalypce.recoveryTime)
			{
				_sun.weaponApocalypce.power = 1;
				_sun.weaponApocalypce.fire();
			}
			else
				FjSnd.playSound("error");
		}
		
		override public function Move(deltaTime:Number):void
		{
			var pa:Number = _buttons[3].alpha;
			
			super.Move(deltaTime);
			
			if ((pa != 1) && (_buttons[3].alpha == 1))
			{
				_shines[3].visible = true;
			}
		}
		
		public function get buttons():Vector.<WeaponButton>
		{
			return _buttons;
		}
		
		public function set buttons(value:Vector.<WeaponButton>):void
		{
			_buttons = value;
		}
	}

}
import flash.display.Bitmap;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.ShaderFilter;
import flash.geom.Point;
import flinjin.graphics.FjSprite;
import flinjin.graphics.FjSpriteAnimation;
import Game.Weapons.Weapon;

class WeaponButton extends FjSprite
{
	private var _active:Boolean = false;
	private var _callback:Function = null;
	private var _weapon:Weapon;
	
	function WeaponButton(bmp:Bitmap, wep:Weapon):void
	{
		super(bmp, null, new Point(92, 87), new FjSpriteAnimation("states"));
		animation.stop();
		interactive = true;
		active = false;
		_weapon = wep;
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	override public function Move(deltaTime:Number):void
	{
		super.Move(deltaTime);
		if (_weapon.recoveryTime > 500)
		{
			if (_weapon.recovery < _weapon.recoveryTime)
				alpha = (_weapon.recovery / _weapon.recoveryTime) * 0.5;
			else
				alpha = 1;
		}
		else
		{
			if (_weapon.recovery == -1)
				alpha = 0;
			else
				alpha = 1;
		}
	}
	
	private function onMouseDown(e:MouseEvent):void
	{
		if (_callback != null)
			_callback.call();
	}
	
	public function get active():Boolean
	{
		return _active;
	}
	
	public function set active(value:Boolean):void
	{
		if (value)
			currentFrame = 0;
		else
			currentFrame = 1;
		_active = value;
	}
	
	public function get callback():Function
	{
		return _callback;
	}
	
	public function set callback(value:Function):void
	{
		_callback = value;
	}
}