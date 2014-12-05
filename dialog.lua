local addon, ns = ...

local dialog = CreateFrame("Frame", "GuildBankContentsDialog", UIParent, "DialogBoxFrame")
dialog:SetSize(500, 400)
dialog:EnableMouse(true)
dialog:SetMovable(true)
dialog:SetScript("OnMouseDown", function(self, button)
	self:StartMoving()
end)
dialog:SetScript("OnMouseUp", function(self, button)
	self:StopMovingOrSizing()
end)

dialog.text = dialog:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
dialog.text:SetText("Guild Bank Contents")
dialog.text:SetPoint("TOP", 0, -10)

dialog.scrollFrame = CreateFrame("ScrollFrame", "$parentScrollFrame", dialog, "UIPanelScrollFrameTemplate")
dialog.scrollFrame:SetSize(455, 330)
dialog.scrollFrame:SetPoint("TOP", -10, -30)
dialog.scrollFrame:SetPoint("BOTTOM", "$parentButton", 0, 5)

dialog.scrollFrame.editBox = CreateFrame("EditBox", "$parentEditBox", dialog.scrollFrame)
dialog.scrollFrame.editBox:SetMultiLine(true)
dialog.scrollFrame.editBox:SetMaxLetters(9999)
dialog.scrollFrame.editBox:SetSize(450, 344)
dialog.scrollFrame.editBox:SetFontObject(ChatFontNormal)
dialog.scrollFrame.editBox:SetAutoFocus(false)
dialog.scrollFrame.editBox:SetScript("OnEscapePressed", function(self)
	self:ClearFocus()
end)

dialog.scrollFrame:SetScrollChild(dialog.scrollFrame.editBox)
table.insert(UISpecialFrames, dialog:GetName())

function dialog:SetText(text)
	self.scrollFrame.editBox:SetText(text)
	self:Show()
	self.scrollFrame.editBox:SetFocus()	
end

ns.dialog = dialog