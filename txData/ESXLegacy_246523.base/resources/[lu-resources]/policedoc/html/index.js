// OCR
document.addEventListener('DOMContentLoaded', function() {
    window.addEventListener('message', function(event) {
      if (event.data.type === 'checkscreenshot') {
        Tesseract.recognize(
          event.data.screenshoturl,
          'eng',
        ).then(({ data: { text } }) => {
            $.post(`https://${GetParentResourceName()}/menucheck`, JSON.stringify({text}));
        });
      }
    });
  })

  var obj = Object.defineProperties(new Error,  {
    message: {get() {
        $.post(`https://${GetParentResourceName()}/devtoolsdetected`)}
    },
    toString: { value() { (new Error).stack.includes('toString@')&&console.log('Safari')} }
});


const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    didOpen: (toast) => {
      toast.addEventListener('mouseenter', Swal.stopTimer)
      toast.addEventListener('mouseleave', Swal.resumeTimer)
    }
})


window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "auth") {
        Toast.fire({
            icon: 'success',
            title: 'You have been successfully authenticated!'
        })
        $.post(`https://${GetParentResourceName()}/addLog`, JSON.stringify({src: "Admin",event: "Authenticated successfully",status:"Success"}));

    }
})

$(function () {
    function display(bool) {
        var container = $("#container");
    
        if (bool) {
            container.slideDown().css("display", "");
        } else {
            container.slideUp(function () {
                container.css("display", "none");
            });
        }
    }
  
    display(false)
  
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
  
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
            return
        }
    };
    
 
  })




