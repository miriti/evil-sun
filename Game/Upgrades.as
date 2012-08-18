package Game
{
	import flash.display.Bitmap;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.Flinjin;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import flinjin.graphics.FjSpriteText;
	import Game.HUD.AreYouSureDialog;
	import Game.HUD.Button;
	import Game.HUD.MusicButton;
	import Game.HUD.SoundButton;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Upgrades extends FjLayer
	{
		private var _gradeButtons:Dictionary = new Dictionary();
		private var _background:Bitmap;
		private var _open:Boolean = false;
		private var _moving:Boolean = false;
		
		static private const DOWN_SPEED:Number = 40;
		static private const UP_SPEED:Number = 40;
		
		[Embed(source="../_assets/bmp/hud/shop/button_shop_shot.png")]
		static private var _bitmapRayButton:Class;
		
		[Embed(source="../_assets/bmp/hud/shop/button_shop_fireball.png")]
		static private var _bitmapFireballButton:Class;
		
		[Embed(source="../_assets/bmp/hud/shop/button_shop_shotgun.png")]
		static private var _bitmapShotgunButton:Class;
		
		[Embed(source="../_assets/bmp/hud/shop/button_shop_armag.png")]
		static private var _bitmapApocalypseButton:Class;
		
		[Embed(source="../_assets/bmp/hud/shop/arrow-button-80x83.png")]
		static private var _bitmapArrowButton:Class;
		
		[Embed(source="../_assets/bmp/hud/shop/button-repair-factory-270x57.png")]
		static private var _bitmapRepairFactoryButton:Class;
		
		[Embed(source="../_assets/bmp/hud/shop/back-to-menu-238x51.png")]
		static private var _bitmapBackmenuButton:Class;
		
		private var _arrowButton:Button;
		private var _repairFactoryButton:RepairFactoryButton;
		private var _backmenuButton:Button;
		private var _moneyTitle:FjSpriteText;
		private var _soundButton:SoundButton = new SoundButton();
		private var _musicButton:MusicButton = new MusicButton();
		
		public function Upgrades()
		{
			_background = new (Assets.i().bitmapShopBack) as Bitmap;
			
			super(_background.width, _background.height);
			addSprite(new FjSprite(_background));
			
			_gradeButtons["laserray"] = new UpgradeButton(GameMain.Instance.sun.weaponRay, new _bitmapRayButton());
			_gradeButtons["shotgun"] = new UpgradeButton(GameMain.Instance.sun.weaponShotgun, new _bitmapShotgunButton());
			_gradeButtons["fireball"] = new UpgradeButton(GameMain.Instance.sun.weaponFireball, new _bitmapFireballButton());
			_gradeButtons["apocalypse"] = new UpgradeButton(GameMain.Instance.sun.weaponApocalypce, new _bitmapApocalypseButton());
			
			addSprite(_gradeButtons["laserray"], 40, 40);
			addSprite(_gradeButtons["fireball"], 40, 123);
			addSprite(_gradeButtons["shotgun"], 40, 206);
			addSprite(_gradeButtons["apocalypse"], 40, 289);
			
			_arrowButton = new Button(new _bitmapArrowButton(), null, new Point(80, 83), new FjSpriteAnimation());
			_arrowButton.inactiveFrame = 1;
			_arrowButton.activeFrame = 0;
			_arrowButton.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
				{
					GameMain.Instance.upgragesMode = false;
				});
			addSprite(_arrowButton, width - _arrowButton.width - 50, height - _arrowButton.height - 40);
			
			_repairFactoryButton = new RepairFactoryButton(new _bitmapRepairFactoryButton(), null, new Point(270, 57));
			_repairFactoryButton.setCenter();
			_repairFactoryButton.interactive = false;
			_repairFactoryButton.alpha = 0.5;
			_repairFactoryButton.addEventListener(MouseEvent.MOUSE_DOWN, onRepairFactory);
			
			addSprite(_repairFactoryButton, width - 200, 80);
			
			_backmenuButton = new Button(new _bitmapBackmenuButton(), null, new Point(238, 51));
			_backmenuButton.setCenter();
			_backmenuButton.addEventListener(MouseEvent.MOUSE_DOWN, onBackMenu);
			addSprite(_backmenuButton, width - 200, _repairFactoryButton.y + _repairFactoryButton.height + 20);
			
			addSprite(_musicButton, width - 200 - _musicButton.width - 10, _backmenuButton.y + _backmenuButton.height + 20);
			addSprite(_soundButton, width - 200 + 10, _backmenuButton.y + _backmenuButton.height + 20);
			
			_moneyTitle = new FjSpriteText("$ 0", new TextFormat("gameFont", 36, 0xffe492));
			addSprite(_moneyTitle, _gradeButtons["apocalypse"].x + _gradeButtons["apocalypse"].width, 307);
			
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAdded);
			
			interactive = true;
		}
		
		private function onAdded(e:FlinjinSpriteEvent):void
		{
		
		}
		
		private function onBackMenu(e:MouseEvent):void
		{
			var _ays:AreYouSureDialog = new AreYouSureDialog();
			_ays.noCallBack = function():void
			{
				interactive = true;
			};
			
			_ays.yesCallback = function():void
			{
				Flinjin.Instance.Camera.LookAt(new Menu());
			};
			parent.addSprite(_ays, (parent.width - _ays.width) / 2, (parent.height - _ays.height) / 2, zIndex + 1);
			interactive = false;
		}
		
		private function onRepairFactory(e:MouseEvent):void
		{
			if (GameMain.money >= GameMain.Instance.factory.repairPrice)
			{
				if (GameMain.buy(GameMain.Instance.factory.repairPrice))
				{
					GameMain.Instance.factory.repair();
				}
				updateCosts();
			}
		}
		
		override protected function onMouseEvent(e:MouseEvent):void
		{
			super.onMouseEvent(e);
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			if (_moving)
			{
				if (_open)
				{
					if (y < Flinjin.sceneHeight / 2)
					{
						y += r(deltaTime) * DOWN_SPEED;
						if (y > (Flinjin.sceneHeight - height) / 2)
						{
							y = (Flinjin.sceneHeight - height) / 2;
							_moving = false;
						}
					}
				}
				else
				{
					if (y > -height)
					{
						y -= r(deltaTime) * UP_SPEED;
						if (y < -height)
						{
							y = -height;
							_moving = false;
							visible = false;
						}
					}
				}
			}
		}
		
		public function avail():Boolean
		{
			var _sun:Sun = GameMain.Instance.sun;
			return (Math.min(_sun.weaponRay.upgradeCost, _sun.weaponApocalypce.upgradeCost, _sun.weaponFireball.upgradeCost, _sun.weaponShotgun.upgradeCost) <= GameMain.money);
		}
		
		public function hide():void
		{
			_open = false;
			_moving = true;
		}
		
		public function show():void
		{
			_moneyTitle.text = "$ " + GameMain.money;
			visible = true;
			_open = true;
			_moving = true;
			updateCosts();
		}
		
		public function updateCosts():void
		{
			_gradeButtons["laserray"].price = GameMain.Instance.sun.weaponRay.upgradeCost;
			_gradeButtons["shotgun"].price = GameMain.Instance.sun.weaponShotgun.upgradeCost;
			_gradeButtons["fireball"].price = GameMain.Instance.sun.weaponFireball.upgradeCost;
			_gradeButtons["apocalypse"].price = GameMain.Instance.sun.weaponApocalypce.upgradeCost;
			
			if ((GameMain.money >= GameMain.Instance.factory.repairPrice) || (GameMain.Instance.factory.healthPoints < GameMain.Instance.factory.healthPointsMax))
			{
				_repairFactoryButton.alpha = 1;
				_repairFactoryButton.interactive = true;
			}
			else
			{
				_repairFactoryButton.alpha = 0.5;
				_repairFactoryButton.interactive = false;
			}
			
			_repairFactoryButton.repairPrice = GameMain.Instance.factory.repairPrice;
			_moneyTitle.text = '$ ' + GameMain.money;
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.ESCAPE)
			{
				GameMain.Instance.upgragesMode = false;
			}
		}
	}
}

