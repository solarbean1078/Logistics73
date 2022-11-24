<%-------------------------------------수정-----------------------------------------------------%>

<%--
  Created by IntelliJ IDEA.
  User: 82109
  Date: 2022-09-29
  Time: 오전 11:23
  To change this template use File | Settings | File Templates.
--%>
<%----------------------------------수정------------------------------------%>

<%-------------------------------------------------------------------------%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%----------------------------수정----------------------------------%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--이거 넣으면 상단 메뉴가 망가짐--%>
    <%--<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>


    <%-----------------------------------------------------------------%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
    <script src="${pageContext.request.contextPath}/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <script src="${pageContext.request.contextPath}/js/datepicker.js" defer></script>
    <script src="${pageContext.request.contextPath}/js/datepickerUse.js" defer></script>
    <script src="${pageContext.request.contextPath}/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/datepicker.css">
    <style>
        .menuButton button {
            background-color: #506FA9;
            border: none;
            color: white;
            text-align: center;


            font-size: 14px;
            border-radius: 3px;
            margin-bottom: 5px;
        }

        h3 {
            margin-top: 20px;
        }

        /*---------------------------수정------------------------------------*/



        /*-------------------------------------------------------------------*/
    </style>
</head>
<body>

    <h3>거래처 목록🏬</h3>
    <%----------------------------------수정------------------------------------%>



    <div class="modal fade" id="addContactModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">거래처 등록</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>

                <div class="modal-body">
                    <%--<form method="POST" enctype='application/json' action="/compinfo/customer/registerCustomer">--%>
                <%--<form &lt;%&ndash;action="addcontact.php"&ndash;%&gt; method="POST" &lt;%&ndash;action="/compinfo/customer/registerCustomer"&ndash;%&gt;>
                    <input type="hidden" class="form-control" id="seq" name="seq">--%>

                        <div class="container-fluid">
                            <div class="row">
                                <form id="registerForm" >
                                <div class="col-md-6 col-sm-6 col-xs-6">



                                    <div class="form-group">
                                        <span style="color: red">*</span><label>고객 코드</label>
                                        <input type="text" class="form-control" id="customerCode" name="customerCode" required>
                                    </div>
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>직장 코드</label>
                                        <input type="text" class="form-control" id="workplaceCode" name="workplaceCode" required>
                                    </div>
                                    <div class="form-group">
                                        <span style="color: red">*</span><label>고객 이름</label>
                                        <input type="text" class="form-control" id="customerName"  name="customerName" required>
                                    </div>

                                </div>

                                <div class="col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <label for="contactea">Email Address</label>
                                        <input type="email" class="form-control" id="contactea" name="txt_ea" >
                                    </div>
                                    <div class="form-group">
                                        <label for="contactnum">Mobile Number</label>
                                        <input type="text" class="form-control" id="contactnum" name="txt_num" >
                                    </div>
                                    <%--쿼리문 바로 입력 가능한듯--%>
                                    <div class="form-group">
                                        <label for="contactgroup">Select Group</label>
                                        <select name="txt_group" class="form-control" id="contactgroup" >
                                            <option value="">Choose group...</option>
                                            <?php
              require 'conn.php';
              try {
                  $data = $conn->query("SELECT * FROM tbl_groups");
                                            foreach($data as $row) {
                                            ?>
                                            <option value="<?php echo $row['id']; ?>"><?php echo $row['groupname']; ?></option>
                                            <?php
                } } catch (PDOException $e) {
                  echo 'ERROR: ' . $e->getMessage();
                                            }
                                            ?>
                                        </select>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                                    <%--<input type="submit" name="addgroupbtn" class="btn btn-primary" value="Save Contact">--%>
                                    <button class="btn btn-primary" id="customerInsertButton" data-dismiss="modal" <%--onclick="addCustomerRow(this)"--%>>완료</button>
                                </div>
                                </form>
                            </div>
                        </div>

                    </div>
                <%--</form>--%>
            </div>
        </div>
    </div>

    <%--------------------------------------------------------------------------%>
    <div class="menuButton">
        <button type="button"  data-toggle="modal" data-target="#addContactModal">작성</button>
        <button id="saveCustomer" onclick="setRow(this)">거래처 등록</button>
        <button id="deleteCustomer" onclick="deleteRow(this)" style=" /*margin-left:10px;*/ float:right; background-color:#F15F5F" >거래처 삭제</button>
    </div>


    <article class="estimateGrid" >
        <div align="center">
            <div id="myGrid" class="ag-theme-balham" style="height:450px; width:auto; text-align: center;" ></div>
        </div>
    </article>


