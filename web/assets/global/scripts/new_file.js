$(function () {
    //Manager.init();
    News.init();
    WeatherData.init();
    SensorData.init();
    AlarmData.init();
    Device.init();
});

var Manager=function() {
    var jump=function() {
        var chooseObj = $("#choose_obj").val();
        window.location.href = "../../agriculture/"+chooseObj.toString()+"/"+chooseObj.toString()+"_list.jsp";
    }

    return{
        jump:function(){
            jump();
        }
    }
}();

var Device=function(){
    var jump=function(){
        window.location.href = "../../agriculture/device/device_list.jsp";
    }

    return {
        init: function () {
           ;
        },
        jump:function(){
            jump();
        }
    };
}();

var News = function () {
    //var newsUrl = "Access-Control-Allow-origin: https://www.jisuapi.com/api/news";
    var newsUrl = "Access-Control-Allow-origin: https://api.jisuapi.com/news/search?keyword=川贝母&appkey=7f13a9d66a33449b";

    var getNews=function(){

        $.post(newsUrl, function (json) {
            console.log("json of news data is " + JSON.stringify(json));
        });
    }

    var jump=function(){
        window.location.href = "../../agriculture/news/news_list.jsp";
    }

    return {
        init: function () {
            getNews();
        },
        jump:function(){
            jump();
        }
    };
}();

var WeatherData = function () {
    var weatherUrl = "https://free-api.heweather.net/s6/weather/now?location=chengdu&key=dca93c999ad64059a89693463ec3f1d9";
    var location = "";
    var detailString = "";
    var tempString = "";
    var windDirection = "";
    var windForce = "";
    var humidityString = "";
    var precipitationString = "";
    var pressureString = "";
    var updateTime = "";
    var index = [0, 0, 0];

    var getWeather = function () {
        $.post(weatherUrl, function (json) {
            //console.log("json of weather data is " + JSON.stringify(json));
            var weatherJson = json.HeWeather6;
            handleWeatherJson(weatherJson);
        });
    };

    var jump=function(){
        window.location.href = "../../agriculture/weather/weather_list.jsp";
    }

    var handleWeatherJson = function (json) {
        var basicJson = json[0].basic;
        var nowJson = json[0].now;
        var updateJson = json[0].update;

        location = basicJson.location;
        detailString = nowJson.cond_txt;
        tempString = nowJson.tmp;
        windDirection = nowJson.wind_dir;
        windForce = nowJson.wind_sc;
        humidityString = nowJson.hum;
        precipitationString = nowJson.pcpn;
        pressureString = nowJson.pres;
        updateTime = updateJson.utc;
        var myDate = new Date();
        if (myDate.getHours() >= 0 && index[0] == 0) {
            addWeatherRecord();
            index[0] = 1;
            index[2] = 0;
        }
        else if (myDate.getHours() >= 8 && index[1] == 0) {
            addWeatherRecord();
            index[1] = 1;
            index[0] = 0;
        }
        else if (myDate.getHours() >=16 && index[1] == 0) {
            addWeatherRecord();
            index[2] = 1;
            index[1] = 0;
        }
    };

    var addWeatherRecord = function () {
        var url = "../../agriculture_weather_servlet_action?action=add_record" +
            "&location=" + location +
            "&detail_string=" + detailString +
            "&temp_string=" + tempString +
            "&wind_direction=" + windDirection +
            "&wind_force=" + windForce +
            "&humidity_string=" + humidityString +
            "&precipitation_string=" + precipitationString +
            "&pressure_string=" + pressureString +
            "&update_time=" + updateTime +
            "&from_index=1";

        console.log("url in addWeatherRecord is " + url);
        $.post(url, function (json) {
            if (json.result_code == 0) {
            } else {
                alert("Error in addWeatherRecord!!!!");
            }
        }).error(function (xhr, errorText, errorType) {
            alert('错误信息：' + errorText + ",错误类型：" + errorType);
        });
    };
    return {
        init: function () {
            getWeather();
        },
        jump:function(){
            jump();
        }
    };
}();

