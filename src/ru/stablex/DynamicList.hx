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


    /**
    * Constructor
    * @param cls - class to use for new objects in list
    */
    public function new (cls:Class<T>) : Void {        
        this._cls = cls;
    }//function new()


    /**
    * New items creation
    * @private
    */
    public function resolve (name:String) : T {
        if( Reflect.hasField(this, name) ){
            return Reflect.field(this, name);
        }else{
            var newField = Type.createInstance(this._cls, []);
            Reflect.setField(this, name, newField);
            return newField;
        }
    }//function resolve()
}//class ButtonStates
