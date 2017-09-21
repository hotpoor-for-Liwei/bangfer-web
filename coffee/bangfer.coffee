root = exports ? this
bangfer_ws = null
# bangfer_app = ["fix","clothes","shoes","package","express","helper","shop"]
bangfer_app = []
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
root.bangfer_free_print = (title, string, auto=true,alertColor="black")->
    bangfer_print(title, string, auto, alertColor)

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

getQueryVariable = (variable)->
       query = window.location.search.substring(1)
       vars = query.split("&")
       for i in vars
            pair = i.split("=")
            if pair[0] == variable
                return pair[1]
       return false
aim_ad_id = null
aim_ad_members = {}
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

    html1 = """
        #{html_fix}
        #{html_clothes}
        #{html_shoes}
        #{html_package}
        #{html_express}
        #{html_helper}
        #{html_shop}
    """

    html = """
    """
    aim_ad_id = getQueryVariable("aim_ad_id")
    if not aim_ad_id
        aim_ad_id = USER_ID
    $.ajax
        "type":"GET"
        "url":"/api/ad/list"
        "dataType":"json"
        "data":
            "aim_id":aim_ad_id
        "success":(data)->
            console.log data
            aim_ad_members = Object.assign(aim_ad_members,data.members)
            console.log(aim_ad_members)
            root.wx_ready aim_ad_members[USER_ID]["headimgurl"]
        "error":(data)->
            console.log data
    $("#bangfer_app").append html
root.wx_ready = (img) ->
    wx.ready ()->
        wx.showAllNonBaseMenuItem()
        wx.onMenuShareAppMessage
            title:'我在帮范儿预定iPhone，帮帮砍价！',
            desc: '最高￥50~￥5000抵扣，赶快召集小伙伴们来砍价！',
            link: 'http://www.hotpoor.org/home/mmplus?user_id=f0d75199ce334fdaa2091df00a9e087b&aim_ad_id='+USER_ID
            imgUrl: img,
            type: '',
            dataUrl: '',
            success: ()->

            cancel: ()->
                console.log "取消分享给好友"
        wx.onMenuShareTimeline
            title: '我在帮范儿预定iPhone，帮帮砍价！'
            link: 'http://www.hotpoor.org/home/mmplus?user_id=f0d75199ce334fdaa2091df00a9e087b&aim_ad_id='+USER_ID
            imgUrl: img
            success:()->
            cancel: ()->
                console.log "取消分享朋友圈"
$ ->
    bangfer_ws = 1
    bangfer_init(bangfer_app)
    wx.config
        debug: false
        appId: '{{ handler.wx_appid }}'
        timestamp: {{ handler.wx_timestamp }}
        nonceStr: '{{ handler.wx_noncestr }}'
        signature: '{{ handler.wx_signature }}'
        jsApiList: [
            'checkJsApi',
            'onMenuShareTimeline',
            'onMenuShareAppMessage',
            'onMenuShareQQ',
            'onMenuShareWeibo',
            'hideMenuItems',
            'showMenuItems',
            'hideAllNonBaseMenuItem',
            'showAllNonBaseMenuItem',
            'translateVoice',
            'startRecord',
            'stopRecord',
            'onRecordEnd',
            'playVoice',
            'pauseVoice',
            'stopVoice',
            'uploadVoice',
            'downloadVoice',
            'chooseImage',
            'previewImage',
            'uploadImage',
            'downloadImage',
            'getNetworkType',
            'openLocation',
            'getLocation',
            'hideOptionMenu',
            'showOptionMenu',
            'closeWindow',
            'scanQRCode',
            'chooseWXPay',
            'openProductSpecificView',
            'addCard',
            'chooseCard',
            'openCard'
        ]