<%--    <div><h3>거래처 등록📎</h3></div>
    <div class="menuButton">
       <button id="customerInsertButton" onclick="addRow(this)">거래처 등록</button>
    </div>--%>


    <article class="register">
        <div align="center">
            <div id="registerAccount" class="ag-theme-balham"
                 style="height:100px; width:auto; text-align: center;"></div>
        </div>
    </article>


<script>
        const myGrid = document.querySelector("#myGrid"); // grid의 이름 그리고 값을 넣을 div의 id
        const registerAccount = document.querySelector("#registerAccount");
        document.addEventListener('DOMContentLoaded', () => {  // DOMContentLoaded : 스크립트가 시작할 준비가 됐으면 function 함수실행
            new agGrid.Grid(myGrid, cstGridOptions);        // accoutGrid는 div태그의 변수이름이고 , cstGridOptions는 안에 들어갈 값들이다
            new agGrid.Grid(registerAccount, registerOptions);
        })



        // 거래처 목록
        let cstColumn = [
            {checkboxSelection: true, headerCheckboxSelectionFilteredOnly: true, width: 50},
            {headerName: "고객 코드", field: "customerCode"}, // editable: 편집가능한 문자열로 EditText 의 기본 Type , field는 변수명
            {headerName: "직장코드", field: "workplaceCode"},
            {headerName: "고객 이름", field: "customerName"},
            {headerName: "고객유형", field: "customerType"},
            {headerName: "고객CEO", field: "customerCeo"},
            {headerName: "비즈니스 라이선스 번호", field: "businessLicenseNumber"},
            {headerName: "고객비즈니스조건", field: "customerBusinessConditions"},
            {headerName: "고객비즈니스아이템", field: "customerBusinessItems"},
            {headerName: "고객우편번호", field: "customerZipCode"},
            {headerName: "고객기본주소", field: "customerBasicAddress"},
            {headerName: "고객 정보 주소", field: "customerDetailAddress"},
            {headerName: "고객전화번호", field: "customerTelNumber"},
            {headerName: "고객 팩스 번호", field: "customerFaxNumber"}

        ];
        let cstRowData = [];     // 빈 배열을 넣음

        // event.colDef.field
        let cstGridOptions = {
            columnDefs: cstColumn,  // 열을 정의하는거 columnDefs
            autoSizeColumn: cstColumn,
            rowSelection: 'multiple', //row data를 선택하는 경우의 옵션으로 하나만 선택
            rowData: cstRowData,  // 그리드에 표시할 데이터를 설정
            localeText: {noRowsToShow: '나와라요'}, // "key": "dateue"
            onGridReady: function (event) { // 그리드가 시작하자마자 실행되는거
                event.api.sizeColumnsToFit(); //자동으로 글자나 이것저것 크기조정
            },
            onGridSizeChanged: function (event) { // 창크기가 변경되면 실행되는 이벤트
                event.api.sizeColumnsToFit();
            },
            getSelectedRowData() {                          // 특정 필드의 값을 가지고오기 위해서 필요함 cstGridOptions.getSelectedRowData()[0].customerName
                let selectedNodes = this.api.getSelectedNodes();     // Object 찍힘  (선택한 열?)
                let selectedData = selectedNodes.map(node => node.data); // Object 찍힘
                return selectedData;
            }
        }

