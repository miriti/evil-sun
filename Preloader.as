package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;
	import flinjin.FjLog;
	import flinjin.Flinjin;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Preloader extends MovieClip
	{
		private var _loader:PreloaderDisplay = new PreloaderDisplay();
		
		public function Preloader()
		{
			if (Main.CONTENT_WIDTH == Main.SCENE_WIDTH)
			{
				Flinjin.applicationName = "Evil Sun";
			}
			else
			{
				Flinjin.applicationName = "Evil Sun HD";
			}
			
			if (stage)
			{
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO show loader
			addChild(_loader);
			_loader.startCallback = startup;
		}
		
		private function ioError(e:IOErrorEvent):void
		{
			FjLog.l(e.text);
		}
		
		private function progress(e:ProgressEvent):void
		{
			// TODO update loader
			_loader.progress = e.bytesLoaded / e.bytesTotal;
		}
		
		private function checkFrame(e:Event):void
		{
			if (currentFrame == totalFrames)
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
		
			// TODO hide loader
		
		}
		
		private function startup():void
		{
			removeChild(_loader);
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
	
	}

}
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class PreloaderDisplay extends Sprite
{
	[Embed(source="_assets/bmp/loader/loader back.jpg")]
	private static var _backgourndImage:Class;
	
	[Embed(source="_assets/bmp/loader/loading.png")]
	private static var _loadingImage:Class;
	private static var _loadingBitmap:Bitmap = new _loadingImage();
	
	private var _rotatingSun:flmcLoaderRotatigSun = new flmcLoaderRotatigSun();
	
	private var _playGameButton:flmcPlayGameButton = new flmcPlayGameButton();
	
	public var startCallback:Function;
	
	private var progressBar:Sprite = new Sprite();
	
	public function PreloaderDisplay():void
	{
		addChild(new _backgourndImage());
		_rotatingSun.x = 520;
		_rotatingSun.y = 280;
		addChild(_rotatingSun);
		
		_loadingBitmap.x = (width - _loadingBitmap.width) / 2;
		_loadingBitmap.y = 445 - _loadingBitmap.height / 2;
		addChild(_loadingBitmap);
		
		_playGameButton.x = width / 2;
		_playGameButton.y = 445;
		_playGameButton.addEventListener(MouseEvent.MOUSE_DOWN, onPlayGame);
		
		progressBar.x = 83;
		progressBar.y = 486;
		addChild(progressBar);
	}
	
	private function onPlayGame(e:MouseEvent):void
	{
		startCallback.call();
	}
	
	public function set progress(val:Number):void
	{
		if (val == 1)
		{
			removeChild(_loadingBitmap);
			addChild(_playGameButton);
		}
		
		progressBar.graphics.beginFill(0xffffff);
		progressBar.graphics.drawRect(0, 0, val * 865, 25);
		progressBar.graphics.endFill();
	}
}