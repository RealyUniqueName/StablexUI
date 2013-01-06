#!/usr/bin/php
<?php

$urls = array(
    'ru'      => '#type#.html',
    'nme'     => 'http://nme.io/api/types/#type#.html',
    'default' => 'http://haxe.org/api/#type#'
);

file_put_contents('doc/menu.html', "<ul>\n<li class=\"package\"><a class=\"package\">ru</a>\n<ul>\n". generate('../ru/', 'doc/ru/') ."\n</ul>\n</li></ul>\n");

define('DOC_BASE_URL', 'ui/api/');

function generate($srcPath, $dstPath = 'doc/', $imports = array()){
    mkdir($dstPath, 0777, true);

    $menu = "";

    #process files
    foreach (glob($srcPath . "*.hx") as $fname) {
        $import = preg_replace('/(\.\/)|(\.\/)/', '', $fname);
        $import = preg_replace('/\//', '.', $import);
        $import = preg_replace('/^([^a-zA-Z]*)/', '', $import);
        $imports[ basename($fname, '.hx') ] = $import;

        $menu .= "<li class=\"class\" data-url=\"". url(preg_replace('/\.hx$/', '', $import)) ."\"><a class=\"class\">". basename($fname, '.hx') ."</a></li>\n";

        $doc = genDoc($fname, $imports);
        file_put_contents($dstPath . basename($fname, '.hx') .'.html', $doc);
    }

    #process dirs
    foreach (glob($srcPath."*", GLOB_ONLYDIR) as $dirName) {
        $menu = "<li class=\"package\"><a class=\"package\">". basename($dirName) ."</a>\n<ul>\n". generate($dirName.'/', $dstPath . basename($dirName) .'/', $imports) ."</ul>\n</li>\n". $menu;
    }

    return $menu;
}


function genDoc($fname, $imports = array()){
    $doc = '';


    $lines = file($fname);
    $cLines = count($lines);

    $classOpened = false;

    for($i = 0; $i < $cLines; $i ++){
        $comment = '';
        $ln = $lines[$i];

        if( !trim($ln) ) continue;

        #found import
        if( preg_match('/import/', $ln) ){
            $classpath = trim(preg_replace('/(import)|\s+|;/', '', $ln));
            $parts = explode('.', $classpath);
            $shortcut = $parts[count($parts) - 1];
            $imports[$shortcut] = $classpath;
        }

        #comment
        if( preg_match('/^\s*\/\*\*/', $ln) ){
            $comment .= $ln;
            while( !preg_match('/\*\//', $ln) ){
                $i ++;
                $ln = $lines[$i];
                $comment .= $ln;
            }
        }elseif( preg_match('/^\s*\/\//', $ln) ){
            $comment .= $ln;
        }

        #skip empty lines
        while($i + 1 < $cLines && !trim($lines[$i + 1]) ){
            $i ++;
        }

        #found comment. Search for definitions{
            #vars & functions
            if( $comment && $i + 1 < $cLines && preg_match('/public/', $lines[$i + 1]) ){
                $definition = preg_replace('/\{|;/', '', $lines[$i + 1]);
                $doc .= definition($definition, $imports) . comment($comment);
            #classes
            }elseif( $comment && $i + 1 < $cLines && preg_match('/class|interface/', $lines[$i + 1]) ){
                if( $classOpened ) $doc .="</div>\n";

                $definition = preg_replace('/\{|;/', '', $lines[$i + 1]);
                $doc .= "<dic class=\"classContainer\">" . classDef($definition, $imports) . comment($comment);
                $classOpened = true;

            #typedefs
            }elseif( $comment && $i + 1 < $cLines && preg_match('/typedef/', $lines[$i + 1]) ){
                $definition = preg_replace('/\{|;/', ' ', $lines[$i + 1]);
                $doc .= "<div class=\"classContainer\">"
                        . comment($comment) . classDef($definition, $imports);

                $body = '';
                $i++;
                $ln = $lines[$i];
                $m = array();
                $opened = preg_match_all('/\{/', $ln, $m) - preg_match_all('/\}/', $ln, $m);
                while( $opened > 0 ){
                    $i++;
                    $ln = $lines[$i];
                    $opened += preg_match_all('/\{/', $ln, $m) - preg_match_all('/\}/', $ln, $m);
                    $body .= $ln;
                }

                if( $body ){
                    $doc .= "<div class=\"typedefBody\">{\n" . definition($body, $imports) . "</div>\n";
                }

                $doc .= "</div>\n";
            }
        #}
    }//for(lines)

    if( $classOpened ) $doc .="</div>\n";

    return $doc;
}//function genDoc()



