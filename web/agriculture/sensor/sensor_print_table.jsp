<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.*,java.util.*,org.json.JSONObject,org.json.JSONArray,java.util.ArrayList"%>
<%
	//做调试用，这里要在正式发布的时候去掉
	System.out.println("[" + (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new java.util.Date()) + "]=======================调试：" + request.getServletPath() + "开始==============================");
%>
<%
	String existResultset = request.getParameter("exist_resultset");
%>
<%
	//接下来从session里取json出来，循环对于json里的aaData，显示每一条记录（略）
	JSONObject jsonObj=new JSONObject();
	if(existResultset!=null && existResultset.equals("1")){
		jsonObj=(JSONObject)session.getAttribute("agriculture_sensor_get_record_result");
	}
	System.out.println("获得的数据集是："+jsonObj.toString());
	JSONArray jsonArr=(JSONArray)jsonObj.get("aaData");
	System.out.println(jsonArr.toString());
	ArrayList jsonRec=(ArrayList)jsonArr.get(0);
	System.out.println(jsonRec.toString());
%>
<style media=print>
.no_print{display:none;}
.page_next{page-break-after: always;}
</style>
<OBJECT id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0 width=0></OBJECT>
<div>
	<input type="button" class="no_print" value="打印" onclick="javascript:window.print()">
	<input type="button" class="no_print" value="返回" onclick=javascript:window.history.back()>
	<input type="button" style="display:none;" value="页面设置" onclick="javascript:WebBrowser.ExecWB(8,1)">
	<input type="button" style="display:none;" value="打印预览" onclick="javascript:WebBrowser.ExecWB(7,1)">
<div>

<script>
    function clos() {
        window.open('','_self','');
        window.close();
    }
