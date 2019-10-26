/**
 * Created by 33826 on 2019/5/12.
 */
console.log("进入mainmenu.js");
var module="agriculture";

initLeftMenu(module);

function initLeftMenu(module){
    delMenu();
    document.title="管理系统";
    if(module=="home"){
        $.post("../../common_data_action?action=get_main_menu&table_name=document_main&module="+module,function(e){processMenuItemResult(e)});
    }else{
        $.post("../../common_data_action?action=get_main_menu&table_name="+module+"_tree&module="+module,function(e){processMenuItemResult(e)});
    }
}
function delMenu(){
    var ul = document.getElementById("page_sidebar_menu");
    if(ul!=null){
        var lilength = ul.childNodes.length;
        var str="";
        for (var i = lilength-1; i >=0; i--) {
            str=str+"\r\nindex="+i+",id="+ul.childNodes[i].id;
            var li=ul.childNodes[i];
            if(li.id=="sidebar_toggle_wrapper_li" || li.id=="sidebar_search_wrapper_li"){
            }else{
                ul.removeChild(ul.childNodes[i]);
            }
        }
    }
}
function processMenuItemResult(text){
    //console.log("读取了菜单:"+text);
    var json=eval("("+text+")");
    initMenu(json);
}
function initMenu(json){
    var ul = document.getElementById("page_sidebar_menu");
    if(ul!=null){
        json=json.record_list;
        //console.log(json);
        for (var topIndex in json){
            if(json[topIndex].parent_item_id==0){
                var li= document.createElement("li");
                li.id=itemId;
                li.class="start active open";
                var itemId="menu_"+json[topIndex].item_id;
                var itemName=json[topIndex].item_name;
                var html="<a href=\"javascript:;\"><i class=\"icon-home\"></i><span class=\"title\">"+itemName+"</span><span class=\"selected\"></span><span class=\"arrow open\"></span></a>";
                if(json[topIndex].details_tag==1){
                    html=html+"<ul class=\"sub-menu\">";
                    for (var subIndex in json){//用patentid来索引
                        if(itemId=="menu_"+json[subIndex].parent_item_id){
                            var subItemId="menu_"+json[subIndex].item_id;
                            var subItemName=json[subIndex].item_name;
                            var href="../../"+json[subIndex].file_path+json[subIndex].href_link;///////
                            if(json[subIndex].href_link=="")
                                href="../../home/main/index.jsp?content_page=under_construction";
                            html=html+"<li id=\""+subItemId+"\"><a href=\""+href+"\"><i class=\"icon-bulb\"></i>"+subItemName+"</a></li>";
                        }
                    }
                    html=html+"</ul>";
                }
                //console.log(html);
                li.innerHTML=html;//构造li
                ul.appendChild(li);

            }
        }
        var menuDiv=document.getElementById("sidebar_menu_div");
        menuDiv.appendChild(ul);
    }
}
