function SendChatMessage(playername,reason)
    TriggerClientEvent('chat:addMessage', -1, {
      template = [[
        <div style="padding: 0.3vw; height: auto; margin: 0.5vw; background-color: #222228ec; border-radius: 10px; padding-top: 0.35vw; border: 0.11vw solid #414146; box-shadow: 0px 0px 11px rgba(158, 158, 158, 0.35)">
        <font style="padding: 0.15vw; margin: 0.22vw; background-color: #922a2a; padding-left: 1%; border-radius: 8px; border: #c72f2f solid 0.11vw; font-size: 12px; box-shadow: 0px 0px 11px rgba(156, 21, 21, 0.55)">
           <font style="font-weight: 600;"><i class="fa-solid fa-shield"></i> WX ANTICHEAT</font>
        </font>
        <font style="font-size: 14px; padding-left: 5px; color: #c7c5c5; margin: auto; font-weight:400"></font>
        <font class="message" style="font-size: 14px; color: #a8a7a7; margin: auto; font-weight:400">Player <b>{0}</b> has been detected for <b>{1}</b></font>
    </div>
      ]],        args = { playername, reason }
      })
end