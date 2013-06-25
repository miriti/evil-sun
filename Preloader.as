package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;
	import flinjin.Flinjin;
	import mochi.as3.MochiAd;
	import mochi.as3.MochiServices;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	dynamic public class Preloader extends MovieClip
	{
		//private var _loader:PreloaderDisplay = new PreloaderDisplay();
		
		//private var p:preloader = new preloader();
		
		private var _preloader_complete:Boolean = false;
		
		public function Preloader()
		{
			Flinjin.applicationName = "Evil Sun";
			
			if (stage)
			{
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				stage.quality = StageQuality.BEST;
				MochiServices.connect("d8ba1df8df94d299", root, onMochiConnectError);
				MochiAd.showPreGameAd({clip: root, id: "d8ba1df8df94d299", res: "800x450"});
			}
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
		
		/**
		   _loader.scaleX = _loader.scaleY = 800 / 1024;
		   addChild(_loader);
		 _loader.startCallback = startup;*/
		
			//p.width = 800;
			//p.height = 450;
		
			//p.x = 400;
			//p.y = 225;
			//p.addEventListener(Event.COMPLETE, onPreloaderComplete);
		
			//addChild(p);
		
		}
		
		private function onPreloaderComplete(e:Event):void
		{
			startup();
		}
		
		private function onMochiConnectError():void
		{
		
		}
		
		private function ioError(e:IOErrorEvent):void
		{
		}
		
		private function progress(e:ProgressEvent):void
		{
			//_loader.progress = e.bytesLoaded / e.bytesTotal;
			trace(e.bytesLoaded / e.bytesTotal);
		}
		
		private function checkFrame(e:Event):void
		{
			if (currentFrame == totalFrames)
			{
				stop();
				loadingFinished();
			}
			trace(currentFrame, '/', totalFrames);
		}
		
		private function loadingFinished():void
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			startup();
		}
		
		private function startup():void
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
	}
} /*
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

   _playButton.x = width / 2 + 5;
   _playButton.y = 445 - _playButton.height / 2;
   addChild(_playButton);
   }

   progressBar.graphics.beginFill(0xffffff);
   progressBar.graphics.drawRect(0, 0, val * 865, 25);
   progressBar.graphics.endFill();
   }
 }*/