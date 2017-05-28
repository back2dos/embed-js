package ;

import haxe.unit.*;
import js.Browser.*;

@:native('ReactDOM')
extern class ReactDom {
  static private function __init__():Void {
    embed.Js.from('http://cdnjs.cloudflare.com/ajax/libs/react/15.5.4/react-dom.js');
  }
  static function render(element:ReactElement, target:js.html.Element):ReactElement;
}


extern class React {
  static public function createElement(tag:String, props:Dynamic, children:haxe.extern.Rest<Dynamic>):ReactElement;
}

extern class ReactElement {}

class RunTests extends TestCase {
  function test() {
    var container = document.createDivElement();
    document.body.appendChild(container);
    ReactDom.render(React.createElement('div', { id: "foobar"}, "hello!"), container);
    assertEquals("hello!", document.getElementById("foobar").innerHTML);
  }
  static function main() {
    var runner = new TestRunner();
    runner.add(new RunTests());
    travix.Logger.exit(if (runner.run()) 0 else 500); 
  }
  
}