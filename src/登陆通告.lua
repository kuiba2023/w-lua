print(">>Script: Player Log Message.")
local TEAM_ALLIANCE=0
local TEAM_HORDE=1
--CLASS                    职业
local CLASS_WARRIOR         = 1        --战士
local CLASS_PALADIN            = 2        --圣骑士
local CLASS_HUNTER            = 3        --猎人
local CLASS_ROGUE            = 4        --盗贼
local CLASS_PRIEST            = 5        --牧师
local CLASS_DEATH_KNIGHT    = 6        --死亡骑士
local CLASS_SHAMAN            = 7        --萨满
local CLASS_MAGE            = 8        --法师
local CLASS_WARLOCK            = 9        --术士
local CLASS_DRUID            = 11    --德鲁伊

local ClassName={--职业表
    [CLASS_WARRIOR]    ="战士",
    [CLASS_PALADIN]    ="圣骑士",
    [CLASS_HUNTER]    ="猎人",
    [CLASS_ROGUE]    ="盗贼",
    [CLASS_PRIEST]    ="牧师",
    [CLASS_DEATH_KNIGHT]="死亡骑士",
    [CLASS_SHAMAN]    ="萨满",
    [CLASS_MAGE]    ="法师",
    [CLASS_WARLOCK]    ="术士",
    [CLASS_DRUID]    ="德鲁伊",
}

local function GetPlayerInfo(player)--得到玩家信息
    local Pclass    = ClassName[player:GetClass()] or "? ? ?" --得到职业
    local Pname        = player:GetName()
    local Pteam        = ""
    local team=player:GetTeam()
    if(team==TEAM_ALLIANCE)then
        Pteam        ="|cFF0070d0联盟|r"
    elseif(team==TEAM_HORDE)then
        Pteam        ="|cFFF000A0部落|r"
    end
    return string.format("%s%s玩家[|cFF00FF00|Hplayer:%s|h%s|h|r]",Pteam,Pclass,Pname,Pname)
end

local function PlayerFirstLogin(event, player)--玩家首次登录
    SendWorldMessage("|cFFFF0000[系统]欢迎|r"..GetPlayerInfo(player).." |cFFFF0000首次进入魔兽世界。|r")
    print("Player is Created. GUID:"..player:GetGUIDLow())

    local job = player:GetClass() --获取玩家的职业
    if job == 6 then
      local STARTER_QUESTS= { 12593, 12619, 12842, 12848, 12636, 12641, 12657, 12678, 12679, 12680, 12687, 12698, 12701, 12706, 12716, 12719, 12720, 12722, 12724, 12725, 12727, 12733, -1, 12751, 12754, 12755, 12756, 12757, 12779, 12801, 13165, 13166 };
	 local specialSurpriseQuestId = -1
        local race = player:GetRace()
        local team = player:GetTeam()
        if race == 6 then
            specialSurpriseQuestId = 12739
        elseif race == 4 then
            specialSurpriseQuestId = 12743;
        elseif race == 3 then
            specialSurpriseQuestId = 12744;
        elseif race == 7 then
            specialSurpriseQuestId = 12745;
        elseif race == 11 then
            specialSurpriseQuestId = 12746;
        elseif race == 10 then
            specialSurpriseQuestId = 12747;
        elseif race == 2 then
            specialSurpriseQuestId = 12748;
        elseif race == 8 then
            specialSurpriseQuestId = 12749;
        elseif race == 5 then
            specialSurpriseQuestId = 12750;
        elseif race == 1 then
            specialSurpriseQuestId = 12742;
        end

        STARTER_QUESTS[23] = specialSurpriseQuestId;
        if team == 0 then
            STARTER_QUESTS[33] = 13188
        else
            STARTER_QUESTS[33] = 13189
        end
        --用一个for循环，依次对任务进行处理
        for k, v in ipairs(STARTER_QUESTS) do
            local quest_status = player:GetQuestStatus(v)
            if quest_status == 0 then
                --没这个任务，自动加这个任务，然后完成
                player:AddQuest(v)
                player:CompleteQuest(v)
                player:RewardQuest(v)
            end
        end
		player:AddItem(6948);
          player:SaveToDB();
          player:SendBroadcastMessage("已为你自动完成死亡骑士出生任务线,你可以直接进行游戏了.");

      print("Player is Created. 职业: DK")
    end

end

local function PlayerLogin(event, player)--玩家登录
    SendWorldMessage("|cFFFF0000[系统]|r欢迎"..GetPlayerInfo(player).." 上线")
    print("Player is Login. GUID:"..player:GetGUIDLow())
end

local function PlayerLogout(event, player)--玩家登出
    SendWorldMessage("|cFFFF0000[系统]|r"..GetPlayerInfo(player).." 下线。")
    print("Player is Logout. GUID:"..player:GetGUIDLow())
end

--PLAYER_EVENT_ON_FIRST_LOGIN             =     30       -- (event, player)
    RegisterPlayerEvent(30, PlayerFirstLogin)--首次登录
--PLAYER_EVENT_ON_LOGIN                   =     3        -- (event, player)
    RegisterPlayerEvent(3, PlayerLogin)--登录
--PLAYER_EVENT_ON_LOGOUT                  =     4        -- (event, player)
    RegisterPlayerEvent(4, PlayerLogout)--登出