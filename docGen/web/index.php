<!DOCTYPE html>
<html>
    <head>
        <title>StablexUI API</title>
        <script src="jquery.js" type="text/javascript"></script>

        <script type="text/javascript">
            $(function(){
                $.get('menu.html?' + Math.random(), function(data) {
                    $('.menu').html("<h1>StablexUI classes</h1><hr/>" + data);
                    process('.menu');
                });

                $('.external').height($(window).height());
                $(window).resize(function(){
                    $('.external').height($(window).height());
                });
            });


            function process(el){
                $(el + ' ul:first').show();
                $(el + ' span.package').click(function(){
                    $(this).parent().children('ul:first').toggle();
                });

                $(el + ' span.class').click(function(){
                    var url = $(this).parent().data('url');
                    if( url != undefined ){
                        $('.external').hide();
                        $('.content').show();
                        $.get(url + '?' + Math.random(), function(data) {
                            $('.content').html("<h1>" + url.replace(/\//g, '.').replace('.html', '') + "</h1>" + data);
                            process('.content');
                            $('html, body').animate({scrollTop:0}, 'fast');
                        });
                    }
                });

                $(el + ' span.type').click(function(){
                    var url = $(this).data('url');
                    if( url != undefined ){
                        if( url.indexOf('http') == 0 ){
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
                    }
                });
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

            .menu span.class{
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
            .content .var{
                color : #448005;
                /* font-weight : bold; */
            }

            .content .definitionName,
            .content .className{
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
        </style>
    </head>
    <body>
        <div class="menu">
        </div>
        <div class="content">
        </div>
        <div class="external">
            <iframe id="external" src="about:blank"></iframe>
        </div>
    </body>
</html>