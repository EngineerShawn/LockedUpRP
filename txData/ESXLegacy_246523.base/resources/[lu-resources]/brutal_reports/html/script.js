Category = null

window.addEventListener('message', function(event) {
    let data = event.data

    if (data.action === "OpenReportMenu") {
      hide(".chat-container")
      setTimeout(function(){
        show(".section-main")
      }, 100);
    }
    else if (data.action === "ReportsTableUpdate") {
      Reports = data.ReportsTable
      if ($('.section-admin .second-container').css("display") != "none"){
        for (let i = 0; i < Reports.length; i++) {
          if(Reports[i].reportid === reportid){
            if(Reports[i].open === true){
              view(reportid)
            }
            else{
              refreshadmintable()
              back()
            }
          }
        }
      }
      else if ($('.section-admin .main-container').css("display") != "none"){
        refreshadmintable()
      }
    }
    else if (data.action === "OpenAdminReports") {
      show(".section-admin")

      Reports = data.ReportsTable
      MyID = data.MyID

      refreshadmintable()
    }
    else if (data.action === "OpenAdminReport") {
      Reports = data.ReportsTable
      view(data.reportid)
    }
    else if (data.action === "OpenMyReport") {
      if (data.NeedOpen === true){
        show(".section-main")
      }
      MyReport = data.MyReport
      reportid = MyReport.reportid

      $('.messages-container').html("")
      for (let i = 0; i < MyReport.chatdata.length; i++) {
        if(MyReport.chatdata[i].permission === "Admin"){
          $('.messages-container').append(`
          <div class="message-element" id="admin">
            <h1>Admin(${MyReport.chatdata[i].name})</h1>
            <h2>${MyReport.chatdata[i].message}</h2>
          </div>
          `)
        }
        else{
          $('.messages-container').append(`
          <div class="message-element" id="player">
            <h1>You</h1>
            <h2>${MyReport.chatdata[i].message }</h2>
          </div>
          `)
        }
      }
      scrollToBottom("messages-container")
    }
    else if (data.action === "ClearMyReport") {
      Close()
      setTimeout(() => {
        hide(".chat-container")
        document.getElementById("title").value = ""
        document.getElementById("description").value = ""
        $(`.category`).css("color", "white")
        $(`.section-main .main-container`).css({"pointer-events": "all"})
        $(`.section-main .main-container #send_report`).css({"opacity": "1"})
        hide(`.section-main .main-container #close`)
      }, 400);
    }
})

const scrollToBottom = (id) => {
  const element = document.getElementById(id)
  element.scrollTop = element.scrollHeight
}

function fancyTimeFormat(duration)
{   
    var hrs = ~~(duration / 3600);
    var mins = ~~((duration % 3600) / 60);
    var secs = ~~duration % 60;

    var ret = "";

    if (hrs > 0) {
        ret += "" + hrs + ":" + (mins < 10 ? "0" : "");
    }

    ret += "" + mins + ":" + (secs < 10 ? "0" : "");
    ret += "" + secs;
    return ret;
}

document.onkeyup = function() {
  if (event.key == 'Escape') {
    Close()
  }
}

function Close(){
  hide(".section-main")
  hide(".section-admin")
  $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"close"}))
}

function show(element){
  if (element === ".section-main" || element === ".section-admin .second-container"){
    $(element).css("display", "flex")
  }else{
    $(element).css("display", "block")
  }
  setTimeout(function(){
      $(element).css("opacity", "1")
  }, 10);
}

function hide(element){
  $(element).css("opacity", "0")
  setTimeout(function(){
    $(element).css("display", "none")
  }, 400)
}

function category(id){ 
  $(`.category`).css("color", "white")
  $(`#${id}`).css("color", "rgb(32, 123, 214)")
  Category = id
}

function send(id){
  scrollToBottom("messages-container")
  scrollToBottom("messages-container_2")
  if (id === "send_report"){
    if (Category != null && document.getElementById("description").value != "" && document.getElementById("title").value != ""){
      if (document.getElementById("title").value.length < 25){
        Report = [Category, document.getElementById("title").value,  document.getElementById("description").value]
        $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"NewReport", Report}))
        $(`.section-main .main-container`).css({"pointer-events": "none"})
        $(`.section-main .main-container #close`).css({"pointer-events": "all"})
        $(`.exit`).css({"pointer-events": "all"})
        $(`.section-main .main-container #send_report`).css({"opacity": "0"})
        hide(`.section-main`)
        setTimeout(function(){
          show(`.section-main .main-container #close`)
          show(`.section-main`)
          show(".chat-container")
        },400)
      }
      else{
        $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"Notify", notifyid:11}))
      }
    }
    else{
      $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"Notify", notifyid:12}))
    }
  }
  if (id === "send_message"){
    if ($(".section-admin .second-container").css("display") === "flex" && document.getElementById("message_2").value != ""){
      $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"NewAdminMessage", reportid, message:(document.getElementById("message_2").value)}))
      document.getElementById("message_2").value = ""
    }
    else if(document.getElementById("message_1").value != ""){
      $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"NewMessage", reportid, message:(document.getElementById("message_1").value)}))
      document.getElementById("message_1").value = ""
    }
  }
}

