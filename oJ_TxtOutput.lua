OJTOP = {}
OJTOP.ename = 'OJTOP'
OJTOP.name = 'oJ_TxtOutput' -- sugar daddy
OJTOP.author = 'oJelly'
OJTOP.version = '1.1.1'
OJTOP.init = false
OJTOP.savedata = {}
local WM = WINDOW_MANAGER
local EM = EVENT_MANAGER
local SM = SCENE_MANAGER
local CM = CALLBACK_MANAGER
local strformat = zo_strformat
local init_savedef = {
    status = true, --auto show status
    aleryuistatus = true, --icon show status
    mainbox_pos = {70,120},
    statusicon_pos = {20,20},
}
local debug_mode = false

OJTOP.talkstatus = false
OJTOP.queststatus = false
OJTOP.talkoptcount = 0

local LAM2 = LibStub:GetLibrary("LibAddonMenu-2.0")

-- 因為無法有正確的事件 取得對話選項的更新狀態 只好繼承 副寫 每一個 setText 
local OriginTitleSet = ZO_InteractWindowTargetAreaTitle.SetText
ZO_InteractWindowTargetAreaTitle.SetText = function (self, bodyText)
    OriginTitleSet(self, bodyText)
    OJTOP.talkoptcount = 0
end
-- local OriginTitleSet = ZO_InteractWindowTargetAreaBodyText.SetText
-- ZO_InteractWindowTargetAreaBodyText.SetText = function (self, bodyText)
--     OriginBodySet(self, bodyText)
-- end
-- local OriginOpt_1_Set = ZO_ChatterOption1.SetText; ZO_ChatterOption1.SetText = function (self, bodyText) OriginOpt_1_Set(self, bodyText); OJTOP.talkoptcount = OJTOP.talkoptcount + 1; end
-- local OriginOpt_2_Set = ZO_ChatterOption2.SetText; ZO_ChatterOption2.SetText = function (self, bodyText) OriginOpt_2_Set(self, bodyText); OJTOP.talkoptcount = OJTOP.talkoptcount + 1; end
-- local OriginOpt_3_Set = ZO_ChatterOption3.SetText; ZO_ChatterOption3.SetText = function (self, bodyText) OriginOpt_3_Set(self, bodyText); OJTOP.talkoptcount = OJTOP.talkoptcount + 1; end
-- local OriginOpt_4_Set = ZO_ChatterOption4.SetText; ZO_ChatterOption4.SetText = function (self, bodyText) OriginOpt_4_Set(self, bodyText); OJTOP.talkoptcount = OJTOP.talkoptcount + 1; end
-- local OriginOpt_5_Set = ZO_ChatterOption5.SetText; ZO_ChatterOption5.SetText = function (self, bodyText) OriginOpt_5_Set(self, bodyText); OJTOP.talkoptcount = OJTOP.talkoptcount + 1; end
-- local OriginOpt_6_Set = ZO_ChatterOption6.SetText; ZO_ChatterOption6.SetText = function (self, bodyText) OriginOpt_6_Set(self, bodyText); OJTOP.talkoptcount = OJTOP.talkoptcount + 1; end
-- local OriginOpt_7_Set = ZO_ChatterOption7.SetText; ZO_ChatterOption7.SetText = function (self, bodyText) OriginOpt_7_Set(self, bodyText); OJTOP.talkoptcount = OJTOP.talkoptcount + 1; end
-- local OriginOpt_8_Set = ZO_ChatterOption8.SetText; ZO_ChatterOption8.SetText = function (self, bodyText) OriginOpt_8_Set(self, bodyText); OJTOP.talkoptcount = OJTOP.talkoptcount + 1; end
-- local OriginOpt_9_Set = ZO_ChatterOption9.SetText; ZO_ChatterOption9.SetText = function (self, bodyText) OriginOpt_9_Set(self, bodyText); OJTOP.talkoptcount = OJTOP.talkoptcount + 1; end
-- local OriginOpt_10_Set = ZO_ChatterOption10.SetText; ZO_ChatterOption10.SetText = function (self, bodyText) OriginOpt_10_Set(self, bodyText); OJTOP.talkoptcount = OJTOP.talkoptcount + 1; end

