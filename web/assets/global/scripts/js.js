$(function () {
    AlarmData.init();
    UsersData.init();
    SensorData.init();
    DeviceData.init();
    //sensor_echart();
    alarm_echart();
    //echarts_31();
    //echarts_32();
    //echarts_33();
    //weather_echart();
    //device_echart();
});

var AlarmData = function () {
    var dayString = new Array(); //the string array of date

    var monString = new Array(); //the string array of month

    var dateString = new Array();

    var index = -1;

    var recordAlarmed = new Array(
        new Array(0, 0, 0, 0, 0, 0, 0),//to store the alarm number by day
        new Array(0, 0, 0, 0, 0, 0)//to store the alarm number by month
    )

    var recordSended = new Array(
        new Array(0, 0, 0, 0, 0, 0, 0),
        new Array(0, 0, 0, 0, 0, 0)
    )

    var createDayString = function () {
        var senvenDays = new Array();
        for (var i = 0; i < 7; i++) {
            senvenDays.push(new Date(new Date().setDate(new Date().getDate() - 6 + i)));
            //dayString.push(senvenDays[i].toLocaleDateString());
            dayString.push(senvenDays[i].getFullYear() + "." + (senvenDays[i].getMonth() + 1) + "." + senvenDays[i].getDate());

            console.log("the " + i + " of dayString is " + dayString[i]);
        }
    }

    var createMonString = function () {
        var sixMons = new Array();
        for (var i = 0; i < 7; i++) {
            sixMons.push(new Date(new Date().setMonth(new Date().getMonth() - 6 + i)));
            //monString.push(sixMons[i].toLocaleDateString());
            monString.push(sixMons[i].getFullYear() + "." + (sixMons[i].getMonth() + 1));

            console.log("the " + i + " of monString is " + monString[i]);
        }
    }


    var drawAlarmChart = function () {
        var myChart = echarts.init(document.getElementById('alarm_echart'));

        option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    lineStyle: {
                        color: '#dddc6b'
                    }
                }
            },
            //information
            legend: {
                top: '0%',
                data: ['预警数', '已发送'],
                textStyle: {
                    color: 'rgba(255,255,255,.5)',
                    fontSize: '12',
                }
            },

            grid: {
                left: '10',
                top: '30',
                right: '10',
                bottom: '10',
                containLabel: true
            },

            xAxis: [{
                type: 'category',
                boundaryGap: false,
                axisLabel: {
                    textStyle: {
                        color: "rgba(255,255,255,.6)",
                        fontSize: 12,
                    },
                },
                axisLine: {
                    lineStyle: {
                        color: 'rgba(255,255,255,.2)'
                    }

                },

                data: dateString[index]//mon string or day string

            }, {

                axisPointer: {show: false},
                axisLine: {show: false},
                position: 'bottom',
                offset: 20,


            }],

            yAxis: [{
                type: 'value',
                axisTick: {show: false},
                axisLine: {
                    lineStyle: {
                        color: 'rgba(255,255,255,.1)'
                    }
                },
                axisLabel: {
                    textStyle: {
                        color: "rgba(255,255,255,.6)",
                        fontSize: 12,
                    },
                },

                splitLine: {
                    lineStyle: {
                        color: 'rgba(255,255,255,.1)'
                    }
                }
            }],
            series: [
                {
                    name: '预警数',
                    type: 'line',
                    smooth: true,
                    symbol: 'circle',
                    symbolSize: 5,
                    showSymbol: false,
                    lineStyle: {

                        normal: {
                            color: '#0184d5',
                            width: 2
                        }
                    },
                    areaStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                offset: 0,
                                color: 'rgba(1, 132, 213, 0.4)'
                            }, {
                                offset: 0.8,
                                color: 'rgba(1, 132, 213, 0.1)'
                            }], false),
                            shadowColor: 'rgba(0, 0, 0, 0.1)',
                        }
                    },
                    itemStyle: {
                        normal: {
                            color: '#0184d5',
                            borderColor: 'rgba(221, 220, 107, .1)',
                            borderWidth: 12
                        }
                    },
                    data: recordAlarmed[index]//

                },
                {
                    name: '已发送',
                    type: 'line',
                    smooth: true,
                    symbol: 'circle',
                    symbolSize: 5,
                    showSymbol: false,
                    lineStyle: {

                        normal: {
                            color: '#00d887',
                            width: 2
                        }
                    },
                    areaStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                offset: 0,
                                color: 'rgba(0, 216, 135, 0.4)'
                            }, {
                                offset: 0.8,
                                color: 'rgba(0, 216, 135, 0.1)'
                            }], false),
                            shadowColor: 'rgba(0, 0, 0, 0.1)',
                        }
                    },
                    itemStyle: {
                        normal: {
                            color: '#00d887',
                            borderColor: 'rgba(221, 220, 107, .1)',
                            borderWidth: 12
                        }
                    },
                    data: recordSended[index]

                },

            ]

        }
    }

    var handleRecord = function (json) {
        if(index==0){
            for(var i=0;i<7;i++){
                if(json[7].toString().indexOf(dayString[i]))
                    console.log("it works!");

                else console.log("error in here!!!!");
            }
        }
        else if(index==1){
            for(var i=0;i<7;i++){
                if(json[7].toString().indexOf(monString[i]))
                    console.log("it works!");

                else console.log("error in here!!!!");
            }
        }
        else{
            console.log("error in handleRecord in AlarmData");
        }
/*        switch () {
            case "normal":
                numOfRoleId[0].value++;
                break;

            case "manager":
                numOfRoleId[1].value++;
                break;

            default:
                console.log("Error in handleRecord in AlarmData!");
                break;
        }
        */
    };

    var getAlarmDataFromSQL = function () {
        dateString.push(dayString, monString);
        index = (new String($("#time_type")) == 'day') ? 0 : 1;
        console.log("index is "+index);
        //index= $("#statistic_obj").val();
        var url = "../../agriculture_alarm_servlet_action?action=get_record&this_mon=1";
        $.post(url, function (json) {

            if (json.result_code == 0) {
                if (json != null) {
                    var list = json.aaData;
                    for (var i = 0; i < list.length; i++) {
                        handleRecord(list[i]);
                    }
                    drawAlarmChart();
                }
            } else {
                alert("Error in getAlarmDataFromSQL!!!!");
            }

        }).error(function (xhr, errorText, errorType) {
            alert('错误信息：' + errorText + ",错误类型：" + errorType);
        });
    };


    return {
        init: function () {
            createDayString();
            createMonString();
            getAlarmDataFromSQL();
        },
        jump: function () {
            jump();
        }
    };
}();

