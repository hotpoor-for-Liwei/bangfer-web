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
aim_ad_open = 0
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
    # alert(aim_ad_id)
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
            aim_ad_open = data.ad_open
            if aim_ad_open == 1
                h_m = ""
                h_fee_all = 0
                for u in data.list_plus
                    u_name = aim_ad_members[u[0]]["name"]
                    u_headimgurl = aim_ad_members[u[0]]["headimgurl"]
                    u_content = u[2]
                    u_fee = u[1]
                    h_fee_all = h_fee_all+ u_fee
                    u_price = "￥"+(u_fee/100.0).toFixed(2)+"元"
                    u_time = formatDate(u[3]*1000)
                    h_m = h_m+"""
                        <div class="iphone_list_line"><img src="#{u_headimgurl}"><span>#{u_name}</span><span>#{u_time}</span><p>#{u_content}</p><span>#{u_price}</span></div>
                    """
                if USER_ID in data.list
                    h_kan = ""
                else
                    h_kan = """
                    <div id="iphone_kan_cover">
                        <button class="iphone_kan_btn">点击砍价</button>
                    </div>
                    """
                html = """
                    <div id="iphone_list_info">
                        <img src="#{aim_ad_members[aim_ad_id]["headimgurl"]}" style="width:50px;height:50px;"><span>#{aim_ad_members[aim_ad_id]["name"]}</span><p>亲们，帮我一块砍价吧！</p>
                    </div>
                    <div id="iphone_list_lines_top">砍价排行榜</div>
                    <div id="iphone_list_lines" align="center">
                    #{h_m}
                    </div>
                    <div id="iphone_list_lines_bottom">看看谁才是最强助攻...</div>
                    <a href="http://www.hotpoor.org/home/mmplus?user_id=f0d75199ce334fdaa2091df00a9e087b&aim_ad_id=#{USER_ID}"><div class="i_want_order">我也要预定</div></a>
                    <div class="img_plus_01"></div>
                    #{h_kan}
                """
            else
                html = """
                    <div id="iphone_list">
                        <div class="iphone_select"><button class="select_btn">iPhone 8</button></div>
                        <div class="iphone_select"><button class="select_btn">iPhone 8Plus</button></div>
                        <div class="iphone_select"><button class="select_btn">iPhone X</button></div>
                    </div>
                    <div id="iphone_pay"><button class="iphone_pay_50">￥50 支付定金</button></div>
                    <div id="iphone_pay_info" style="display:none;">正在提交</div>
                """
            $("#bangfer_app").append html
        "error":(data)->
            console.log data
formatDate = (now) ->
        now_date = new Date(now)
        audio_list_time_now = new Date()
        year = now_date.getFullYear()
        month = now_date.getMonth()+1
        date = now_date.getDate()
        hour = now_date.getHours()
        minute = now_date.getMinutes()
        if hour < 10
            hour = "0"+hour
        if minute < 10
            minute = "0"+minute

        if audio_list_time_now.getFullYear() == year && audio_list_time_now.getMonth()+1 == month && audio_list_time_now.getDate() == date
            return  hour+":"+minute
        if audio_list_time_now.getFullYear() == year
            return  month+"月"+date+"日 "+hour+":"+minute
        return  year+"年"+month+"月"+date+"日 "+hour+":"+minute

root.wx_ready = (img,text="iPhone") ->
    wx.ready ()->
        wx.showAllNonBaseMenuItem()
        wx.onMenuShareAppMessage
            title:"我在帮范儿预定#{text}，帮帮砍价！",
            desc: '最高￥50~￥5000抵扣，赶快召集小伙伴们来砍价！',
            link: 'http://www.hotpoor.org/home/mmplus?user_id=f0d75199ce334fdaa2091df00a9e087b&aim_ad_id='+USER_ID
            imgUrl: img,
            type: '',
            dataUrl: '',
            success: ()->
                console.log "分享给好友成功"
            cancel: ()->
                console.log "取消分享给好友"
        wx.onMenuShareTimeline
            title: "我在帮范儿预定#{text}，帮帮砍价！"
            link: 'http://www.hotpoor.org/home/mmplus?user_id=f0d75199ce334fdaa2091df00a9e087b&aim_ad_id='+USER_ID
            imgUrl: img
            success:()->
                console.log "分享朋友圈成功"
            cancel: ()->
                console.log "取消分享朋友圈"
