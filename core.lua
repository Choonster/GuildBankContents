local addon, ns = ...

-- The format to use for each line.
-- %NAME% is replaced by the name of the item
-- %COUNT% is replaced by the total count of the item
local LINE_FORMAT = "%NAME% x %COUNT%"

----------
-- Core --
----------
local SLOTS_PER_TAB = MAX_GUILDBANK_SLOTS_PER_TAB

local pairs, tconcat, wipe = pairs, table.concat, wipe

local totals = {}
local lines = {}
local gsubTemp = {}

local function GetGuildBankContents()
	for tab = 1, GetNumGuildBankTabs() do
		for slot = 1, SLOTS_PER_TAB do
			local link = GetGuildBankItemLink(tab, slot)
			if link then
				local texturePath, itemCount, locked, isFiltered = GetGuildBankItemInfo(tab, slot)
				local name = link:match("|h%[(.-)%]|h")
				totals[name] = (totals[name] or 0) + itemCount
			end
		end
	end
	
	local numLines = 0
	for name, total in pairs(totals) do
		gsubTemp.NAME, gsubTemp.COUNT = name, total
		
		numLines = numLines + 1
		lines[numLines] = LINE_FORMAT:gsub("%%(%a+)%%", gsubTemp)
	end
	
	wipe(totals)
	
	local contents = tconcat(lines, "\n", 1, numLines)
	return contents
end

------------
-- Button --
------------
local dialog = ns.dialog

local button = CreateFrame("Button", "GuildBankContentsButton", GuildBankFrame, "UIPanelButtonTemplate")
button:SetPoint("TOP", "GuildBankMoneyFrameBackground")
button:SetPoint("BOTTOM", "GuildBankMoneyFrameBackground")
button:SetWidth(150)
button:SetText("Guild Bank Contents")
button:SetScript("OnClick", function(self, button, down)
	dialog:SetText(GetGuildBankContents())
end)
button:SetFrameLevel(button:GetFrameLevel() + 1)
