// Generated by CoffeeScript 1.12.7
(function() {
  var HOTPOOR_CDN_PREFIX, HOTPOOR_CDN_PREFIX_AUDIO, HOTPOOR_CDN_PREFIX_VIDEO, bangfer_app, bangfer_init, bangfer_log, bangfer_print, bangfer_ws, root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  bangfer_ws = null;

  bangfer_app = ["fix", "clothes", "shoes", "package", "express", "helper", "shop"];

  HOTPOOR_CDN_PREFIX = "http://image.hotpoor.org";

  HOTPOOR_CDN_PREFIX_AUDIO = "http://audio.hotpoor.org";

  HOTPOOR_CDN_PREFIX_VIDEO = "http://video.hotpoor.org";

  bangfer_log = function(string) {
    return console.log(string);
  };

  bangfer_print = function(title, string, alertColor, colorType0, colorType1, bgColorType) {
    var bangfer_print_action;
    if (alertColor == null) {
      alertColor = "black";
    }
    if (colorType0 == null) {
      colorType0 = "#161616";
    }
    if (colorType1 == null) {
      colorType1 = "#999999";
    }
    if (bgColorType == null) {
      bgColorType = "white";
    }
    bangfer_print_action = (new Date()).getTime() + "_" + parseInt(Math.random() * 100);
    $("body").append("<div class=\"js_print\" data-value=\"" + bangfer_print_action + "\" style=\"background:" + bgColorType + ";border-left:2px solid " + alertColor + "\">\n    <div style=\"color:" + colorType1 + ";font-size:16px;\">" + title + "</div>\n    <div style=\"color:" + colorType1 + ";font-size:12px;\">" + string + "</div>\n    <div style=\"color:" + colorType1 + "\" class=\"remove_js_print\">x</div>\n</div>");
    $(".js_code[data-value=" + js_code_action + "]").fadeIn();
    bangfer_print_action = setTimeout(function() {
      return $(".js_code[data-value=" + js_code_action + "]").fadeOut(300, function() {
        return $(".js_code[data-value=" + js_code_action + "]").remove();
      });
    }, 1000);
    return $(".remove_js_print").on("click", function(evt) {
      return $(this).parent().fadeOut(300, function() {
        return $(".js_code[data-value=" + js_code_action + "]").remove();
      });
    });
  };

  root.bangfer_normal_print = function(string) {
    return bangfer_print("通知", string);
  };

  root.bangfer_success_print = function(string) {
    return bangfer_print("成功", string, "#4caf50");
  };

  root.bangfer_danger_print = function(string) {
    return bangfer_print("警告", string, "#ff5722");
  };

  root.bangfer_script = function(js_code, del) {
    var js_code_action;
    if (del == null) {
      del = true;
    }
    js_code_action = (new Date()).getTime() + "_" + parseInt(Math.random() * 100);
    $("body").append("<div class=\"js_code\" style=\"display:none;\" data-value=\"" + js_code_action + "\">\n    <script>\n        " + js_code + "\n        if (" + del + "){\n            $(\".js_code[data-value=" + js_code_action + "]\").remove();\n        }\n    </script>\n</div>");
    return bangfer_log(js_code_action + ",del:" + del);
  };

  root.bangfer_script_edit = function(action) {
    if (action == null) {
      action = "close";
    }
    $("#js_code_edit").remove();
    if (action === "open") {
      $("body").append("<div id=\"js_code_edit\">\n    <textarea id=\"js_code_edit_area\"></textarea>\n    <div id=\"js_code_edit_send_btns\" align=\"center\"><button id=\"js_code_edit_send_local\" class=\"js_code_edit_send_btn\">本地执行</button><button id=\"js_code_edit_send_all\" class=\"js_code_edit_send_btn\">发送全局</button></div>\n</div>");
      $("#js_code_edit_send_local").on("click", function(evt) {
        root.bangfer_script($("#js_code_edit_area").val());
        return console.log("已发送");
      });
      return $("#js_code_edit_send_all").on("click", function(evt) {
        return console.log("未开启");
      });
    }
  };

  bangfer_init = function(bangfer_app) {
    var app, html, html_clothes, html_express, html_fix, html_helper, html_package, html_shoes, html_shop, i, len;
    $("body").append("<div id=\"bangfer_app\"></div>");
    html = null;
    html_fix = null;
    html_clothes = null;
    html_shoes = null;
    html_package = null;
    html_express = null;
    html_helper = null;
    html_shop = null;
    for (i = 0, len = bangfer_app.length; i < len; i++) {
      app = bangfer_app[i];
      if (app === "fix") {
        html_fix = "<div class=\"bangfer_app_item\">维修</div>";
      } else if (app === "clothes") {
        html_clothes = "<div class=\"bangfer_app_item\">洗衣</div>";
      } else if (app === "shoes") {
        html_shoes = "<div class=\"bangfer_app_item\">洗鞋</div>";
      } else if (app === "package") {
        html_package = "<div class=\"bangfer_app_item\">代取快递</div>";
      } else if (app === "express") {
        html_express = "<div class=\"bangfer_app_item\">发快递</div>";
      } else if (app === "helper") {
        html_helper = "<div class=\"bangfer_app_item\">互助</div>";
      } else if (app === "shop") {
        html_shop = "<div class=\"bangfer_app_item\">商店</div>";
      }
    }
    html = html_fix + "\n" + html_clothes + "\n" + html_shoes + "\n" + html_package + "\n" + html_express + "\n" + html_helper + "\n" + html_shop;
    return $("#bangfer_app").append(html);
  };

  $(function() {
    bangfer_ws = 1;
    return bangfer_init(bangfer_app);
  });

}).call(this);
