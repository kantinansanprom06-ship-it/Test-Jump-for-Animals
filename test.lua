local TARGET_STAGE = "Savannah"

local TARGET_RARITIES = {
    Ascended = true,
    Eternal = true,
    Celestial = true,
    Divine = false,
    Mythic = false
}

local function TPTo(Position)
    local Character = game.Players.LocalPlayer.Character
        or game.Players.LocalPlayer.CharacterAdded:Wait()

    local Root = Character:WaitForChild("HumanoidRootPart")

    print("TP ไป:", Position)

    Root.CFrame = CFrame.new(Position)

    print("TP ถึงแล้ว")
end

local function ScanEggs()
    print("เริ่มสแกน:", TARGET_STAGE)

    local Map = workspace:FindFirstChild("Map")
    local Stages = Map and Map:FindFirstChild("Stages")
    local Stage = Stages and Stages:FindFirstChild(TARGET_STAGE)

    if not Stage then
        warn("ไม่พบด่าน:", TARGET_STAGE)
        return
    end

    local SpawnedEggs = Stage:FindFirstChild("SpawnedEggs")

    if not SpawnedEggs then
        warn("ไม่พบ SpawnedEggs ในด่าน:", TARGET_STAGE)
        return
    end

    for _, Egg in ipairs(SpawnedEggs:GetChildren()) do

        local Rarity = tostring(
            Egg:GetAttribute("Rarity")
        )

        if TARGET_RARITIES[Rarity] then

            print("TARGET FOUND")
            print("Egg:", Egg.Name)
            print("Rarity:", Rarity)
            print("Stage:", TARGET_STAGE)

            local Position =
                Egg:GetAttribute("NaturalSpawnPosition")

            if typeof(Position) == "Vector3" then
                print("Position:", Position)

                TPTo(Position)

                return
            else
                warn(
                    "NaturalSpawnPosition:",
                    typeof(Position)
                )
            end
        end
    end

    print("ไม่พบ Target Egg ใน", TARGET_STAGE)
end

ScanEggs()