var SensorData = function () {
    //var dataObj = new Array(new Array(), new Array(), new Array(), new Array(), new Array());
    var index;
    var numOfType=new Array(
        /*
        {
            value:0, name:'土壤温度'
        },{
            value:0, name:'土壤湿度'
        },{
            value:0, name:'空气温度'
        },{
            value:0, name:'空气湿度'
        },{
            value:0, name:'光照强度'
        }*/
    );

    var getSensorData = function () {
        numOfType.push(
            {
                value:0, name:'土壤温度'
            },{
                value:0, name:'土壤湿度'
            },{
                value:0, name:'空气温度'
            },{
                value:0, name:'空气湿度'
            },{
                value:0, name:'光照强度'
            });

        var url = "../../agriculture_sensor_servlet_action?action=get_record&today=1&add_new=1";
        //var url = "Access-Control-Allow-Origin: http://www.lfemcp.com/EquipDataAction!queryCurrentData.action?equipId=6672&conId=9067";
        $.getJSON(url,function(json){
            if (json != null) {
                    console.log("json of sensor data is " + JSON.stringify(json));
                    for (var i = 0; i < list.length; i++) {
                        handleRecord(list[i]);
                    }
                    //statistic();
                    drawPieChart();
            } else {
                console.log("No JSON got!!!!");
            }
        }).error(function (xhr, errorText, errorType) {
            alert('错误信息：' + errorText + ",错误类型：" + errorType);
        });
        /*
        $.post(url, function (json) {
            if (json.result_code == 0) {
                if (json != null) {

                    var list = json.aaData;
                    console.log("json of sensor data is " + JSON.stringify(list));

                    for (var i = 0; i < list.length; i++) {
                        handleRecord(list[i]);
                    }
                    //statistic();
                    drawPieChart();
                }
            } else {
                alert("Error in getSensorData!!!!");
            }
        }).error(function (xhr, errorText, errorType) {
            alert('错误信息：' + errorText + ",错误类型：" + errorType);
        });
        */
    };

    var drawPieChart=function(){
        pieChart= echarts.init(document.getElementById("sensor_chart"));
        option = {
            color:["#4f8bf9","#fea31e","#959595"],
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },

            series: [
                {
                    name:'数据类型',
                    type:'pie',
                    selectedMode: 'single',
                    radius: '60%',
                    center:["60%","60%"],
                    label: {
                        normal: {
                            position: 'outside',
                            formatter: "{b}:{d}%"
                        }
                    },
                    data:numOfType
                }
            ]
        };
        pieChart.setOption(option);
    };

    var handleRecord = function (json) {
        switch (json[2]) {
            case "TEMPERATURE":
                numOfType[0].value++;
                break;

            case "HUMIDITY":
                numOfType[1].value++;
                break;

            case "AIR-TEMPERATURE":
                numOfType[2].value++;
                break;

            case "AIR-HUMIDITY":
                numOfType[3].value++;
                break;

            case "LUMEN":
                numOfType[4].value++;
                break;

            default:
                alert("Error!!!!");
                console.log("Error in getRecord!");
                break;
        }
        /*
        dataObj[index].push({
            id: json[0],
            divice_id: json[1],
            value_type: json[2],
            sensor_value_string: parseFloat(json[3]),
            detect_time: json[4]
        });
    */
    };

    /*
    var statistic = function () {
        var statisticObj = $("#statistic_obj").val();
        switch (statisticObj) {
            case "soil_temp":
                index = 0;
                break;

            case "soil_humid":
                index = 1;
                break;

            case "air_temp":
                index = 2;
                break;

            case "air_humid":
                index = 3;
                break;

            case "lumen":
                index = 4;
                break;

            default:
                alert("Error!!!!");
                console.log("Error in statistic!!!!!");
                break;
        }
        drawChart(index);
    };


    var drawChart = function () {
        var chart = new AmCharts.AmSerialChart();
        chart.dataProvider = dataObj[index];     //指定数据源
        chart.categoryField = "divice_id";    //数据的分类

        //创建
        var graph = new AmCharts.AmGraph();
        graph.valueField = "sensor_value_string";    //数值字段名称
        graph.type = "column";          //列名称
        chart.addGraph(graph);
        //	graph.color="#fff";
        graph.fillAlphas = 1;
        graph.balloonText = "[[category]]: <b>[[value]]</b>";

        //$("#statistic_title").html("土壤温度");
        chart.write(document.getElementById("sensor_chart")); //write 到 div 中
    };
    */

    var jump = function () {
        window.location.href = "../../agriculture/sensor/sensor_list.jsp";
    }

    return {
        init: function () {
            getSensorData();
        },
        jump: function () {
            jump();
        }
    };
}();