var UsersData = function () {
    var numOfRoleId = new Array({
            value: 0, name: '普通用户'
        }, {
            value: 0, name: '管理员'
        }
    );

    var drawUsersChart = function () {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('user_echart'));

        option = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)",
                position: function (p) {   //其中p为当前鼠标的位置
                    return [p[0] + 10, p[1] - 10];
                }
            },
            legend: {

                top: '90%',
                itemWidth: 10,
                itemHeight: 10,
                data: ['普通用户', '管理员'],
                textStyle: {
                    color: 'rgba(255,255,255,.5)',
                    fontSize: '16',
                }
            },
            series: [
                {
                    name: '用户类别分布',
                    type: 'pie',
                    radius: [0, '60%'],
                    center: ["50%", "42%"],
                    color: ['#065aab', '#06f0ab'],
                    label: {show: false},
                    labelLine: {show: false},
                    data: numOfRoleId
                    /*[
                     {value: 5, name: '电子商务'},
                     {value: 1, name: '教育'},
                     {value: 6, name: 'IT/互联网'},
                     {value: 2, name: '金融'},
                     {value: 1, name: '学生'},
                     {value: 1, name: '其他'},
                     ]
                     */

                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);

        window.addEventListener("resize", function () {
            myChart.resize();
        });
    }

    var handleRecord = function (json) {
        //console.log("the role_id is " + json[10]);
        switch (json[10]) {
            case "normal":
                numOfRoleId[0].value++;
                break;

            case "manager":
                numOfRoleId[1].value++;
                break;

            default:
                console.log("Error in handleRecord in UsersData!");
                break;
        }
    };

    var getUsersDataFromSQL = function () {

        //index= $("#statistic_obj").val();
        var url = "../../agriculture_users_servlet_action?action=get_record";
        $.post(url, function (json) {

            if (json.result_code == 0) {
                if (json != null) {
                    var list = json.aaData;
                    for (var i = 0; i < list.length; i++) {
                        handleRecord(list[i]);
                    }
                    //drawChart();
                    drawUsersChart();
                }
            } else {
                alert("Error in getSensorDataFromSQL!!!!");
            }

        }).error(function (xhr, errorText, errorType) {
            alert('错误信息：' + errorText + ",错误类型：" + errorType);
        });
    };
    return {
        init: function () {
            getUsersDataFromSQL();
        },
        jump: function () {
            jump();
        }
    };
}();


