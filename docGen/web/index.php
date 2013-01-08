<!DOCTYPE html>
<html>
    <head>
        <title>StablexUI Documentation</title>
        <script src="jquery.js" type="text/javascript"></script>

        <script type="text/javascript">
            $(function(){
                $.get('menu.html?' + Math.random(), function(data) {
                    $('.menu').html("<h1>StablexUI Docs</h1><hr/>" + data);
                    process('.menu');

                    $('.menu').children('ul').children('li').children('ul').hide();
                });

                $('.external').height($(window).height());
                $(window).resize(function(){
                    $('.external').height($(window).height());
                });

                setInterval(checkUrl, 100);
            });


            var currentUrl = '';
            function checkUrl(){
                var url = location.hash.replace('#', '');

                if( url != currentUrl ){
                    if( url == '' ){
                        document.getElementById('external').src = 'about:blank';
                        $('.external').hide();
                        $('.content').show();
                        $('.content').html('');
                    }else if( url.indexOf('http') == 0 ){
                        document.getElementById('external').src = 'about:blank';
                        document.getElementById('external').src = url;
                        $('.external').show();
                        $('.content').hide();
                        $('html, body').animate({scrollTop:0}, 'fast');
                    }else{
                        $('.external').hide();
                        $('.content').show();
                        $.get(url + '?' + Math.random(), function(data) {
                            $('.content').html("<h1>" + url.replace(/\//g, '.').replace('.html', '') + "</h1>" + data);
                            process('.content');
                            $('html, body').animate({scrollTop:0}, 'fast');
                        });
                    }

                    currentUrl = url;
                }
            }


            function process(el){
                $(el + ' span.package').click(function(){
                    $(this).parent().children('ul:first').toggle('fast');
                });

                // $(el + ' span.class').click(function(){
                //     var url = $(this).parent().data('url');
                //     if( url != undefined ){
                //         location.hash = '#' + url;
                //     }
                // });

                // $(el + ' span.type').click(function(){
                //     var url = $(this).data('url');
                //     if( url != undefined ){
                //         location.hash = '#' + url;
                //     }
                // });
            }

        </script>

        <style>
            body,div{
                border           : 0px;
                padding          : 0px;
                margin           : 0px;
                background-color : #042029;
                font-size        : 14px;
                font-family      : monospace;
            }

            a{
                text-decoration: none;
            }

            h1{
                font-size  : 20px;
            }

            div.menu{
                position         : fixed;
                overflow         : auto;
                height           : 100%;
                width            : 250px;
                top              : 0px;
                left             : 0%;
                border-right     : 1px solid #233d44;
                background-color : #e6e6e6;
                line-height      : 20px;
            }

            .menu ul{
                /* display         : none; */
                padding         : 0px;
                margin          : 0px;
                padding-left    : 20px;
                list-style-type : none;
            }

            .menu li.package{
                list-style-type : disc;
            }

            .menu span.package{
                font-weight : bold;
                color       : black;
                cursor      : pointer;
            }

            .menu .class{
                color       : #678007;
                font-weight : bold;
                cursor      : pointer;
            }

            div.content{
                margin-left: 260px;
            }


            .content{
                color: #669496;
            }

            .content h1{
                color: #6d9496;
            }

            .content div{
                white-space: pre;
            }

            .content div.comment{
                padding-bottom : 20px;
                border-bottom: 1px dotted #233d44;
                color : #486d6e;
            }
            .content div.definition{
                padding-top : 20px;
            }

            .content .class,
            .content .extends,
            .content .implements,
            .content .interface,
            .content .typedef,
            .content .public,
            .content .private,
            .content .inline,
            .content .static,
            .content .function,
            .content .var,
            .content .override,
            .content .dynamic{
                color: #3b5c0b;
            }

            .content .class,
            .content .interface,
            .content .typedef,
            .content .function,
            .content .var,
            .content .if,
            .content .null,
            .content .true,
            .content .false,
            .content .return,
            .content .operator{
                color : #448005;
                /* font-weight : bold; */
            }

            .content .definitionName,
            .content .className,
            .content .this,
            .content .super{
                color: #1f8ac3;
            }

            .content .type{
                color: #476103;
                font-weight:bold;
                cursor: pointer;
                border-bottom: 1px dotted #476103;
            }

            .comment .tag{
                color: #859900;
            }

            .external{
                display:none;
                margin-left:250px;
            }
            #external{
                width:100%;
                height:100%;
            }

            .content .manual{
                border-bottom: 1px dotted #233d44;
                color : #486d6e;
            }

            .content .manual h2{
                font-size: 16px;
                color : #448005;
                padding: 0px;
                margin:0px;
                display:inline;
            }

            .content .manual .xml{
                border-left: 1px dashed #233d44;
                margin-left: 20px;
                padding-left: 20px;
                background-color: #052630;
            }

            .content .manual .xml .tag,
            .content .manual .xml .tag .type{
                font-weight:normal;
                color: #1f8ac3;
            }

            .content .manual .xml .attr,
            .content .manual .xml .quotes{
                color: #839496;
            }

            .content .manual .xml i{
                /* color:#0b5166; */
            }

            .content .manual .haxe{
                border-left: 1px dashed #233d44;
                margin-left: 20px;
                padding-left: 20px;
                background-color: #052630;
                color: #839496;
            }

            .content .manual .haxe .tag{
                color: #859900;
            }

            .content .manual .haxe i,
            .content .manual .haxe i .this,
            .content .manual .haxe i .super,
            .content .manual .haxe i .var,
            .content .manual .haxe i .class,
            .content .manual .haxe i .public,
            .content .manual .haxe i .private,
            .content .manual .haxe i .inline,
            .content .manual .haxe i .static,
            .content .manual .haxe i .dynamic,
            .content .manual .haxe i .function {
                color : #486d6e;
            }

            .content .manual .haxe div.classDef,
            .content .manual .haxe div.definition{
                padding: 0px;
                display: inline;
                background: transparent;
            }

            .content .manual .haxe .this,
            .content .manual .haxe .super{
                color: #1f8ac3;
            }
        </style>
    </head>
    <body>
        <div class="menu">
        </div>
        <div class="content">
            <!-- DISQUS -->
                <!-- <div id="disqus_thread" style="display:none"></div>
                <script type="text/javascript">
                    /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
                    var disqus_shortname = 'stablexui'; // required: replace example with your forum shortname

                    /* * * DON'T EDIT BELOW THIS LINE * * */
                    (function() {
                        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
                        dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
                        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
                    })();
                </script>
                <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
                <a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a> -->
            <!-- /DISQUS -->
        </div>
        <div class="external">
            <iframe id="external" src="about:blank"></iframe>
        </div>
    </body>
</html>