var AlarmData = function () {
    var dataObj = new Array(new Array(), new Array(), new Array(), new Array(), new Array());
    //store 5 kinds of data got from servlet action.
    var index;
    //to decide what data to do statistic
    var rangeObj = undefined;
    //to decide what data to do statistic
    var minNum = [-20, 0, -20, 0, 0,];
    //minimal number of 5 kinds of data
    var maxNum = [100, 100, 100, 100, 10000];
    //maximal number of 5 kinds of data.
    var minThreshold = undefined;
    // minimal defined by users
    var maxThreshold = undefined;
    //maximal defined by users
    var dataDevided = new Array();
    // bad number and good number

    var deleteProvider = function () {
        for (var i = 0; i < 5; i++) {
            dataObj[i].splice(0, dataObj[i].length);
        }
        dataDevided.splice(0, 2);
        console.log("the length of dataDevided after delete is " + dataDevided.length);
        console.log("the length of dataObj after delete is " + dataObj.length);
    }

    var handleRecord = function (json) {
        switch (json[2]) {
            case "TEMPERATURE":
                index = 0;
                break;

            case "HUMIDITY":
                index = 1;
                break;

            case "AIR-TEMPERATURE":
                index = 2;
                break;

            case "AIR-HUMIDITY":
                index = 3;
                break;

            case "LUMEN":
                index = 4;
                break;

            default:
                alert("Error!!!!");
                console.log("Error in getRecord!");
                break;
        }
        dataObj[index].push({
            id: json[0],
            divice_id: json[1],
            value_type: json[2],
            sensor_value_string: parseFloat(json[3]),
            detect_time: json[4]
        });
    };

    var initRangeSlider = function () {
        rangeObj = $("#range_obj").val();
        switch (rangeObj) {
            case "soil_temp":
                index = 0;
                break;

            case "soil_humid":
                index = 1;
                break;

            case "air_temp":
                index = 2;
                break;

            case "air_humid":
                index = 3;
                break;

            case "lumen":
                index = 4;
                break;

            default:
                alert("Error!!!!");
                console.log("Error in initRangeSlider!!!!!");
                break;
        }
        drawRangeSlider();
    };

    var drawRangeSlider = function () {
        $("#slider-range").slider({
            isRTL: Metronic.isRTL(),
            range: true,
            min: minNum[index],
            max: maxNum[index],
            //values: [minNum[index] + (maxNum[index] - minNum[index]) * 0.3, maxNum[index] - (maxNum[index] - minNum[index]) * 0.3],
            slide: function (event, ui) {
                $("#slider-range-amount").text(ui.values[0] + " - " + ui.values[1]);
            }
        });

        $("#slider-range-amount").text($("#slider-range").slider("values", 0) + " - " + $("#slider-range").slider("values", 1));
    };

    var filtrateData = function () {
        minThreshold = $("#slider-range").slider("values", 0);
        maxThreshold = $("#slider-range").slider("values", 1);
        console.log("the minThreshold in drawRangeSlider is " + minThreshold);
        console.log("the maxThreshold in drawRangeSlider is " + maxThreshold);
        var tmpObj = dataObj[index];
        console.log("tmpObj in filtrateData is " + JSON.stringify(tmpObj));
        var goodNum = 0;
        var badNum = 0;
        for (var i = 0; i < tmpObj.length; i++) {
            console.log("the value of one tmpObj is " + tmpObj[i].sensor_value_string);
            if (tmpObj[i].sensor_value_string >= minThreshold && tmpObj[i].sensor_value_string < maxThreshold)
                goodNum++;
            else
                badNum++;
        }

        console.log("good number is " + goodNum + " and bad number is " + badNum);
        dataDevided[0] = {
            value:goodNum,
            name:'normal number'
            /*
            type: "normal number",
            number: goodNum,
            */
        };
        dataDevided[1] = {
            value:badNum,
            name:'abnormal number'
            /*
            type: "abnormal number",
            number: badNum,
            */
        };
        console.log("dataDevided is " + JSON.stringify(dataDevided));
    };

    var drawPieChart = function () {

        pieChart= echarts.init(document.getElementById("alarm_chart"));
        option = {
            color:["#4f8bf9","#fea31e","#959595"],
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            series: [
                {
                    name:'访问来源',
                    type:'pie',
                    selectedMode: 'single',
                    radius: [0, '60%'],
                    center:["50%","42%"],
                    label: {
                        normal: {
                            position: 'outside',
                            formatter: "{b}:{d}%"
                        }
                    },
                    data:dataDevided
                }
            ]
        };
        pieChart.setOption(option);
        /*
        var chart = AmCharts.makeChart("alarm_chart", {
            "type": "pie",
            "theme": "light",
            "fontFamily": 'Open Sans',
            "color": '#888',
            "dataProvider": dataDevided,
            "valueField": "number",
            "titleField": "type",
            "labelsEnabled": false,
            "exportConfig": {
                menuItems: [{
                    icon: Metronic.getGlobalPluginsPath() + "amcharts/amcharts/images/export.png",
                    format: 'png'
                }]
            }

        });
        $('#alarm_chart').closest('.portlet').find('.fullscreen').click(function () {
            chart.invalidateSize();
        });
        */
    }

    var jump=function(){
        window.location.href = "../../agriculture/alarm/alarm_list.jsp";
    }

    var initAlarmChart = function () {
        deleteProvider();
        var url = "../../agriculture_sensor_servlet_action?action=get_record";
        $.post(url, function (json) {
            if (json.result_code == 0) {
                if (json != null) {
                    var list = json.aaData;
                    for (var i = 0; i < list.length; i++) {
                        handleRecord(list[i]);
                    }
                    initRangeSlider();
                    filtrateData();
                    drawPieChart();
                }
            } else {
                alert("Error in getSensorData!!!!");
            }
        }).error(function (xhr, errorText, errorType) {
            alert('错误信息：' + errorText + ",错误类型：" + errorType);
        });
    };

    return {
        init: function () {
            initAlarmChart();
        },
        jump: function () {
            jump();
        },
        initAlarmChart: function () {
            initAlarmChart();
        }
    };
}();


