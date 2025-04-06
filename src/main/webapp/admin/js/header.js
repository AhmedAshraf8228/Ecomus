 $(document).ready(function() {
        function loadPage(page) {
            $("#main-content").load(page);
        }

        // Load home.jsp by default
        loadPage("admin/view/home.jsp");

        $(".menu-item").click(function() {
        $(".menu-item").removeClass("active");
        $(this).addClass("active");

        var pageId = $(this).attr("id");
        var pageUrl = "admin/view/" + pageId + ".jsp";

        loadPage(pageUrl);
    });
    });

