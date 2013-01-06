<!DOCTYPE html>
<html>
    <head>
        <script src="jquery.js" type="text/javascript"></script>

        <script type="text/javascript">
            $(function(){
                $.get('menu.html', function(data) {
                    $('.menu').html("<h1>Classes</h1><hr/>" + data);
                    process('.menu');
                });
            });


            function process(el){
                $(el + ' a').attr('href', '#');
                $(el + ' ul:first').show();
                $(el + ' a.package').click(function(){
                    $(this).parent().children('ul:first').toggle();
                });

                $(el + ' a.class').click(function(){
                    var url = $(this).parent().data('url');
                    console.log(url);
                    $.get(url, function(data) {
                        $('.content').html("<h1>" + url.replace(/\//g, '.').replace('.html', '') + "</h1>" + data);
                    });
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

            .menu a.package{
                font-weight: bold;
                color:black;
            }

            .menu a.class{
                color : #678007;
                font-weight:bold;
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
                color: #618909;
            }

            .content .class,
            .content .interface,
            .content .typedef,
            .content .function,
            .content .var{
                color : #448005;
                font-weight : bold;
            }

            .content .definitionName,
            .content .className{
                color: #1f8ac3;
            }

            .content .type{
                color: #476103;
                font-weight:bold;
            }

        </style>
    </head>
    <body>
        <div class="menu">
        </div>
        <div class="content">
        </div>
    </body>
</html>