var SensorData = function () {
    //var dataObj = new Array(new Array(), new Array(), new Array(), new Array(), new Array());
    //number of different data type of today
    var dataOfType = new Array(
        {
            value: 0, type: 'TEMPERATURE', id: 0
        }, {
            value: 0, type: 'HUMIDITY', id: 0
        }, {
            value: 0, type: 'AIR-TEMPERATURE', id: 0
        }, {
            value: 0, type: 'AIR-HUMIDITY', id: 0
        }, {
            value: 0, type: 'LUMEN', id: 0
        }
    );
    var numOfType = new Array(0, 0, 0, 0, 0);
    //var index;

    var addRecordToSQL = function (url) {
        //console.log("url in addRecordToSQL is " + url);
        $.post(url, function (json) {
            if (json.result_code == 0) {
            } else {
                alert("Error in addRecordToSQL!!!!");
            }
        }).error(function (xhr, errorText, errorType) {
            alert('错误信息：' + errorText + ",错误类型：" + errorType);
        });
    }

    var handleRemoteSensorData = function (json) {
        var url;
        var detectTime = json[0].updatetime_;
        var localIndex; // the localIndex of the remote data source
        for (var i = 0; i < 5; i++) {   //i is the localIndex of the local dataOfType
            if (i == 4) localIndex = 5;
            else localIndex = i % 2;

            dataOfType[i].value = json[localIndex].val;
            dataOfType[i].id = json[localIndex].id;

            url = "../../agriculture_sensor_servlet_action?action=add_record" +
                "&device_id=" + dataOfType[i].id +
                "&value_type=" + dataOfType[i].type +
                "&sensor_value_string=" + dataOfType[i].value +
                "&detect_time=" + detectTime +
                "&from_index=1";
            addRecordToSQL(url);
        }
    };

    //get data from sql
    var getSensorDataFromSQL = function () {

        //index= $("#statistic_obj").val();
        var url = "../../agriculture_sensor_servlet_action?action=get_record&today=1";
        $.post(url, function (json) {

            if (json.result_code == 0) {
                if (json != null) {
                    var list = json.aaData;
                    for (var i = 0; i < list.length; i++) {
                        handleRecord(list[i]);
                    }
                    //drawChart();
                    drawSensorChart();
                }
            } else {
                alert("Error in getSensorDataFromSQL!!!!");
            }

        }).error(function (xhr, errorText, errorType) {
            alert('错误信息：' + errorText + ",错误类型：" + errorType);
        });
    };

    var getSensorDataFromRemote = function () {
        var url = "http://121.42.30.247:8083/api/YY15/VCSVGET";
        var data = {};
        data.xmid = 387;
        data.qy = 1;
        data.type = "输入";
        $.post(url, data, function (json) {
            var result0 = JSON.stringify(json);
            var result1 = result0.replace(/\\/g, "");
            var result2 = result1.replace(/"{/g, "{");
            var result3 = result2.replace('}"', '}');
            var result = JSON.parse(result3);
            var table = result.Table;
            handleRemoteSensorData(table);
        });
    }


    var drawSensorChart = function () {
        var myChart = echarts.init(document.getElementById('sensor_echart'));

        option = {
            //  backgroundColor: '#00265f',
            tooltip: {
                trigger: 'axis',
                axisPointer: {type: 'shadow'}
            },
            grid: {
                left: '0%',
                top: '10px',
                right: '0%',
                bottom: '4%',
                containLabel: true
            },
            xAxis: [{
                type: 'category',
                //data of x
                data: ['土壤温度', '土壤湿度', '空气温度', '空气湿度', '光照强度'],
                axisLine: {
                    show: true,
                    lineStyle: {
                        color: "rgba(255,255,255,.1)",
                        width: 1,
                        type: "solid"
                    },
                },

                axisTick: {
                    show: false,
                },
                axisLabel: {
                    interval: 0,
                    // rotate:50,
                    show: true,
                    splitNumber: 15,
                    textStyle: {
                        color: "rgba(255,255,255,.6)",
                        fontSize: '12',
                    },
                },
            }],
            yAxis: [{
                type: 'value',
                axisLabel: {
                    //formatter: '{value} %'
                    show: true,
                    textStyle: {
                        color: "rgba(255,255,255,.6)",
                        fontSize: '12',
                    },
                },
                axisTick: {
                    show: false,
                },
                axisLine: {
                    show: true,
                    lineStyle: {
                        color: "rgba(255,255,255,.1	)",
                        width: 1,
                        type: "solid"
                    },
                },
                splitLine: {
                    lineStyle: {
                        color: "rgba(255,255,255,.1)",
                    }
                }
            }],
            series: [
                {

                    type: 'bar',
                    //input data
                    data: numOfType,
                    barWidth: '35%', //柱子宽度
                    // barGap: 1, //柱子之间间距
                    itemStyle: {
                        normal: {
                            color: '#27d08a',
                            opacity: 1,
                            barBorderRadius: 5,
                        }
                    }
                }

            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        window.addEventListener("resize", function () {
            myChart.resize();
        });
    };


    var handleRecord = function (json) {
        //console.log("the type is " + json[2]);
        switch (json[2]) {
            case "TEMPERATURE":
                numOfType[0]++;
                break;

            case "HUMIDITY":
                numOfType[1]++;
                break;

            case "AIR-TEMPERATURE":
                numOfType[2]++;
                break;

            case "AIR-HUMIDITY":
                numOfType[3]++;
                break;

            case "LUMEN":
                numOfType[4]++;
                break;

            default:
                console.log("Error in handleRecord!");
                break;
        }
    };


    /*
     var drawChart = function () {
     index= $("#statistic_obj").val();
     console.log("index is "+index);
     var chart = new AmCharts.AmSerialChart();
     chart.dataProvider = numOfType[index];     //指定数据源
     chart.categoryField = "name";    //数据的分类

     //创建
     var graph = new AmCharts.AmGraph();
     graphField = "sensor_value_string";    //数值字段名称
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
        window.location.href = "../../agriculture/sensor/record_list.jsp";
    }

    return {
        init: function () {
            getSensorDataFromRemote();
            getSensorDataFromSQL();
        },
        jump: function () {
            jump();
        }
    };
}();

var DeviceData = function () {
    //var dataObj = new Array(new Array(), new Array(), new Array(), new Array(), new Array());
    var numOfType = new Array({
            value: 0, name: '温度传感器'
        }, {
            value: 0, name: '湿度传感器'
        }, {
            value: 0, name: '光强传感器'
        }
    ); //number of different data type of today
    var typeOfDevice = new Array(
        {
            price: 0, type: 'temperature', name: '温度传感器'
        }, {
            price: 0, type: 'humidity', name: '湿度传感器'
        }, {
            price: 0, type: 'illumination', name: '光强传感器'
        }
    );
    //var index;

    var addRecordToSQL = function (url) {
        console.log("url in addRecordToSQL is " + url);
        $.post(url, function (json) {
            if (json.result_code == 0) {
            } else {
                alert("Error in addRecordToSQL!!!!");
            }
        }).error(function (xhr, errorText, errorType) {
            alert('错误信息：' + errorText + ",错误类型：" + errorType);
        });
    }

    var handleRemoteDeviceData = function (json) {
        var url;
        var detectTime = json[0].updatetime_;
        var localIndex; // the localIndex of the remote data source
        for (var i = 0; i < 3; i++) {   //i is the index of the local typeOfDevice
            if (i == 3) localIndex = 5;
            else localIndex = i % 2;

            //create a random price
            typeOfDevice[i].price = Math.floor(Math.random() * (1000 - 500)) + 500;
            console.log("a random price is " + typeOfDevice[i].price);

            url = "../../agriculture_device_servlet_action?action=add_record" +
                "&title=" + typeOfDevice[i].name +
                "&device_type=" + typeOfDevice[i].type +
                "&device_price=" + typeOfDevice[i].price +
                "&detect_time=" + detectTime +
                "&limit_time=" + detectTime +
                "&from_index=1";
            console.log("a url in handleRemoteDeviceData is " + url);
            addRecordToSQL(url);
        }
    };


    //get data from sql
    var getDeviceDataFromSQL = function () {

        var url = "../../agriculture_device_servlet_action?action=get_record";
        $.post(url, function (json) {
            if (json.result_code == 0) {
                if (json != null) {
                    var list = json.aaData;
                    for (var i = 0; i < list.length; i++) {
                        handleRecord(list[i]);
                    }
                    //drawChart();
                    drawPieChart();
                }
            } else {
                alert("Error in getDeviceDataFromSQL!!!!");
            }
        }).error(function (xhr, errorText, errorType) {
            alert('错误信息：' + errorText + ",错误类型：" + errorType);
        });
    };

    var getDeviceDataFromRemote = function () {
        var url = "http://121.42.30.247:8083/api/YY15/VCSVGET";
        var data = {};
        data.xmid = 387;
        data.qy = 1;
        data.type = "输入";
        $.post(url, data, function (json) {
            var result0 = JSON.stringify(json);
            var result1 = result0.replace(/\\/g, "");
            var result2 = result1.replace(/"{/g, "{");
            var result3 = result2.replace('}"', '}');
            var result = JSON.parse(result3);
            var table = result.Table;
            handleRemoteDeviceData(table);
        });
    }


    var drawPieChart = function () {
        for (var i = 0; i < 3; i++) {
            console.log("one of numOfType is " + numOfType[i].value + " and " + numOfType[i].value);
        }
        var myChart = echarts.init(document.getElementById('device_echart'));

        var dataStyle = {
            normal: {
                label: {
                    show: false
                },
                labelLine: {
                    show: false
                },
                //shadowBlur: 40,
                //shadowColor: 'rgba(40, 40, 40, 1)',
            }
        };
        var placeHolderStyle = {
            normal: {
                color: 'rgba(255,255,255,.05)',
                label: {show: false,},
                labelLine: {show: false}
            },
            emphasis: {
                color: 'rgba(0,0,0,0)'
            }
        };
        option = {
            color: ['#0f63d6', '#0f8cd6', '#0fb4d6'],
            tooltip: {
                show: true,
                formatter: "{a} : {c} "
            },
            legend: {
                itemWidth: 10,
                itemHeight: 10,
                itemGap: 12,
                bottom: '3%',

                data: ['温度传感器', '湿度传感器', '光强传感器'],
                textStyle: {
                    color: 'rgba(255,255,255,.6)',
                }
            },

            series: [
                {
                    name: '温度传感器',
                    type: 'pie',
                    clockWise: false,
                    center: ['50%', '42%'],
                    radius: ['59%', '70%'],
                    itemStyle: dataStyle,
                    hoverAnimation: false,
                    data: [numOfType[0],
                        {
                            value: 100 - numOfType[0].value,
                            name: 'invisible',
                            tooltip: {show: false},
                            itemStyle: placeHolderStyle
                        }]
                },
                {
                    name: '湿度传感器',
                    type: 'pie',
                    clockWise: false,
                    hoverAnimation: false,
                    center: ['50%', '42%'],
                    radius: ['39%', '50%'],
                    itemStyle: dataStyle,
                    data: [numOfType[1],
                        {
                            value: 100 - numOfType[1].value,
                            name: 'invisible',
                            tooltip: {show: false},
                            itemStyle: placeHolderStyle
                        }]
                },
                {
                    name: '光强传感器',
                    type: 'pie',
                    clockWise: false,
                    hoverAnimation: false,
                    center: ['50%', '42%'],
                    radius: ['20%', '30%'],
                    itemStyle: dataStyle,
                    data: [numOfType[2], {
                        value: 100 - numOfType[2].value,
                        name: 'invisible',
                        tooltip: {show: false},
                        itemStyle: placeHolderStyle
                    }]
                },]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        window.addEventListener("resize", function () {
            myChart.resize();
        });
    };


    var handleRecord = function (json) {
        switch (json[2]) {
            case "temperature":
                numOfType[0].value++;
                break;

            case "humidity":
                numOfType[1].value++;
                break;

            case "illumination":
                numOfType[2].value++;
                break;

            default:

                console.log("bad type in handleRecord!");
                break;
        }
    };

    var jump = function () {
        window.location.href = "../../agriculture/device/record_list.jsp";
    }

    return {
        init: function () {
            getDeviceDataFromRemote();
            getDeviceDataFromSQL();
        },
        jump: function () {
            jump();
        }
    };
}();


function spy_echart() {
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('echart1'));

    option = {
        //  backgroundColor: '#00265f',
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        grid: {
            left: '0%',
            top: '10px',
            right: '0%',
            bottom: '4%',
            containLabel: true
        },
        xAxis: [{
            type: 'category',
            data: ['商超门店', '教育培训', '房地产', '生活服务', '汽车销售', '旅游酒店', '五金建材'],
            axisLine: {
                show: true,
                lineStyle: {
                    color: "rgba(255,255,255,.1)",
                    width: 1,
                    type: "solid"
                },
            },

            axisTick: {
                show: false,
            },
            axisLabel: {
                interval: 0,
                // rotate:50,
                show: true,
                splitNumber: 15,
                textStyle: {
                    color: "rgba(255,255,255,.6)",
                    fontSize: '12',
                },
            },
        }],
        yAxis: [{
            type: 'value',
            axisLabel: {
                //formatter: '{value} %'
                show: true,
                textStyle: {
                    color: "rgba(255,255,255,.6)",
                    fontSize: '12',
                },
            },
            axisTick: {
                show: false,
            },
            axisLine: {
                show: true,
                lineStyle: {
                    color: "rgba(255,255,255,.1	)",
                    width: 1,
                    type: "solid"
                },
            },
            splitLine: {
                lineStyle: {
                    color: "rgba(255,255,255,.1)",
                }
            }
        }],
        series: [
            {
                type: 'bar',
                data: [200, 300, 300, 900, 1500, 1200, 600],
                barWidth: '35%', //柱子宽度
                // barGap: 1, //柱子之间间距
                itemStyle: {
                    normal: {
                        color: '#2f89cf',
                        opacity: 1,
                        barBorderRadius: 5,
                    }
                }
            }

        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    window.addEventListener("resize", function () {
        myChart.resize();
    });
}

function sensor_echart() {
    // 基于准备好的dom，初始化echarts实例

}

function weather_echart() {
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('weather_echart'));

    option = {
        //  backgroundColor: '#00265f',
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },

        grid: {
            left: '0%',
            top: '10px',
            right: '0%',
            bottom: '2%',
            containLabel: true
        },
        xAxis: [{
            type: 'category',
            data: ['浙江', '上海', '江苏', '广东', '北京', '深圳', '安徽', '四川'],
            axisLine: {
                show: true,
                lineStyle: {
                    color: "rgba(255,255,255,.1)",
                    width: 1,
                    type: "solid"
                },
            },

            axisTick: {
                show: false,
            },
            axisLabel: {
                interval: 0,
                // rotate:50,
                show: true,
                splitNumber: 15,
                textStyle: {
                    color: "rgba(255,255,255,.6)",
                    fontSize: '12',
                },
            },
        }],
        yAxis: [{
            type: 'value',
            axisLabel: {
                //formatter: '{value} %'
                show: true,
                textStyle: {
                    color: "rgba(255,255,255,.6)",
                    fontSize: '12',
                },
            },
            axisTick: {
                show: false,
            },
            axisLine: {
                show: true,
                lineStyle: {
                    color: "rgba(255,255,255,.1	)",
                    width: 1,
                    type: "solid"
                },
            },
            splitLine: {
                lineStyle: {
                    color: "rgba(255,255,255,.1)",
                }
            }
        }],
        series: [{
            type: 'bar',
            data: [2, 3, 3, 9, 15, 12, 6, 4, 6, 7, 4, 10],
            barWidth: '35%', //柱子宽度
            // barGap: 1, //柱子之间间距
            itemStyle: {
                normal: {
                    color: '#2f89cf',
                    opacity: 1,
                    barBorderRadius: 5,
                }
            }
        }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    window.addEventListener("resize", function () {
        myChart.resize();
    });
}

function alarm_echart() {
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('alarm_echart'));
    var monString = new Array(
        '2019.1', '2019.2', '2019.3', '2019.4', '2019.5', '2019.6', '2019.7', '2019.8', '2019.9', '2019.10', '2019.11', '2019.12'
    );
    var data1 = new Array(4, 5);
    var data2 = new Array(5, 6);
    option = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                lineStyle: {
                    color: '#dddc6b'
                }
            }
        },
        legend: {
            top: '0%',
            data: ['预警数', '已发送'],
            textStyle: {
                color: 'rgba(255,255,255,.5)',
                fontSize: '12',
            }
        },
        grid: {
            left: '10',
            top: '30',
            right: '10',
            bottom: '10',
            containLabel: true
        },

        xAxis: [{
            type: 'category',
            boundaryGap: false,
            axisLabel: {
                textStyle: {
                    color: "rgba(255,255,255,.6)",
                    fontSize: 12,
                },
            },
            axisLine: {
                lineStyle: {
                    color: 'rgba(255,255,255,.2)'
                }

            },

            data: monString

        }, {

            axisPointer: {show: false},
            axisLine: {show: false},
            position: 'bottom',
            offset: 20,


        }],

        yAxis: [{
            type: 'value',
            axisTick: {show: false},
            axisLine: {
                lineStyle: {
                    color: 'rgba(255,255,255,.1)'
                }
            },
            axisLabel: {
                textStyle: {
                    color: "rgba(255,255,255,.6)",
                    fontSize: 12,
                },
            },

            splitLine: {
                lineStyle: {
                    color: 'rgba(255,255,255,.1)'
                }
            }
        }],
        series: [
            {
                name: '预警数',
                type: 'line',
                smooth: true,
                symbol: 'circle',
                symbolSize: 5,
                showSymbol: false,
                lineStyle: {

                    normal: {
                        color: '#0184d5',
                        width: 2
                    }
                },
                areaStyle: {
                    normal: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                            offset: 0,
                            color: 'rgba(1, 132, 213, 0.4)'
                        }, {
                            offset: 0.8,
                            color: 'rgba(1, 132, 213, 0.1)'
                        }], false),
                        shadowColor: 'rgba(0, 0, 0, 0.1)',
                    }
                },
                itemStyle: {
                    normal: {
                        color: '#0184d5',
                        borderColor: 'rgba(221, 220, 107, .1)',
                        borderWidth: 12
                    }
                },
                data: data1

            },
            {
                name: '已发送',
                type: 'line',
                smooth: true,
                symbol: 'circle',
                symbolSize: 5,
                showSymbol: false,
                lineStyle: {

                    normal: {
                        color: '#00d887',
                        width: 2
                    }
                },
                areaStyle: {
                    normal: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                            offset: 0,
                            color: 'rgba(0, 216, 135, 0.4)'
                        }, {
                            offset: 0.8,
                            color: 'rgba(0, 216, 135, 0.1)'
                        }], false),
                        shadowColor: 'rgba(0, 0, 0, 0.1)',
                    }
                },
                itemStyle: {
                    normal: {
                        color: '#00d887',
                        borderColor: 'rgba(221, 220, 107, .1)',
                        borderWidth: 12
                    }
                },
                data: data2

            },

        ]

    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    window.addEventListener("resize", function () {
        myChart.resize();
    });
}
function device_echart() {
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('device_echart'));

    var dataStyle = {
        normal: {
            label: {
                show: false
            },
            labelLine: {
                show: false
            },
            //shadowBlur: 40,
            //shadowColor: 'rgba(40, 40, 40, 1)',
        }
    };
    var placeHolderStyle = {
        normal: {
            color: 'rgba(255,255,255,.05)',
            label: {show: false,},
            labelLine: {show: false}
        },
        emphasis: {
            color: 'rgba(0,0,0,0)'
        }
    };
    option = {
        color: ['#0f63d6', '#0f78d6', '#0f8cd6', '#0fa0d6', '#0fb4d6'],
        tooltip: {
            show: true,
            formatter: "{a} : {c} "
        },
        legend: {
            itemWidth: 10,
            itemHeight: 10,
            itemGap: 12,
            bottom: '3%',

            data: ['浙江', '上海', '广东', '北京', '深圳'],
            textStyle: {
                color: 'rgba(255,255,255,.6)',
            }
        },

        series: [
            {
                name: '浙江',
                type: 'pie',
                clockWise: false,
                center: ['50%', '42%'],
                radius: ['59%', '70%'],
                itemStyle: dataStyle,
                hoverAnimation: false,
                data: [{
                    value: 80,
                    name: '01'
                }, {
                    value: 20,
                    name: 'invisible',
                    tooltip: {show: false},
                    itemStyle: placeHolderStyle
                }]
            },
            {
                name: '上海',
                type: 'pie',
                clockWise: false,
                center: ['50%', '42%'],
                radius: ['49%', '60%'],
                itemStyle: dataStyle,
                hoverAnimation: false,
                data: [{
                    value: 70,
                    name: '02'
                }, {
                    value: 30,
                    name: 'invisible',
                    tooltip: {show: false},
                    itemStyle: placeHolderStyle
                }]
            },
            {
                name: '广东',
                type: 'pie',
                clockWise: false,
                hoverAnimation: false,
                center: ['50%', '42%'],
                radius: ['39%', '50%'],
                itemStyle: dataStyle,
                data: [{
                    value: 65,
                    name: '03'
                }, {
                    value: 35,
                    name: 'invisible',
                    tooltip: {show: false},
                    itemStyle: placeHolderStyle
                }]
            },
            {
                name: '北京',
                type: 'pie',
                clockWise: false,
                hoverAnimation: false,
                center: ['50%', '42%'],
                radius: ['29%', '40%'],
                itemStyle: dataStyle,
                data: [{
                    value: 60,
                    name: '04'
                }, {
                    value: 40,
                    name: 'invisible',
                    tooltip: {show: false},
                    itemStyle: placeHolderStyle
                }]
            },
            {
                name: '深圳',
                type: 'pie',
                clockWise: false,
                hoverAnimation: false,
                center: ['50%', '42%'],
                radius: ['20%', '30%'],
                itemStyle: dataStyle,
                data: [{
                    value: 50,
                    name: '05'
                }, {
                    value: 50,
                    name: 'invisible',
                    tooltip: {show: false},
                    itemStyle: placeHolderStyle
                }]
            },]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    window.addEventListener("resize", function () {
        myChart.resize();
    });
}
function echarts_31() {
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('fb1'));
    option = {

        title: [{
            text: '年龄分布',
            left: 'center',
            textStyle: {
                color: '#fff',
                fontSize: '16'
            }

        }],
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b}: {c} ({d}%)",
            position: function (p) {   //其中p为当前鼠标的位置
                return [p[0] + 10, p[1] - 10];
            }
        },
        legend: {

            top: '70%',
            itemWidth: 10,
            itemHeight: 10,
            data: ['0岁以下', '20-29岁', '30-39岁', '40-49岁', '50岁以上'],
            textStyle: {
                color: 'rgba(255,255,255,.5)',
                fontSize: '12',
            }
        },
        series: [
            {
                name: '年龄分布',
                type: 'pie',
                center: ['50%', '42%'],
                radius: ['40%', '60%'],
                color: ['#065aab', '#066eab', '#0682ab', '#0696ab', '#06a0ab', '#06b4ab', '#06c8ab', '#06dcab', '#06f0ab'],
                label: {show: false},
                labelLine: {show: false},
                data: [
                    {value: 1, name: '0岁以下'},
                    {value: 4, name: '20-29岁'},
                    {value: 2, name: '30-39岁'},
                    {value: 2, name: '40-49岁'},
                    {value: 1, name: '50岁以上'},
                ]
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    window.addEventListener("resize", function () {
        myChart.resize();
    });
}

function echarts_32() {
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('user_echart'));

    option = {
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b}: {c} ({d}%)",
            position: function (p) {   //其中p为当前鼠标的位置
                return [p[0] + 10, p[1] - 10];
            }
        },
        legend: {

            top: '90%',
            itemWidth: 10,
            itemHeight: 10,
            data: ['普通用户', '管理员'],
            textStyle: {
                color: 'rgba(255,255,255,.5)',
                fontSize: '16',
            }
        },
        series: [
            {
                name: '用户类别分布',
                type: 'pie',
                radius: [0, '60%'],
                center: ["50%", "42%"],
                color: ['#065aab', '#06f0ab'],
                label: {show: false},
                labelLine: {show: false},
                data: [
                    {value: 5, name: '普通用户'},
                    {value: 1, name: '管理员'},
                ]
                /*[
                 {value: 5, name: '电子商务'},
                 {value: 1, name: '教育'},
                 {value: 6, name: 'IT/互联网'},
                 {value: 2, name: '金融'},
                 {value: 1, name: '学生'},
                 {value: 1, name: '其他'},
                 ]
                 */

            }
        ]

    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);

    window.addEventListener("resize", function () {
        myChart.resize();
    });
}
function echarts_33() {
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('fb3'));
    option = {
        title: [{
            text: '兴趣分布',
            left: 'center',
            textStyle: {
                color: '#fff',
                fontSize: '16'
            }

        }],
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b}: {c} ({d}%)",
            position: function (p) {   //其中p为当前鼠标的位置
                return [p[0] + 10, p[1] - 10];
            }
        },
        legend: {
            top: '70%',
            itemWidth: 10,
            itemHeight: 10,
            data: ['汽车', '旅游', '财经', '教育', '软件', '其他'],
            textStyle: {
                color: 'rgba(255,255,255,.5)',
                fontSize: '12',
            }
        },
        series: [
            {
                name: '兴趣分布',
                type: 'pie',
                center: ['50%', '42%'],
                radius: ['40%', '60%'],
                color: ['#065aab', '#066eab', '#0682ab', '#0696ab', '#06a0ab', '#06b4ab', '#06c8ab', '#06dcab', '#06f0ab'],
                label: {show: false},
                labelLine: {show: false},
                data: [
                    {value: 2, name: '汽车'},
                    {value: 3, name: '旅游'},
                    {value: 1, name: '财经'},
                    {value: 4, name: '教育'},
                    {value: 8, name: '软件'},
                    {value: 1, name: '其他'},
                ]
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    window.addEventListener("resize", function () {
        myChart.resize();
    });
}
				
	




		
		
		


		









