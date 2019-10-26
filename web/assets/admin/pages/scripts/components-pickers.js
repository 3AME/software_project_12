var ComponentsPickers = function () {
    var formatDate = function (date,format) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        return y + '-' + m + '-' + d;
    };
    var formatDateTime = function (date,format) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        var h = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        minute = minute < 10 ? ('0' + minute) : minute;
        second = second < 10 ? ('0' + second) : second;
        return y + '-' + m + '-' + d+' '+h+':'+minute+':'+second;
    };
    var parseDate = function (date) {
        var t = Date.parse(date);
        if (!isNaN(t)) {
            return new Date(t);
        } else {
            return new Date();
        }
    };
    var handleDatePickers = function () {

        if (jQuery().datepicker) {
            $('.date-picker').datepicker({
                rtl: Metronic.isRTL(),
                orientation: "left",
                autoclose: true
            });
            //$('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
        }

        /* Workaround to restrict daterange past date select: http://stackoverflow.com/questions/11933173/how-to-restrict-the-selectable-date-ranges-in-bootstrap-datepicker */
    }

    var handleTimePickers = function () {

        if (jQuery().timepicker) {
            $('.timepicker-default').timepicker({
                autoclose: true,
                showSeconds: true,
                minuteStep: 1
            });

            $('.timepicker-no-seconds').timepicker({
                autoclose: true,
                minuteStep: 5
            });

            $('.timepicker-24').timepicker({
                autoclose: true,
                minuteStep: 5,
                showSeconds: false,
                showMeridian: false
            });

            // handle input group button click
            $('.timepicker').parent('.input-group').on('click', '.input-group-btn', function(e){
                e.preventDefault();
                $(this).parent('.input-group').find('.timepicker').timepicker('showWidget');
            });
        }
    }

    var handleDateRangePickers = function () {
        if (!jQuery().daterangepicker) {
            return;
        }

        $('#defaultrange').daterangepicker({
                opens: (Metronic.isRTL() ? 'left' : 'right'),
                format: 'MM/DD/YYYY',
                separator: ' to ',
                startDate: moment().subtract('days', 29),
                endDate: moment(),
                minDate: '01/01/2012',
                maxDate: '12/31/2018',
            },
            function (start, end) {
                $('#defaultrange input').val(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
            }
        );

        $('#defaultrange_modal').daterangepicker({
                opens: (Metronic.isRTL() ? 'left' : 'right'),
                format: 'MM/DD/YYYY',
                separator: ' to ',
                startDate: moment().subtract('days', 29),
                endDate: moment(),
                minDate: '01/01/2012',
                maxDate: '12/31/2018',
            },
            function (start, end) {
                $('#defaultrange_modal input').val(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
            }
        );

        // this is very important fix when daterangepicker is used in modal. in modal when daterange picker is opened and mouse clicked anywhere bootstrap modal removes the modal-open class from the body element.
        // so the below code will fix this issue.
        $('#defaultrange_modal').on('click', function(){
            if ($('#daterangepicker_modal').is(":visible") && $('body').hasClass("modal-open") == false) {
                $('body').addClass("modal-open");
            }
        });

        $('#reportrange').daterangepicker({
                opens: (Metronic.isRTL() ? 'left' : 'right'),
                startDate: moment().subtract('days', 29),
                endDate: moment(),
                minDate: '01/01/2012',
                maxDate: '12/31/2014',
                dateLimit: {
                    days: 60
                },
                showDropdowns: true,
                showWeekNumbers: true,
                timePicker: false,
                timePickerIncrement: 1,
                timePicker12Hour: true,
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
                    'Last 7 Days': [moment().subtract('days', 6), moment()],
                    'Last 30 Days': [moment().subtract('days', 29), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
                },
                buttonClasses: ['btn'],
                applyClass: 'green',
                cancelClass: 'default',
                format: 'MM/DD/YYYY',
                separator: ' to ',
                locale: {
                    applyLabel: 'Apply',
                    fromLabel: 'From',
                    toLabel: 'To',
                    customRangeLabel: 'Custom Range',
                    daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
                    monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                    firstDay: 1
                }
            },
            function (start, end) {
                $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
            }
        );
        //Set the initial state of the picker label
        $('#reportrange span').html(moment().subtract('days', 29).format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));
    }

    var handleDatetimePicker = function () {

        if (!jQuery().datetimepicker) {
            return;
        }

        $(".form_datetime").datetimepicker({
            autoclose: true,
            isRTL: Metronic.isRTL(),
            format: "yyyy-mm-dd hh:ii:ss",
            pickerPosition: (Metronic.isRTL() ? "bottom-right" : "bottom-left")
        });

        $(".form_advance_datetime").datetimepicker({
            isRTL: Metronic.isRTL(),
            format: "dd MM yyyy - hh:ii",
            autoclose: true,
            todayBtn: true,
            startDate: "2013-02-14 10:00",
            pickerPosition: (Metronic.isRTL() ? "bottom-right" : "bottom-left"),
            minuteStep: 10
        });

        $(".form_meridian_datetime").datetimepicker({
            isRTL: Metronic.isRTL(),
            format: "dd MM yyyy - HH:ii P",
            showMeridian: true,
            autoclose: true,
            pickerPosition: (Metronic.isRTL() ? "bottom-right" : "bottom-left"),
            todayBtn: true
        });

        $('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
    }

    var handleClockfaceTimePickers = function () {

        if (!jQuery().clockface) {
            return;
        }

        $('.clockface_1').clockface();

        $('#clockface_2').clockface({
            format: 'HH:mm',
            trigger: 'manual'
        });

        $('#clockface_2_toggle').click(function (e) {
            e.stopPropagation();
            $('#clockface_2').clockface('toggle');
        });

        $('#clockface_2_modal').clockface({
            format: 'HH:mm',
            trigger: 'manual'
        });

        $('#clockface_2_modal_toggle').click(function (e) {
            e.stopPropagation();
            $('#clockface_2_modal').clockface('toggle');
        });

        $('.clockface_3').clockface({
            format: 'H:mm'
        }).clockface('show', '14:30');
    }

    var handleColorPicker = function () {
        if (!jQuery().colorpicker) {
            return;
        }
        $('.colorpicker-default').colorpicker({
            format: 'hex'
        });
        $('.colorpicker-rgba').colorpicker();
    }


    return {
        //main function to initiate the module
        init: function () {
            handleDatePickers();
            handleTimePickers();
            handleDatetimePicker();
            handleDateRangePickers();
            handleClockfaceTimePickers();
            handleColorPicker();
        },
        formatDate:function(date,format){
            return formatDate(date,format);
        },
        formatDateTime:function(date,format){
            return formatDateTime(date,format);
        },
        parseDate:function(date){
            return parseDate(date);
        }
    };

}();


/**
 * 时间对象的格式化;
 */
Date.prototype.format = function(format) {
    /*
     * eg:format="YYYY-MM-dd hh:mm:ss";
     */
    var o = {
        "M+" :this.getMonth() + 1, // month
        "d+" :this.getDate(), // day
        "h+" :this.getHours(), // hour
        "m+" :this.getMinutes(), // minute
        "s+" :this.getSeconds(), // second
        "q+" :Math.floor((this.getMonth() + 3) / 3), // quarter
        "S" :this.getMilliseconds()
        // millisecond
    }
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    for ( var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}