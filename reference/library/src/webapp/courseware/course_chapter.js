$(function(){function d(b){var c=$.grep(a,function(a){return a.id==b})[0];$("#cm_title").html(c.title.split(" ")[0]),$("#cm_required").html(1==c.required?"\u5fc5\u4fee":"\u9009\u4fee"),$("#cm_openStatus").attr("src",1==c.openStatus?"images_t/suo.png":"images_t/suo_lock.png"),$("#cm_passStatus").html(1==c.passStatus?"\u901a\u8fc7":"\u672a\u901a\u8fc7");var d=c.studyTime?(c.studyTime/60).toFixed(1):0;$("#cm_studyTime").html(d+"\u5c0f\u65f6"),$("#cm_studyTime_p").css("width",f(d));var e=c.avgTime?(c.avgTime/60).toFixed(1):0;$("#cm_avgTime").html(e+"\u5c0f\u65f6"),$("#cm_avgTime_p").css("width",f(e));var g=c.myTime?(c.myTime/60).toFixed(1):0;$("#cm_myTime").html(g+"\u5c0f\u65f6"),$("#cm_myTime_p").css("width",f(g))}function e(){$("#cm_panel")&&0!=$("#cm_panel").length&&(0==$("#cm_panel.info_hover").length?($("#cm_panel").addClass("info_hover"),$("#cm_panel").removeClass("info")):($("#cm_panel").addClass("info"),$("#cm_panel").removeClass("info_hover")))}function f(a){if(1>a)return"5px";var b=120;$(".barbox").length>0&&(b=$($(".barbox")[0]).width());var c=(b/4).toFixed(0);return b=a*c>=b?b:a*c,b+"px"}function g(){$("#para_sitetoolid").val($.url().param("placementId"));var a="<form id='staticfrm' method='post' target='_blank' action='/portal/tool/"+$("#para_sitetoolid").val()+"/list_modules_student' enctype='application/x-www-form-urlencoded'>"+'<input type="hidden" name="listmodulesStudentform" value="listmodulesStudentform" />'+'<input type="hidden" name="openStatus" /><input type="hidden" name="moduleId" />'+'<input type="hidden" name="listmodulesStudentform:_idcl" /></form>';$("body").append(a)}var a=null,b=null;0==$("#para_sitetoolid").val().length&&$("#para_sitetoolid").val($.url().param("placementId"));var c=$("#para_sitetoolid").val();"undefined"==typeof _c_config&&(_c_config={orderShow:1}),$.get("/portal/tool/"+c+"/studySpace_nodesJson.do?dt="+Math.round(1e4*Math.random()),function(f){f=$.parseJSON(f);var h=$(".c_list").children();a=f.children,b=f.course,studyRecord=f.record,$.each(a,function(a,b){var e=b.title.split(" "),f=$(h[a]).find(".c_o"),g=1==_c_config.orderShow?a+1:getNumShow(a+1);$(f).html("<a href='module.html?placementId="+c+"&module="+b.id+"&dt="+Math.round(1e4*Math.random())+"' mid='"+b.id+"'>"+g+"</a>");var i=$(h[a]).find(".c_t");$(i).html("<a href='module.html?placementId="+c+"&module="+b.id+"&dt="+Math.round(1e4*Math.random())+"' mid='"+b.id+"'>"+e[1]+"</a>"),0==a&&d(b.id)});var i="\u5728\u5b66";switch(b.status){case"2":i="\u5df2\u901a\u8fc7";break;case"3":i="\u672a\u901a\u8fc7"}$("#cm_cstatus").html(i),$(".c_o>a").live("mouseover",function(){d($(this).attr("mid")),e()}),$(".c_o>a").live("mouseout",function(){e()}),$("#cm_avgScore").html(studyRecord.score),g();try{"undefined"!=typeof loadextend&&"function"==typeof loadextend&&loadextend(b,a)}catch(j){}try{$buptnu.cware.fitScreen()}catch(j){}})}),$(window).load(function(){try{$buptnu.cware.fitScreen()}catch(a){}});