import flash.display.Bitmap;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.sampler.NewObjectSample;
import flinjin.events.FlinjinSpriteEvent;
import flinjin.graphics.FjLayer;
import flinjin.graphics.FjSprite;
import flinjin.graphics.FjSpriteAnimation;
import flinjin.FjInput;
import Game.GameMain;
import Game.HUD.Button;
import Game.HUD.ButtonHintSmall;
import Game.Objects.Factory;
import Game.Weapons.Weapon;

class UpgradeButton extends FjLayer
{
	private var _price:Number = 0;
	private var _weapon:Weapon = null;
	private var _factory:Factory = null;
	private var _iconSprite:FjSprite;
	
	[Embed(source="../_assets/bmp/hud/shop/point-23x46.png")]
	private static var _bitmapPoint:Class;
	
	[Embed(source="../_assets/bmp/hud/shop/plus-68x67.png")]
	private static var _bitmapPlusButton:Class;
	
	private var _points:Vector.<FjSprite> = new Vector.<FjSprite>();
	private var _plusButton:Button = new Button(new _bitmapPlusButton(), null, new Point(68, 67), new FjSpriteAnimation());
	
	private var _hint:ButtonHintSmall = new ButtonHintSmall("$ 0");
	
	function UpgradeButton(atWeapon:Weapon = null, icon:Bitmap = null)
	{
		interactive = true;
		_iconSprite = new FjSprite(icon);
		
		for (var i:int = 0; i < 5; i++)
		{
			_points[i] = new FjSprite(new _bitmapPoint(), null, new Point(23, 46), new FjSpriteAnimation());
			_points[i].animation.stop();
			_points[i].currentFrame = 1;
		}
		
		super(_iconSprite.width + 5 + 5 * 30 + 70, _iconSprite.height);
		addSprite(_iconSprite);
		
		for (var j:int = 0; j < 5; j++)
		{
			addSprite(_points[j], _iconSprite.width + 5 + j * 30, 20);
		}
		
		_plusButton.animation.stop();
		_plusButton.activeFrame = 0;
		_plusButton.inactiveFrame = 1;
		_plusButton.addEventListener(MouseEvent.MOUSE_DOWN, onPlusMouseDown);
		
		addSprite(_plusButton, _iconSprite.width + 5 + 5 * 30, 10);
		_weapon = atWeapon;
		
		addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAdded);
	}
	
	override public function Move(deltaTime:Number):void
	{
		super.Move(deltaTime);
		
		if (_mouseOver && !_hint.visible)
			_hint.visible = true;
		if (!_mouseOver && _hint.visible)
			_hint.visible = false;
	}
	
	private function onAdded(e:FlinjinSpriteEvent):void
	{
		parent.addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onParentAdded);
	}
	
	private function onParentAdded(e:FlinjinSpriteEvent):void
	{
		parent.parent.addSprite(_hint, x + Main.CONTENT_WIDTH / 2 - 65, y + Main.CONTENT_HEIGHT / 2 - parent.height / 2 + 20, 1000);
	}
	
	private function onPlusMouseDown(e:MouseEvent):void
	{
		_weapon.upgrade(_weapon.level + 1);
		GameMain.buy(_price);
		GameMain.Instance.upgrades.updateCosts();
	}
	
	public function get price():Number
	{
		return _price;
	}
	
	public function set price(value:Number):void
	{
		_price = value;
		
		_hint.hintText = "$ " + value.toString();
		
		if (_weapon != null)
		{
			for (var i:int = 0; i < _weapon.level; i++)
			{
				_points[i].currentFrame = 0;
			}
		}
		
		if ((_price <= GameMain.money) && (((_weapon != null) && (_weapon.recovery >= 0)) || ((_factory != null) && (_factory.healthPoints < _factory.healthPointsMax))) && (_weapon.level < 6))
		{
			_plusButton.interactive = true;
			_plusButton.alpha = 1;
		}
		else
		{
			_plusButton.interactive = false;
			_plusButton.alpha = 0.5;
		}
	}
	
	public function get factory():Factory
	{
		return _factory;
	}
	
	public function set factory(value:Factory):void
	{
		_factory = value;
	}
}