$ ->
    bangfer_ws = 1
    bangfer_init(bangfer_app)
iphone_info = "新iPhone 未选择"
$("body").on "click", ".select_btn", (evt)->
    $(".select_btn").removeClass("select_btn_now")
    $(this).addClass("select_btn_now")
    root.wx_ready(USER_HEADIMGURL,$(this).text())
    iphone_info = $(this).text()
boss_user_id = "f0d75199ce334fdaa2091df00a9e087b"
help_user_id = "0cd8429c1da249b6935d7eef72d7fc0b"

$("body").on "click",".iphone_kan_btn", (evt)->
    $.ajax
        "type":"GET"
        "url":"/api/ad/add"
        "dataType":"json"
        "data":
            aim_id:aim_ad_id
        success:(data)->
            console.log "砍价成功"
            if data.info == "update"
                $("#iphone_kan_cover").remove()
                $("#iphone_list_lines").empty()
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
                        aim_ad_open = data.ad_open
                        if aim_ad_open == 1
                            h_m = ""
                            h_fee_all = 0
                            for u in data.list_plus
                                u_name = aim_ad_members[u[0]]["name"]
                                u_headimgurl = aim_ad_members[u[0]]["headimgurl"]
                                u_content = u[2]
                                u_fee = u[1]
                                h_fee_all = h_fee_all+ u_fee
                                u_price = "￥"+(u_fee/100.0).toFixed(2)+"元"
                                u_time = formatDate(u[3]*1000)
                                h_m = h_m+"""
                                    <div class="iphone_list_line"><img src="#{u_headimgurl}"><span>#{u_name}</span><span>#{u_time}</span><p>#{u_content}</p><span>#{u_price}</span></div>
                                """
                            html = """
                                #{h_m}
                            """
                        $("#iphone_list_lines").append html
                    "error":(data)->
                        console.log data
        error:(data)->
            console.log "砍价失败"

$("body").on "click",".iphone_pay_50", (evt)->
    wx_pay_order_id = ""
    wx_pay_app = "lovebangfer"
    wx_pay_price = 1
    $.ajax
        "type":"POST"
        "url":"/api/wechat_pay/home/order_unifiedorder"
        "dataType":"json"
        "data":
            weixin_app: wx_pay_app
            price: wx_pay_price
            order_id: wx_pay_order_id
            title: "帮范儿预定"
        success:(data)->
            wxPayData = 
                timestamp: data["timestamp"]
                nonceStr: data["nonce"]
                package: 'prepay_id=' + data["prepay_id"]
                signType: 'MD5'
                paySign: data["paysign"]
                success: (res)->
                    $("#iphone_pay").hide()
                    $("#iphone_pay_info").show()
                    $.ajax
                        url: "/api/ad/pay_success"
                        type: "GET"
                        dataType: "json"
                        data:
                            time: parseInt((new Date).getTime()/1000)
                        success:(data)->
                            console.log data
                            $.ajax
                                url: 'http://www.hotpoor.org/api/comment/submit_data'
                                type: 'POST'
                                dataType: 'json'
                                data:
                                    "app": 'hotpoor'
                                    "aim_id": boss_user_id
                                    "user_id": boss_user_id
                                    "content": "用户昵称:#{USER_NAME}，手机号:#{aim_ad_members[USER_ID]["tel"]}，支付成功￥50元，预约手机，型号："+iphone_info
                                success: (data)->
                                    console.log "wx pay info send success"
                                    window.location.href = 'http://www.hotpoor.org/home/mmplus?user_id=f0d75199ce334fdaa2091df00a9e087b&aim_ad_id=' + USER_ID
                                error: (data)->
                                    console.log "wx pay info send error"
                        error:(data)->
                            console.log "pay_success update error"
                complete: (res)->
                    console.log "wx pay complete"
              wx.chooseWXPay wxPayData
        error:(data)->
            console.log "申请支付失败"

