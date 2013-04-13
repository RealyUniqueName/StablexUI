package ru.stablex;


/**
* List of any objects. Once requested, objects become accessible as properties of this list
* Objects constructor must take no necessary arguments.
* New object is created every time you request an undefined property.
* So dynamicListInstance.someProperty never returns null
*/
class DynamicList<T> implements Dynamic<T>{
    //class for objects in this list
    private var _cls : Class<T>;
    #if haxe3
    private var _hash : Map<String,T>;
    #else
    private var _hash : Hash<T>;
    #end


    /**
    * Constructor
    * @param cls - class to use for new objects in list
    */
    public function new (cls:Class<T>) : Void {
        #if haxe3
        this._hash = new Map();
        #else
        this._hash = new Hash();
        #end
        this._cls = cls;
    }//function new()


    /**
    * Get stored value, or create a new one. This function is required by <type>Dynamic</type> interface
    * @private
    */
    public function resolve (key:String) : T {
        var value = this._hash.get(key);
        if( value == null ){
            value = Type.createInstance(this._cls, []);
            this._hash.set(key, value);
        }
        return value;
    }//function resolve()


    /**
    * Get stored value, or create a new one
    *
    */
    public inline function get (key:String) : Null<T> {
        return this.resolve(key);
    }//function get()


    /**
    * Check if given key exists
    *
    */
    public inline function exists (key:String) : Bool {
        return this._hash.exists(key);
    }//function exists()

}//class DynamicList