/*
        // 거래처 등록 칼럼
        let registercstColumn = [
            {checkboxSelection: true, headerCheckboxSelectionFilteredOnly: true, headerCheckboxSelection: true}, // 어떤 열을 보낼지 선택하도록 체크박스 추가
            {headerName: "고객 코드", field: "customerCode", editable: true}, // editable: 편집가능한 문자열로 EditText 의 기본 Type , field는 변수명
            {headerName: "직장코드", field: "workplaceCode", editable: true},
            {headerName: "고객 이름", field: "customerName", editable: true},
            {headerName: "고객유형", field: "customerType", editable: true},
            {headerName: "고객CEO", field: "customerCeo", editable: true},
            {headerName: "비즈니스 라이선스 번호", field: "businessLicenseNumber", editable: true},
            {headerName: "고객비즈니스조건", field: "customerBusinessConditions", editable: true},
            {headerName: "고객비즈니스아이템", field: "customerBusinessItems", editable: true},
            {headerName: "고객우편번호", field: "customerZipCode", editable: true},
            {headerName: "고객기본주소", field: "customerBasicAddress", editable: true},
            {headerName: "고객 정보 주소", field: "customerDetailAddress", editable: true},
            {headerName: "고객전화번호", field: "customerTelNumber", editable: true},
            {headerName: "고객 팩스 번호", field: "customerFaxNumber", editable: true}
        ];

        let row = {
            customerCode: "",
            workplaceCode: "",
            customerName: "",
            customerType: "",
            customerCeo: "",
            businessLicenseNumber: "",
            customerBusinessConditions: "",
            customerBusinessItems: "",
            customerZipCode: "",
            customerBasicAddress: "",
            customerDetailAddress: "",
            customerTelNumber: "",
            customerFaxNumber: "",
        };


        let registerOptions = {
            columnDefs: registercstColumn,  // 열을 정의하는거 columnDefs
            autoSizeColumn: cstColumn,      // 자동으로 칼럼들을 사이즈조정해줌
            rowData: cstRowData,            // 그리드에 표시할 데이터를 설정
            onGridReady: function (event) { // 그리드가 시작하자마자 실행되는거
                event.api.sizeColumnsToFit();//자동으로 가로크기 조정
                registerOptions.api.updateRowData({add: [row]});

            },
            onGridSizeChanged: function (event) { // 창크기가 변경되면 실행되는 이벤트
                event.api.sizeColumnsToFit();
            },
            getSelectedRowData() {
                let selectedNodes = this.api.getSelectedNodes();     // Object 찍힘  (선택한 열?)
                let selectedData = selectedNodes.map(node => node.data); // Object 찍힘
                return selectedData;
            },

        }*/

        /*----------------------------------수정---------------------------------------*/
      /*  function addCustomerRow(customerCode, workplaceCode, customerName){
            $('#addContactModal').on(function(event) {
                $(".modal-body #customerCode").val(customerCode);
                $(".modal-body #workplaceCode").val(workplaceCode);
                $(".modal-body #customerName").val(customerName);
                $(".modal-body #seq").val( seq );
            })
            $.ajax({
                type : 'POST',
                url: "/compinfo/customer/registerCustomer",     // 데이터를 받아올 경로
                contentType : 'application/json',
                data : JSON.stringify(registerOptions.getSelectedRowData()),

                success: (result) => {                     // url의 경로가 성공적이면 실행
                    //console.log(obj.customer+"abvced");
                    /!*cstGridOptions.api.setRowData(result.customer) // = 컨트롤러의 list 출력*!/
                    registerOptions.api.setRowData([]);
                    // cstGridOptions.api.setRowData()는 데이터를 교체하는것이라고함 , 빈배열에 컨트롤러에서 가져온 값들을 넣기위함
                }
            })
        }*/

        /*----------------------------------------------------------------------------*/
        /*----------------------------------수정2---------------------------------------*/
       /* $('#customerInsertButton').on('click', function(){

        });*/

        /*function addCustomerRow() {
            /!*let queryString = $("form[name=registerForm]").serialize();*!/

            const customerCode = $("#customerCode").val();
            const workplaceCode = $("#workplaceCode").val();
            const customerName = $("#customerName").val();

            $.ajax({
                    type: 'post',
                    url: '/compinfo/customer/registerCustomer',
                    data: JSON.stringify({
                        method : 'registerCustomer',
                        customerCode: customerCode,
                        workplaceCode: workplaceCode,
                        customerName: customerName
                    }),
                    contentType : 'application/json',
                    dataType: 'json',

                    success: function (jsonData) {
                        registerOptions.api.setRowData(jsonData.customerList);
                    }
                });

        }*/

            /*----------------------------------------------------------------------------*/
        /*----------------------------------수정3---------------------------------------*/
        /*function addCustomerRow() {
        /!*$(document).on('click','#customerInsertButton', function(){*!/
            /!*let formArray = new Array();*!/
            let formArray = [];
            /!*let newObj = Object.assign(formArray);*!/
            formArray.reduce( (a,b) => {
                return a.concat(b);
            }, [] );


            //제이쿼리 선택자가 유동적일때
            // id ^= a a로 시작하는것
            //id *= a a가 포함된것
            //id $= a a로 끝나는것
            $("form[id*='registerForm']").find("input").each(function(){
                let formVal = $(this).prop("value");
                let formName = $(this).prop("name");
                /!*formArray.push($(this).val());*!/

                //tableName 변수에 들어있는 값을 키 값으로 써주기 위해 []안에 넣어서 처리 해준다.
                formArray.push(
                    {
                        [formName]:formVal
                    }
                );


                console.log(Object.values(formArray));
            // Array ["Dip2K", 30, true, Object {  }]
            });
            let JsonData = JSON.stringify(Object.values(formArray));
            console.log(JsonData);

            $.ajax({
                type:'post',
                /!*async:false,*!/
                traditional: true,
                contentType:'application/json; charset=utf-8',
                beforeSend : function(xhr)
                {   /!*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*!/
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                data:JSON.stringify(JsonData),
                dataType:'json',
                url:'${pageContext.request.contextPath}/compinfo/customer/registerCustomer',
                success:function(res){
                    registerOptions.api.setRowData([]);
                    console.log(res);
                }
            });
        }*/



        /*----------------------------------------------------------------------------*/


        /*----------------------------------수정4---------------------------------------*/
       $('#customerInsertButton').click(function(){
        //function addCustomerRow() {
            /*$(document).on('click','#customerInsertButton', function() {*/
           let keyArray = [];
           let valueArray = [];

           //제이쿼리 선택자가 유동적일때
           // id ^= a a로 시작하는것
           //id *= a a가 포함된것
           //id $= a a로 끝나는것
           $("form[id*='registerForm']").find("input").each(function () {
               let formName = $(this).prop("name");
               let formVal = $(this).prop("value");

               keyArray.push(formName);
               valueArray.push(formVal);
           });

           let resultArray = keyArray.reduce((acc, curr, idx) => {
               acc[curr] = valueArray[idx];
               return acc;
           }, new Object);


                console.log(JSON.stringify(resultArray) + " 확인");
                let xhr = new XMLHttpRequest();
                // XHR을 사용하면 페이지의 새로고침 없이도 URL에서 데이터를 가져올 수 있습니다
                xhr.open('POST', "/compinfo/customer/registerCustomer" // 위의 값들을 addNewEstimate.do를 호출시켜서 던질거임
                    , true);
                xhr.setRequestHeader('Content-Type', 'application/json');// (헤더이름,헤더값) HTTP요청 헤더에 포함하고자 하는 헤더 이름과 그 값인데 전에 무조건 open()뒤에는 send()메소드를 써주어야 한다.
                //xhr.send(JSON.parse(JSON.stringify(cstGridOptions.api.updateRowData({add: [resultArray]})).toString())); // 요청을 전송합니다. 비동기 요청(기본 동작)인 경우, send()는 요청을 전송하는 즉시 반환
                xhr.send(JSON.stringify(cstGridOptions.api.updateRowData({add: [resultArray]}))); // 요청을 전송합니다. 비동기 요청(기본 동작)인 경우, send()는 요청을 전송하는 즉시 반환
                /*xhr.onreadystatechange = () => {                    // readyState 속성이 바뀔 때마다 발생합니다. onreadystatechange 속성으로도 수신할 수 있음
                    if (xhr.readyState == 4 && xhr.status == 200) {

                        let txt = xhr.responseText;
                        txt = JSON.parse(txt);
                        if (txt.errorCode < 0) {
                            swal.fire("오류", txt.errorMsg, "error");
                            return;
                        }
                        //cstGridOptions.api.setRowData(resultArray.data);
                        //cstGridOptions.api.setRowData([]);
                        //cstGridOptions.rowData.slice(resultArray)
                        //registerOptions.api.setRowData([]);  // 문자열들을 배열에 담음
                    }
                }*/
                //location.reload();   // 클릭하면 다시 로드
            })

  /*      "customerCode"}, // editable: 편집가능한 문자열로 EditText 의 기본 Type , field는 변수명
        {headerName: "직장코드", field: "workplaceCode"},
        {headerName: "고객 이름", field: "customerName"*/



        /*----------------------------------------------------------------------------*/

            // 거래처 등록
            function setRow() {
                let data = cstGridOptions.getSelectedRowData();
                console.log(JSON.stringify(data) + " 확인");
                let xhr = new XMLHttpRequest(); /*  XMLHttpRequest는 HTTP를 통해서 쉽게 데이터를 받을 수 있게 해주는 오브젝트를 제공한다
                                                        Ajax로 실행되는 HTTP 통신도 XMLHttpRequest규격을 이용함  */
                // XHR을 사용하면 페이지의 새로고침 없이도 URL에서 데이터를 가져올 수 있습니다
                xhr.open('POST', "/compinfo/customer/registerCustomer" // 위의 값들을 addNewEstimate.do를 호출시켜서 던질거임
                    , true);
                xhr.setRequestHeader('Content-Type', 'application/json');// (헤더이름,헤더값) HTTP요청 헤더에 포함하고자 하는 헤더 이름과 그 값인데 전에 무조건 open()뒤에는 send()메소드를 써주어야 한다.
                xhr.send(JSON.stringify(data)); // 요청을 전송합니다. 비동기 요청(기본 동작)인 경우, send()는 요청을 전송하는 즉시 반환
                xhr.onreadystatechange = () => {                    // readyState 속성이 바뀔 때마다 발생합니다. onreadystatechange 속성으로도 수신할 수 있음
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        let txt = xhr.responseText;
                        txt = JSON.parse(txt);
                        if (txt.errorCode < 0) {
                            swal.fire("오류", txt.errorMsg, "error");
                            return;
                        }

                        cstGridOptions.api.setRowData([]);  // 문자열들을 배열에 담음
                    }
                }
                //location.reload();   // 클릭하면 다시 로드
            }


        /*----------------------------------------------------------------------------*/
        // 거래처 등록
        /*function addRow() {
            let data = registerOptions.getSelectedRowData();
            console.log(JSON.stringify(data) + " 확인");
            let xhr = new XMLHttpRequest(); /!*  XMLHttpRequest는 HTTP를 통해서 쉽게 데이터를 받을 수 있게 해주는 오브젝트를 제공한다
                                                    Ajax로 실행되는 HTTP 통신도 XMLHttpRequest규격을 이용함  *!/
            // XHR을 사용하면 페이지의 새로고침 없이도 URL에서 데이터를 가져올 수 있습니다
            xhr.open('POST', "/compinfo/customer/registerCustomer" // 위의 값들을 addNewEstimate.do를 호출시켜서 던질거임
                , true);
            xhr.setRequestHeader('Content-Type', 'application/json');// (헤더이름,헤더값) HTTP요청 헤더에 포함하고자 하는 헤더 이름과 그 값인데 전에 무조건 open()뒤에는 send()메소드를 써주어야 한다.
            xhr.send(JSON.stringify(data)); // 요청을 전송합니다. 비동기 요청(기본 동작)인 경우, send()는 요청을 전송하는 즉시 반환
            xhr.onreadystatechange = () => {                    // readyState 속성이 바뀔 때마다 발생합니다. onreadystatechange 속성으로도 수신할 수 있음
                if (xhr.readyState == 4 && xhr.status == 200) {
                    let txt = xhr.responseText;
                    txt = JSON.parse(txt);
                    if (txt.errorCode < 0) {
                        swal.fire("오류", txt.errorMsg, "error");
                        return;
                    }

                    registerOptions.api.setRowData([]);  // 문자열들을 배열에 담음
                }
            }
            location.reload();   // 클릭하면 다시 로드
        }*/



            // 거래처 삭제
            function deleteRow(event) {
                let customerRowValue = cstGridOptions.getSelectedRowData();
                console.log(JSON.stringify(customerRowValue) + " 확인");
                /*-----------선택하지 않았을 때---------------------*/
                let selectedRows = cstGridOptions.api.getSelectedRows();  // '견적상세추가'그리드 배열 리턴 받음
                console.log(selectedRows); // 콘솔로 견적상세추가 그리드 배열을 출력
                if (customerRowValue.length == 0) { // 견적 상세 그리드가 없으면
                    Swal.fire({              // 에러메세지창 출력
                        text: "선택한 행이 없습니다.",
                        icon: "info",
                    })
                    return;
                }
                /*------------------------------------------------*/
                if (customerRowValue[0].customerCode >= "PTN-01" && customerRowValue[0].customerCode <= "PTN-13") {
                    Swal.fire({
                        text: "삭제할 수 없는 거래처입니다.",
                        icon: "error"
                    });
                    return;
                } else if (customerRowValue[0].customerCode != "") {
                    Swal.fire({
                        text: "선택한 거래처를 삭제하시겠습니까?",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        cancelButtonText: '취소',
                        confirmButtonText: '확인'
                    }).then((result) => {
                        if (result.isConfirmed) { //확인을 눌렀을 경우(이렇게 안하면 취소해도 삭제됨)
                            let customerName = cstGridOptions.getSelectedRowData()[0].customerName;
                            console.log(JSON.stringify(customerName))
                            let xhr = new XMLHttpRequest();
                            /*XMLHttpRequest는 HTTP를 통해서 쉽게 데이터를 받을 수 있게 해주는 오브젝트를 제공한다
                                                        Ajax로 실행되는 HTTP 통신도 XMLHttpRequest규격을 이용함 */
                            // XHR을 사용하면 페이지의 새로고침 없이도 URL에서 데이터를 가져올 수 있습니다
                            xhr.open('POST', "/compinfo/customer/removeCustomer?deleteCustomer=" + customerName, true);   // Accept Param 값 전달할 때 사용
                            // Content-Type RequestBody 사용할 때 사용
                            xhr.setRequestHeader('Accept', 'application/json');// (헤더이름,헤더값) HTTP요청 헤더에 포함하고자 하는 헤더 이름과 그 값인데 전에 무조건 open()뒤에는 send()메소드를 써주어야 한다.
                            xhr.send(); // 요청을 전송합니다. 비동기 요청(기본 동작)인 경우, send()는 요청을 전송하는 즉시 반환
                            xhr.onreadystatechange = () => {  //callback함수 사용
                                // 숫자값에 따라 처리상태가 달라지는 것.
                                // xhr.readyState == 4 : 데이터를 전부 받은 상태,완료되었다.
                                // xhr.status == 200 : 서버로부터의 응답상태가 요청에 성공하였다는 의미.
                                if (xhr.readyState == 4 && xhr.status == 200) {
                                    Swal.fire({
                                        title: "삭제가 완료되었습니다.",
                                        icon: "success"
                                    })
                                    return;
                                }
                                // 확인 버튼을 눌렀을 때 새로고침 없이 바로 삭제
                                selectedRows.forEach(function (selectedRow) {
                                    console.log(selectedRow);
                                    cstGridOptions.api.updateRowData({remove: [selectedRow]});
                                });
                            }
                        };
                    })
                }
            }

            $.ajax({
                url: "/compinfo/customer/allList",     // 데이터를 받아올 경로
                dataType: "json",                       // json형태로 받아오기 위함
                method: "GET",                          //GET 메소드는 주로 데이터를 읽거나(Read) 검색(Retrieve)할 때에 사용
                                                        //POST 메소드는 주로 새로운 리소스를 생성(create)할 때 사용
                success: (obj) => {                     // url의 경로가 성공적이면 실행
                    //console.log(obj.customer+"abvced");
                    cstGridOptions.api.setRowData(obj.customer) // = 컨트롤러의 list 출력
                    // cstGridOptions.api.setRowData()는 데이터를 교체하는것이라고함 , 빈배열에 컨트롤러에서 가져온 값들을 넣기위함
                }
            })

    </script>
