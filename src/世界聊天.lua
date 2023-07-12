print(">>Script: Wolrd Chating.")

local SAY=" "--普通聊天

local TEAM_ALLIANCE    = 0    --联盟阵营
local TEAM_HORDE    = 1    --部落阵营
local MyEquip="~me"
local CLASS={--职业号
    WARRIOR         = 1,        --战士
    PALADIN            = 2,    --圣骑士
    HUNTER            = 3,        --猎人
    ROGUE            = 4,        --盗贼
    PRIEST            = 5,        --牧师
    DEATH_KNIGHT    = 6,        --死亡骑士
    SHAMAN            = 7,        --萨满
    MAGE            = 8,        --法师
    WARLOCK            = 9,        --术士
    DRUID            = 11,    --德鲁伊
}

local ClassName={--职业表
    [CLASS.WARRIOR]    ="战士",
    [CLASS.PALADIN]    ="圣骑士",
    [CLASS.HUNTER]    ="猎人",
    [CLASS.ROGUE]    ="盗贼",
    [CLASS.PRIEST]    ="牧师",
    [CLASS.DEATH_KNIGHT]="死亡骑士",
    [CLASS.SHAMAN]    ="萨满",
    [CLASS.MAGE]    ="法师",
    [CLASS.WARLOCK]    ="术士",
    [CLASS.DRUID]    ="德鲁伊",
}
local function GetPlayerInfo(player)--得到玩家信息
    local Pclass    = ClassName[player:GetClass()] or "???" --得到职业
    local Pname        = player:GetName()
    local Pteam        = ""
    local team=player:GetTeam()
    if(team==TEAM_ALLIANCE)then
        Pteam="|cFF0070d0联盟|r"
    elseif(team==TEAM_HORDE)then
        Pteam="|cFFF000A0部落|r"
    end
    return string.format("%s%s玩家[|cFF00FF00|Hplayer:%s|h%s|h|r]",Pteam,Pclass,Pname,Pname)
end

local function ShowAllEquip(player, isworld)

    local ts=os.date("*t",time)
    local t=string.format("%2d:%2d:%2d",ts.hour,ts.min,ts.sec)
    local Pinfo=GetPlayerInfo(player)
    local head=string.format("[世界] |cFFF08000%s|r %s 说: ",t,Pinfo)
    if(isworld)then
        SendWorldMessage(head.."大家看我的装备。")
    else
        player:Say(head.."大家看我的装备。",0)
    end

    for i=0,18 do
        local item=player:GetEquippedItemBySlot(i)
        if(item)then
            if(isworld)then
                SendWorldMessage(head..item:GetItemLink())
            else
                player:Say(head..item:GetItemLink(),0)
            end
        end
    end
end

local function PlayerOnChat(event, player, msg, Type, lang)--世界聊天
    local ts=os.date("*t",time)
    local t=string.format("%2d:%2d:%2d",ts.hour,ts.min,ts.sec)
    local head=string.format("[世界]|cFFF08000%s|r %s说:",t,GetPlayerInfo(player))
    if(string.find(msg,SAY)==1)then
        player:Say(msg:sub(SAY:len()+1),0)
        return false
    elseif(msg==MyEquip)then
        ShowAllEquip(player, true)
    else
        SendWorldMessage(string.format("%s|cFFFFFFFF%s|r",head,msg))
        return false
    end
end
--PLAYER_EVENT_ON_CHAT                    =     18       -- (event, player, msg, Type, lang) - Can return false
    RegisterPlayerEvent(18, PlayerOnChat) --世界聊天