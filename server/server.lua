RegisterNetEvent("nwd-seatbelt-check::server::checkSeatbelt", function(serverid, seat)
    TriggerClientEvent("nwd-seatbelt-check::client::checkSeatbelt", serverid, source, seat)
end)

RegisterNetEvent("nwd-seatbelt-check::server::seatbeltCheckReturn", function(returnTo, wearing, seat)
    TriggerClientEvent("nwd-seatbelt-check::client::seatbeltCheckReturn", returnTo, wearing, seat)
end)