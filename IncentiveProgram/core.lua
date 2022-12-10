-----------------------------
------Incentive Program------
----Created by: Jacob Beu----
-----Xubera @ US-Alleria-----
--------r7 | 10/26/2016------
-----------------------------

local addonName, IncentiveProgram = ...

local eventFrame = CreateFrame("Frame", "IncentiveProgramEventFrame", UIParent)
eventFrame:RegisterEvent("VARIABLES_LOADED")
eventFrame:SetScript("OnEvent", function(self, ...) self:OnEvent(...) end)
eventFrame:SetScript("OnUpdate", function(self, ...) self:OnUpdate(...) end)

-----------------------------------------
---- Variables
-----------------------------------------
IncentiveProgram.SavedLFGRoles = {
    isUpdated = false,
    Leader = false,
    Tank = false,
    Healer = false,
    Damage = false
}

-----------------------------------------
---- Slash Command
-----------------------------------------

SLASH_INCENTIVEPROGRAM1 = "/ip"
function SlashCmdList.INCENTIVEPROGRAM(msg, editbox)
    IncentiveProgram:GetSettings():SetSetting(IncentiveProgram.Settings["HIDE_IN_PARTY"], false)
    IncentiveProgram:GetSettings():SetSetting(IncentiveProgram.Settings["HIDE_ALWAYS"], false)
    IncentiveProgram:GetFrame():ShowFrame()
end

-----------------------------------------
---- OnEvent is the Event Handler for the Frame
---- Registered Events:
----      VARIABLES_LOADED
----      GROUP_ROSTER_UPDATE
----      LFG_UPDATE_RANDOM_INFO
----      LFG_ROLE_UPDATE
----      LFG_UPDATE
-----------------------------------------
function eventFrame:OnEvent(event, ...)
    if ( event == "VARIABLES_LOADED" ) then
        IncentiveProgram:SetCount(0)
        IncentiveProgram:GetFrame():UpdatedSettings()
        
        self:RegisterEvent("GROUP_ROSTER_UPDATE")
        self:RegisterEvent("LFG_UPDATE_RANDOM_INFO")
        self:RegisterEvent("LFG_ROLE_UPDATE")
        self:RegisterEvent("LFG_UPDATE")
    elseif ( event == "GROUP_ROSTER_UPDATE" or event == "LFG_UPDATE" ) then --Party Update
        if IsInGroup() then
            if ( IncentiveProgram:GetSettings():GetSetting(IncentiveProgram.Settings["HIDE_IN_PARTY"]) ) then
                IncentiveProgram:GetFrame():HideFrame()
            end
            
            IncentiveProgram:SetCount(0)
        else
            IncentiveProgram:GetFrame():UpdatedSettings()
            RequestLFDPlayerLockInfo()
        end
    elseif ( event == "LFG_UPDATE_RANDOM_INFO" ) then --Received new LFD Info
        IncentiveProgram:SetCount(IncentiveProgram:GetDungeon():GetShortageCount())
    elseif ( event == "LFG_ROLE_UPDATE" ) then --updated the role
    
    end
    
    if ( IncentiveProgram.SavedLFGRoles.isUpdated ) then
        SetLFGRoles(IncentiveProgram.SavedLFGRoles.Leader, IncentiveProgram.SavedLFGRoles.Tank, IncentiveProgram.SavedLFGRoles.Healer, IncentiveProgram.SavedLFGRoles.Damage)
        IncentiveProgram.SavedLFGRoles.isUpdated = false
    end
end

function eventFrame:OnUpdate(e)
    self.elapsed = self.elapsed or (IncentiveProgram.TickRate - 5)
    self.elapsed = self.elapsed + e
    self.alertCount = self.alertCount or 0
    
    if ( ( self.alertCount > 0 ) and ( self.elapsed > 1.5 ) ) then
        if ( ( self.alertCount % 3 ) == 0 ) then
            IncentiveProgram:SetCount(IncentiveProgram:GetDungeon():GetShortageCount()
                ,IncentiveProgram.Icons["INCENTIVE_PLENTIFUL"])
        elseif ( ( self.alertCount % 3 ) == 1 ) then
            IncentiveProgram:SetCount(IncentiveProgram:GetDungeon():GetShortageCount()
                ,IncentiveProgram.Icons["INCENTIVE_UNCOMMON"])
        else
            IncentiveProgram:SetCount(IncentiveProgram:GetDungeon():GetShortageCount()
                ,IncentiveProgram.Icons["INCENTIVE_RARE"])
        end
        PlaySound("UI_GroupFinderReceiveApplication")
        self.alertCount = self.alertCount - 1
        
        if ( self.alertCount > 0 ) then
            self.elapsed = 0
        else
            self.elapsed = IncentiveProgram.TickRate - self.elapsed
        end
    end
    
    if self.elapsed > IncentiveProgram.TickRate then
        self.elapsed = self.elapsed - IncentiveProgram.TickRate
		if ( not IsInGroup() ) then --can't get incentives in a group anyways.  Seems to still trigger
									--when in LFR dungeons anyways, so ignore it now.
			RequestLFDPlayerLockInfo()
		end
    end
end

---------------------------------------
-- SetCount is a global that can allow the setting of the count.  Updates frame and dbroker
-- @params
--      count - (Optional) Sets the text in the frame and the broker
--		texture - (Optional) Sets the texture of the frame and the broker
-- @returns
--		nil
---------------------------------------
function IncentiveProgram:SetCount(count, texture)
	if ( not count ) then count = 0 end
    if ( not texture ) then
        texture = IncentiveProgram.Icons["INCENTIVE_RARE"]
    end

    if ( count > 0 ) then
        IncentiveProgram:GetFrame():ShowTextures(count, texture)
        IncentiveProgram:GetDataBroker():SetData(count, texture)
    else
        IncentiveProgram:GetFrame():HideTextures()
        IncentiveProgram:GetDataBroker():SetData(count, IncentiveProgram.Icons["INCENTIVE_NONE"])
    end       
end

---------------------------------------
-- SetAlert has the frame and broker chime or provide parameters for the Toast.
-- @params
--      line1 - (Optional) Line 1 of the Toast
--		line2 - (Optional) Line 2 of the Toast
--		texture - (Optional) texture of the Toast
--		arg1 - (Optional) the dungeon ID of the Toast for the OnClick function
--		arg2 - Not in use
-- @returns
--		nil
---------------------------------------
function IncentiveProgram:SetAlert(line1, line2, texture, arg1, arg2)
    if ( IncentiveProgram:GetSettings():GetSetting(IncentiveProgram.Settings["ALERT"]) ) then
        eventFrame.elapsed = 0 --reset timer for alert animation instead
        eventFrame.alertCount = 6 -- how many times to cycle alert
    end
    
    if ( IncentiveProgram:GetSettings():GetSetting(IncentiveProgram.Settings["ALERT_TOAST"]) ) then
        IncentiveProgram:GetToast():AddToast(line1, line2, texture, arg1, arg2, IncentiveProgram:GetMenu().JoinDungeon)
    end
end