--[[
	SquidMod
	Author: SAM (recoded by Ganders) - (Grafic Patch by Imithat)
	--Edited by Jay Whaley [09/13/2019]
	--Edited by Larry @ Baelgun [DE] [01/07/2023] - [02/25/2024]
	Version: 100205.1
]]

local iSquidMod = LibStub("AceAddon-3.0"):NewAddon("iSquidMod", "AceHook-3.0")

local CUI = LibStub("AceAddon-3.0"):GetAddon("ClassicUI")

-- List of the loaded textures available
local textures = {
	"hide",
	"emblem",
	"griffon",
	"lion",
	"diablo1",
	"diablo1_roth",
	"diablo2",
	"diablo2_roth",
	"diablo3crest",
	"murloc",
	"murloc2",
	"crest",
	"hordecrest",
	"orccrest",
	"allianzcrest",
	"huntercrest",
	"druidcrest",
	"pandacrest",
	"nightelfcrest",
	"priestcrest",
	"huntercrest",
	"dkcrest",
	"magecrest",
	"magecrest2",
	"monkcrest",
	"palacrest",
	"roguecrest",
	"shamancrest",
	"shamancrest2",
	"warlockcrest",
	"warriorcrest",
	"undeadcrest",
	"crusadercrest",
	"axecrest",
	"worg",
	"bfmage",
	"panda",
	"pandakind",
	"swking",
	"draenei",
	"druidtree",
	"druidbear",
	"lichking",
	"nightelf",
	"onyxia",
	"orc",
	"orc2",
	"ysera",
	"drake",
	"bleach",
	"wowlogo",
	"orbdaemon",
	"yulon",
	"xuen",
	"niuzao",
	"minichi",
	"minidroplet",
	"miniporcupette",
	"minisha",
	"minixuen",
	"miniyulon",
}

-- Sets the default griffon texture.
iSquidModDB = 3

-- Defines how to handle the slash commmand for controlling the mod.
function iSquidMod.SlashCommand(msg)
	local self = iSquidMod
	if strlen(msg) > 0 then
		local command = string.lower(msg)
		local help = true

		-- If the user used the string names, then...
		if ( type(command) == "string" ) then
			for i,v in ipairs(textures) do
				if ( command == string.lower(v) ) then
					self:Update(i)
					iSquidMod.ChatMsg("iSquidMod: "..string.lower(v))
					help = false
				end
			end
		-- If the user used the texture id, then...
		elseif ( type(command) == "number" ) then
			if textures[command] ~= nil then
				self:Update(command)
				iSquidMod.ChatMsg("iSquidMod: "..string.lower(textures[command]))
				help = false
			end
		end

		if ( help == true ) then
			iSquidMod.ShowHelp()
		end
	else
		iSquidMod.ShowHelp()
	end
end

function iSquidMod.ChatMsg(message)
	DEFAULT_CHAT_FRAME:AddMessage(message);
end

function iSquidMod.ShowHelp()
	for i,v in ipairs(textures) do
		iSquidMod.ChatMsg("iSquidMod: /squid "..v)
	end
end

-- Defines how to integrate into Classic UI
function iSquidMod:OnEnable()
  self:RawHook(CUI, "ModifyOriginalFrames", true)
end

function iSquidMod:ModifyOriginalFrames()
	self.hooks[CUI].ModifyOriginalFrames()
	iSquidMod:Update(iSquidModDB)
end
		
-- Will updated the interface based on the provided toggle.
function iSquidMod:Update(toggle)
	if ( toggle == 1 ) then
		CUI_MainMenuBarLeftEndCap:Hide()
		CUI_MainMenuBarRightEndCap:Hide()
	elseif ( toggle == 2 ) then
		CUI_MainMenuBarLeftEndCap:SetTexture("Interface\\AddOns\\iSquidMod\\skin\\emblemLeft.tga")
		CUI_MainMenuBarRightEndCap:SetTexture("Interface\\AddOns\\iSquidMod\\skin\\emblemRight.tga")
		CUI_MainMenuBarLeftEndCap:Show()
		CUI_MainMenuBarRightEndCap:Show()
	elseif ( textures[toggle] ~= nil ) then
		CUI_MainMenuBarLeftEndCap:SetTexture("Interface\\AddOns\\iSquidMod\\skin\\"..textures[toggle]..".tga")
		CUI_MainMenuBarRightEndCap:SetTexture("Interface\\AddOns\\iSquidMod\\skin\\"..textures[toggle]..".tga")
		CUI_MainMenuBarLeftEndCap:Show()
		CUI_MainMenuBarRightEndCap:Show()
	end
	CUI_MainMenuBarLeftEndCap:SetWidth(128)
	CUI_MainMenuBarLeftEndCap:SetHeight(128)
	CUI_MainMenuBarRightEndCap:SetWidth(128)
	CUI_MainMenuBarRightEndCap:SetHeight(128)
	iSquidModDB = toggle
end

-- String literal for the actual in-game slash command.
SLASH_SQUID1 = "/squid"

-- Adds the string literal to this mods registered slash commands.
SlashCmdList["SQUID"] = iSquidMod.SlashCommand
