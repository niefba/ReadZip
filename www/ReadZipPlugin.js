/**
 * ReadZipPlugin.js
 *  
 * Cordova Read Zip File plugin
 *
 * Created by Fabien Tillon on 18/06/12.
 * Copyright (c) 2012 Rupil. All rights reserved.
 *
 */

var ReadZipPlugin = function(){
}

cordova.addConstructor(function(){
                       if(!window.plugins) window.plugins = {};
                       window.plugins.readZip = new ReadZipPlugin();
                       });

ReadZipPlugin.prototype.extractZip = function(content, password, filename, base64, successCallback, errorCallback) 
{
    return cordova.exec(successCallback, errorCallback, "ReadZipPlugin", "extract", [content, password, filename, base64]);
};