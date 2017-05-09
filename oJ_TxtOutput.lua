OJTOP = {}
OJTOP.ename = 'OJTOP'
OJTOP.name = 'oJ_TxtOutput' -- sugar daddy
OJTOP.version = '1.0.2'
OJTOP.init = false
OJTOP.savedata = {}
local WM = WINDOW_MANAGER
local EM = EVENT_MANAGER
local SM = SCENE_MANAGER
local CM = CALLBACK_MANAGER
local strformat = zo_strformat
local init_savedef = {
    status = true,
    mainbox_pos = {70,120},
    statusicon_pos = {20,20},
}
local debug_mode = false

--npc講話
function OJTOP.OnNpcTalk(eventCode, optionCount)
    if OJTOP.savedata.status ~= true then return end
    local maxOpt = optionCount + 1
    findAllTxt4InteractWindow(maxOpt)
end
function OJTOP.OnNpcTalk2(eventCode, conversationBodyText, conversationOptionCount)
    if OJTOP.savedata.status ~= true then return end
    local maxOpt = conversationOptionCount + 1
    findAllTxt4InteractWindow(maxOpt)
end
function findAllTxt4InteractWindow(maxOpt)
    if OJTOP.savedata.status ~= true then return end
    -- title 
    local main = ":::  "..ZO_InteractWindowTargetAreaTitle:GetText().."  :::\n\n"
    -- body
    main = main..ZO_InteractWindowTargetAreaBodyText:GetText().."\n\n"
    -- option
    if maxOpt >= 1 then main = main.."\n >> "..ZO_ChatterOption1:GetText() end
    if maxOpt >= 2 then main = main.."\n >> "..ZO_ChatterOption2:GetText() end
    if maxOpt >= 3 then main = main.."\n >> "..ZO_ChatterOption3:GetText() end
    if maxOpt >= 4 then main = main.."\n >> "..ZO_ChatterOption4:GetText() end
    if maxOpt >= 5 then main = main.."\n >> "..ZO_ChatterOption5:GetText() end
    if maxOpt >= 6 then main = main.."\n >> "..ZO_ChatterOption6:GetText() end
    if maxOpt >= 7 then main = main.."\n >> "..ZO_ChatterOption7:GetText() end
    if maxOpt >= 8 then main = main.."\n >> "..ZO_ChatterOption8:GetText() end
    if maxOpt >= 9 then main = main.."\n >> "..ZO_ChatterOption9:GetText() end
    if maxOpt >= 10 then main = main.."\n >> "..ZO_ChatterOption10:GetText() end

    OJTOP:showTxt2Box(main)
end
-- 即時開書
function OJTOP.OnShowBook(eventCode, title, body, medium, showTitle)
    if OJTOP.savedata.status ~= true then return end
    local main = ":::  "..title.."  :::\n\n\n"..body
    OJTOP:showTxt2Box(main)
end
-- j 介面開書
local Origin_LoreLibrary_ReadBook = ZO_LoreLibrary_ReadBook
ZO_LoreLibrary_ReadBook = function (categoryIndex, collectionIndex, bookIndex)
    Origin_LoreLibrary_ReadBook(categoryIndex, collectionIndex, bookIndex)
    if OJTOP.savedata.status ~= true then return end
    local title = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)
    local body, medium, showTitle = ReadLoreBook(categoryIndex, collectionIndex, bookIndex)

    local main = ":::  "..title.."  :::"
    main = main.." -- ("..categoryIndex.." , "..collectionIndex.." , "..bookIndex..") \n\n"
    main = main..body

    OJTOP:showTxt2Box(main)
end
function OJTOP:showTxt2Box(main)
    if OJTOP.savedata.status ~= true then return end
    OJTOPPanelViewOutputBoxTxtBox:Clear()
    OJTOPPanelViewOutputBoxTxtBox:SetText(main)
    OJTOP.toggleOJTOPPanelView(1);
end
-- 硬讀書
function OJTOP.ShowFilterBook()
    local category_i = OJTOPPanelViewCategoryIndexVal:GetText()
    local collection_i = OJTOPPanelViewCollectionIndexVal:GetText()
    local book_i = OJTOPPanelViewBookIndexVal:GetText()

    if category_i ~= '' and collection_i ~= '' and book_i ~= '' then
        local title = GetLoreBookInfo(category_i, collection_i, book_i)
        local body, medium, showTitle = ReadLoreBook(category_i, collection_i, book_i)

        local main = ":::  "..title.."  :::\n\n\n"..body
        OJTOP:showTxt2Box(main)
    else
        local main = "please input 3 input val"
        OJTOP:showTxt2Box(main)
    end
end

