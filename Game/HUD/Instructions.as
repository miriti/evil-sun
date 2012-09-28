package Game.HUD
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteText;
	import Game.GameMain;
	import Game.GameMainScenario;
	import Game.Rounds.GameRound;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Instructions extends FjLayer
	{
		private var _closeButton:FjSpriteText;
		private var _wave:GameRound;
		private var _time:Number;
		private var _timeTotal:Number;
		static protected var _back:FjSprite = null;
		
		public function Instructions(wave:GameRound, time:Number = 5000)
		{
			super(Main.CONTENT_WIDTH, Main.CONTENT_HEIGHT);
			if (GameMainScenario.helpEnabled)
			{
				if (_back == null)
				{
					_back = new FjSprite(new Bitmap(new BitmapData(width, height, true, 0xbb000000)));
					GameMain.Instance.addSprite(_back, 0, 0, 12);
				}
				
				initImages();
			}
			
			_wave = wave;
			_time = time;
			_timeTotal = time;
			alpha = 0;
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if (_time > 0)
			{
				if (_time <= _timeTotal / 4)
				{
					alpha = _time / (_timeTotal / 4);
				}
				else
				{
					if (_timeTotal - _time < 1000)
					{
						alpha = (_timeTotal - _time) / 1000;
					}
				}
				_time -= deltaTime;
				
				if (GameMain.Instance.pause && visible)
					visible = false;
				if ((!GameMain.Instance.pause) && (!visible))
					visible = true;
			}
			else
			{
				_return();
			}
		}
		
		override public function Delete(doDispose:Boolean = false):void
		{
			super.Delete(doDispose);
		
		}
		
		override public function get alpha():Number
		{
			return super.alpha;
		}
		
		override public function set alpha(value:Number):void
		{
			super.alpha = value;
			_back.alpha = value;
			if (_back.alpha <= 0)
				_back.visible = false;
			else if (!_back.visible)
				_back.visible = true;
		}
		
		public function show():void
		{
			if (GameMainScenario.helpEnabled)
			{
				GameMain.Instance.addSprite(this, 0, 0, 51);
			}
		}
		
		protected function _return():void
		{
			Delete();
		}
		
		protected function initImages():void
		{
		
		}
	
	}

}