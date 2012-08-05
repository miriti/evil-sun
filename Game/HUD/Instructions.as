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
		
		public function Instructions(wave:GameRound)
		{
			super(Main.CONTENT_WIDTH, Main.CONTENT_HEIGHT);
			if (GameMainScenario.helpEnabled)
			{
				
				addSprite(new FjSprite(new Bitmap(new BitmapData(width, height, true, 0x88000000))), 0, 0, 0);
				
				initImages();
			}
			
			interactive = true;
			_wave = wave;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		public function show():void
		{
			if (GameMainScenario.helpEnabled)
			{
				GameMain.Instance.scenario.running = false;
				_wave.running = false;
				GameMain.Instance.pause = true;
				GameMain.Instance.addSprite(this, 0, 0, 100);
			}
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			_return();
		}
		
		protected function _return():void
		{
			GameMain.Instance.scenario.running = true;
			GameMain.Instance.pause = false;
			_wave.running = true;
			Delete();
		}
		
		protected function initImages():void
		{
		
		}
	
	}

}