--npc講話 原本期待用事件判斷抓資料時間
function OJTOP.oj_chatter_begin(eventCode, optionCount)
    -- local maxOpt = optionCount + 1
    -- findAllTxt4InteractWindow(maxOpt)
    OJTOP.talkstatus = true
    findAllTxt4InteractWindow(0)
end
function OJTOP.oj_conversation_updated(eventCode, conversationBodyText, conversationOptionCount)
    -- local maxOpt = conversationOptionCount + 1
    -- findAllTxt4InteractWindow(maxOpt)
    findAllTxt4InteractWindow(0)
end
function OJTOP.oj_quest_offered()
    findAllTxt4InteractWindow(0)
end
function OJTOP.oj_quest_complete_dialog()
    findAllTxt4InteractWindow(0)
end
function OJTOP.oj_chatter_end()
    if OJTOP.talkstatus then
        OJTOP.talkstatus = false
        OJTOP.toggleOJTOPPanelView(0);
    end
end


function findAllTxt4InteractWindow(maxOpt)
    if maxOpt == 0 then
        maxOpt = OJTOP.talkoptcount
    end
    -- title 
    local main = ":::  "..ZO_InteractWindowTargetAreaTitle:GetText().."  :::\n\n"
    -- body
    main = main..ZO_InteractWindowTargetAreaBodyText:GetText().."\n\n"
    -- option
    if ZO_ChatterOption1:IsHidden() == false then main = main.."\n >> "..ZO_ChatterOption1:GetText() end
    if ZO_ChatterOption2:IsHidden() == false then main = main.."\n >> "..ZO_ChatterOption2:GetText() end
    if ZO_ChatterOption3:IsHidden() == false then main = main.."\n >> "..ZO_ChatterOption3:GetText() end
    if ZO_ChatterOption4:IsHidden() == false then main = main.."\n >> "..ZO_ChatterOption4:GetText() end
    if ZO_ChatterOption5:IsHidden() == false then main = main.."\n >> "..ZO_ChatterOption5:GetText() end
    if ZO_ChatterOption6:IsHidden() == false then main = main.."\n >> "..ZO_ChatterOption6:GetText() end
    if ZO_ChatterOption7:IsHidden() == false then main = main.."\n >> "..ZO_ChatterOption7:GetText() end
    if ZO_ChatterOption8:IsHidden() == false then main = main.."\n >> "..ZO_ChatterOption8:GetText() end
    if ZO_ChatterOption9:IsHidden() == false then main = main.."\n >> "..ZO_ChatterOption9:GetText() end
    if ZO_ChatterOption10:IsHidden() == false then main = main.."\n >> "..ZO_ChatterOption10:GetText() end
    main = main.."\n\n\n"

    OJTOP:showTxt2Box(main)
end


-- 任務
local OriginQJTitleSet = ZO_QuestJournalTitleText.SetText
ZO_QuestJournalTitleText.SetText = function (self, bodyText)
    OriginQJTitleSet(self, bodyText)
    OJTOP.talkoptcount = 0
    zo_callLater(findAllTxt4QuestJournal, 100)
    -- d( '===============================' )
end
-- local OriginQJStepSet = ZO_QuestJournalStepText.SetText
-- ZO_QuestJournalStepText.SetText = function (self, bodyText)
--     OriginQJStepSet(self, bodyText)
-- end
-- local OriginQJBGSet = ZO_QuestJournalBGText.SetText
-- ZO_QuestJournalBGText.SetText = function (self, bodyText)
--     OriginQJBGSet(self, bodyText)
-- end
function cancelc666(str)
    str = string.gsub(str, "|c666666", "")
    str = string.gsub(str, "|r", "")
    return str
