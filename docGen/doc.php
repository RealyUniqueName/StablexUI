#!/usr/bin/php
<?php

/**
* Custom doc generator.
*
*/

define('SRC_ROOT', '../src/');
define('DOC_ROOT', 'src/');
define('DOC_BASE_URL', '/doc/');

$urls = array(
    'manual'  => DOC_BASE_URL.'##type#.html',
    'ru'      => DOC_BASE_URL.'##type#.html',
    'nme'     => DOC_BASE_URL.'#http://nme.io/api/types/#type#.html',
    'default' => DOC_BASE_URL.'#http://haxe.org/api/#type#'
);

$hide = array("ru.stablex.ui.ClassBuilder");

file_put_contents(
    'doc/menu.html',
    "<ul>\n"
        ."<li class=\"package\"><a href=\"". DOC_BASE_URL ."\" class=\"class\">FEEDBACK</a></li>\n"
        . generate(DOC_ROOT, 'doc/')
        ."<li class=\"package\"><span class=\"package\">API</span>\n"
            ."<ul>\n"
                . generate(SRC_ROOT, 'doc/')
            ."</ul>\n"
        ."</li>\n"
    ."</ul>\n"
);


function generate($srcPath, $dstPath = 'doc/', $imports = array()){
    global $hide;

    if( !file_exists($dstPath) ){
        mkdir($dstPath, 0777, true);
    }

    $menu = "";

    #collect imports
    foreach (glob($srcPath . "*.hx") as $fname) {
        $import = str_replace(SRC_ROOT, '', $fname);
        $import = str_replace(DOC_ROOT, '', $fname);
        $import = preg_replace('/(\.\/)|(\.\/)/', '', $import);
        $import = preg_replace('/\//', '.', $import);
        $import = preg_replace('/^([^a-zA-Z]*)/', '', $import);
        $import = preg_replace('/\.hx$/', '', $import);
        $imports[ basename($fname, '.hx') ] = $import;
    }

    #process files
    foreach (glob($srcPath . "*.hx") as $fname) {
        $import = str_replace(SRC_ROOT, '', $fname);
        $import = str_replace(DOC_ROOT, '', $fname);
        $import = preg_replace('/(\.\/)|(\.\/)/', '', $import);
        $import = preg_replace('/\//', '.', $import);
        $import = preg_replace('/^([^a-zA-Z]*)/', '', $import);
        $import = preg_replace('/\.hx$/', '', $import);

        if( in_array($import, $hide) ){
            continue;
        }

        $menu .= "<li class=\"class\"><a href=\"". url($import) ."\" class=\"class\">". basename($fname, '.hx') ."</a></li>\n";

        $doc = genDoc($fname, $imports);
        file_put_contents($dstPath . basename($fname, '.hx') .'.html', $doc);
    }

    #process dirs
    foreach (glob($srcPath."*", GLOB_ONLYDIR) as $dirName) {
        $menu = "<li class=\"package\"><span class=\"package\">". basename($dirName) ."</span>\n<ul>\n". generate($dirName.'/', $dstPath . basename($dirName) .'/', $imports) ."</ul>\n</li>\n". $menu;
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
            $skip    = false;
            $cnt     = 1;
            while( $cnt > 0 ){
                $i ++;
                $ln = $lines[$i];
                if( preg_match('/\@private/', $ln) ){
                    $skip = true;
                }
                $comment .= $ln;
                if( preg_match('/\*\//', $ln) ) $cnt --;
                if( preg_match('/^\s*\/\*/', $ln) ) $cnt ++;
            }
            if($skip){
                $comment = '';
            }
        }elseif( preg_match('/^\s*\/\//', $ln) ){
            $comment .= $ln;
        }

        #skip empty lines
        while($i + 1 < $cLines && !trim($lines[$i + 1]) ){
            $i ++;
        }

        #found comment. Search for definitions{
            #manual section
            if( preg_match('/@manual/', $comment) ){
                $doc .= "<div class=\"manual\">". manual($comment) ."</div>\n";
            #vars & functions
            }elseif( $comment && $i + 1 < $cLines && preg_match('/public/', $lines[$i + 1]) ){
                $definition = preg_replace('/\{|;/', '', $lines[$i + 1]);
                $doc .= definition($definition, $imports) . comment($comment, $imports);
            #classes
            }elseif( $comment && $i + 1 < $cLines && preg_match('/class|interface/', $lines[$i + 1]) && !preg_match('/\}/', $lines[$i + 1]) ){
                if( $classOpened ) $doc .="</div>\n";

                $definition = preg_replace('/\{|;/', '', $lines[$i + 1]);
                $doc .= "<dic class=\"classContainer\">" . classDef($definition, $imports) . comment($comment, $imports);
                $classOpened = true;

            #typedefs
            }elseif( $comment && $i + 1 < $cLines && preg_match('/typedef/', $lines[$i + 1]) ){
                $definition = preg_replace('/\{|;/', ' ', $lines[$i + 1]);
                $doc .= "<div class=\"classContainer\">"
                        . comment($comment, $imports) . classDef($definition, $imports);

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



function comment($str, $imports = array()){
    $lines = explode("\n", $str);
    $str   = '';

    foreach($lines as $ln){
        $ln = preg_replace('/^\s*\/\*\*/', '', $ln); # /**
        $ln = preg_replace('/^\s*\*\//', '', $ln); # */
        $ln = preg_replace('/^\s*\*/', '', $ln); # *
        $ln = preg_replace('/^\s*\/\//', '', $ln); # //
        $ln = preg_replace('/^(\s*)\@(dispatch|param|result|return|author|throws|throw|exception)/', '\\1<span class="tag \\2">@\\2</span>', $ln); # @tags

        if( trim($ln) ){
            $str .= $ln . "\n";
        }
    }

    return "<div class=\"comment\">". imports($str, $imports) . "</div>\n";
}


function definition($str, $imports = array()){
    $str = preg_replace('/</', '&lt;', $str);
    $str = preg_replace('/>/', '&gt;', $str);
    $str = str_replace('#if haxe3 macro #else @:macro #end', '<span class="macro">macro</span>', $str);
    $str = preg_replace('/((var|function)\s*)([a-zA-Z0-9_]+)(\s*(\:|\())/', '\\1<span class="definitionName">\\3</span>\\4', $str);
    $str = preg_replace('/(override|dynamic|static|public|private|inline|var|function)/', '<span class="\\1">\\1</span>', $str);
    $str = preg_replace('/(@\:[a-zA-Z0-9_]+)/', '<span class="macro">\\1</span>', $str);
    $str = preg_replace('/(?<!@)\:(\s*)([.a-zA-Z0-9_]+)/', ':\\1<span class="type">\\2</span>', $str);
    $str = preg_replace('/((&lt;|&gt;)\s*)([.a-zA-Z0-9_]+)([^.a-zA-Z0-9_])/', '\\1<span class="type">\\3</span>\\4', $str);

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
    if( preg_match_all('/((\<span class="type"\>)|(\<type\>))([.a-zA-Z0-9_]+)\<\/(span|type)\>/', $str, $types) ){
        $types = $types[4];
        for($i = 0; $i < count($types); $i++){

            if( isset($imports[ $types[$i] ]) ){
                $url = url($imports[$types[$i]]);
                $tip = $imports[$types[$i]];
            }else{
                $url = url($types[$i]);
                $tip = $types[$i];
            }
            $parts = explode('.', $types[$i]);
            $shortcut = $parts[ count($parts) - 1 ];

            $str = preg_replace('/((\<(a|span) class="type"\>)|(\<type\>))'. $types[$i] .'\<\/(span|type|a)\>/', '<a class="type" href="'. $url .'" title="'. $tip .'">'. $shortcut .'</a>', $str);
        }
    }

    return $str;
}


function url($classpath){
    global $urls;

    $parts = explode('.', $classpath);
    $url = implode('/', $parts);

    #hack for actuate
    if( strpos($classpath, 'motion') !== false ){
        $url = DOC_BASE_URL.'#http://haxe.org/com/libs/actuate';

    }elseif( isset($urls[ $parts[0] ]) ){
        $url = str_replace('#type#', $url, $urls[$parts[0]]);
    }else{
        $url = str_replace('#type#', $url, $urls['default']);
    }

    return $url;
}


function manual($str, $imports = array()){
    $lines  = explode("\n", $str);
    $str    = '';
    $cLines = count($lines);

    for($i = 0; $i < $cLines; $i ++){
        $ln = $lines[$i];

        $ln = preg_replace('/^\s*\/\*\*/', '', $ln); # /**
        $ln = preg_replace('/^\s*\*\//', '', $ln); # */
        $ln = preg_replace('/@manual (.*)/', '<h2>\\1</h2>', $ln); # @tags

        #xml
        if( preg_match('/\<xml\>/', $ln) ){
            $xml = '';
            $i ++;
            $ln = $lines[$i];
            while( !preg_match('/\<\/xml\>/', $ln) && $i < $cLines - 1 ){
                $ln = preg_replace('/\</', '&lt;', $ln);
                $ln = preg_replace('/\>/', '&gt;', $ln);
                $ln = preg_replace('/&lt;([-a-zA-Z0-9_]+)/', '&lt;<tag>\\1</tag>\\2', $ln);
                $ln = preg_replace('/&lt;\!--(.*)--\&gt;/U', '<i>&lt;!--\\1--&gt;</i>', $ln); # comments
                $ln = preg_replace('/&lt;\/(\s*)([-a-zA-Z0-9_]+)(\s*)&gt;/', '&lt;/\\1<tag>\\2</tag>\\3&gt;', $ln);
                $ln = preg_replace('/([-a-zA-Z0-9_:]+)(\s*=\s*")/', '<attr>\\1</attr>\\2', $ln);
                $ln = preg_replace('/"/', '<span class="quotes">"</span>', $ln);
                $ln = preg_replace('/\<tag\>(.*)\<\/tag\>/U', '<span class="tag"><span class="type">ru.stablex.ui.widgets.\\1</span></span>', $ln);
                $ln = preg_replace('/&lt;(\/?)\|([-a-zA-Z0-9_:]+)/', '&lt;\\1<span class="tag">\\2</span>', $ln);
                $ln = preg_replace('/\<attr\>/', '<span class="attr">', $ln);
                $ln = preg_replace('/\<\/attr\>/', '</span>', $ln);

                $ln = preg_replace('/(#[a-zA-Z_]+\([a-zA-Z_]+\))/', '<span class="placeholder">\\1</span>', $ln);
                $ln = preg_replace('/((\@|#|\$)[a-zA-Z_]+)/', '<span class="placeholder">\\1</span>', $ln);


                $xml .= $ln . "\n";

                $i ++;
                $ln = $lines[$i];
            }
            $ln = "<div class=\"xml\">\n". $xml ."\n</div>";

        #haxe
        }elseif(preg_match('/\<haxe\>/', $ln)){
            $haxe = '';
            $i ++;
            $ln = $lines[$i];
            while( !preg_match('/\<\/haxe\>/', $ln) && $i < $cLines - 1 ){
                $haxe .= $ln . "\n";

                $i ++;
                $ln = $lines[$i];
            }

            $ln = haxe($haxe);
        }


        $str .= $ln . (preg_match('/\<\/(div|pre)\>\s*$/', $ln) ? '' : "\n");
    }

    return imports($str, $imports);
}



function haxe($str){
    $lines = explode("\n", $str);
    $str   = '';

    foreach($lines as $ln){
        $ln = preg_replace('/(\!\=|\>\=|\<\=|\|\||\=\=|\&\&)/', '<span class="operator">\\1</span>', $ln);

        if( preg_match('/^\s*(class )|(interface )/', $ln) ){
            $ln = classDef($ln);

        }elseif( preg_match('/(var )|(function )/U', preg_replace('/(\/\/.*$)/U', '', $ln)) ){
            $ln = definition($ln);

        }else{
            $ln = preg_replace('/\@(dispatch|param|result|return|author|throws|throw|exception)/', '<span class="tag \\1">@\\1</span>', $ln) . "\n"; # @tags
        }

        $ln = preg_replace('/^(\s*(\*|\/\*).*)$/', '<i>\\1</i>', $ln);
            $ln = preg_replace('/^(\s*\*\/)/', '<i>\\1</i>', $ln);
        $ln = preg_replace('/(?<!\:)(\/\/.*)$/', '<i>\\1</i>', $ln);
        $ln = preg_replace('/(\s|\()(([a-z0-9_]+\.)+[A-Z][a-zA-Z0-9_]*)/', '\\1<type>\\2</type>', $ln);
        $ln = preg_replace('/([^a-zA-Z0-9_])(this|super)([^a-zA-Z0-9_])/', '\\1<span class="\\2">\\2</span>\\3', $ln);
        $ln = preg_replace('/([^a-zA-Z0-9_])(package|cast|null|false|true|return)([^a-zA-Z0-9_])/', '\\1<span class="\\2">\\2</span>\\3', $ln);

        $ln = preg_replace('/([^a-zA-Z-0-9_])if(\s*)\(/', '\\1<span class="if">if</span>\\3(', $ln);

        $str .= $ln;
    }

    return "<div class=\"haxe\">\n". imports($str) . "</div>";
}