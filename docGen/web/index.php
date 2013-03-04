<?php
    if( isset($_GET["scheme"]) ){
        setcookie("scheme", $_GET["scheme"], time() + 3600 * 24 * 365);
        header("Location: ./");
        die();
    }

    $scheme = "dark";
    if( isset($_COOKIE["scheme"]) ){
        $scheme = $_COOKIE["scheme"];
    }

?><!DOCTYPE html>
<html>
    <head>
        <title>StablexUI Documentation</title>
        <link href="<?=$scheme?>.css" rel="stylesheet" type="text/css" />
        <script src="jquery.js" type="text/javascript"></script>

        <script type="text/javascript">
            $(function(){
                $.get('menu.html?' + Math.random(), function(data) {
                    $('.menu').html("<h1>StablexUI Docs</h1>color scheme: <a href='?scheme=dark'>dark</a> <a href='?scheme=light'>light</a> <hr/>" + data);
                    process('.menu');

                    //hide everything below level 5
                    $('.menu')
                        .children('ul').children('li')
                        .children('ul').children('li')
                        .children('ul').children('li')
                        .children('ul').children('li')
                        .children('ul').children('li')
                    .children('ul').hide();
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
            }

        </script>

    </head>
    <body>
        <div class="menu">
        </div>
        <div class="content">
            <!-- DISQUS -->
                <div id="disqus_thread" style="padding:20px 50px 20px 50px;background:#e6e6e6;margin:10px 10px 0px 0px;"></div>
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
                <a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
            <!-- /DISQUS -->
        </div>
        <div class="external">
            <iframe id="external" src="about:blank"></iframe>
        </div>
    </body>
</html>