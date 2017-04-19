//anonymous function executing outside the globe so that it wouldn't be overwritte by some other func
(function () {
    
   //var ele = $("#username");
   //ele.text("Bob");
   //
   //var main = $("#main");
   //main.on("mouseenter", function () {
   //    main.style="background-color:#888;";
   //});
   //
   //main.on("mouseleave",function () {
   //    main.style="";
   //});
   //
   //var menuItems = $("ul.menu li a");
   //menuItems.on("click", function () {
   //    var me = $(this);
   //    aler(me.text());
    //});

    var $sidebarAndWrapper = $("#sidebar,#wrapper");
    var $icon = $("#sidebarToggle i.fa");

    $("#sidebarToggle").on("click", function () {
        $sidebarAndWrapper.toggleClass("hide-sidebar");
        if ($sidebarAndWrapper.hasClass("hide-sidebar")) {
            $icon.removeClass("fa-angle-left");
            $icon.addClass("fa-angle-right");
        }
        else {
            $icon.addClass("fa-angle-left");
            $icon.removeClass("fa-angle-right");
        }
    });
})();