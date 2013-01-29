package ru.stablex.net;

#if flash
    import flash.events.ProgressEvent;
    import flash.events.Event;
    import flash.net.Socket;
#else
// import nme.Lib;
import sys.net.Host;
import sys.net.Socket;
#end

#if !flash
/**
*   classname:  Client
*
* на cpp-платформах
*/

class Client extends Socket{

    // private var _mutex : Mutex;
    // private var _sock  : Socket;

    // private var _worker : Thread;


    /**
    * Конструктор
    *
    */
    public function new () : Void{
        super();
    }//function new()


    /**
    * Коннектимся к серверу
    *
    */
    public function hconnect (host:String, port:Int) : Void{
        this.connect(new Host(host), port);
        this.setBlocking(false);

        // var tm : Timer = new Timer(25);
        // tm.run = this._poll;
        nme.Lib.current.addEventListener(nme.events.Event.ENTER_FRAME, this._poll);
    }//function hconnect()


    /**
    * Проверяет, нет ли данных в сокете
    *
    */
    private function _poll (e:nme.events.Event) : Void{
        var repeat = true;
        while(repeat){
            var str : String = null;

            try{
                str = this.input.readLine();
            }catch(e:Dynamic){
                repeat = false;
                if( e != "Blocked" ){
                    trace(e);
                }
            }

            if( str != null ){
                this.onMsg(str);
            }
        }//while(true)
    }//function _poll()


    /**
    * Обработка сообщений от сервера
    *
    */
    public dynamic function onMsg(msg:String) : Void {
        trace('Server message: ' + msg);
    }//function onMsg()


    /**
    * Отправляем на сервер
    *
    */
    public function sendMsg (str:String) : Void{
        this.output.writeString(str + "\n");
    }//function sendMsg()


}//class Client

#else


/**
*   classname:  Client
*
* Description
*/

class Client extends Socket{

    public var onMsg : String->Void;

    private var _buf : String;


    /**
    * Конструктор
    *
    */
    public function new () : Void{
        super();
        this._buf = '';
    }//function new()


    /**
    * Коннектимся к уканазнному серверу
    *
    */
    public function hconnect (host:String, port:Int) : Void{
        this.addEventListener(ProgressEvent.SOCKET_DATA, this.onData);
        this.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
        this.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.onError);

        this.connect(host, port);
    }//function hconnect()


    /**
    * Обработка получения данных
    *
    */
    public function onData (e:ProgressEvent) : Void{
        this._buf += this.readUTFBytes(this.bytesAvailable);

        var messages : Array<String> = this._buf.split("\n");

        while(messages.length > 1){
            this.onMsg(messages.shift());
        }

        this._buf = messages[0];
    }//function onData()


    /**
    * Обработка ошибок
    *
    */
    public function onError (e:Event) : Void{
        trace(e);
    }//function onError()


    /**
    * Отправка на сервер
    *
    */
    public function sendMsg (str:String) : Void{
        this.writeUTFBytes(str + "\n");
        this.flush();
    }//function sendMsg()



}//class Client

#end