function comment($str){
    $lines = explode("\n", $str);
    $str   = '';

    foreach($lines as $ln){
        $ln = preg_replace('/^\s*\/\*\*/', '', $ln); # /**
        $ln = preg_replace('/^\s*\*\//', '', $ln); # */
        $ln = preg_replace('/^\s*\*/', '', $ln); # *
        $ln = preg_replace('/^\s*\/\//', '', $ln); # //

        if( trim($ln) ){
            $str .= $ln . "\n";
        }
    }

    return "<div class=\"comment\">" .$str . "</div>\n";
}


function definition($str, $imports = array()){
    //$str = preg_replace('/([()<>\[\]])/', '<span class="bracket">\\1</span>', $str);
    $str = preg_replace('/</', '&lt;', $str);
    $str = preg_replace('/>/', '&gt;', $str);
    $str = preg_replace('/((var|function)\s*)([a-zA-Z0-9_]+)(\s*(\:|\())/', '\\1<span class="definitionName">\\3</span>\\4', $str);
    $str = preg_replace('/(override|dynamic|static|public|private|inline|var|function)/', '<span class="\\1">\\1</span>', $str);
    $str = preg_replace('/(@\:[a-zA-Z0-9_]+)/', '<span class="macro">\\1</span>', $str);
    $str = preg_replace('/(?<!@)\:(\s*)([.a-zA-Z0-9_]+)/', ':\\1<span class="type">\\2</span>', $str);
    $str = preg_replace('/(&lt;\s*)([.a-zA-Z0-9_]+)(\s*(&lt;|&gt;))/', '\\1<span class="type">\\2</span>\\3', $str);

    return "<div class=\"definition\">". imports($str, $imports) ."</div>\n";
}


function classDef($str, $imports = array()){
    //$str = preg_replace('/([()<>\[\]])/', '<span class="bracket">\\1</span>', $str);
    $str = preg_replace('/</', '&lt;', $str);
    $str = preg_replace('/>/', '&gt;', $str);
    $str = preg_replace('/((class|interface|typedef)\s*)([a-zA-Z0-9_]+)([^a-zA-Z0-9_])/', '\\1<span class="className">\\3</span>\\4', $str);
    $str = preg_replace('/(typedef|extends|implements|interface)/', '<span class="\\1">\\1</span>', $str);
    $str = preg_replace('/(@\:[a-zA-Z0-9_]+)/', '<span class="macro">\\1</span>', $str);
    $str = preg_replace('/class(\s+)/', '\\1<span class="class">class</span>\\1', $str);
    $str = preg_replace('/(\s+)([.a-zA-Z0-9_]+)([^=.a-zA-Z0-9_])/', '\\1<span class="type">\\2</span>\\3', $str);

    return "<div class=\"classDef\">". imports($str, $imports) ."</div>\n";
}


function imports($str, $imports = array()){
    $types = array();
    if( preg_match_all('/\<span class="type"\>([.a-zA-Z0-9_]+)\<\/span\>/', $str, $types) ){
        $types = $types[1];
        for($i = 0; $i < count($types); $i++){
            if( isset($imports[ $types[$i] ]) ){
                $url = url($imports[$types[$i]]);
            }else{
                $url = url($types[$i]);
            }

            $str = preg_replace('/\<span class="type"\>'.$types[$i].'\<\/span\>/', '<span class="type" data-url="'. $url .'">'.$types[$i].'</span>', $str);
        }
    }

    return $str;
}


function url($classpath){
    global $urls;

    $parts = explode('.', $classpath);
    $url = implode('/', $parts);

    #hack for actuate
    if( strpos($classpath, 'com.eclecticdesignstudio.motion') ){
        $url = 'http://haxe.org/com/libs/actuate';

    }elseif( isset($urls[ $parts[0] ]) ){
        $url = str_replace('#type#', $url, $urls[$parts[0]]);
    }else{
        $url = str_replace('#type#', $url, $urls['default']);
    }

    return $url;
}