</body>
</html>
<%-------------------------------------여기까지 수정-----------------------------------------------------%>


<%------------------------------------------원본-------------------------------------------------%>
<%--

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
    <script src="${pageContext.request.contextPath}/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <script src="${pageContext.request.contextPath}/js/datepicker.js" defer></script>
    <script src="${pageContext.request.contextPath}/js/datepickerUse.js" defer></script>
    <script src="${pageContext.request.contextPath}/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/datepicker.css">

</head>
<body>
<div>
    <h1>거래처 목록🏬</h1>
    <article class="estimateGrid">
        <div align="center">
            <div id="accountData" class="ag-theme-balham" style="height:450px; width:auto; text-align: center;"></div>
        </div>
        <button onclick="deleteCustomer()" id="deleteCustomer">삭제</button>
        <div><h1>거래처 등록🌎</h1></div>

    </article>


    <script>
        $.ajax({
            url: "/compinfo/customer/allList",     // 데이터를 받아올 경로
            dataType: "json",                       // json형태로 받아오기 위함
            method: "GET",                          //GET 메소드는 주로 데이터를 읽거나(Read) 검색(Retrieve)할 때에 사용
                                                    //POST 메소드는 주로 새로운 리소스를 생성(create)할 때 사용
            success: (obj) => {                     // url의 경로가 성공적이면 실행
                //console.log(obj.customer+"abvced");
                cstGridOptions.api.setRowData(obj.customer) // = 컨트롤러의 list 출력
                // cstGridOptions.api.setRowData()는 데이터를 교체하는것이라고함 , 빈배열에 컨트롤러에서 가져온 값들을 넣기위함
            }
        })

        const accoutGrid = document.querySelector("#accountData"); // grid의 이름 그리고 값을 넣을 div의 id

        let cstColumn = [
            {checkboxSelection: true,headerCheckboxSelectionFilteredOnly: true, width: 30},
            {headerName: "고객 코드", field: "customerCode"}, // editable: 편집가능한 문자열로 EditText 의 기본 Type , field는 변수명
            {headerName: "직장코드", field: "workplaceCode"},
            {headerName: "고객 이름", field: "customerName"},
            {headerName: "고객유형", field: "customerType"},
            {headerName: "고객CEO", field: "customerCeo"},
            {headerName: "비즈니스 라이선스 번호", field: "businessLicenseNumber"},
            {headerName: "사회보장번호", field: "socialSecurityNumber"},
            {headerName: "고객비즈니스조건", field: "customerBusinessConditions"},
            {headerName: "고객비즈니스아이템", field: "customerBusinessItems"},
            {headerName: "고객우편번호", field: "customerZipCode"},
            {headerName: "고객기본주소", field: "customerBasicAddress"},
            {headerName: "고객 정보 주소", field: "customerDetailAddress"},
            {headerName: "고객전화번호", field: "customerTelNumber"},
            {headerName: "고객 팩스 번호", field: "customerFaxNumber"},
            {headerName: "고객노트", field: "customerNote"},
            {headerName: "생산된 제품", field: "producedProduct"}

        ];
        let cstRowData = [];     // 빈 배열을 넣음

        // event.colDef.field
        let cstGridOptions = {
            columnDefs: cstColumn,  // 열을 정의하는거 columnDefs
            rowSelection: 'single', //row data를 선택하는 경우의 옵션으로 하나만 선택
            rowData: cstRowData,  // 그리드에 표시할 데이터를 설정
            localeText:{noRowsToShow: '새로고침하면 보입니다.'}, // "key": "value"
            onGridReady: function (event) { // 그리드가 시작하자마자 실행되는거
                event.api.sizeColumnsToFit(); //자동으로 글자나 이것저것 크기조정
            },
            getSelectedRowData() {                          // 특정 필드의 값을 가지고오기 위해서 필요함 cstGridOptions.getSelectedRowData()[0].customerName
                let selectedNodes = this.api.getSelectedNodes();     // Object 찍힘  (선택한 열?)
                let selectedData = selectedNodes.map(node => node.data); // Object 찍힘
                return selectedData;
            }
        }
        function deleteCustomer(){
            let PTN=cstGridOptions.getSelectedRowData()[0].customerCode;
            let customerName=cstGridOptions.getSelectedRowData()[0].customerName;
            console.log(JSON.stringify(customerName))
            if(PTN>="PTN-01"&&PTN<="PTN-13"){
                Swal.fire({
                    text: "삭제할 수 없는 거래처입니다.",
                    icon: "error",
                });
                return;
            }
            let xhr = new XMLHttpRequest();  /*XMLHttpRequest는 HTTP를 통해서 쉽게 데이터를 받을 수 있게 해주는 오브젝트를 제공한다
                                                    Ajax로 실행되는 HTTP 통신도 XMLHttpRequest규격을 이용함 */
            // XHR을 사용하면 페이지의 새로고침 없이도 URL에서 데이터를 가져올 수 있습니다
            xhr.open('POST', "/compinfo/customer/removeCustomer?deleteCustomer="
                + customerName,
                true);              // Accept Param 값 전달할 때 사용
                                    // Content-Type RequestBody 사용할 때 사용
            xhr.setRequestHeader('Accept', 'application/json');// (헤더이름,헤더값) HTTP요청 헤더에 포함하고자 하는 헤더 이름과 그 값인데 전에 무조건 open()뒤에는 send()메소드를 써주어야 한다.
            xhr.send(); // 요청을 전송합니다. 비동기 요청(기본 동작)인 경우, send()는 요청을 전송하는 즉시 반환
            xhr.onreadystatechange = () => {                    // readyState 속성이 바뀔 때마다 발생합니다. onreadystatechange 속성으로도 수신할 수 있음
                if (xhr.readyState == 4 && xhr.status == 200) {
                    let txt = xhr.responseText;
                    txt = JSON.parse(txt);
                    if (txt.errorCode < 0) {
                        swal.fire("오류", txt.errorMsg, "error");
                        return;
                    }
                }
            }
            location.reload();
        }
        document.addEventListener('DOMContentLoaded', () => {  // DOMContentLoaded : 스크립트가 시작할 준비가 됐으면 function 함수실행
            new agGrid.Grid(accoutGrid, cstGridOptions);        // accoutGrid는 div태그의 변수이름이고 , cstGridOptions는 안에 들어갈 값들이다
        })

    </script>


    <article class="register">
        <div align="center">
            <div id="registerAccount" class="ag-theme-balham"
                 style="height:100px; width:auto; text-align: center;"></div>
        </div>
    </article>
    <button onclick="insertCustomer()">등록</button>
    <script>
        const registerAccount = document.querySelector("#registerAccount");
        let registercstColumn = [
            {checkboxSelection: true,headerCheckboxSelectionFilteredOnly: true,headerCheckboxSelection: true,width: 100}, // 어떤 열을 보낼지 선택하도록 체크박스 추가
            {headerName: "고객 코드", field: "customerCode", editable: true}, // editable: 편집가능한 문자열로 EditText 의 기본 Type , field는 변수명
            {headerName: "직장코드", field: "workplaceCode", editable: true},
            {headerName: "고객 이름", field: "customerName", editable: true},
            {headerName: "고객유형", field: "customerType", editable: true},
            {headerName: "고객CEO", field: "customerCeo", editable: true},
            {headerName: "비즈니스 라이선스 번호", field: "businessLicenseNumber", editable: true},
            {headerName: "사회보장번호", field: "socialSecurityNumber", editable: true},
            {headerName: "고객비즈니스조건", field: "customerBusinessConditions", editable: true},
            {headerName: "고객비즈니스아이템", field: "customerBusinessItems", editable: true},
            {headerName: "고객우편번호", field: "customerZipCode", editable: true},
            {headerName: "고객기본주소", field: "customerBasicAddress", editable: true},
            {headerName: "고객 정보 주소", field: "customerDetailAddress", editable: true},
            {headerName: "고객전화번호", field: "customerTelNumber", editable: true},
            {headerName: "고객 팩스 번호", field: "customerFaxNumber", editable: true},
            {headerName: "고객노트", field: "customerNote", editable: true},
            {headerName: "생산된 제품", field: "producedProduct", editable: true}
        ];

        let row = {
            customerCode: "",
            workplaceCode: "",
            customerName: "",
            customerType: "",
            customerCeo: "",
            businessLicenseNumber: "",
            socialSecurityNumber: "",
            customerBusinessConditions: "",
            customerBusinessItems: "",
            customerZipCode: "",
            customerBasicAddress: "",
            customerDetailAddress: "",
            customerTelNumber: "",
            customerFaxNumber: "",
            customerNote: "",
            producedProduct: ""
        };
        /*console.log(registerOptions.rowData(row)+"tqtq");
                    if(registerOptions.api.RowData!=undefined){
                        Swal.fire({
                            icon: 'error',
                            title: '열 존재',
                            text: '이미 추가시작한 열이 있습니다.',
                        })
                    }
                    else {*/

        let registerOptions = {
            columnDefs: registercstColumn,  // 열을 정의하는거 columnDefs
            autoSizeColumn: cstColumn,      // 자동으로 칼럼들을 사이즈조정해줌
            rowData: cstRowData,            // 그리드에 표시할 데이터를 설정
            onGridReady: function (event) { // 그리드가 시작하자마자 실행되는거
                event.api.sizeColumnsToFit();//자동으로 가로크기 조정
                registerOptions.api.updateRowData({add: [row]});

            },
            onGridSizeChanged: function (event) { // 창크기가 변경되면 실행되는 이벤트
                event.api.sizeColumnsToFit();
            },
            getSelectedRowData() {
                let selectedNodes = this.api.getSelectedNodes();     // Object 찍힘  (선택한 열?)
                let selectedData = selectedNodes.map(node => node.data); // Object 찍힘
                return selectedData;
            },

        }


        function insertCustomer() {

            let data = registerOptions.getSelectedRowData();
            console.log(JSON.stringify(data)+" 확인");
            let xhr = new XMLHttpRequest(); /*  XMLHttpRequest는 HTTP를 통해서 쉽게 데이터를 받을 수 있게 해주는 오브젝트를 제공한다
                                                    Ajax로 실행되는 HTTP 통신도 XMLHttpRequest규격을 이용함  */
            // XHR을 사용하면 페이지의 새로고침 없이도 URL에서 데이터를 가져올 수 있습니다
            xhr.open('POST', "/compinfo/customer/registerCustomer" // 위의 값들을 addNewEstimate.do를 호출시켜서 던질거임
                ,true);
            xhr.setRequestHeader('Content-Type', 'application/json');// (헤더이름,헤더값) HTTP요청 헤더에 포함하고자 하는 헤더 이름과 그 값인데 전에 무조건 open()뒤에는 send()메소드를 써주어야 한다.
            xhr.send(JSON.stringify(data)); // 요청을 전송합니다. 비동기 요청(기본 동작)인 경우, send()는 요청을 전송하는 즉시 반환
            xhr.onreadystatechange = () => {                    // readyState 속성이 바뀔 때마다 발생합니다. onreadystatechange 속성으로도 수신할 수 있음
                if (xhr.readyState == 4 && xhr.status == 200) {
                    let txt = xhr.responseText;
                    txt = JSON.parse(txt);
                    if (txt.errorCode < 0) {
                        swal.fire("오류", txt.errorMsg, "error");
                        return;
                    }

                    registerOptions.api.setRowData([]);  // 문자열들을 배열에 담음
                }
            }
            // console.log(registerOptions.getSelectedRowData()[0]+"@@@@@@@@@@@");

            location.reload();   // 클릭하면 다시 로드
        }



        document.addEventListener('DOMContentLoaded', () => {   // 위와 같음
            new agGrid.Grid(registerAccount, registerOptions);
        })
    </script>
</div>
</body>
</html>--%>
<%------------------------------------------여기까지 원본------------------------------------------%>