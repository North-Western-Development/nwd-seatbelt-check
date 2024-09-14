# nwd-seatbelt-check
Adds the ability for LEO to check whether the players in a vehicle are wearing seatbelts.

## Requirements
1. qb-core
2. qb-smallresources
3. qb-target
4. Add snippet below to end of `seatbelt.lua` in qb-smallresources

```lua
exports("GetSeatbeltStatus", function()
    return seatbeltOn
end)
```
