local entitiesCount = {}
local totalEntities = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- Adjust the interval as needed
        
        -- Reset the counts
        entitiesCount = {}
        totalEntities = 0

        -- Iterate over all entities in the world
        local entities = {}
        for _, entity in ipairs(GetGamePool('CObject')) do
            table.insert(entities, entity)
        end
        for _, entity in ipairs(GetGamePool('CPed')) do
            table.insert(entities, entity)
        end
        for _, entity in ipairs(GetGamePool('CVehicle')) do
            table.insert(entities, entity)
        end

        -- Count entities
        for _, entity in ipairs(entities) do
            local model = GetEntityModel(entity)
            entitiesCount[model] = entitiesCount[model] or { count = 0 }
            entitiesCount[model].count = entitiesCount[model].count + 1
            totalEntities = totalEntities + 1
        end

        -- Sort the entities by count
        local sortedEntities = {}
        for model, data in pairs(entitiesCount) do
            table.insert(sortedEntities, { model = model, count = data.count })
        end
        table.sort(sortedEntities, function(a, b) return a.count > b.count end)

        -- Print the most spawned entities
        print("Total entities in world: " .. totalEntities)
        print("Most spawned entities:")
        for i, entry in ipairs(sortedEntities) do
            if i > 10 then -- Change the number to display more or fewer entities
                break
            end
            print("Model: " .. entry.model .. ", Count: " .. entry.count)
        end
    end
end)
