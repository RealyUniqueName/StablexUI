package ru.stablex.net;

#if cpp
import cpp.vm.Thread;
#end
#if neko
import neko.vm.Thread;
#end
import haxe.Timer;
import sys.net.Host;
import sys.net.Socket;


/**
*   classname:  Server
*
* Сервер
*/

class Server {

    private var _sock   : Socket;

    public var pollInterval : Float;


    /**
    * Конструктор
    *
    */
    public function new () : Void{
        this._sock        = new Socket();
        this.pollInterval = 1;
    }//function new()


    /**
    * Запуск сервера
    *
    */
    public function run (host:String, port:Int) : Void{
        this._sock.bind(new Host(host), port);
        this._sock.listen(10);

        Sys.println("STARTING SERVER");

        var worker : Thread = Thread.create(this._worker);

        while( true ) {
            var c : Socket = this._sock.accept();
            c.setBlocking(false);

            worker.sendMessage(c);
        }
    }//function run()


    /**
    * Работа с клиентами
    *
    */
    private function _worker () : Void{
        var socks  : Array<Socket> = [];
        var sock   : Socket;
        var select : {
            read   : Array<Socket>,
            write  : Array<Socket>,
            others : Array<Socket>
        };
        var str      : String;
        var lastPoll : Float = Timer.stamp();
        var stamp    : Float = 0;
        var repeat   : Bool = true;

        this.onWorker(this);

        while(true){
            //принимаем новых клиентов
            sock = Thread.readMessage(false);

            if( sock != null ){
                try{
                    if( this.onConnect(sock, socks) ){
                        socks.push(sock);
                    }
                }catch(e:Dynamic){
                    #if debug
                        var stack = haxe.Stack.exceptionStack();
                        trace(stack.join('\n'));
                        trace(e);
                    #end
                    sock.close();
                }
            }

            stamp = Timer.stamp();

            //читаем из сокетов
            select = Socket.select(socks, null, null, lastPoll + this.pollInterval - stamp);

            for(s in select.read){
                try{
                    while(true){
                        str = s.input.readLine();
                        this.onMsg(str, s, socks);
                    }
                }catch(e:Dynamic){
                    if( e != "Blocked" ){
                        #if debug
                            var stack = haxe.Stack.exceptionStack();
                            trace(stack.join('\n'));
                            trace(e);
                        #end
                        socks.remove(s);
                        try{
                            this.onDisconnect(s, socks);
                        }catch(e:Dynamic){
                            #if debug trace(e); #end
                        }
                        s.close();
                    }
                }
            }//for(socks)

            stamp = Timer.stamp();
            if( stamp - lastPoll >= this.pollInterval ){
                lastPoll += Math.floor( (stamp - lastPoll) / this.pollInterval ) * this.pollInterval;
                this.onPoll(socks);
            }
        }//while(true)
    }//function _worker()


    /**
    * При запуске нового воркера
    *
    */
    public dynamic function onWorker (s:Server) : Void {
        //code...
    }//function onWorker()


    /**
    * Получение сообщения от клиента
    *
    */
    public dynamic function onMsg (msg:String, sender:Socket, clients:Array<Socket>) : Void {
        //code...
    }//function onMsg()


    /**
    * Подключение нового клиента
    *
    * @return bool - false, если не нужно продолжать обрабатывать этот новый сокет
    */
    public dynamic function onConnect (sock:Socket, clients:Array<Socket>) : Bool {
        return true;
    }//function onConnect()


    /**
    * Отключение нового клиента
    *
    */
    public dynamic function onDisconnect (sock:Socket, clients:Array<Socket>) : Void {
        //code...
    }//function onDisconnect()


    /**
    * Периодический обработчик
    *
    */
    public dynamic function onPoll (clients:Array<Socket>) : Void {
        //code...
    }//function onPoll()

}//class Server