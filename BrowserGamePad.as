package
{
    /**
     * ...
     * @author @YoupSolo
     * yopsolo.fr
     */
    import flash.external.ExternalInterface;
 
    public class BrowserGamePad{
   
        private var _ready:Boolean=false;
 
        public function BrowserGamePad(){
        
            _ready = false;
 
            // entry point
            if (ExternalInterface.available){
                // create the gamepad object
                ExternalInterface.call("eval", "var gamepad = new Gamepad();");
                _ready = ExternalInterface.call("eval","gamepad.init()");
            }
        }
 
        public function getDeviceLength():*
        {
            if (ExternalInterface.available && _ready)
            {
                return ExternalInterface.call("eval", "gamepad.gamepads.length");
            }
        }
 
        public function getDeviceName(idx:int = 0):*
        {
            if (ExternalInterface.available && _ready)
            {
                var rs:* = ExternalInterface.call("eval", "gamepad.gamepads["+idx+"].id");
                if(rs){
                    return rs;
                }
            }
 
            return "???";
        }
 
        public function getButtons(idx:int = 0):*
        {
            if (ExternalInterface.available && _ready)
            {
                var rs:* = ExternalInterface.call("eval", "gamepad.gamepads["+idx+"].buttons");
                if(rs){
                    return rs;
                }
            }
            return [];
        }
 
        public function getAxes(idx:int = 0):*
        {
            if (ExternalInterface.available && _ready)
            {
                var rs:* =  ExternalInterface.call("eval", "gamepad.gamepads["+idx+"].axes");
                if(rs){
                    return rs;
                }
            }
 
            return [];
        }
 
        public function getTimestamp(idx:int = 0):*
        {
            if (ExternalInterface.available && _ready)
            {
                return ExternalInterface.call("eval", "gamepad.gamepads["+idx+"].timestamp");
            }
        }
 
        public function get ready():Boolean
        {
            return _ready;
        }
 
    }
 
}