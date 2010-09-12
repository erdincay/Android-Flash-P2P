package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;

	/**
	public class SliderUI extends Sprite {
		// - PRIVATE & PROTECTED VARIABLES -------------------------------------------------------------------------
		private var _stage:Stage;
		private var _track:Sprite;
		private var _slider:Sprite;
		private var _timer:Timer;
		private var _percent:Number;
		private var _lowVal:Number;
		private var _highVal:Number;
		private var _startVal:Number;
		private var _currentVal:Number;
		private var _range:Number;
		private var _axis:String;
		private var _changeProp:String;
		
		public var isDown:Boolean;

		// - PUBLIC & INTERNAL VARIABLES ---------------------------------------------------------------------------
		// - CONSTRUCTOR	-------------------------------------------------------------------------------------------
		/**
		public function SliderUI($stage:Stage, $axis:String, $track:Sprite, $slider:Sprite, $lowVal:Number, $highVal:Number, $startVal:Number = 0):void {
			this._stage = $stage;
			this._axis = $axis;
			this._track = $track;
			this._slider = $slider;
			this._lowVal = $lowVal;
			this._highVal = $highVal;
			this._startVal = $startVal;
			this._changeProp = (this._axis == "x") ? "width" : "height";
			this._range = (Math.abs(this._lowVal) + this._highVal);
			this._slider.buttonMode = true;
			this._timer = new Timer(10);
			if (this._startVal < this._lowVal)
				this._startVal = this._lowVal;
			if (this._startVal > this._highVal)
				this._startVal = this._highVal;
			if (this._startVal < 0) {
				this._percent = (Math.abs(this._lowVal + Math.abs(this._startVal)) / this._range);
			} else {
				this._percent = (Math.abs(this._lowVal - this._startVal) / this._range);
			}
			this._currentVal = (this._lowVal + (this._range * this._percent));
			if (this._axis == "x") {
				this._slider[this._axis] = (this._track[this._axis] + (this._percent * this._track[this._changeProp]));
			} else {
				this._slider[this._axis] = (this._track[this._axis] - (this._percent * this._track[this._changeProp]));
			}
			this.initEvents();
		}

		// - PRIVATE & PROTECTED METHODS ---------------------------------------------------------------------------
		/**
		private function initEvents():void {
			this._slider.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			this._slider.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			this._timer.addEventListener(TimerEvent.TIMER, updateInfo);
		}

		// - PUBLIC & INTERNAL METHODS -----------------------------------------------------------------------------
		/**
		public function enable():void {
			this.initEvents();
		}

		/**
		public function disable():void {
			this._slider.removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			this._slider.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			this._timer.removeEventListener(TimerEvent.TIMER, updateInfo);
		}

		/**
		public function destroy():void {
			this.disable();
			this._timer = null;
		}

		// - EVENT HANDLERS ----------------------------------------------------------------------------------------
		/**
		private function handleMouseDown($evt:MouseEvent):void {
			isDown = true;
			
			if (this._axis == "x") {
				this._slider.startDrag(false, new Rectangle(this._track.x, this._slider.y, this._track.width, 0));
			} else {
				this._slider.startDrag(false, new Rectangle(this._slider.x, this._track.y, 0, -this._track.height));
			}
			this._timer.start();
			this._stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}

		/**
		private function handleMouseUp($evt:MouseEvent):void {
			isDown = false;
			
			this._slider.stopDrag();
			this._timer.reset();
			dispatchEvent(new Event("up", true, false));
			this._stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}

		/**
		private function updateInfo($evt:TimerEvent):void {
			this._percent = Math.abs((this._slider[this._axis] - this._track[this._axis]) / this._track[this._changeProp]);
			this._currentVal = (this._lowVal + (this._range * this._percent));
		}

		// - GETTERS & SETTERS -------------------------------------------------------------------------------------
		/**
		public function get percent():Number {
			return this._percent;
		}

		/**
		public function get currentValue():Number {
			return this._currentVal;
		}


		// - END CLASS ---------------------------------------------------------------------------------------------
	}
}