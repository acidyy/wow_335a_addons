local E, L, V, P, G = unpack(select(2, ...)) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule("Skins")

--Lua functions
local _G = _G
local select = select
local find, gsub = string.find, string.gsub
--WoW API / Variables

local function LoadSkin()
	if not E.private.skins.blizzard.enable or not E.private.skins.blizzard.gossip then return end

	ItemTextScrollFrame:StripTextures()
	GossipFrameGreetingPanel:StripTextures()

	ItemTextFrame:StripTextures(true)
	ItemTextFrame:CreateBackdrop("Transparent")
	ItemTextFrame.backdrop:Point("TOPLEFT", 13, -13)
	ItemTextFrame.backdrop:Point("BOTTOMRIGHT", -32, 74)

	ItemTextPageText:SetTextColor(1, 1, 1)
	ItemTextPageText.SetTextColor = E.noop

	S:HandleCloseButton(ItemTextCloseButton)

	GossipFramePortrait:Kill()

	GossipGreetingText:SetTextColor(1, 1, 1)

	GossipFrame:CreateBackdrop("Transparent")
	GossipFrame.backdrop:Point("TOPLEFT", 15, -11)
	GossipFrame.backdrop:Point("BOTTOMRIGHT", -30, 0)

	GossipFrameNpcNameText:ClearAllPoints()
	GossipFrameNpcNameText:Point("TOP", GossipFrame, "TOP", -5, -19)

	GossipGreetingScrollFrame:Height(403)

	S:HandleButton(GossipFrameGreetingGoodbyeButton)
	GossipFrameGreetingGoodbyeButton:Point("BOTTOMRIGHT", -37, 4)

	S:HandleNextPrevButton(ItemTextPrevPageButton)
	ItemTextPrevPageButton:Point("CENTER", ItemTextFrame, "TOPLEFT", 45, -60)

	S:HandleNextPrevButton(ItemTextNextPageButton)
	ItemTextNextPageButton:Point("CENTER", ItemTextFrame, "TOPRIGHT", -80, -60)

	ItemTextCurrentPage:Point("TOP", -15, -52)

	S:HandleScrollBar(ItemTextScrollFrameScrollBar)
	S:HandleScrollBar(GossipGreetingScrollFrameScrollBar, 5)

	S:HandleCloseButton(GossipFrameCloseButton)
	GossipFrameCloseButton:Point("CENTER", GossipFrame, "TOPRIGHT", -44, -25)

	for i = 1, NUMGOSSIPBUTTONS do
		local button = _G["GossipTitleButton"..i]
		local obj = select(3, button:GetRegions())

		S:HandleButtonHighlight(button)

		obj:SetTextColor(1, 1, 1)
	end

	hooksecurefunc("GossipFrameUpdate", function()
		for i = 1, NUMGOSSIPBUTTONS do
			local button = _G["GossipTitleButton"..i]

			if button:GetFontString() then
				if button:GetFontString():GetText() and find(button:GetFontString():GetText(), "|cff000000") then
					button:GetFontString():SetText(gsub(button:GetFontString():GetText(), "|cff000000", "|cffFFFF00"))
				end
			end
		end
	end)
end

S:AddCallback("Skin_Gossip", LoadSkin)