----------------------------------------
-- UI CTRL Start
----------------------------------------
function OJTOP:OnUiPosLoad()
    OJTOPPanelView:ClearAnchors()
    OJTOPPanelView:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, OJTOP.savedata.mainbox_pos[0], OJTOP.savedata.mainbox_pos[1])

    if OJTOP.savedata.status == false then
        OJTOPStatusView:SetHidden(false)
    else
        OJTOPStatusView:SetHidden(true)
    end
    OJTOPStatusView:ClearAnchors()
    OJTOPStatusView:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, OJTOP.savedata.statusicon_pos[0], OJTOP.savedata.statusicon_pos[1])
end
function OJTOP.OnUiPosSave(tag)
    if tag == 'OJTOPPanelView' then
        OJTOP.savedata.mainbox_pos[0] = OJTOPPanelView:GetLeft()
        OJTOP.savedata.mainbox_pos[1] = OJTOPPanelView:GetTop()
    end
    if tag == 'OJTOPStatusView' then
        OJTOP.savedata.statusicon_pos[0] = OJTOPStatusView:GetLeft()
        OJTOP.savedata.statusicon_pos[1] = OJTOPStatusView:GetTop()
    end
end
function OJTOP.toggleOJTOPPanelView(open)
    if open == nil then
        SM:ToggleTopLevel(OJTOPPanelView)
    elseif open == 1 then
        SM:ShowTopLevel(OJTOPPanelView)
    elseif open == 0 then
        SM:HideTopLevel(OJTOPPanelView)
    end
end
function OJTOP.statusOJTOPPanelView()
    if OJTOP.savedata.status == true then
        OJTOP.savedata.status = false
    else
        OJTOP.savedata.status = true
    end

    if OJTOP.savedata.status == false then
        OJTOPStatusView:SetHidden(false)
    else
        OJTOPStatusView:SetHidden(true)
    end
end
function OJTOP.conmoveOJTOPStatusView(status)
    if status == 1 then
        OJTOPStatusViewBg:SetCenterColor(255,0,0,1)
        WM:SetMouseCursor(MOUSE_CURSOR_PAN)
    elseif status == 0 then
        OJTOPStatusViewBg:SetCenterColor(0,0,0,1)
        WM:SetMouseCursor(MOUSE_CURSOR_DO_NOT_CARE)
    end
end

----------------------------------------
-- INIT
----------------------------------------
function OJTOP:Initialize()
    SM:RegisterTopLevel(OJTOPPanelView,false) -- 註冊最高層

    -- savedata
    OJTOP.savedata = ZO_SavedVars:NewAccountWide('OJTOP_savedata',1,nil,init_savedef)
    
    -- key bind controls
    ZO_CreateStringId("SI_BINDING_NAME_SHOW_OJTOPPanelView", "toggle ui")
    ZO_CreateStringId("SI_BINDING_NAME_STATUS_OJTOPPanelView", "enable/desable ui")

    -- 事件綁定
    EM:RegisterForEvent(OJTOP.name, EVENT_SHOW_BOOK, OJTOP.OnShowBook) --即時打開書本
    EM:RegisterForEvent(OJTOP.name, EVENT_CHATTER_BEGIN, OJTOP.OnNpcTalk) --npc講話
    EM:RegisterForEvent(OJTOP.name, EVENT_CONVERSATION_UPDATED, OJTOP.OnNpcTalk2) --npc繼續講話

    -- 一堆 TopLevel 視窗問題
    EM:RegisterForEvent(self.ename,EVENT_NEW_MOVEMENT_IN_UI_MODE, function() OJTOP.toggleOJTOPPanelView(0) end)
    ZO_PreHookHandler(OJTOPStatusView,'OnMouseEnter', function() OJTOP.conmoveOJTOPStatusView(1) end)
    ZO_PreHookHandler(OJTOPStatusView,'OnMouseExit', function() OJTOP.conmoveOJTOPStatusView(0) end)

    -- default run func
    OJTOP:OnUiPosLoad()

    SLASH_COMMANDS["/ojtoptest"] = function()
        d(OJTOP.savedata.status)
        d('===================')
    end
    SLASH_COMMANDS["/ojtopinit"] = function()
        d('Initialize')
    end
end
function OJTOP.OnAddOnLoaded(event, addonName)
    if addonName ~= OJTOP.name then return end

    EM:UnregisterForEvent(OJTOP.ename,EVENT_ADD_ON_LOADED)
    OJTOP:Initialize()

    SLASH_COMMANDS["/ojtop"] = function()
        d('OnAddOnLoaded')
    end
end
EM:RegisterForEvent(OJTOP.ename, EVENT_ADD_ON_LOADED, OJTOP.OnAddOnLoaded);
