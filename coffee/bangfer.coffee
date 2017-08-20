root = exports ? this
bangfer_ws = null
bangfer_app = ["fix","clothes","shoes","package","express","helper","shop"]
HOTPOOR_CDN_PREFIX = "http://image.hotpoor.org"
HOTPOOR_CDN_PREFIX_AUDIO = "http://audio.hotpoor.org"
HOTPOOR_CDN_PREFIX_VIDEO = "http://video.hotpoor.org"
bangfer_init = (bangfer_app)->
    $("body").append """
        <div id="bangfer_app"></div>
    """
    html = null
    html_fix = null
    html_clothes = null
    html_shoes = null
    html_package = null
    html_express = null
    html_helper = null
    html_shop = null
    for app in bangfer_app
        if app == "fix"
            html_clothes = """
                <div class="bangfer_app_item">维修</div>
            """
        else if app == "clothes"
            html_clothes = """
                <div class="bangfer_app_item">洗衣</div>
            """
        else if app == "shoes"
            html_clothes = """
                <div class="bangfer_app_item">洗鞋</div>
            """
        else if app == "package"
            html_clothes = """
                <div class="bangfer_app_item">代取快递</div>
            """
        else if app == "express"
            html_clothes = """
                <div class="bangfer_app_item">发快递</div>
            """
        else if app == "helper"
            html_clothes = """
                <div class="bangfer_app_item">互助</div>
            """
        else if app == "shop"
            html_clothes = """
                <div class="bangfer_app_item">商店</div>
            """

    html = """
        #{html_fix}
        #{html_clothes}
        #{html_shoes}
        #{html_package}
        #{html_express}
        #{html_helper}
        #{html_shop}
    """
    $("#bangfer_app").append html



$ ->
	bangfer_ws = 1