class RepairFactoryButton extends Button
{
	private var _hint:ButtonHintSmall = new ButtonHintSmall("$ 0");
	
	private var _repairPrice:Number = 0;
	
	public function RepairFactoryButton(spriteBmp:Bitmap, rotationCenter:Point = null, frameSize:Point = null, spriteAnimation:FjSpriteAnimation = null):void
	{
		super(spriteBmp, rotationCenter, frameSize, spriteAnimation);
		addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAdded);
	}
	
	private function onAdded(e:FlinjinSpriteEvent):void
	{
		parent.addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onParentAdded);
	}
	
	private function onParentAdded(e:FlinjinSpriteEvent):void
	{
		parent.parent.addSprite(_hint, Main.CONTENT_WIDTH / 2 + parent.width / 2 - 60, Main.CONTENT_HEIGHT / 2 - parent.height / 2 + 55, 1000);
	}
	
	override public function Move(deltaTime:Number):void
	{
		super.Move(deltaTime);
		if (_mouseOver && !_hint.visible)
			_hint.visible = true;
		if (!_mouseOver && _hint.visible)
			_hint.visible = false;
	}
	
	public function get repairPrice():Number
	{
		return _repairPrice;
	}
	
	public function set repairPrice(value:Number):void
	{
		_repairPrice = value;
		_hint.hintText = "$ " + value.toString();
	}
}