end
function findAllTxt4QuestJournal()
    if OJTOP.queststatus == false then return end

    maxOpt = OJTOP.talkoptcount
    -- title 
    local main = ":::  "..ZO_QuestJournalTitleText:GetText().."  :::\n\n"
    -- body
    main = main..ZO_QuestJournalBGText:GetText().."\n\n"
    main = main..ZO_QuestJournalStepText:GetText().."\n\n"
    -- tasks
    if ZO_QuestJournalConditionTextBulletListLabel1 then 
        if ZO_QuestJournalConditionTextBulletListLabel1:IsHidden() == false then
            main = main.."\n >> "..cancelc666( ZO_QuestJournalConditionTextBulletListLabel1:GetText() )
        end
    end
    if ZO_QuestJournalConditionTextBulletListLabel2 then 
        if ZO_QuestJournalConditionTextBulletListLabel2:IsHidden() == false then
            main = main.."\n >> "..cancelc666( ZO_QuestJournalConditionTextBulletListLabel2:GetText() )
        end
    end
    if ZO_QuestJournalConditionTextBulletListLabel3 then 
        if ZO_QuestJournalConditionTextBulletListLabel3:IsHidden() == false then
            main = main.."\n >> "..cancelc666( ZO_QuestJournalConditionTextBulletListLabel3:GetText() )
        end
    end
    if ZO_QuestJournalConditionTextBulletListLabel4 then 
        if ZO_QuestJournalConditionTextBulletListLabel4:IsHidden() == false then
            main = main.."\n >> "..cancelc666( ZO_QuestJournalConditionTextBulletListLabel4:GetText() )
        end
    end
    if ZO_QuestJournalConditionTextBulletListLabel5 then 
        if ZO_QuestJournalConditionTextBulletListLabel5:IsHidden() == false then
            main = main.."\n >> "..cancelc666( ZO_QuestJournalConditionTextBulletListLabel5:GetText() )
        end
    end
    -- option
    if ZO_QuestJournalOptionalStepTextBulletListLabel1 then 
        if ZO_QuestJournalOptionalStepTextBulletListLabel1:IsHidden() == false then
            main = main.."\n\n\n >> "..ZO_QuestJournalOptionalStepTextBulletListLabel1:GetText()
        end
    end
    if ZO_QuestJournalOptionalStepTextBulletListLabel2 then 
        if ZO_QuestJournalOptionalStepTextBulletListLabel2:IsHidden() == false then
            main = main.."\n >> "..ZO_QuestJournalOptionalStepTextBulletListLabel2:GetText()
        end
    end
    if ZO_QuestJournalOptionalStepTextBulletListLabel3 then 
        if ZO_QuestJournalOptionalStepTextBulletListLabel3:IsHidden() == false then
            main = main.."\n >> "..ZO_QuestJournalOptionalStepTextBulletListLabel3:GetText()
        end
    end
    if ZO_QuestJournalOptionalStepTextBulletListLabel4 then 
        if ZO_QuestJournalOptionalStepTextBulletListLabel4:IsHidden() == false then
            main = main.."\n >> "..ZO_QuestJournalOptionalStepTextBulletListLabel4:GetText()
        end
    end
    if ZO_QuestJournalOptionalStepTextBulletListLabel5 then 
        if ZO_QuestJournalOptionalStepTextBulletListLabel5:IsHidden() == false then
            main = main.."\n >> "..ZO_QuestJournalOptionalStepTextBulletListLabel5:GetText()
        end
    end
    main = main.."\n\n\n"

    OJTOP:showTxt2Box(main)
end

-- 即時開書
function OJTOP.OnShowBook(eventCode, title, body, medium, showTitle)
    local main = ":::  "..title.."  :::\n\n\n"..body
    OJTOP:showTxt2Box(main)
end
-- j 介面開書
local Origin_LoreLibrary_ReadBook = ZO_LoreLibrary_ReadBook
ZO_LoreLibrary_ReadBook = function (categoryIndex, collectionIndex, bookIndex)
    Origin_LoreLibrary_ReadBook(categoryIndex, collectionIndex, bookIndex)
    local title = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)
    local body, medium, showTitle = ReadLoreBook(categoryIndex, collectionIndex, bookIndex)

    local main = ":::  "..title.."  :::"
    main = main.." -- ("..categoryIndex.." , "..collectionIndex.." , "..bookIndex..") \n\n"
    main = main..body

    OJTOP:showTxt2Box(main)
end
function OJTOP:showTxt2Box(main)
    OJTOPPanelViewOutputBoxTxtBox:Clear()
    OJTOPPanelViewOutputBoxTxtBox:SetText(main)
    if OJTOP.savedata.status == true then
        OJTOP.toggleOJTOPPanelView(1);
    end
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

    if OJTOP.savedata.status == false and OJTOP.savedata.aleryuistatus == true then
        OJTOP.toggleOJTOPStatusView(1)
    else
        OJTOP.toggleOJTOPStatusView(0)
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

    if OJTOP.savedata.status == false and OJTOP.savedata.aleryuistatus == true then
        OJTOP.toggleOJTOPStatusView(1)
    else
        OJTOP.toggleOJTOPStatusView(0)
    end
