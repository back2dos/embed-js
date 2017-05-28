# embed-js

Embed JavaScript files from the web.

Usage is straightforward:

- with compiler arguments 
  ```hxml
  --macro embed.Js.from('http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js')
  ```

- within class initializers

  ```haxe
  @:native('ReactDOM')
  extern class ReactDOM {
    static private function __init__():Void {
      embed.Js.from('http://cdnjs.cloudflare.com/ajax/libs/react/15.5.4/react-dom.js');
    }
    static function render(element:ReactElement, target:js.html.Element):ReactElement;
  }
  ```
  
## Remarks

- the downloaded JavaScript files are cached on the file system, with the SHA1 of the URL acting as key. There's currently no way to purge the cache. Most web servers will allow you to add arbitrary query strings to the URL, which you can use to bypass the cache.
- HTTPS is currently not supported, because the macro interpreter does not support it
- this library combines rather well with closure, at least to the degree the JavaScript you are embedding is closure compatible.
