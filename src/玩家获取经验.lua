--PLAYER_EVENT_ON_KILL_CREATURE 杀死生物 7
-- RegisterPlayerEvent(7, SKILL.AutoLearn)--玩家升级时

local function GetXP(event, player, amount, victim)
	return amount * 10
end

 --PLAYER_EVENT_ON_GIVE_XP 当玩家获取经验时 12
  RegisterPlayerEvent(12, GetXP)--玩家升级时