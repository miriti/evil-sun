package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;
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
			Flinjin.applicationName = "Evil Sun HD";
			
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
		}
		
		private function progress(e:ProgressEvent):void
		{
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
import flash.display.Bitmap;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;

class PreloaderDisplay extends Sprite
{
	[Embed(source="_assets/bmp/loader/loader-back.jpg")]
	private static var _backgourndImage:Class;
	
	[Embed(source="_assets/bmp/loader/loading.png")]
	private static var _loadingImage:Class;
	private static var _loadingBitmap:Bitmap = new _loadingImage();
	
	[Embed(source="_assets/bmp/loader/Play_game_activ.png")]
	private static var _playButton_active:Class;
	
	[Embed(source="_assets/bmp/loader/Play_game_deactiv.png")]
	private static var _playButton_inactive:Class;
	
	private var _playButtonBmpActive:Bitmap = new _playButton_active() as Bitmap;
	private var _playButtonBmpInactive:Bitmap = new _playButton_inactive() as Bitmap;
	private var _playButton:SimpleButton = new SimpleButton(_playButtonBmpActive, _playButtonBmpInactive, _playButtonBmpInactive, _playButtonBmpInactive);
	
	public var startCallback:Function;
	
	private var progressBar:Sprite = new Sprite();
	
	private var _rotatingSun:flmcLoaderRotatigSun = new flmcLoaderRotatigSun();
	
	public function PreloaderDisplay():void
	{
		addChild(new _backgourndImage());
		
		_loadingBitmap.x = (width - _loadingBitmap.width) / 2;
		_loadingBitmap.y = 445 - _loadingBitmap.height / 2;
		addChild(_loadingBitmap);
		
		progressBar.x = 83;
		progressBar.y = 486;
		addChild(progressBar);
		
		_rotatingSun.x = 520;
		_rotatingSun.y = 285;
		addChild(_rotatingSun);
		
		_playButton.addEventListener(MouseEvent.MOUSE_DOWN, onPlayGame);
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
			
			_playButton.x = (width - _playButton.width) / 2 + 5;
			_playButton.y = 445 - _playButton.height / 2;
			addChild(_playButton);
		}
		
		progressBar.graphics.beginFill(0xffffff);
		progressBar.graphics.drawRect(0, 0, val * 865, 25);
		progressBar.graphics.endFill();
	}
}