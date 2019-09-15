--[[
	SquidMod
	Author: SAM (recoded by Ganders) - (Grafic Patch by Imithat)
	--Edited by Jay Whaley [09/13/2019]
	Version: 2.6
]]

-- Creates a frame to which the mod to attaches.
local iSquidMod = CreateFrame("Frame")

-- List of the loaded textrues available
local textures = {
	"hide",
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

-- Claims this as the database ID for the mod.
iSquidModDB = 2

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
					DEFAULT_CHAT_FRAME:AddMessage("iSquidMod: "..string.lower(v))
					help = false
				end
			end
		-- If the user used the texture id, then...
		elseif ( type(command) == "number" ) then
			if textures[command] ~= nil then
				self:Update(command)
				DEFAULT_CHAT_FRAME:AddMessage("iSquidMod: "..string.lower(textures[command]))
				help = false
			end
		end

		-- Will display the usage string if requested.
		if ( help == true ) then
			for i,v in ipairs(textures) do
				DEFAULT_CHAT_FRAME:AddMessage("iSquidMod: /squid "..v)
			end
		end
	else
		for i,v in ipairs(textures) do
			DEFAULT_CHAT_FRAME:AddMessage("iSquidMod: /squid "..v)
		end
	end
end
		
-- Will updated the interface based on the provided toggle.
function iSquidMod:Update(toggle)
	if ( toggle == 1 ) then
		MainMenuBarLeftEndCap:Hide()
		MainMenuBarRightEndCap:Hide()
	elseif ( toggle == 29 ) then
		MainMenuBarLeftEndCap:SetTexture("Interface\\AddOns\\iSquidMod\\skin\\emblemLeft.tga")
		MainMenuBarRightEndCap:SetTexture("Interface\\AddOns\\iSquidMod\\skin\\emblemRight.tga")
		MainMenuBarLeftEndCap:Show()
		MainMenuBarRightEndCap:Show()
	else
		MainMenuBarLeftEndCap:SetTexture("Interface\\AddOns\\iSquidMod\\skin\\"..textures[toggle]..".tga")
		MainMenuBarRightEndCap:SetTexture("Interface\\AddOns\\iSquidMod\\skin\\"..textures[toggle]..".tga")
		MainMenuBarLeftEndCap:Show()
		MainMenuBarRightEndCap:Show()
	end
	iSquidModDB = toggle
end

-- Attches the Update function to the OnEvent event to actually tie this mod with the main WoW UI.
iSquidMod:SetScript("OnEvent", function() iSquidMod:Update(iSquidModDB) end)
-- Sets the target event to listen for to trigger the Update function.
iSquidMod:RegisterEvent("PLAYER_LOGIN")

-- String literal for the actual in-game slash command.
SLASH_SQUID1 = "/squid"
-- Adds the string literal to this mods registered slash commands.
SlashCmdList["SQUID"] = iSquidMod.SlashCommand