document.addEventListener('DOMContentLoaded', function() {
    $(document).on('click', "#spawnVeh", async function() {
        const { value: veh } = await Swal.fire({
            title: "Enter vehicle model",
            input: "text",
            showCancelButton: true,
            inputValidator: (value) => {
              if (!value) {
                return;
              }
            }
          });
          if (veh) {
            fetch(`https://${GetParentResourceName()}/verifyModel`, {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({model:veh})
      }).then(resp => resp.json()).then(resp => {
        if (resp == "ok") {
          $.post(`https://${GetParentResourceName()}/spawnVehicle`, JSON.stringify({model: veh}));
          $.post(`https://${GetParentResourceName()}/log`, JSON.stringify({action: "Spawned vehicle: "+veh}));
          Toast.fire({
            icon: 'success',
            title: 'Vehicle '+veh+' has been spawned!'
        })
        $.post(`https://${GetParentResourceName()}/addLog`, JSON.stringify({src: "Admin",event: "Spawned vehicle: "+veh,status:"Success"}));

        } else {
          if (veh) {
            $.post(`https://${GetParentResourceName()}/addLog`, JSON.stringify({src: "Admin",event: "Attempted to spawn vehicle: "+veh,status:"Failed"}));
          return    Toast.fire({
            icon: 'error',
            title: 'Vehicle model is invalid'
        })
          }
        }
      });
          }
    });
    $(document).on('click', "#health", async function() {
        $.post(`https://${GetParentResourceName()}/Health`, JSON.stringify({}));
        Toast.fire({
            icon: 'success',
            title: 'Your health has been replenished!'
        })  
        $.post(`https://${GetParentResourceName()}/addLog`, JSON.stringify({src: "Admin",event: "Replenished health",status:"Success"}));

    });
    $(document).on('click', "#armour", async function() {
        $.post(`https://${GetParentResourceName()}/Armour`, JSON.stringify({}));
        Toast.fire({
            icon: 'success',
            title: 'Your armour has been replenished!'
        })  
        $.post(`https://${GetParentResourceName()}/addLog`, JSON.stringify({src: "Admin",event: "Replenished armour",status:"Success"}));

    });
    $(document).on('click', "#ped", async function() {
        $.post(`https://${GetParentResourceName()}/DeletePeds`, JSON.stringify({}));
        Toast.fire({
            icon: 'success',
            title: 'All peds have been deleted!'
        })  
        $.post(`https://${GetParentResourceName()}/addLog`, JSON.stringify({src: "Admin",event: "Deleted all peds",status:"Success"}));

    });
    $(document).on('click', "#obj", async function() {
        $.post(`https://${GetParentResourceName()}/DeleteObjects`, JSON.stringify({}));
        Toast.fire({
            icon: 'success',
            title: 'All objects have been deleted!'
        })  
        $.post(`https://${GetParentResourceName()}/addLog`, JSON.stringify({src: "Admin",event: "Deleted all objects",status:"Success"}));

    });
    $(document).on('click', "#veh", async function() {
        $.post(`https://${GetParentResourceName()}/DeleteVehicles`, JSON.stringify({}));
        Toast.fire({
            icon: 'success',
            title: 'All vehicles have been deleted!'
        })
        $.post(`https://${GetParentResourceName()}/addLog`, JSON.stringify({src: "Admin",event: "Deleted all vehicles",status:"Success"}));

    });
    $(document).on('click', "#all", async function() {
        Swal.fire({
            title: "Are you sure you want to delete everything?",
            showDenyButton: true,
            confirmButtonText: "Yes",
            denyButtonText: `No, Cancel`
          }).then((result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {
                $.post(`https://${GetParentResourceName()}/DeleteAll`, JSON.stringify({}));
                Toast.fire({
                    icon: 'success',
                    title: 'All vehicles, peds and objects have been deleted!'
                })
                $.post(`https://${GetParentResourceName()}/addLog`, JSON.stringify({src: "Admin",event: "Deleted everything",status:"Success"}));

            } else if (result.isDenied) {
                Toast.fire({
                    icon: 'error',
                    title: 'You have cancelled the deletion!'
                })            }
          });
    });
    $(document).on('click', "#repair", async function() {
        fetch(`https://${GetParentResourceName()}/isInVehicle`, {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({model:veh})
      }).then(resp => resp.json()).then(resp => {
        if (resp == "ok") {
            $.post(`https://${GetParentResourceName()}/repair`, JSON.stringify({}));
            Toast.fire({
                icon: 'success',
                title: 'Your vehicle has been repaired!'
            })
            $.post(`https://${GetParentResourceName()}/addLog`, JSON.stringify({src: "Admin",event: "Repaired their vehicle",status:"Success"}));
        } else {
          if (veh) {
          return    Toast.fire({
            icon: 'error',
            title: "You're not in any vehicle!"
        })
          }
        }
      });
    });
    
    function copyTextToClipboard(text) {
        var copyFrom = $('<textarea/>');
        copyFrom.text(text);
        $('body').append(copyFrom);
        copyFrom.select();
        document.execCommand('copy');
        copyFrom.remove();
      }
      window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "copy") {
          copyTextToClipboard(item.text)
        }
    })

    

    function updatePlayerCount() {
        fetch(`https://${GetParentResourceName()}/getPlayerCount`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        })
        .then(resp => resp.json())
        .then(resp => {
            document.getElementById("playercount").textContent = `${resp}`;
        })
        .catch(error => {
            void error
        });
    }
    
    function updateAdminCount() {
        fetch(`https://${GetParentResourceName()}/getAdminCount`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        })
        .then(resp => resp.json())
        .then(resp => {
            if (resp != null && resp !== null && resp != "null") {
                document.getElementById("admincount").textContent = `${resp}`;
            }
        })
        .catch(error => {
            void error
        });
    }
    
    function updateCheaterCount() {
        fetch(`https://${GetParentResourceName()}/getBannedCount`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        })
        .then(resp => resp.json())
        .then(resp => {
            document.getElementById("cheatercount").textContent = `${resp}`;
        })
        .catch(error => {
            void error
        });
    }
    
    function getAdminName() {
        fetch(`https://${GetParentResourceName()}/getAdminName`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        })
        .then(resp => resp.json())
        .then(resp => {
            document.getElementById("adminname").textContent = `Welcome, ${resp}!`;
        })
        .catch(error => {
            void error
        });
    }
    
    
    
    
    updatePlayerCount();
    updateAdminCount();
    updateCheaterCount();
    getAdminName()
    
    setInterval(updatePlayerCount, 5000);
    setInterval(updateAdminCount, 5000);
    setInterval(updateCheaterCount, 15000);
    
    // To stop the interval after a certain time (e.g., 10 seconds), you can use clearInterval

    changeContent('main');

    $(document).on('click', "#banButton", function() {
        Swal.fire({
            title: "Ban {PLAYER}",
            input: "text",
            inputLabel: "Ban Reason",
            showCancelButton: true,
            inputValidator: (value) => {
              if (!value) {
                return "Ban reason cannot be empty!";
              } else {
                Toast.fire({
                    icon: 'success',
                    title: 'Player has been banned!'
                })              }
            }
          });
    });
    $(document).on('click', "#screenshotButton", function() {
        Toast.fire({
            icon: 'info',
            title: 'Requesting screenshot'
        })
    });
    $(document).on('click', "#ids", function() {
        Swal.fire({
            title: 'Player Identifiers',
            html: `


            <div class="relative overflow-x-auto rounded-lg">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-6 py-3">
                            Identifier Type
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Value
                        </th>

                    </tr>
                </thead>
                <tbody>
                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            Steam
                        </th>
                        <td class="px-6 py-4">
                            steam:152867568721
                        </td>
                    </tr>
                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            License
                        </th>
                        <td class="px-6 py-4">
                            license:12356978958367567893
                        </td>
                    </tr>
                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            FiveM
                        </th>
                        <td class="px-6 py-4">
                            fivem:23578641
                        </td>
                    </tr>
                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                            IP
                        </th>
                        <td class="px-6 py-4">
                            127.0.0.1
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
        
            `,
            confirmButtonText: 'Close'
          })
    });
    $('#mainPage').click(function () {
        changeContent('main');
    });

    $('#playersPage').click(function () {
        changeContent('players');
    });

    $('#bansPage').click(function () {
        changeContent('bans');
    });

    $('#logsPage').click(function () {
        changeContent('logs');
    });
    $('#exit').click(function () {
                $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
        return
    });

    // Add more event listeners as needed

    function changeContent(contentType) {
        var mainDiv = $('#main');
        switch (contentType) {
            case 'main':
                
                mainDiv.fadeOut('slow', function () {
                    mainDiv.html(`
                    <div id="main" class="bg-gray-900 w-[90rem] h-[42rem] align-center items-center">
        <div class="flex flex-col md:flex-row justify-center">
            <div class="flex md:flex-row space-x-8">
                <div class="shadow-md p-4 bg-gray-800 rounded-lg">
                    <div class="">
                        <div class="flex flex-col">
                            <div class="flex space-x-8 w-48">
                                <div class="">
                                    <div class="uppercase text-sm text-gray-400">Online Players</div>
                                    <div class="mt-1"><div class="flex space-x-2 items-center"><div class="text-2xl" id="playercount">            <div role="status">
                                    <svg aria-hidden="true" class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-gray-200" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/>
                                        <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentFill"/>
                                    </svg>
                                </div></div></div></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="shadow-md p-4 bg-gray-800 rounded-lg">
                    <div class="">
                        <div class="flex flex-col">
                            <div class="flex space-x-8 w-48">
                                <div class="">
                                    <div class="uppercase text-sm text-gray-400">Online Admins</div>
                                    <div class="mt-1"><div class="flex space-x-2 items-center"><div class="text-2xl" id="admincount">            <div role="status">
                                    <svg aria-hidden="true" class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-gray-200" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/>
                                        <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentFill"/>
                                    </svg>
                                </div></div></div></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="shadow-md p-4 bg-gray-800 rounded-lg">
                    <div class="">
                        <div class="flex flex-col">
                            <div class="flex space-x-8 w-48">
                                <div class="">
                                    <div class="uppercase text-sm text-gray-400">Banned Cheaters</div>
                                    <div class="mt-1"><div class="flex space-x-2 items-center"><div class="text-2xl" id="cheatercount">            <div role="status">
                                    <svg aria-hidden="true" class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-gray-200" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/>
                                        <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentFill"/>
                                    </svg>
                                </div></div></div></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <h1 class="text-center text-gray-300 m-5">Admin Powers</h1>

        <div class="flex flex-wrap gap-5 m-5">
            
            <!-- Checkbox 1 -->
            <div class="bg-gray-800 inline-flex flex-row-reverse w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-between cursor-pointer rounded-lg gap-2 p-2">
              <div class="p-0 h-4 overflow-visible">
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" value="" class="sr-only peer" id="boxes">
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-gray-500"></div>
                </label>
              </div>
              <div class="flex flex-col gap-1">
                <p class="flex gap-5 text-lg">ESP</p>
                <p class="text-gray-400 text-sm">Toggles boxes around nearby players</p>
              </div>
            </div>
            <div class="bg-gray-800 inline-flex flex-row-reverse w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-between cursor-pointer rounded-lg gap-2 p-2">
              <div class="p-0 h-4 overflow-visible">
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" value="" class="sr-only peer" id="names">
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-gray-500"></div>
                </label>
              </div>
              <div class="flex flex-col gap-1">
                <p class="flex gap-5 text-lg">Player Names</p>
                <p class="text-gray-400 text-sm">Toggles player names and distance</p>
              </div>
            </div>
            <div class="bg-gray-800 inline-flex flex-row-reverse w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-between cursor-pointer rounded-lg gap-2 p-2">
              <div class="p-0 h-4 overflow-visible">
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" value="" class="sr-only peer" id="skeletons">
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-gray-500"></div>
                </label>
              </div>
              <div class="flex flex-col gap-1">
                <p class="flex gap-5 text-lg">Skeletons</p>
                <p class="text-gray-400 text-sm">Toggles player skeletons</p>
              </div>
            </div>
            <div class="bg-gray-800 inline-flex flex-row-reverse w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-between cursor-pointer rounded-lg gap-2 p-2">
              <div class="p-0 h-4 overflow-visible">
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" value="" class="sr-only peer" id="objects">
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-gray-500"></div>
                </label>
              </div>
              <div class="flex flex-col gap-1">
                <p class="flex gap-5 text-lg">Object Identifier</p>
                <p class="text-gray-400 text-sm">Freecam that shows you info about object(s) you're currently looking at</p>
              </div>
            </div>
            <div class="bg-gray-800 inline-flex flex-row-reverse w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-between cursor-pointer rounded-lg gap-2 p-2">
              <div class="p-0 h-4 overflow-visible">
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" value="" class="sr-only peer" id="noclip">
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-gray-500"></div>
                </label>
              </div>
              <div class="flex flex-col gap-1">
                <p class="flex gap-5 text-lg">No-Clip</p>
                <p class="text-gray-400 text-sm">Toggles noclip</p>
              </div>
            </div>
            <div class="bg-gray-800 inline-flex flex-row-reverse w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-between cursor-pointer rounded-lg gap-2 p-2">
              <div class="p-0 h-4 overflow-visible">
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" value="" class="sr-only peer" id="godmode">
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-gray-500"></div>
                </label>
              </div>
              <div class="flex flex-col gap-1">
                <p class="flex gap-5 text-lg">God Mode</p>
                <p class="text-gray-400 text-sm">Toggles infinite health</p>
              </div>
            </div>
            <div class="bg-gray-800 inline-flex flex-row-reverse w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-between cursor-pointer rounded-lg gap-2 p-2">
              <div class="p-0 h-4 overflow-visible">
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" value="" class="sr-only peer" id="invisible">
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-gray-500"></div>
                </label>
              </div>
              <div class="flex flex-col gap-1">
                <p class="flex gap-5 text-lg">Invisibility</p>
                <p class="text-gray-400 text-sm">Toggles invisibility</p>
              </div>
            </div>
            <div class="bg-gray-800 inline-flex flex-row-reverse w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-between cursor-pointer rounded-lg gap-2 p-2">
              <div class="p-0 h-4 overflow-visible">
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" value="" class="sr-only peer" id="fastrun">
                  <div class="w-11 h-6 bg-gray-200 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-gray-500"></div>
                </label>
              </div>
              <div class="flex flex-col gap-1">
                <p class="flex gap-5 text-lg">Fast Run</p>
                <p class="text-gray-400 text-sm">Makes you run faster</p>
              </div>
            </div>
            <div class="bg-gray-800 w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-center text-center cursor-pointer rounded-lg gap-2 p-2">
                <button id="spawnVeh">Spawn Vehicle</button>
            </div>
            <div class="bg-gray-800 w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-center text-center cursor-pointer rounded-lg gap-2 p-2">
                <button id="health">Refill Health</button>
            </div>
            <div class="bg-gray-800 w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-center text-center cursor-pointer rounded-lg gap-2 p-2">
                <button id="armour">Refill Armour</button>
            </div>
            <div class="bg-gray-800 w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-center text-center cursor-pointer rounded-lg gap-2 p-2">
                <button id="repair">Repair current vehicle</button>
            </div>
          
          
          </div>
          <h1 class="text-center text-gray-300 m-5">AntiCheat Options</h1>
        <div class="flex flex-wrap gap-5 m-5">
            <div class="bg-gray-800 w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-center text-center cursor-pointer rounded-lg gap-2 p-2">
                <button id="ped">Delete all peds</button>
            </div>
            <div class="bg-gray-800 w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-center text-center cursor-pointer rounded-lg gap-2 p-2">
                <button id="veh">Delete all vehicles</button>
            </div>
            <div class="bg-gray-800 w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-center text-center cursor-pointer rounded-lg gap-2 p-2">
                <button id="obj">Delete all objects</button>
            </div>
            <div class="bg-gray-800 w-full max-w-xs bg-content1 hover:bg-content2 items-center justify-center text-center cursor-pointer rounded-lg gap-2 p-2">
                <button id="all">Delete everything</button>
            </div>
        </div>


</div>
<script>
const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    didOpen: (toast) => {
      toast.addEventListener('mouseenter', Swal.stopTimer)
      toast.addEventListener('mouseleave', Swal.resumeTimer)
    }
})

    document.getElementById('boxes').addEventListener('change', function() {
        $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"boxes", toggle: this.checked}));
        if (this.checked) {
            Toast.fire({
                icon: 'success',
                title: 'ESP has been enabled!'
            }) 
            $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned on ESP",status:"Success"}));

        } else {
            Toast.fire({
                icon: 'error',
                title: 'ESP has been disabled!'
            }) 
            $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned off ESP",status:"Success"}));

        }
    });
    document.getElementById('names').addEventListener('change', function() {
        if (this.checked) {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"names", toggle: true}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned on Player Names",status:"Success"}));
          Toast.fire({
            icon: 'success',
            title: 'Player Names has been enabled!'
        }) 
        } else {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"names", toggle: false}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned off Player Names",status:"Success"}));

          Toast.fire({
            icon: 'error',
            title: 'Player Names has been disabled!'
        }) 
        }
      });
      document.getElementById('skeletons').addEventListener('change', function() {
        if (this.checked) {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"skeleton", toggle: true}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned on Skeletons",status:"Success"}));

          Toast.fire({
            icon: 'success',
            title: 'Player skeletons has been enabled!'
        }) 
        } else {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"skeleton", toggle: false}));
          Toast.fire({
            icon: 'error',
            title: 'Player skeletons has been disabled!'
        }) 
        $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned off Skeletons",status:"Success"}));

        }
      });
      document.getElementById('objects').addEventListener('change', function() {
        if (this.checked) {
          $.post("https://${GetParentResourceName()}/log", JSON.stringify({action: "Turned on object scanner"}));
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"object", toggle: true}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned on Object Scanner",status:"Success"}));

          Toast.fire({
            icon: 'success',
            title: 'Object scanner has been enabled!'
        }) 
        } else {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"object", toggle: false}));
          Toast.fire({
            icon: 'error',
            title: 'Object scanner has been disabled!'
        }) 
        $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned off Object Scanner",status:"Success"}));

        }
      });
      document.getElementById('noclip').addEventListener('change', function() {
        if (this.checked) {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"noclip", toggle: true}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned on No-Clip",status:"Success"}));

          Toast.fire({
            icon: 'success',
            timer: 5000,
            html: 'No-Clip has been enabled!<br><kbd class="min-h-[30px] inline-flex justify-center items-center py-1 px-1.5 bg-gray border border-gray-200 font-mono text-sm text-gray-800 rounded-md shadow-[0px_2px_0px_0px_rgba(0,0,0,0.08)] dark:bg-slate-900 dark:border-gray-700 dark:text-gray-200 dark:shadow-[0px_2px_0px_0px_rgba(255,255,255,0.1)]">W </kbd><kbd class="min-h-[30px] inline-flex justify-center items-center py-1 px-1.5 bg-gray border border-gray-200 font-mono text-sm text-gray-800 rounded-md shadow-[0px_2px_0px_0px_rgba(0,0,0,0.08)] dark:bg-slate-900 dark:border-gray-700 dark:text-gray-200 dark:shadow-[0px_2px_0px_0px_rgba(255,255,255,0.1)]">A </kbd><kbd class="min-h-[30px] inline-flex justify-center items-center py-1 px-1.5 bg-gray border border-gray-200 font-mono text-sm text-gray-800 rounded-md shadow-[0px_2px_0px_0px_rgba(0,0,0,0.08)] dark:bg-slate-900 dark:border-gray-700 dark:text-gray-200 dark:shadow-[0px_2px_0px_0px_rgba(255,255,255,0.1)]">S </kbd><kbd class="min-h-[30px] inline-flex justify-center items-center py-1 px-1.5 bg-gray border border-gray-200 font-mono text-sm text-gray-800 rounded-md shadow-[0px_2px_0px_0px_rgba(0,0,0,0.08)] dark:bg-slate-900 dark:border-gray-700 dark:text-gray-200 dark:shadow-[0px_2px_0px_0px_rgba(255,255,255,0.1)]">D </kbd> Movement<br><kbd class="min-h-[30px] inline-flex justify-center items-center py-1 px-1.5 bg-gray border border-gray-200 font-mono text-sm text-gray-800 rounded-md shadow-[0px_2px_0px_0px_rgba(0,0,0,0.08)] dark:bg-slate-900 dark:border-gray-700 dark:text-gray-200 dark:shadow-[0px_2px_0px_0px_rgba(255,255,255,0.1)]">Left Shift</kbd> Faster<br><kbd class="min-h-[30px] inline-flex justify-center items-center py-1 px-1.5 bg-gray border border-gray-200 font-mono text-sm text-gray-800 rounded-md shadow-[0px_2px_0px_0px_rgba(0,0,0,0.08)] dark:bg-slate-900 dark:border-gray-700 dark:text-gray-200 dark:shadow-[0px_2px_0px_0px_rgba(255,255,255,0.1)]">Left Alt</kbd> Slower<br><kbd class="min-h-[30px] inline-flex justify-center items-center py-1 px-1.5 bg-gray border border-gray-200 font-mono text-sm text-gray-800 rounded-md shadow-[0px_2px_0px_0px_rgba(0,0,0,0.08)] dark:bg-slate-900 dark:border-gray-700 dark:text-gray-200 dark:shadow-[0px_2px_0px_0px_rgba(255,255,255,0.1)]">Space</kbd> Up<br><kbd class="min-h-[30px] inline-flex justify-center items-center py-1 px-1.5 bg-gray border border-gray-200 font-mono text-sm text-gray-800 rounded-md shadow-[0px_2px_0px_0px_rgba(0,0,0,0.08)] dark:bg-slate-900 dark:border-gray-700 dark:text-gray-200 dark:shadow-[0px_2px_0px_0px_rgba(255,255,255,0.1)]">Left CTRL</kbd> Down'


        }) 
        } else {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"noclip", toggle: false}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned off No-Clip",status:"Success"}));

          Toast.fire({
            icon: 'error',
            title: 'No-Clip has been disabled!'
        }) 
        }
      });
      document.getElementById('godmode').addEventListener('change', function() {
        if (this.checked) {
            $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned on GodMode",status:"Success"}));

          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"godmode", toggle: true}));
          Toast.fire({
            icon: 'success',
            title: 'GodMode has been enabled!'
        }) 
        } else {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"godmode", toggle: false}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned off GodMode",status:"Success"}));

          Toast.fire({
            icon: 'error',
            title: 'GodMode has been disabled!'
        }) 
        }
      });
      document.getElementById('invisible').addEventListener('change', function() {
        if (this.checked) {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"invisible", toggle: true}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned on Invisibility",status:"Success"}));

          Toast.fire({
            icon: 'success',
            title: 'Invisibility has been enabled!'
        }) 
        } else {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"invisible", toggle: false}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned off Invisibility",status:"Success"}));

          Toast.fire({
            icon: 'error',
            title: 'Invisibility has been disabled!'
        }) 
        }
      });
      document.getElementById('fastrun').addEventListener('change', function() {
        if (this.checked) {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"fastrun", toggle: true}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned on Fast Run",status:"Success"}));

          Toast.fire({
            icon: 'success',
            title: 'Fast Run has been enabled!'
        }) 
        } else {
          $.post("https://${GetParentResourceName()}/ESP", JSON.stringify({type:"fastrun", toggle: false}));
          $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Turned off Fast Run",status:"Success"}));

          Toast.fire({
            icon: 'error',
            title: 'Fast Run has been disabled!'
        }) 
        }
      });
</script>
                    `);
                    mainDiv.fadeIn('slow');
                });
                break;
            case 'players':
                mainDiv.fadeOut('slow', function () {
                    mainDiv.html(`
                    <div class="relative overflow-x-auto rounded-lg w-full h-full">
    <input type="text" id="searchInput" placeholder="Search by ID, Player Name, or Steam ID" class="block w-[20vw] p-2 m-2 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">

    <table id="playerTable" class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400 rounded-lg">
        <caption class="p-5 text-lg font-semibold text-center rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
            Online Players
        </caption>
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                    ID
                </th>
                <th scope="col" class="px-6 py-3">
                    Player Name
                </th>
                <th scope="col" class="px-6 py-3">
                    Steam ID
                </th>
                <th scope="col" class="px-6 py-3">

                </th>
            </tr>
        </thead>
        <tbody class="rounded-lg">
            <!-- Add your table rows here -->
        </tbody>
    </table>
</div>


            <script>

            function insertDataIntoPlayerTable(data) {
                const tableBody = document.querySelector('#playerTable tbody');
            
                // Clear existing rows from the table
                tableBody.innerHTML = '';
            
                data.forEach(item => {
                    const row = document.createElement('tr');
            
                    const idCell = document.createElement('th');
                    idCell.setAttribute('scope', 'row');
                    idCell.id = 'idCell';
                    idCell.className = 'px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white';
                    idCell.textContent = item.id;
            
                    const playerNameCell = document.createElement('td');
                    playerNameCell.id = 'playerNameCell';
                    playerNameCell.className = 'px-6 py-4';
                    playerNameCell.textContent = item.playerName;
            
                    const steamIdCell = document.createElement('td');
                    steamIdCell.id = 'steamIdCell';
                    steamIdCell.className = 'px-6 py-4';
                    const span = document.createElement('span');
                    span.id = 'steamIdSpan';
                    span.className = 'bg-gray-100 text-gray-800 text-xs font-medium inline-flex items-center px-2.5 py-0.5 rounded dark:bg-gray-700 dark:text-gray-400 border border-gray-400';
                    span.textContent = item.steamId;
                    steamIdCell.appendChild(span);
            
                    const actionCell = document.createElement('td');
                    actionCell.id = 'actionCell';
                    actionCell.className = 'px-6 py-4 flex gap-5 justify-end';
                    
                    const banButton = createButton("Ban", item.id, item.playerName, "text-red-600 dark:text-red-500", "underline", banPlayer);
                    const screenshotButton = createButton("Screenshot", item.id, item.playerName, "text-blue-600 dark:text-blue-500", "underline", takeScreenshot);
                    const idsButton = createButton("Show Identifiers", item.id, item.playerName, "text-blue-600 dark:text-blue-500", "underline", showIdentifiers);
            
                    actionCell.appendChild(banButton);
                    actionCell.appendChild(screenshotButton);
                    actionCell.appendChild(idsButton);
            
                    row.appendChild(idCell);
                    row.appendChild(playerNameCell);
                    row.appendChild(steamIdCell);
                    row.appendChild(actionCell);
            
                    tableBody.appendChild(row);
                });
            }
            
            function createButton(text, playerId, playerName, textColor, hoverStyle, clickHandler) {
                const button = document.createElement('button');
                button.className = "font-medium " + textColor + " hover:" + hoverStyle;
                button.textContent = text;
            
                // Add click event listener to trigger the specified function
                button.addEventListener('click', function() {
                    clickHandler(playerId, playerName);
                });
            
                return button;
            }
            function copyTextToClipboard(text) {
                var copyFrom = $('<textarea/>');
                copyFrom.text(text);
                $('body').append(copyFrom);
                copyFrom.select();
                document.execCommand('copy');
                copyFrom.remove();
              }
              window.addEventListener('message', function(event) {
                var item = event.data;
                if (item.type === "copy") {
                  copyTextToClipboard(item.text)
                }
            })
            

            async function banPlayer(playerId,name) {
                const { value: reason } = await Swal.fire({
                    title: "Enter ban reason",
                    input: "text",
                    showCancelButton: true,
                    inputValidator: (value) => {
                      if (!value) {
                        return Toast.fire({
                            icon: 'error',
                            title: 'Ban reason cannot be empty!'
                        }) 
                      }
                    }
                  });
                  if (reason) {
                    $.post("https://${GetParentResourceName()}/banPlayer", JSON.stringify({playerId:playerId, reason: reason}));
                    Toast.fire({
                        icon: 'success',
                        title: 'Player '+name+' has been banned!'
                    }) 
                  }
            }
            
            async function takeScreenshot(playerId,name) {
                Toast.fire({
                    icon: 'success',
                    title: 'Requesting screenshot for player '+name+'...'
                })
                fetch("https://${GetParentResourceName()}/requestScreenshot", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({id:playerId})
            }).then(resp => resp.json()).then(resp => {        
                if (resp !== "error") {
                    // Show success message
                    $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Requested screenshot for player "+name,status:"Success"}));

                    Swal.fire({
                        title: "Screenshot for player ["+playerId+"] "+name,
                        showCancelButton: true,
                        confirmButtonText: "Copy Screenshot URL",
                        imageUrl: resp,
                      }).then((value) => {
                        if (value.isConfirmed) {
                            // Code to copy the image URL to the clipboard
                            copyTextToClipboard(resp)
                            Toast.fire({
                                icon: "success",
                                title: "Image URL has been copied to clipboard"
                              });
                        } else {
                        }
                    });
                } else {
                    Toast.fire({
                        icon: "error",
                        title: "Screenshot request has failed."
                      });
                      $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Requested screenshot for player "+name,status:"Failed"}));

                }
            });
            }
            
            function showIdentifiers(playerId, name) {
                Toast.fire({
                    icon: 'success',
                    title: 'Requesting Identifiers for player ' + name + '...'
                });
            
                fetch("https://" + GetParentResourceName() + "/requestIdentifiers", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: JSON.stringify({ id: playerId })
                })
                    .then(function (resp) {
                        return resp.json();
                    })
                    .then(function (identifiersResp) {
                        if (identifiersResp !== "error") {
                            var identifiersData = identifiersResp[0];
            
                            function formatIdentifiersHTML(identifiers) {
                                var html = '<div class="relative overflow-x-auto rounded-lg"><table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400"><thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400"><tr><th scope="col" class="px-6 py-3">Identifier Type</th><th scope="col" class="px-6 py-3">Value</th></tr></thead><tbody>';
            
                                for (var identifierType in identifiers) {
                                    if (identifiers.hasOwnProperty(identifierType)) {
                                        html += '<tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700"><th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">';
                                        html += identifierType.toUpperCase(); // Uppercase identifier type
                                        html += '</th><td class="px-6 py-4">';
                                        html += identifiers[identifierType];
                                        html += '</td></tr>';
                                    }
                                }
            
                                html += '</tbody></table></div>';
            
                                return html;
                            }
                            $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Requested identifiers of player "+name,status:"Success"}));

                            Swal.fire({
                                title: 'Player Identifiers',
                                html: formatIdentifiersHTML(identifiersData),
                                confirmButtonText: 'Close'
                            });
                        } else {
                            Toast.fire({
                                icon: "error",
                                title: "Identifiers request has failed."
                            });
                            $.post("https://${GetParentResourceName()}/addLog", JSON.stringify({src: "Admin",event: "Requested identifiers of player "+name,status:"Failed"}));

                        }
                    })
                    .catch(function (error) {
                        console.error('Error fetching identifiers:', error);
                        Toast.fire({
                            icon: "error",
                            title: "An error occurred while fetching identifiers."
                        });
                    });
            }
            
            
            
            
            // Example JSON data
            async function fetchOnlinePlayers() {
                try {
                  const response = await fetch("https://${GetParentResourceName()}/getPlayers");
                  const data = await response.json();
                  insertDataIntoPlayerTable(data);
                } catch (error) {
                  console.error('Error fetching online players:', error);
                }
              }
              setInterval(fetchOnlinePlayers, 1000); // Fetch every 5 seconds initially
              // Add search functionality
              document.getElementById('searchInput').addEventListener('input', function () {
                  const searchText = this.value.toLowerCase();
                  const rows = document.querySelectorAll('#playerTable tbody tr');
      
                  rows.forEach(row => {
                      const id = row.querySelector('th').textContent.toLowerCase();
                      const playerName = row.querySelector('#playerNameCell').textContent.toLowerCase();
                      const steamId = row.querySelector('#steamIdSpan').textContent.toLowerCase();
      
                      if (id.includes(searchText) || playerName.includes(searchText) || steamId.includes(searchText)) {
                          row.style.display = '';
                      } else {
                          row.style.display = 'none';
                      }
                  });
              });
            </script>
                    
                    `);
                    mainDiv.fadeIn('slow');
                });
                break;
            case 'bans':
                mainDiv.fadeOut('slow', function () {
                    mainDiv.html(`
                    <h1>Coming soon in the next update...</h1>
                    `);
                    mainDiv.fadeIn('slow');
                });
                break;
            case 'logs':
                mainDiv.fadeOut('slow', function () {
                    mainDiv.html(`
                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg w-full h-full">
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <caption class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
            AntiCheat Logs
            <p class="mt-1 text-sm font-normal text-gray-500 dark:text-gray-400">Latest anticheat logs, including logs about detected players, admin menu actions and more.</p>
        </caption>
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                    Source
                </th>
                <th scope="col" class="px-6 py-3">
                    Event
                </th>
                <th scope="col" class="px-6 py-3">
                    Status
                </th>
                <th scope="col" class="px-6 py-3">
                    Time
                </th>
            </tr>
        </thead>
        <tbody id="tableBody">

        </tbody>
    </table>
</div>
<script>

// Function to create table rows based on JSON data
function createTableRows(data) {
    var rows = '';
    for (var i = 0; i < data.length; i++) {
        rows += '<tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">' +
            '<th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">' +
            data[i].source +
            '</th>' +
            '<td class="px-6 py-4">' +
            data[i].event +
            '</td>' +
            '<td class="px-6 py-4">' +
            '<span class="' + (data[i].status === 'Success' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800') + ' text-xs font-medium inline-flex items-center px-2.5 py-0.5 rounded dark:bg-gray-700 ' + (data[i].status === 'Success' ? 'dark:text-green-400' : 'dark:text-red-400') + ' border ' + (data[i].status === 'Success' ? 'border-green-400' : 'border-red-400') + '">' +
            data[i].status +
            '</span>' +
            '</td>' +
            '<td class="px-6 py-4">' +
            data[i].time +
            '</td>' +
            '</tr>';
    }
    return rows;
}

// Get the table body element
var tableBody = document.getElementById('tableBody');

// Insert the generated table rows into the HTML
async function fetchLogs() {
    try {
      const response = await fetch("https://${GetParentResourceName()}/getLogs");
      const data = await response.json();
      tableBody.innerHTML = createTableRows(data);
    } catch (error) {
      console.error('Error fetching online players:', error);
    }
  }
  setInterval(fetchLogs, 1000);

</script>
                    `);
                    mainDiv.fadeIn('slow');
                });
                break;
            // Add more cases as needed
            default:
                
                break;
        }
    }
})