root = exports ? this
bangfer_ws = null
bangfer_app = ["fix","clothes","shoes","package","express","helper","shop"]
HOTPOOR_CDN_PREFIX = "http://image.hotpoor.org"
HOTPOOR_CDN_PREFIX_AUDIO = "http://audio.hotpoor.org"
HOTPOOR_CDN_PREFIX_VIDEO = "http://video.hotpoor.org"


bangfer_log = (string)->
    console.log string
bangfer_print = (title, string, auto=true, alertColor="black", colorType0="#161616", colorType1="#999999", bgColorType="white")->
    bangfer_print_action = (new Date()).getTime()+"_"+parseInt(Math.random()*100)
    if string.length>=50
        string = string.substring(0,50)+"..."
    $("body").append """
    <div class="js_print" data-value="#{bangfer_print_action}" style="background:#{bgColorType};border-left:2px solid #{alertColor}">
        <div style="color:#{colorType1};font-size:16px;">#{title}</div>
        <div style="color:#{colorType1};font-size:12px;">#{string}</div>
        <div style="color:#{colorType1}" class="remove_js_print">x</div>
    </div>
    """
    $(".js_print[data-value=#{bangfer_print_action}]").fadeIn()
    if auto
        bangfer_print_action_i = setTimeout ()->
                $(".js_print[data-value=#{bangfer_print_action}]").fadeOut 300, ()->
                    $(".js_print[data-value=#{bangfer_print_action}]").remove()
            ,2000
    $(".remove_js_print").on "click",(evt)->
        $(this).parent().fadeOut 300, ()->
            $(".js_code[data-value=#{bangfer_print_action}]").remove()
root.bangfer_normal_print = (string)->
    bangfer_print("通知", string, true)
root.bangfer_success_print = (string)->
    bangfer_print("成功", string, true, "#4caf50")
root.bangfer_danger_print = (string)->
    bangfer_print("警告", string, true, "#ff5722")

root.bangfer_script = (js_code,del=true)->
    js_code_action = (new Date()).getTime()+"_"+parseInt(Math.random()*100)
    $("body").append """
    <div class="js_code" style="display:none;" data-value="#{js_code_action}">
        <script>
            #{js_code}
            if (#{del}){
                $(".js_code[data-value=#{js_code_action}]").remove();
            }
        </script>
    </div>
    """
    bangfer_log """#{js_code_action},del:#{del}"""
root.bangfer_script_edit = (action="close")->
    $("#js_code_edit").remove()
    if action == "open"
        $("body").append """
        <div id="js_code_edit">
            <textarea id="js_code_edit_area"></textarea>
            <div id="js_code_edit_send_btns" align="center"><button id="js_code_edit_send_local" class="js_code_edit_send_btn">本地执行</button><button id="js_code_edit_send_all" class="js_code_edit_send_btn">发送全局</button></div>
        </div>
        """
        $("#js_code_edit_send_local").on "click",(evt)->
            root.bangfer_script $("#js_code_edit_area").val()
            console.log "已发送"
        $("#js_code_edit_send_all").on "click",(evt)->
            console.log "未开启"



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
            html_fix = """
                <div class="bangfer_app_item">维修</div>
            """
        else if app == "clothes"
            html_clothes = """
                <div class="bangfer_app_item">洗衣</div>
            """
        else if app == "shoes"
            html_shoes = """
                <div class="bangfer_app_item">洗鞋</div>
            """
        else if app == "package"
            html_package = """
                <div class="bangfer_app_item">代取快递</div>
            """
        else if app == "express"
            html_express = """
                <div class="bangfer_app_item">发快递</div>
            """
        else if app == "helper"
            html_helper = """
                <div class="bangfer_app_item">互助</div>
            """
        else if app == "shop"
            html_shop = """
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
    bangfer_init(bangfer_app)

