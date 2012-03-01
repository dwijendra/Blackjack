
// Ambilight Class V1 - 2010 by FLAIM - mb@thinq.pl
// feel free to use and modify
// http://flaim.wordpress.com
// average colour algorithm taken and modified from -> soulwire.co.uk ColorUtil class for AS3 - THANKS!

package gameCommon.lib 
{
	import flash.display.*;
	import flash.geom.*;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.filters.GlowFilter;

	public class Ambilight extends Sprite
	{
		private var inputBitmap:BitmapData;
		private var boxHolder:Sprite;
		private var avgColours:Array;
		private var _source:*;
		private var _caller:*;
		private var _boxes:Number; //number of rectangles
		private var _animated:Boolean;
		private var _glowQuality:Number;
		
		public function Ambilight(sourceObject:DisplayObject,boxes:Number = 5,animated:Boolean = false, glowQuality:Number = 1) 
		{
			this.name = sourceObject.name+"_ambi";
			_glowQuality = glowQuality;
			_animated = animated;
			_boxes = boxes*boxes+1;
			_source = sourceObject;
			_caller = sourceObject.parent;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:*):void
		{
			inputBitmap = new BitmapData(_source.width,_source.height,true);
			inputBitmap.draw(_source);
			boxHolder = new Sprite();
			boxHolder.x = _source.x
			boxHolder.y = _source.y;
			addChild(boxHolder);
			
			var sourceObjectIndex:Number = _caller.getChildIndex(_source);
			_caller.setChildIndex(this,sourceObjectIndex);
			
			//check if animated and either run the ENTER_FRAME or create all objects once
			if(_animated)
			{
				boxHolder.addEventListener(Event.ENTER_FRAME, ef);
			}
			else
			{
				Refresh();
			}
		}
		
		private function ef(e:*):void{
			
			inputBitmap = new BitmapData(_source.width,_source.height,true);
			inputBitmap.draw(_source);
			createColourPalette();
			if(	boxHolder.width!= _source.width)
			{
				boxHolder.width = _source.width;
				boxHolder.height = _source.height;
			}
		}
		private function averageColour( source:BitmapData ):uint{
			
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
		 
			var count:Number = 0;
			var pixel:Number;
		 
			for (var x:int = 0; x < source.width; x++)
			{
				for (var y:int = 0; y < source.height; y++)
				{
					pixel = source.getPixel(x, y);
		 
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;
		 
					count++
				}
			}
		 
			red /= count;
			green /= count;
			blue /= count;
		 
			return red << 16 | green << 8 | blue;
		}
		
		private function averageColours( source:BitmapData, colours:int ):Array{
			
			var averages:Array = new Array();
			var boxes:Array = new Array();
			var columns:int = Math.round( Math.sqrt( colours ) );
		 
			var row:int = 0;
			var col:int = 0;
			var x:int = 0;
			var y:int = 0;
		 
			var w:int = Math.floor( source.width/ columns );
			var h:int = Math.floor( source.height/ columns );
		 
			for (var i:int = 0; i < colours; i++)
			{
				var rect:Rectangle = new Rectangle( x, y, w, h );
		 		
				var box:BitmapData = new BitmapData( w, h, false );
				box.copyPixels( source, rect, new Point() );
		 
				averages.push( averageColour( box ) );
				var pt:Point = new Point(x,y);
				boxes.push(pt);
				box.dispose();
		 
				col = i % columns;
		 
				x = w * col;
				y = h * row;
				
				if ( col == columns - 1 ) row++;
			}
		 
			return [averages,boxes,w,h];
			
		}
		private function createColourPalette( event:* = null ):void{
			
			while ( boxHolder.numChildren > 0 ) boxHolder.removeChildAt(0);
			var boxResults:Array = new Array();
			boxResults = averageColours(inputBitmap,_boxes);
			avgColours = boxResults[0];
			var box:Shape;
			for (var i:int = 0; i < avgColours.length; i++) 
			{
				var maxw:* = Math.round(Math.sqrt(_boxes))*boxResults[2]-boxResults[2];
				var maxh:* = Math.round(Math.sqrt(_boxes))*boxResults[3]-boxResults[3];
				
				if(boxResults[1][i].x==0 || boxResults[1][i].y==0 || boxResults[1][i].x==maxw || boxResults[1][i].y==maxh)
				{
					box = new Shape();
					box.x = boxResults[1][i].x;
					box.y = boxResults[1][i].y;
					box.graphics.beginFill( avgColours[i] );
					box.graphics.drawRect( 0, 0, boxResults[2], boxResults[3] );
					box.graphics.endFill();
					box.filters = [new GlowFilter(avgColours[i],1,85,85,1,_glowQuality)];
					boxHolder.addChild( box );
				}
			}
		}
		public function Refresh():void{
			
			inputBitmap = new BitmapData(_source.width,_source.height,true);
			inputBitmap.draw(_source);
			createColourPalette();
			boxHolder.width = _source.width;
			boxHolder.height = _source.height;
			boxHolder.x = _source.x
			boxHolder.y = _source.y;
		}
		
	}
	
}