end
function OJTOP.toggleOJTOPStatusView(open)
    if open == nil then
        if OJTOP.savedata.aleryuistatus == true then
            OJTOP.savedata.aleryuistatus = false
            OJTOPStatusView:SetHidden(true)
        else
            OJTOP.savedata.aleryuistatus = true
            OJTOPStatusView:SetHidden(false)
        end
    elseif open == 1 then
        OJTOPStatusView:SetHidden(false)
    elseif open == 0 then
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
-- setting
----------------------------------------
local function createLAM2Panel()
    local panelData = {
        type = "panel",
        name = 'TxtOutput',
        displayName = ZO_HIGHLIGHT_TEXT:Colorize('TxtOutput'),
        author = "|cFFAA33"..OJTOP.author.."|r",
        version = OJTOP.version,
        registerForRefresh = true,
    }
    local optionsData = {
        [1] = {
            type = "checkbox",
            name = 'auto show on/off',
            tooltip = 'auto show UI : book/quest/talk',
            getFunc = function() 
                return OJTOP.savedata.status
            end,
            setFunc = function(val) 
                OJTOP.statusOJTOPPanelView()
            end,
            default = OJTOP.savedata.status,
        },
        [2] = {
            type = "checkbox",
            name = 'show status ui',
            tooltip = 'show the status ui when you trun off auto show',
            getFunc = function() 
                return OJTOP.savedata.aleryuistatus
            end,
            setFunc = function(val) 
                OJTOP.toggleOJTOPStatusView(open)
            end,
            default = OJTOP.savedata.aleryuistatus,
        },
    }
    local myPanel = LAM2:RegisterAddonPanel(OJTOP.name.."LAM2Options", panelData)
    LAM2:RegisterOptionControls(OJTOP.name.."LAM2Options", optionsData)
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
    ZO_CreateStringId("SI_BINDING_NAME_STATUS_OJTOPPanelView", "auto show on/off")

    -- 事件綁定
    EM:RegisterForEvent(OJTOP.name, EVENT_SHOW_BOOK, OJTOP.OnShowBook) --即時打開書本
    -- 以下4個事件 都在 ui 文字貼好才觸發 , 無法判斷我想要的 選項數量 只能改用 繼承的方式處理
    EM:RegisterForEvent(OJTOP.name, EVENT_CHATTER_BEGIN, OJTOP.oj_chatter_begin) --npc講話
    EM:RegisterForEvent(OJTOP.name, EVENT_CONVERSATION_UPDATED, OJTOP.oj_conversation_updated) --npc繼續講話
    EM:RegisterForEvent(OJTOP.name, EVENT_QUEST_OFFERED , OJTOP.oj_quest_offered); --npc對話給予任務選項
    EM:RegisterForEvent(OJTOP.name, EVENT_QUEST_COMPLETE_DIALOG , OJTOP.oj_quest_complete_dialog) --npc對話給予任務獎勵
    EM:RegisterForEvent(OJTOP.name, EVENT_CHATTER_END, OJTOP.oj_chatter_end) --npc對話結束

    -- 一堆 TopLevel 視窗問題
    EM:RegisterForEvent(OJTOP.ename,EVENT_NEW_MOVEMENT_IN_UI_MODE, function() OJTOP.toggleOJTOPPanelView(0) end)
    ZO_PreHookHandler(OJTOPStatusView,'OnMouseEnter', function() OJTOP.conmoveOJTOPStatusView(1) end)
    ZO_PreHookHandler(OJTOPStatusView,'OnMouseExit', function() OJTOP.conmoveOJTOPStatusView(0) end)
    ZO_PreHookHandler(ZO_QuestJournal,'OnShow', function() OJTOP.queststatus = true end)
    ZO_PreHookHandler(ZO_QuestJournal,'OnHide', function() OJTOP.queststatus = false; OJTOP.toggleOJTOPPanelView(0); end)

    -- default run func
    OJTOP:OnUiPosLoad()
    -- setting page
    createLAM2Panel()

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
