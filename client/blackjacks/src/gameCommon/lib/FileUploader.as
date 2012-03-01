package gameCommon.lib 
{
			
	import mx.controls.*;
    import mx.managers.*;
    import mx.events.*;
    import flash.events.*;
    import flash.net.*;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;

	
	/**
	 * ...
	 * @author ...
	 */
	public class FileUploader extends EventDispatcher
	{
		            
            private var _strUploadUrl:String;
            private var _refAddFiles:FileReferenceList;    
            private var _refUploadFile:FileReference;
            public var _arrUploadFiles:Array;
            public var _numCurrentUpload:Number = 0; 
			
		
		public function FileUploader() 
		{
			
		}
           
            
            // Set uploadUrl
            public function set uploadUrl(strUploadUrl:String):void {
                _strUploadUrl = strUploadUrl;
            }
            
            // Initalize
            public function initCom():void {
                _arrUploadFiles = new Array();                
                //enableUI();
                //uploadCheck();
            }
			
			private function getImageTypeFilter():FileFilter {
				return new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png");
			}

            
            // Called to add file(s) for upload
            public function addFiles():void {
                _refAddFiles = new FileReferenceList();
                _refAddFiles.addEventListener(Event.SELECT, onSelectFile);
				var typeA:Array = new Array();
				typeA.push(getImageTypeFilter());
                _refAddFiles.browse(typeA);
            }
            
            // Called when a file is selected
            private function onSelectFile(event:Event):void {
                var arrFoundList:Array = new Array();
                // Get list of files from fileList, make list of files already on upload list
                for (var i:Number = 0; i < _arrUploadFiles.length; i++) {
                    for (var j:Number = 0; j < _refAddFiles.fileList.length; j++) {
                        if (_arrUploadFiles[i].name == _refAddFiles.fileList[j].name) {
                            arrFoundList.push(_refAddFiles.fileList[j].name);
                            _refAddFiles.fileList.splice(j, 1);
                            j--;
                        }
                    }
                }
                if (_refAddFiles.fileList.length >= 1) {                
                    for (var k:Number = 0; k < _refAddFiles.fileList.length; k++) {
                        _arrUploadFiles.push({
                            FileName:_refAddFiles.fileList[k].name,
                            FileSize:formatFileSize(_refAddFiles.fileList[k].size),
                            file:_refAddFiles.fileList[k]});
                    }
                    //listFiles.dataProvider = _arrUploadFiles;
                    //listFiles.selectedIndex = _arrUploadFiles.length - 1;
                }                
                if (arrFoundList.length >= 1) {
                    Alert.show("The file(s): \n\n• " + arrFoundList.join("\n• ") + "\n\n...are already on the upload list. Please change the filename(s) or pick a different file.", "File(s) already on list");
                }
				dispatchEvent(new Event("FileSelected"));
                //updateProgBar();
                //scrollFiles();
                //uploadCheck();
            }
            
            // Called to format number to file size
            private function formatFileSize(numSize:Number):String {
                var strReturn:String;
                numSize = Number(numSize / 1000);
                strReturn = String(numSize.toFixed(1) + " KB");
                if (numSize > 1000) {
                    numSize = numSize / 1000;
                    strReturn = String(numSize.toFixed(1) + " MB");
                    if (numSize > 1000) {
                        numSize = numSize / 1000;
                        strReturn = String(numSize.toFixed(1) + " GB");
                    }
                }                
                return strReturn;
            }
            
            // Called to remove selected file(s) for upload
            public function removeFiles(arrSelected:Array):void {
               // var arrSelected:Array = listFiles.selectedIndices;
			   //trace (_arrUploadFiles + " 1 ");
                if (arrSelected.length >= 1) {
                    for (var i:Number = 0; i < arrSelected.length; i++) {
						trace (_arrUploadFiles[Number(arrSelected[i])]  + " and and " + arrSelected[i]);
                        _arrUploadFiles[Number(arrSelected[i])] = null;
                    }
					//trace (_arrUploadFiles + "  2 ");
                    for (var j:Number = 0; j < _arrUploadFiles.length; j++) {
                        if (_arrUploadFiles[j] == null) {
                            _arrUploadFiles.splice(j, 1);
                            j--;
                        }
                    }
					//trace (_arrUploadFiles + "  3 ");
					//trace (_arrUploadFiles);
					dispatchEvent(new Event("FileRemoved"));  
                }

            }
            
      
            
            // Called to upload file based on current upload number
            public function startUpload():void {
                if (_arrUploadFiles.length > 0) {
                    //disableUI();
                    
                    //listFiles.selectedIndex = _numCurrentUpload;
                    //scrollFiles();
                    
                    // Variables to send along with upload
                    var sendVars:URLVariables = new URLVariables();
                    sendVars.action = "upload";
                    
                    var request:URLRequest = new URLRequest();
                    request.data = sendVars;
                    request.url = _strUploadUrl;
                    request.method = URLRequestMethod.POST;
                    _refUploadFile = _arrUploadFiles[_numCurrentUpload].file;// new FileReference();
                    //_refUploadFile = listFiles.selectedItem.file;
                    _refUploadFile.addEventListener(ProgressEvent.PROGRESS, onUploadProgress);
                    _refUploadFile.addEventListener(Event.COMPLETE, onUploadComplete);
                    _refUploadFile.addEventListener(IOErrorEvent.IO_ERROR, onUploadIoError);
                    _refUploadFile.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onUploadSecurityError);
                    _refUploadFile.upload(request, "file", false);
                }
            }
            
            // Cancel and clear eventlisteners on last upload
            private function clearUpload():void {
                _refUploadFile.removeEventListener(ProgressEvent.PROGRESS, onUploadProgress);
                _refUploadFile.removeEventListener(Event.COMPLETE, onUploadComplete);
                _refUploadFile.removeEventListener(IOErrorEvent.IO_ERROR, onUploadIoError);
                _refUploadFile.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onUploadSecurityError);
                _refUploadFile.cancel();
                _numCurrentUpload = 0;
                //updateProgBar();
                //enableUI();
            }
            
            // Called on upload cancel
            private function onUploadCanceled():void {
                clearUpload();
                dispatchEvent(new Event("uploadCancel"));
            }
            
            // Get upload progress
            private function onUploadProgress(event:ProgressEvent):void {
                var numPerc:Number = Math.round((event.bytesLoaded / event.bytesTotal) * 100);
               // updateProgBar(numPerc);
                var evt:ProgressEvent = new ProgressEvent("uploadProgress", false, false, event.bytesLoaded, event.bytesTotal);
                dispatchEvent(evt);
            }
            
            // Update progBar
            /*private function updateProgBar(numPerc:Number = 0):void {
                var strLabel:String = (_numCurrentUpload + 1) + "/" + _arrUploadFiles.length;
                strLabel = (_numCurrentUpload + 1 <= _arrUploadFiles.length && numPerc > 0 && numPerc < 100) ? numPerc + "% - " + strLabel : strLabel;
                strLabel = (_numCurrentUpload + 1 == _arrUploadFiles.length && numPerc == 100) ? "Upload Complete - " + strLabel : strLabel;
                strLabel = (_arrUploadFiles.length == 0) ? "" : strLabel;
                progBar.label = strLabel;
                progBar.setProgress(numPerc, 100);
                progBar.validateNow();
            }*/
            
            // Called on upload complete
            private function onUploadComplete(event:Event):void {
                _numCurrentUpload++;                
                if (_numCurrentUpload < _arrUploadFiles.length) {
                    startUpload();
                } else {
                    //enableUI();
                    clearUpload();
                    dispatchEvent(new Event("uploadComplete"));
                }
            }
            
            // Called on upload io error
            private function onUploadIoError(event:IOErrorEvent):void {
                clearUpload();
                var evt:IOErrorEvent = new IOErrorEvent("uploadIoError", false, false, event.text);
                dispatchEvent(evt);
            }
            
            // Called on upload security error
            private function onUploadSecurityError(event:SecurityErrorEvent):void {
                clearUpload();
                var evt:SecurityErrorEvent = new SecurityErrorEvent("uploadSecurityError", false, false, event.text);
                dispatchEvent(evt);
            }
            
           // Change view state
           // private function changeView():void {
           //    currentState = (currentState == "mini") ? "" : "mini";
           //}		
	}	
}