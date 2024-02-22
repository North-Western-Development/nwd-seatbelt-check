local QBCore = exports["qb-core"]:GetCoreObject()
local seats = {
    [-1] = "Driver",
    [0] = "Front Passenger",
    [1] = "Rear Driver's Side Passenger",
    [2] = "Rear Passenger's Side Passenger",
    [3] = "Front Middle Driver's Side Passenger",
    [4] = "Front Middle Passenger's Side Passenger",
    [5] = "Rear Middle Driver's Side Passenger",
    [6] = "Rear Middle Passenger's Side Passenger"
}

local vehicleOptionsTable = {
    options = {
        {
            type = "client",
            icon = 'fas fa-eye',
            label = "Check For Seatbelts",
            action = function(closeVeh)
                local seatCount = GetVehicleModelNumberOfSeats(GetEntityModel(closeVeh))
                local players = 0
                for i = -1, seatCount-2 do
                    if not IsVehicleSeatFree(closeVeh, i) and IsPedAPlayer(GetPedInVehicleSeat(closeVeh, i)) then
                        players += 1
                        TriggerServerEvent("nwd-seatbelt-check::server::checkSeatbelt", GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(closeVeh, i))), i)
                    end
                end
                if players == 0 then
                    QBCore.Functions.Notify("You don't see anyone", 'error', 2000)
                end
            end,
            canInteract = function()
                return not IsPedInAnyVehicle(PlayerPedId(), true)
            end
        }
    },
    distance = 2.5
}

exports["qb-target"]:AddGlobalVehicle(vehicleOptionsTable);


RegisterNetEvent("nwd-seatbelt-check::client::checkSeatbelt", function(returnTo, seat)
    TriggerServerEvent("nwd-seatbelt-check::server::seatbeltCheckReturn", returnTo, exports["qb-smallresources"]:GetSeatbeltStatus(), seat)
end)

RegisterNetEvent("nwd-seatbelt-check::client::seatbeltCheckReturn", function(wearing, seat)
    QBCore.Functions.Notify(seats[seat]..' is '.. (wearing and '' or ' not ') ..'wearing seatbelt', wearing and 'success' or 'error', 2500)
end)