</script>

    <html xmlns:v="urn:schemas-microsoft-com:vml"
          xmlns:o="urn:schemas-microsoft-com:office:office"
          xmlns:w="urn:schemas-microsoft-com:office:word"
          xmlns:m="http://schemas.microsoft.com/office/2004/12/omml"
          xmlns="http://www.w3.org/TR/REC-html40">

    <head>
        <meta http-equiv=Content-Type content="text/html; charset=gb2312">
        <meta name=ProgId content=Word.Document>
        <meta name=Generator content="Microsoft Word 15">
        <meta name=Originator content="Microsoft Word 15">
        <link rel=File-List href="sensor_print.files.files/filelist.xml">

        <!--[if gte mso 9]><xml>
        <o:DocumentProperties>
            <o:Author>Windows 用户</o:Author>
            <o:LastAuthor>Finn Wu</o:LastAuthor>
            <o:Revision>2</o:Revision>
            <o:TotalTime>3304</o:TotalTime>
            <o:Created>2019-04-22T08:58:00Z</o:Created>
            <o:LastSaved>2019-04-22T08:58:00Z</o:LastSaved>
            <o:Pages>1</o:Pages>
            <o:Words>9</o:Words>
            <o:Characters>54</o:Characters>
            <o:Company>Users</o:Company>
            <o:Lines>1</o:Lines>
            <o:Paragraphs>1</o:Paragraphs>
            <o:CharactersWithSpaces>62</o:CharactersWithSpaces>
            <o:Version>16.00</o:Version>
        </o:DocumentProperties>
        <o:OfficeDocumentSettings>
            <o:TargetScreenSize>800x600</o:TargetScreenSize>
        </o:OfficeDocumentSettings>
    </xml><![endif]-->
        <link rel=themeData href="sensor_print.files.files/themedata.thmx">
        <link rel=colorSchemeMapping
              href="sensor_print.files.files/colorschememapping.xml">
        <!--[if gte mso 9]><xml>
        <w:WordDocument>
            <w:Zoom>88</w:Zoom>
            <w:TrackMoves>false</w:TrackMoves>
            <w:TrackFormatting/>
            <w:PunctuationKerning/>
            <w:DrawingGridVerticalSpacing>7.8 磅</w:DrawingGridVerticalSpacing>
            <w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery>
            <w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery>
            <w:ValidateAgainstSchemas/>
            <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
            <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
            <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
            <w:DoNotPromoteQF/>
            <w:LidThemeOther>EN-US</w:LidThemeOther>
            <w:LidThemeAsian>ZH-CN</w:LidThemeAsian>
            <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
            <w:Compatibility>
                <w:SpaceForUL/>
                <w:BalanceSingleByteDoubleByteWidth/>
                <w:DoNotLeaveBackslashAlone/>
                <w:ULTrailSpace/>
                <w:DoNotExpandShiftReturn/>
                <w:AdjustLineHeightInTable/>
                <w:BreakWrappedTables/>
                <w:SnapToGridInCell/>
                <w:WrapTextWithPunct/>
                <w:UseAsianBreakRules/>
                <w:UseWord2010TableStyleRules/>
                <w:DontGrowAutofit/>
                <w:DontUseIndentAsNumberingTabStop/>
                <w:FELineBreak11/>
                <w:WW11IndentRules/>
                <w:DontAutofitConstrainedTables/>
                <w:AutofitLikeWW11/>
                <w:HangulWidthLikeWW11/>
                <w:UseNormalStyleForList/>
                <w:SplitPgBreakAndParaMark/>
                <w:DontVertAlignCellWithSp/>
                <w:DontBreakConstrainedForcedTables/>
                <w:DontVertAlignInTxbx/>
                <w:Word11KerningPairs/>
                <w:CachedColBalance/>
                <w:UseFELayout/>
            </w:Compatibility>
            <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
            <m:mathPr>
                <m:mathFont m:val="Cambria Math"/>
                <m:brkBin m:val="before"/>
                <m:brkBinSub m:val="&#45;-"/>
                <m:smallFrac m:val="off"/>
                <m:dispDef/>
                <m:lMargin m:val="0"/>
                <m:rMargin m:val="0"/>
                <m:defJc m:val="centerGroup"/>
                <m:wrapIndent m:val="1440"/>
                <m:intLim m:val="subSup"/>
                <m:naryLim m:val="undOvr"/>
            </m:mathPr></w:WordDocument>
    </xml><![endif]--><!--[if gte mso 9]><xml>
        <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
                        DefSemiHidden="false" DefQFormat="false" LatentStyleCount="376">
            <w:LsdException Locked="false" QFormat="true" Name="Normal"/>
            <w:LsdException Locked="false" QFormat="true" Name="heading 1"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            QFormat="true" Name="heading 2"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            QFormat="true" Name="heading 3"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            QFormat="true" Name="heading 4"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            QFormat="true" Name="heading 5"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            QFormat="true" Name="heading 6"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            QFormat="true" Name="heading 7"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            QFormat="true" Name="heading 8"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            QFormat="true" Name="heading 9"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            QFormat="true" Name="caption"/>
            <w:LsdException Locked="false" QFormat="true" Name="Title"/>
            <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font"/>
            <w:LsdException Locked="false" QFormat="true" Name="Subtitle"/>
            <w:LsdException Locked="false" Priority="99" Name="Hyperlink"/>
            <w:LsdException Locked="false" QFormat="true" Name="Strong"/>
            <w:LsdException Locked="false" QFormat="true" Name="Emphasis"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Normal Table"/>
            <w:LsdException Locked="false" Priority="99" Name="No List"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Simple 1"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Simple 2"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Simple 3"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Classic 1"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Classic 2"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Classic 3"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Classic 4"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Colorful 1"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Colorful 2"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Colorful 3"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Columns 1"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Columns 2"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Columns 3"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Columns 4"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Columns 5"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Grid 1"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Grid 2"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Grid 3"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Grid 4"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Grid 5"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Grid 6"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Grid 7"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Grid 8"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table List 1"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table List 2"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table List 3"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table List 4"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table List 5"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table List 6"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table List 7"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table List 8"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table 3D effects 1"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table 3D effects 2"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table 3D effects 3"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Contemporary"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Elegant"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Professional"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Subtle 1"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Subtle 2"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Web 1"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Web 2"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Web 3"/>
            <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
                            Name="Table Theme"/>
            <w:LsdException Locked="false" Priority="99" SemiHidden="true"
                            Name="Placeholder Text"/>
            <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
            <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
            <w:LsdException Locked="false" Priority="61" Name="Light List"/>
            <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
            <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
            <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
            <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
            <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
            <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
            <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
            <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
            <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
            <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
            <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
            <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
            <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
            <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
            <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
            <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
            <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
            <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
            <w:LsdException Locked="false" Priority="99" SemiHidden="true" Name="Revision"/>
            <w:LsdException Locked="false" Priority="34" QFormat="true"
                            Name="List Paragraph"/>
            <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
            <w:LsdException Locked="false" Priority="30" QFormat="true"
                            Name="Intense Quote"/>
            <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
            <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
            <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
            <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
            <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
            <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
            <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
            <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
            <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
            <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
            <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
            <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
            <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
            <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
            <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
            <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
            <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
            <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
            <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
            <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
            <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
            <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
            <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
            <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
            <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
            <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
            <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
            <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
            <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
            <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
            <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
            <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
            <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
            <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
            <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
            <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
            <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
            <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
            <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
            <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
            <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
            <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
            <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
            <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
            <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
            <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
            <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
            <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
            <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
            <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
            <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
            <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
            <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
            <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
            <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
            <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
            <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
            <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
            <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
            <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
            <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
            <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
            <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
            <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
            <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
            <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
            <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
            <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
            <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
            <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
            <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
            <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
            <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
            <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
            <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
            <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
            <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
            <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
            <w:LsdException Locked="false" Priority="19" QFormat="true"
                            Name="Subtle Emphasis"/>
            <w:LsdException Locked="false" Priority="21" QFormat="true"
                            Name="Intense Emphasis"/>
            <w:LsdException Locked="false" Priority="31" QFormat="true"
                            Name="Subtle Reference"/>
            <w:LsdException Locked="false" Priority="32" QFormat="true"
                            Name="Intense Reference"/>
            <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
            <w:LsdException Locked="false" Priority="37" SemiHidden="true"
                            UnhideWhenUsed="true" Name="Bibliography"/>
            <w:LsdException Locked="false" Priority="39" SemiHidden="true"
                            UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
            <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
            <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
            <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
            <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
            <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
            <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
            <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
            <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
            <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
            <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
            <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
            <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
            <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="Grid Table 1 Light Accent 1"/>
            <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
            <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
            <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
            <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="Grid Table 6 Colorful Accent 1"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="Grid Table 7 Colorful Accent 1"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="Grid Table 1 Light Accent 2"/>
            <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
            <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
            <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
            <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="Grid Table 6 Colorful Accent 2"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="Grid Table 7 Colorful Accent 2"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="Grid Table 1 Light Accent 3"/>
            <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
            <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
            <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
            <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="Grid Table 6 Colorful Accent 3"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="Grid Table 7 Colorful Accent 3"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="Grid Table 1 Light Accent 4"/>
            <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
            <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
            <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
            <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="Grid Table 6 Colorful Accent 4"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="Grid Table 7 Colorful Accent 4"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="Grid Table 1 Light Accent 5"/>
            <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
            <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
            <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
            <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="Grid Table 6 Colorful Accent 5"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="Grid Table 7 Colorful Accent 5"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="Grid Table 1 Light Accent 6"/>
            <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
            <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
            <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
            <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="Grid Table 6 Colorful Accent 6"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="Grid Table 7 Colorful Accent 6"/>
            <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
            <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
            <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
            <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
            <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
            <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
            <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="List Table 1 Light Accent 1"/>
            <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
            <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
            <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
            <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="List Table 6 Colorful Accent 1"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="List Table 7 Colorful Accent 1"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="List Table 1 Light Accent 2"/>
            <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
            <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
            <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
            <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="List Table 6 Colorful Accent 2"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="List Table 7 Colorful Accent 2"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="List Table 1 Light Accent 3"/>
            <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
            <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
            <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
            <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="List Table 6 Colorful Accent 3"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="List Table 7 Colorful Accent 3"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="List Table 1 Light Accent 4"/>
            <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
            <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
            <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
            <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="List Table 6 Colorful Accent 4"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="List Table 7 Colorful Accent 4"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="List Table 1 Light Accent 5"/>
            <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
            <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
            <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
            <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="List Table 6 Colorful Accent 5"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="List Table 7 Colorful Accent 5"/>
            <w:LsdException Locked="false" Priority="46"
                            Name="List Table 1 Light Accent 6"/>
            <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
            <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
            <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
            <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
            <w:LsdException Locked="false" Priority="51"
                            Name="List Table 6 Colorful Accent 6"/>
            <w:LsdException Locked="false" Priority="52"
                            Name="List Table 7 Colorful Accent 6"/>
            <w:LsdException Locked="false" Priority="99" SemiHidden="true"
                            UnhideWhenUsed="true" Name="Mention"/>
            <w:LsdException Locked="false" Priority="99" SemiHidden="true"
                            UnhideWhenUsed="true" Name="Smart Hyperlink"/>
            <w:LsdException Locked="false" Priority="99" SemiHidden="true"
                            UnhideWhenUsed="true" Name="Hashtag"/>
            <w:LsdException Locked="false" Priority="99" SemiHidden="true"
                            UnhideWhenUsed="true" Name="Unresolved Mention"/>
            <w:LsdException Locked="false" Priority="99" SemiHidden="true"
                            UnhideWhenUsed="true" Name="Smart Link"/>
        </w:LatentStyles>
    </xml><![endif]-->
        <style>
            <!--
            /* Font Definitions */
            @font-face
            {font-family:宋体;
                panose-1:2 1 6 0 3 1 1 1 1 1;
                mso-font-alt:SimSun;
                mso-font-charset:134;
                mso-generic-font-family:auto;
                mso-font-pitch:variable;
                mso-font-signature:3 680460288 22 0 262145 0;}
            @font-face
            {font-family:"Cambria Math";
                panose-1:2 4 5 3 5 4 6 3 2 4;
                mso-font-charset:0;
                mso-generic-font-family:roman;
                mso-font-pitch:variable;
                mso-font-signature:3 0 0 0 1 0;}
            @font-face
            {font-family:"\@宋体";
                panose-1:2 1 6 0 3 1 1 1 1 1;
                mso-font-charset:134;
                mso-generic-font-family:auto;
                mso-font-pitch:variable;
                mso-font-signature:3 680460288 22 0 262145 0;}
            /* Style Definitions */
            p.MsoNormal, li.MsoNormal, div.MsoNormal
            {mso-style-unhide:no;
                mso-style-qformat:yes;
                mso-style-parent:"";
                margin:0cm;
                margin-bottom:.0001pt;
                text-align:justify;
                text-justify:inter-ideograph;
                mso-pagination:none;
                font-size:10.5pt;
                mso-bidi-font-size:12.0pt;
                font-family:"Times New Roman",serif;
                mso-fareast-font-family:宋体;
                mso-font-kerning:1.0pt;}
            p.MsoHeader, li.MsoHeader, div.MsoHeader
            {mso-style-unhide:no;
                mso-style-link:"页眉 字符1";
                margin:0cm;
                margin-bottom:.0001pt;
                text-align:center;
                mso-pagination:none;
                tab-stops:center 207.65pt right 415.3pt;
                layout-grid-mode:char;
                border:none;
                mso-border-bottom-alt:solid windowtext .75pt;
                padding:0cm;
                mso-padding-alt:0cm 0cm 1.0pt 0cm;
                font-size:9.0pt;
                font-family:"Times New Roman",serif;
                mso-fareast-font-family:宋体;
                mso-font-kerning:1.0pt;}
            p.MsoFooter, li.MsoFooter, div.MsoFooter
            {mso-style-unhide:no;
                mso-style-link:"页脚 字符1";
                margin:0cm;
                margin-bottom:.0001pt;
                mso-pagination:none;
                tab-stops:center 207.65pt right 415.3pt;
                layout-grid-mode:char;
                font-size:9.0pt;
                font-family:"Times New Roman",serif;
                mso-fareast-font-family:宋体;
                mso-font-kerning:1.0pt;}
            a:link, span.MsoHyperlink
            {mso-style-priority:99;
                mso-style-unhide:no;
                color:blue;
                text-decoration:underline;
                text-underline:single;}
            a:visited, span.MsoHyperlinkFollowed
            {mso-style-unhide:no;
                color:#954F72;
                mso-themecolor:followedhyperlink;
                text-decoration:underline;
                text-underline:single;}
            p.msonormal0, li.msonormal0, div.msonormal0
            {mso-style-name:msonormal;
                mso-style-unhide:no;
                mso-margin-top-alt:auto;
                margin-right:0cm;
                mso-margin-bottom-alt:auto;
                margin-left:0cm;
                mso-pagination:widow-orphan;
                font-size:12.0pt;
                font-family:宋体;
                mso-bidi-font-family:宋体;}
            span.a
            {mso-style-name:"页眉 字符";
                mso-style-unhide:no;
                mso-style-locked:yes;
                mso-style-link:页眉;
                mso-ansi-font-size:9.0pt;
                mso-bidi-font-size:9.0pt;
                mso-font-kerning:1.0pt;}
            span.a0
            {mso-style-name:"页脚 字符";
                mso-style-unhide:no;
                mso-style-locked:yes;
                mso-style-link:页脚;
                mso-ansi-font-size:9.0pt;
                mso-bidi-font-size:9.0pt;
                mso-font-kerning:1.0pt;}
            span.1
            {mso-style-name:"页眉 字符1";
                mso-style-unhide:no;
                mso-style-locked:yes;
                mso-style-link:页眉;
                mso-ansi-font-size:9.0pt;
                mso-bidi-font-size:9.0pt;
                mso-font-kerning:1.0pt;}
            span.10
            {mso-style-name:"页脚 字符1";
                mso-style-unhide:no;
                mso-style-locked:yes;
                mso-style-link:页脚;
                mso-ansi-font-size:9.0pt;
                mso-bidi-font-size:9.0pt;
                mso-font-kerning:1.0pt;}
            .MsoChpDefault
            {mso-style-type:export-only;
                mso-default-props:yes;
                font-size:10.0pt;
                mso-ansi-font-size:10.0pt;
                mso-bidi-font-size:10.0pt;
                mso-ascii-font-family:"Times New Roman";
                mso-fareast-font-family:宋体;
                mso-hansi-font-family:"Times New Roman";
                mso-font-kerning:0pt;}
            /* Page Definitions */
            @page
            {mso-page-border-surround-header:no;
                mso-page-border-surround-footer:no;
                mso-footnote-separator:url("sensor_print.files.files/header.htm") fs;
                mso-footnote-continuation-separator:url("sensor_print.files.files/header.htm") fcs;
                mso-endnote-separator:url("sensor_print.files.files/header.htm") es;
                mso-endnote-continuation-separator:url("sensor_print.files.files/header.htm") ecs;}
            @page WordSection1
            {size:595.3pt 841.9pt;
                margin:72.0pt 90.0pt 72.0pt 90.0pt;
                mso-header-margin:42.55pt;
                mso-footer-margin:49.6pt;
                mso-paper-source:0;
                layout-grid:15.6pt;}
            div.WordSection1
            {page:WordSection1;}
            -->
        </style>
        <!--[if gte mso 10]>
        <style>
            /* Style Definitions */
            table.MsoNormalTable
            {mso-style-name:普通表格;
                mso-tstyle-rowband-size:0;
                mso-tstyle-colband-size:0;
                mso-style-noshow:yes;
                mso-style-priority:99;
                mso-style-parent:"";
                mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
                mso-para-margin:0cm;
                mso-para-margin-bottom:.0001pt;
                mso-pagination:widow-orphan;
                font-size:10.0pt;
                font-family:"Times New Roman",serif;}
            table.MsoTableGrid
            {mso-style-name:网格型;
                mso-tstyle-rowband-size:0;
                mso-tstyle-colband-size:0;
                mso-style-unhide:no;
                border:solid windowtext 1.0pt;
                mso-border-alt:solid windowtext .5pt;
                mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
                mso-border-insideh:.5pt solid windowtext;
                mso-border-insidev:.5pt solid windowtext;
                mso-para-margin:0cm;
                mso-para-margin-bottom:.0001pt;
                mso-pagination:widow-orphan;
                font-size:10.0pt;
                font-family:"Times New Roman",serif;}
        </style>
        <![endif]--><!--[if gte mso 9]><xml>
        <o:shapedefaults v:ext="edit" spidmax="2049"/>
    </xml><![endif]--><!--[if gte mso 9]><xml>
        <o:shapelayout v:ext="edit">
            <o:idmap v:ext="edit" data="1"/>
        </o:shapelayout></xml><![endif]-->
    </head>

    <body lang=ZH-CN style='tab-interval: 21.0pt; text-justify-trim: punctuation'>

    <div class=Section1 style='layout-grid: 15.6pt'>

        <p class=MsoNormal align=center style='text-align: center'>
            <b style='mso-bidi-font-weight: normal'><span
                    style='font-size: 16.0pt; mso-bidi-font-size: 11.0pt; font-family: 宋体; mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: 宋体; mso-fareast-theme-font: minor-fareast; mso-hansi-font-family: Calibri; mso-hansi-theme-font: minor-latin'>数据列表</span>
            </b><b style='mso-bidi-font-weight: normal'><span lang=EN-US
                                                              style='font-size: 16.0pt; mso-bidi-font-size: 11.0pt'><o:p></o:p>
				</span>
        </b>
        </p>

        <div align=center>

            <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
                   style='border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-border-themecolor: text1; mso-yfti-tbllook: 1184; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt'>
                <tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes'>
                    <td width=95 valign=top
                        style='width: 71.0pt; border: solid black 1.0pt; mso-border-themecolor: text1; mso-border-alt: solid black .5pt; mso-border-themecolor: text1; background: #BFBFBF; mso-shading: windowtext; mso-pattern: gray-25 auto; padding: 0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal align=center style='text-align: center'>
                            <b style='mso-bidi-font-weight: normal'><span
                                    style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: 宋体; mso-fareast-theme-font: minor-fareast; mso-hansi-font-family: Calibri; mso-hansi-theme-font: minor-latin'>ID</span>
                            </b><b style='mso-bidi-font-weight: normal'><span lang=EN-US
                                                                              style='font-size: 14.0pt'><o:p></o:p>
								</span>
                        </b>
                        </p>
                    </td>
                    <td width=102 valign=top
                        style='width: 76.15pt; border: solid black 1.0pt; mso-border-themecolor: text1; border-left: none; mso-border-left-alt: solid black .5pt; mso-border-left-themecolor: text1; mso-border-alt: solid black .5pt; mso-border-themecolor: text1; background: #BFBFBF; mso-shading: windowtext; mso-pattern: gray-25 auto; padding: 0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal align=center style='text-align: center'>
                            <b style='mso-bidi-font-weight: normal'><span
                                    style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: 宋体; mso-fareast-theme-font: minor-fareast; mso-hansi-font-family: Calibri; mso-hansi-theme-font: minor-latin'>设备ID</span>
                            </b><b style='mso-bidi-font-weight: normal'><span lang=EN-US
                                                                              style='font-size: 14.0pt'><o:p></o:p>
								</span>
                        </b>
                        </p>
                    </td>
                    <td width=227 valign=top
                        style='width: 6.0cm; border: solid black 1.0pt; mso-border-themecolor: text1; border-left: none; mso-border-left-alt: solid black .5pt; mso-border-left-themecolor: text1; mso-border-alt: solid black .5pt; mso-border-themecolor: text1; background: #BFBFBF; mso-shading: windowtext; mso-pattern: gray-25 auto; padding: 0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal align=center style='text-align: center'>
                            <b style='mso-bidi-font-weight: normal'><span
                                    style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: 宋体; mso-fareast-theme-font: minor-fareast; mso-hansi-font-family: Calibri; mso-hansi-theme-font: minor-latin'>数值类型</span>
                            </b><b style='mso-bidi-font-weight: normal'><span lang=EN-US
                                                                              style='font-size: 14.0pt'><o:p></o:p>
								</span>
                        </b>
                        </p>
                    </td>
                    <td width=227 valign=top
                        style='width: 6.0cm; border: solid black 1.0pt; mso-border-themecolor: text1; border-left: none; mso-border-left-alt: solid black .5pt; mso-border-left-themecolor: text1; mso-border-alt: solid black .5pt; mso-border-themecolor: text1; background: #BFBFBF; mso-shading: windowtext; mso-pattern: gray-25 auto; padding: 0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal align=center style='text-align: center'>
                            <b style='mso-bidi-font-weight: normal'><span
                                    style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: 宋体; mso-fareast-theme-font: minor-fareast; mso-hansi-font-family: Calibri; mso-hansi-theme-font: minor-latin'>数值</span>
                            </b><b style='mso-bidi-font-weight: normal'><span lang=EN-US
                                                                              style='font-size: 14.0pt'><o:p></o:p>
								</span>
                        </b>
                        </p>
                    </td>

                    <td width=227 valign=top
                        style='width: 6.0cm; border: solid black 1.0pt; mso-border-themecolor: text1; border-left: none; mso-border-left-alt: solid black .5pt; mso-border-left-themecolor: text1; mso-border-alt: solid black .5pt; mso-border-themecolor: text1; background: #BFBFBF; mso-shading: windowtext; mso-pattern: gray-25 auto; padding: 0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal align=center style='text-align: center'>
                            <b style='mso-bidi-font-weight: normal'><span
                                    style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: 宋体; mso-fareast-theme-font: minor-fareast; mso-hansi-font-family: Calibri; mso-hansi-theme-font: minor-latin'>检测时间</span>
                            </b><b style='mso-bidi-font-weight: normal'><span lang=EN-US
                                                                              style='font-size: 14.0pt'><o:p></o:p>
								</span>
                        </b>
                        </p>
                    </td>


                </tr>
                <%
                    for (int i = 0; i < jsonArr.length(); i++) {
                        ArrayList list = (ArrayList) jsonArr.get(i);
                        System.out.println(list.toString());
                        String id = (String) list.get(0);
                        String device_id = (String) list.get(1);
                        String value_type = (String) list.get(2);
                        String sensor_value_string = (String) list.get(3);
                        String detect_time = (String) list.get(4);
                        System.out.println("detect_time is " + detect_time);

                        // console.log(detect_time);
                %>
                <tr style='mso-yfti-irow: 1'>
                    <td width=95 valign=top
                        style='width: 71.0pt; border: solid black 1.0pt; mso-border-themecolor: text1; border-top: none; mso-border-top-alt: solid black .5pt; mso-border-top-themecolor: text1; mso-border-alt: solid black .5pt; mso-border-themecolor: text1; padding: 0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal>
								<span lang=EN-US style='font-size: 14.0pt'><o:p><%=id %>
                                </o:p>
								</span>
                        </p>
                    </td>
                    <td width=102 valign=top
                        style='width: 76.15pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; mso-border-bottom-themecolor: text1; border-right: solid black 1.0pt; mso-border-right-themecolor: text1; mso-border-top-alt: solid black .5pt; mso-border-top-themecolor: text1; mso-border-left-alt: solid black .5pt; mso-border-left-themecolor: text1; mso-border-alt: solid black .5pt; mso-border-themecolor: text1; padding: 0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal>
								<span lang=EN-US style='font-size: 14.0pt'><o:p><%=device_id %>
                                </o:p>
								</span>
                        </p>
                    </td>
                    <td width=102 valign=top
                        style='width: 76.15pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; mso-border-bottom-themecolor: text1; border-right: solid black 1.0pt; mso-border-right-themecolor: text1; mso-border-top-alt: solid black .5pt; mso-border-top-themecolor: text1; mso-border-left-alt: solid black .5pt; mso-border-left-themecolor: text1; mso-border-alt: solid black .5pt; mso-border-themecolor: text1; padding: 0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal>
								<span lang=EN-US style='font-size: 14.0pt'><o:p><%=value_type %>
                                </o:p>
								</span>
                        </p>
                    </td>
                    <td width=227 valign=top
                        style='width: 6.0cm; border-top: none; border-left: none; border-bottom: solid black 1.0pt; mso-border-bottom-themecolor: text1; border-right: solid black 1.0pt; mso-border-right-themecolor: text1; mso-border-top-alt: solid black .5pt; mso-border-top-themecolor: text1; mso-border-left-alt: solid black .5pt; mso-border-left-themecolor: text1; mso-border-alt: solid black .5pt; mso-border-themecolor: text1; padding: 0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal>
								<span lang=EN-US style='font-size: 14.0pt'><o:p><%=sensor_value_string %>
                                </o:p>
								</span>
                        </p>
                    </td>
                    <td width=111 valign=top style='width:83.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal><span lang=EN-US
                                                 style='font-size:14.0pt;color:windowtext'><o:p><%=detect_time %>
                        </o:p></span></p>
                    </td>

                </tr>
                <%
                    }
                    Calendar cal = Calendar.getInstance();
                    int year = cal.get(Calendar.YEAR);
                    int month = cal.get(Calendar.MONTH) + 1;
                    int day = cal.get(Calendar.DATE);
                    System.out.println(month);
                %>
                <tr style='mso-yfti-irow: 2; mso-yfti-lastrow: yes'>
                    <td width=555 colspan=4 valign=top
                        style='width: 416.5pt; border: none; mso-border-top-alt: solid black .5pt; mso-border-top-themecolor: text1; padding: 0cm 5.4pt 0cm 5.4pt'>
                        <p class=MsoNormal align=right style='text-align: right'>
                            <span lang=EN-US style='font-size: 14.0pt'><%=year %></span><span
                                style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: 宋体; mso-fareast-theme-font: minor-fareast; mso-hansi-font-family: Calibri; mso-hansi-theme-font: minor-latin'>年</span><span
                                lang=EN-US style='font-size: 14.0pt'><%=month %></span><span
                                style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: 宋体; mso-fareast-theme-font: minor-fareast; mso-hansi-font-family: Calibri; mso-hansi-theme-font: minor-latin'>月</span><span
                                lang=EN-US style='font-size: 14.0pt'><%=day %></span><span
                                style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: 宋体; mso-fareast-theme-font: minor-fareast; mso-hansi-font-family: Calibri; mso-hansi-theme-font: minor-latin'>日</span><span
                                lang=EN-US style='font-size: 14.0pt'><o:p></o:p>
								</span>
                        </p>
                    </td>
                </tr>
            </table>
        </div>
        <p class=MsoNormal>
				<span lang=EN-US><o:p>&nbsp;</o:p>
				</span>
        </p>
    </div>
    </body>
</html>




<script src="../../assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script>
    var today=new Date();
    jQuery(document).ready(function() {
        init();
    });
    var init = function() {
        var mouth=today.getMonth()+1;
        $("#year").html("<span lang=EN-US style='font-size: 14.0pt' id=\"year\">"+today.getFullYear()+"</span>");
        $("#mouth").html("<span lang=EN-US style='font-size: 14.0pt' id=\"year\">"+mouth+"</span>");
        $("#day").html("<span lang=EN-US style='font-size: 14.0pt' id=\"year\">"+today.getDate()+"</span>");
    }


</script>