var pieChart = "";
function pieChar() {
    pieChart = echarts.init(document.getElementById("pie-chart"));
    option = {
        color: ["#4f8bf9", "#fea31e", "#959595"],
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b}: {c} ({d}%)"
        },
        series: [
            {
                name: '访问来源',
                type: 'pie',
                selectedMode: 'single',
                radius: [0, '60%'],
                center: ["50%", "42%"],
                label: {
                    normal: {
                        position: 'outside',
                        formatter: "{b}:{d}%"
                    }
                },
                data: [
                    {value: 556, name: '正常'},
                    {value: 100, name: '告警', selected: true},
                    {value: 30, name: '离线'}
                ]
            }
        ]
    };
    pieChart.setOption(option);
}
//柱状图
var barChart = "";
function barChar(data) {
    barChart = echarts.init(document.getElementById("bar-chart"));
    option = {
        tooltip: {
            formatter: '{b}:{c}'
        },
        grid: {
            left: '15%',
            right: '15%',
            bottom: '20%',
            top: '20%',

            containLabel: true,
            z: 22
        },
        xAxis: {
            data: ["NHN", "TP", "NP", "COD"],       //横坐标
            axisLabel: {
                textStyle: {
                    color: '#fff',
                    fontSize: 12,
                }
            },
            axisLine: {
                lineStyle: {
                    type: 'solid',
                    color: '#24214e',
                    width: '1  ',                                                //坐标线的宽度
                }
            },
        },
        yAxis: {
            name: "（数次）",
            nameTextStyle: {
                color: "#fff"
            },
            nameLocation: "center",
            nameGap: 30,
            nameRotate: -270,
            axisLabel: {
                textStyle: {
                    color: '#fff',
                    fontSize: 12,//坐标值得具体的颜色
                }
            },
            axisLine: {
                lineStyle: {
                    type: 'solid',
                    color: '#24214e',
                    width: '1  ',                                                //坐标线的宽度

                }
            },
            splitLine: {
                lineStyle: {
                    color: "#24214e",
                }
            }
        },
        series: [{
            type: 'bar',
            barWidth: 20,
            data: data,
            /*label: {
             normal: {
             show: true,
             position: "top",
             textStyle: {
             color: "#fffff",
             fontSize: 12
             }
             }
             },*/
            itemStyle: {
                normal: {
                    color: new echarts.graphic.LinearGradient(
                        0, 0, 0, 1,
                        [
                            {offset: 0, color: '#4f92fa'},                   //柱图渐变色
                            {offset: 0.5, color: '#565cf8'},                 //柱图渐变色
                            {offset: 1, color: '#5d29f7'},                   //柱图渐变色
                        ]
                    )
                }
            },
        }]
    };
    barChart.setOption(option)

}
//折线图
var linchart = "";
function linchar() {
    linchart = echarts.init(document.getElementById("line-chart"));
    option = {
        tooltip: {
            formatter: '{b}&nbsp; {c}次'
        },
        grid: {
            left: '15%',
            right: '15%',
            bottom: '20%',
            top: '20%',

            containLabel: true,
            z: 22
        },
        xAxis: {
            data: ['00:00', '06:00', '12:00', '18:00', '24:00'],
            axisLabel: {
                textStyle: {
                    color: '#fff',
                    fontSize: 12,
                }
            },
            axisLine: {
                lineStyle: {
                    type: 'solid',
                    color: '#24214e',
                    width: '1  ',                                                //坐标线的宽度
                }
            },
        },
        yAxis: {
            name: "（数次）",
            nameTextStyle: {
                color: "#fff"
            },
            nameLocation: "center",
            nameGap: 30,
            nameRotate: -270,
            axisLabel: {
                textStyle: {
                    color: '#fff',
                    fontSize: 12,//坐标值得具体的颜色
                }
            },
            axisLine: {
                lineStyle: {
                    type: 'solid',
                    color: '#24214e',
                    width: '1  ',                                                //坐标线的宽度

                }
            },
            splitLine: {
                lineStyle: {
                    color: "#24214e",
                }
            }

        },
        series: [{
            type: 'line',
            data: [40, 182, 191, 234, 290],
            itemStyle: {
                normal: {
                    lineStyle: {
                        width: 3,//折线宽度
                    },
                    color: new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
                        offset: 1,
                        color: '#508ff6' // 0% 处的颜色
                    }, {
                        offset: 0,
                        color: '#2c137a' // 100% 处的颜色
                    }], false),
                    opacity: 0.4
                }
            },
        }]
    };
    linchart.setOption(option)
}
//柱状图2
var barschart = ""
function barschar() {
    barschart = echarts.init(document.getElementById("bars-chart"));
    option = {
        color: ["#fd8f1e", "#7cb5ec", "#4280f1", "#957bde"],
        tooltip: {
            trigger: 'axis',
            axisPointer: { // 坐标轴指示器，坐标轴触发有效
                type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '10%',
            right: '15%',
            bottom: '20%',
            top: '20%',
            containLabel: true,
            z: 22
        },

        legend: {
            data: ['进样异常', '缺试剂A', '缺试剂B', '消解异常'],
            textStyle: {
                fontSize: 12,
                color: "#fff"
            },
            icon: "rect",
            itemWidth: 10,
            itemHeight: 10,
            bottom: "9%"
        },

        xAxis: {
            name: '次数',
            nameTextStyle: {
                color: "#fff"
            },
            axisLabel: {
                textStyle: {
                    color: '#fff',
                    fontSize: 12,
                }
            },
            splitLine: {
                lineStyle: {
                    color: "#24214e",
                }
            },
            axisLine: {
                lineStyle: {
                    type: 'solid',
                    color: '#24214e',
                    width: '1  ',                                                //坐标线的宽度
                }
            }
        },
        yAxis: {
            data: ['2018.11', '2018.12', '2019.01', '2019.02', '2019.03'],
            axisLabel: {
                textStyle: {
                    color: '#fff',
                    fontSize: 12,//坐标值得具体的颜色
                }
            },
            axisLine: {
                lineStyle: {
                    type: 'solid',
                    color: '#24214e',
                    width: '1  ',                                                //坐标线的宽度

                }
            },
        },
        series: [{
            name: '进样异常',
            type: 'bar',
            stack: '总量',
            barWidth: 20,
            label: {
                normal: {
                    show: false,
                    position: 'insideRight'
                }
            },
            data: [6, 4, 10, 8, 7]
        }, {
            name: '缺试剂A',
            type: 'bar',
            barWidth: 20,
            stack: '总量',
            label: {
                normal: {
                    show: false,
                    position: 'insideRight'
                }
            },
            data: [8, 10, 4, 5, 6]
        }, {
            name: '缺试剂B',
            type: 'bar',
            stack: '总量',
            barWidth: 20,
            label: {
                normal: {
                    show: false,
                    position: 'insideRight'
                }
            },
            data: [6, 4, 10, 8, 7]
        }, {
            name: '消解异常',
            type: 'bar',
            stack: '总量',
            barWidth: 20,
            label: {
                normal: {
                    show: false,
                    position: 'insideRight'
                }
            },
            data: [6, 4, 10, 8, 7]
        },

        ]

    };
    barschart.setOption(option)
};
//雷达图
var radarchart = "";

function radarchar() {
    radarchart = echarts.init(document.getElementById("radar-chart"));
    option = {
        color: ['#623ad1', '#3383fc'],
        tooltip: {},
        radar: [{
            indicator: [{
                text: '进样异常',
                max: 100
            },
                {
                    text: '缺试剂A',
                    max: 100
                },
                {
                    text: '消解异常',
                    max: 100
                },
                {
                    text: '缺纯水',
                    max: 100
                },
                {
                    text: '缺试剂B',
                    max: 100
                }
            ],
            center: ['50%', '60%'],
            radius: '65%',
            startAngle: 90,
            name: {
                formatter: '{value}',
                textStyle: {
                    fontSize: 12, //外圈标签字体大小
                    color: '#FFF' //外圈标签字体颜色
                }
            },
            splitArea: { // 坐标轴在 grid 区域中的分隔区域，默认不显示。
                show: true,
                areaStyle: { // 分隔区域的样式设置。
                    color: [], // 分隔区域颜色。分隔区域会按数组中颜色的顺序依次循环设置颜色。默认是一个深浅的间隔色。
                }
            },
            axisLine: { //指向外圈文本的分隔线样式
                lineStyle: {
                    color: '#24214e'
                }
            },
            splitLine: {
                lineStyle: {
                    color: '#24214e', // 分隔线颜色
                    width: 1, // 分隔线线宽
                }
            }
        },],
        series: [{
            name: '雷达图',
            type: 'radar',
            data: [
                {
                    name: '2016',
                    value: [85, 65, 55, 90, 82],
                    areaStyle: {
                        normal: { // 单项区域填充样式
                            opacity: 1 // 区域透明度
                        }
                    },
                    symbolSize: 0, // 单个数据标记的大小，可以设置成诸如 10 这样单一的数字，也可以用数组分开表示宽和高，例如 [20, 10] 表示标记宽为20，高为10。
                }, {
                    name: '2017',
                    value: [50, 80, 45, 30, 75],
                    symbolSize: 0,
                    areaStyle: {
                        normal: { // 单项区域填充样式
                            color: {
                                type: 'linear',
                                x: 0, //右
                                y: 0, //下
                                x2: 1, //左
                                y2: 1, //上
                                colorStops: [{
                                    offset: 0,
                                    color: '#3cd2f3'
                                },
                                    {
                                        offset: 1,
                                        color: '#306eff'
                                    }],
                                globalCoord: false
                            },
                            opacity: 1 // 区域透明度

                        }
                    },
                }]
        }]
    };
    radarchart.setOption(option)
}
//进度条1
var progress1chart = "";
function progress1char() {
    progress1chart = echarts.init(document.getElementById("progress1-chart"));
    var baifenbi = [0.333, 0.444, 0.555, 0.777, 0.888];
    var grayBar = [1, 1, 1, 1, 1,];
    var paiming = [5, 4, 3, 2, 1];
    var xingm = ['宁波', '台州', '焦作', '邢台', '嘉兴'];
    option = {
        title: {
            text: '2019年 第一季度',
            left: '75%',
            top: "20",
            textStyle: {
                color: "#fff",
                fontSize: 12
            }
        },
        grid: {
            left: '15%',  //如果离左边太远就用这个......
            right: '15%',
            bottom: '5%',
            top: '20%',
            containLabel: true
        },
        xAxis: [{
            show: false,
        },
            {
                show: false,
            }
        ],
        yAxis: {
            type: 'category',
            axisLabel: {
                show: true, //让Y轴数据不显示
            },

            axisTick: {
                show: false, //隐藏Y轴刻度
            },
            axisLine: {
                show: false, //隐藏Y轴线段
            },
        },
        series: [
            //背景色
            {
                show: true,
                type: 'bar',
                barGap: '-100%',
                barWidth: '10%', //统计条宽度
                itemStyle: {
                    normal: {
                        barBorderRadius: 50,
                        color: 'rgba(41, 55, 94)'
                    },
                },
                z: 1,
                data: grayBar,
            },
            //蓝条
            {
                show: true,
                type: 'bar',
                barGap: '-100%',
                barWidth: '10%', //统计条宽度
                itemStyle: {
                    normal: {
                        barBorderRadius: 50, //统计条弧度
                        color: {
                            colorStops: [{
                                offset: 0,
                                color: '#5d29f7' // 0% 处的颜色
                            }, {
                                offset: 1,
                                color: '#5093fb' // 100% 处的颜色
                            }],
                            globalCoord: false, // 缺省为 false

                        }
                    },
                },
                max: 1,
                label: {
                    normal: {
                        show: true,
                        textStyle: {
                            color: '#fff', //百分比颜色
                        },
                        position: [0, '-35'],
                        rich: { //富文本
                            yellow: {
                                color: '#FEC735',
                            }
                        },
                        formatter: function (data) {
                            //富文本固定格式{colorName|这里填你想要写的内容}
                            if (paiming[data.dataIndex] == 1 || paiming[data.dataIndex] == 2 || paiming[data.dataIndex] == 3) {
                                return '{yellow|' + paiming[data.dataIndex] + '  ' + xingm[data.dataIndex] + '}';
                            } else {
                                return paiming[data.dataIndex] + '  ' + xingm[data.dataIndex]
                            }

                        },

                    }
                },
                data: baifenbi,
            },

        ]
    };

    progress1chart.setOption(option)
}
//点击切换数据
function DataSwitch(obj, num) {
    $(obj).removeClass("Datasame");
    $(obj).siblings().addClass("Datasame")
    if (num == 1) {
        $(obj).parent().prev().addClass("Defaultgray");
        $(obj).parent().next().removeClass("Defaultgray");

        barChar([100, 20, 60, 81])


    } else {
        barChar()
        $(obj).parent().prev().removeClass("Defaultgray");
        $(obj).parent().next().addClass("Defaultgray");
        barChar([10, 20, 50, 81])
    }


}