function view(id){
  for (let i = 0; i < Reports.length; i++) {
    if (Reports[i].reportid.toString() === id.toString()){
      if (MyID != Reports[i].playerid){

        reportid = Reports[i].reportid  
        playerid = Reports[i].playerid
        Iden = Reports[i].identifier

        $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"ViewButton", reportid, adminname:Reports[i].adminname}))

        $('.report-container #id').html("REPORT ID: <a>#"+Reports[i].reportid+"</a>")
        $('.report-container #player').html("PLAYER: "+Reports[i].playername+" ["+Reports[i].playerid+"]<button class='copy' onclick='copyid()' title='Copy Identifier'><i class='fa-regular fa-copy'></i></button>")
        $('.report-container #category').html("CATEGORY: "+Reports[i].category.toUpperCase()+" "+$('#'+Reports[i].category).html())
        $('.report-container #title').html("TITLE: "+Reports[i].title)
        $('.report-container #des').html(Reports[i].description)
  
        $('.messages-container').html("")
        for (let _i = 0; _i < Reports[i].chatdata.length; _i++) {
          if(Reports[i].chatdata[_i].permission === "Admin"){
            $('.messages-container').append(`
            <div class="message-element" id="player">
              <h1>Admin(${Reports[i].chatdata[_i].name})</h1>
              <h2>${Reports[i].chatdata[_i].message}</h2>
            </div>
            `)
          }
          else{
            $('.messages-container').append(`
            <div class="message-element" id="admin">
              <h1>Player</h1>
              <h2>${Reports[i].chatdata[_i].message}</h2>
            </div>
            `)
          }
        }
        hide(".section-admin .main-container")
        setTimeout(function(){
          show(".section-admin .second-container")
          show(".chat-container")
          scrollToBottom("messages-container_2")
        },400)
      }
      else{
        $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"Notify", notifyid:13}))
      }
    }
  }
}

function back(){
  hide(".section-admin .second-container")
  setTimeout(function(){
    show(".section-admin .main-container")
  },400)
}

function task(id){
  if (id === "close"){
    show(".surebuy")
  }
  else if (id === "cancel"){
    hide(".surebuy")
  }
  else if (id === "yes"){
    hide(".surebuy")
    back()
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"CloseReport", reportid}))
  }
  else{
    $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"AdminButton", ButtonType:id, playerid, reportid}))
  }
}

function task2(id){
  show(".surebuy")
  reportid = id
}

function refreshadmintable(){
  $('.reports-container').html('')
  OpenedReportsCount = 0
  for (let i = 0; i < Reports.length; i++) {
    if(Reports[i].open === true){
      OpenedReportsCount ++
      $('.reports-container').append(`
      <div class="report-element">
        <table>
            <tr>
              <th class="id">${Reports[i].reportid}</th>
              <th>${Reports[i].playername.slice(0, 15)} [${Reports[i].playerid}]</th> 
              <th class="cat">${$('#'+Reports[i].category).html()}</th>
              <th>${Reports[i].adminname}</th>
              <th class="action"><button class="sure" id="${Reports[i].reportid}" onclick="view(id)"><i class="fa-solid fa-eye"></i></button>
              <button class="sure close" id="${Reports[i].reportid}" onclick="task2(id)"><i class="fa-solid fa-xmark"></i></button></th>
            </tr>
        </table>
        </div>
      `)
    }
  }
  if (OpenedReportsCount === 0){
    $('.reports-container').html("There aren't any reports...")
  }
}

function copyid(){
  fallbackCopyTextToClipboard(Iden)
}

function fallbackCopyTextToClipboard(text){
  var textArea = document.createElement("textarea");
  textArea.value = text;

  textArea.style.top = "0";
  textArea.style.left = "0";
  textArea.style.position = "fixed";

  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
  } catch (err) {
    console.error('Fallback: Oops, unable to copy', err);
  }

  document.body.removeChild(textArea);
}