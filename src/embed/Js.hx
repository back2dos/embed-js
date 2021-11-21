package embed;

#if macro
import haxe.macro.Context.*;
import haxe.macro.Compiler;
using haxe.io.Path;
using StringTools;
using sys.FileSystem;
using sys.io.File;
#end
class Js {
  macro static public function from(source:String, ?pos:IncludePosition) {
    var url:tink.Url = source;

    switch url.scheme {
      case 'http':
      case 'https':
      case v: 'Unsupported scheme in $url';
    }

    var here = getPosInfos((macro null).pos).file.replace('\\', '/');
    var root = switch [here.isAbsolute(), here.indexOf('embed-js')] {
      case [false, -1]: 'filecache';
      case [_, v]: here.substr(0, v) + 'embed-js/filecache';
    }

    if (!root.exists())
      root.createDirectory();

    var file = '$root/${haxe.crypto.Sha1.encode(source)}.js';

    var js =
      if (file.exists()) file.getContent();
      else {
        var ret = haxe.Http.requestUrl(source);
        file.saveContent(ret);
        ret;
      }

    return
      if (getPosInfos(currentPos()).file.startsWith('--macro')) {
        haxe.macro.Compiler.includeFile(file, pos);
        null;
      }
      else macro untyped __js__($v{js});
  }
}
