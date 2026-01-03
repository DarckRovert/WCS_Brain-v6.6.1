-- Registrar comando /wcshotfix642 de forma robusta (definido globalmente)
SLASH_WCSHOTFIX642_1 = "/wcshotfix642"

if not SlashCmdList then SlashCmdList = {} end
SlashCmdList["WCSHOTFIX642"] = function(msg)
    local m = string.lower(msg or "")
    if m == "verify" then
        if WCS_HotFix_v642 and WCS_HotFix_v642.VerifyModuleVersions then
            local issues = WCS_HotFix_v642:VerifyModuleVersions()
            local _count = WCS_TableCount or table.getn or function(t) return 0 end
            if _count(issues) == 0 then
                DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.4.2]|r ✓ Todas las versiones son correctas")
            else
                DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.4.2]|r ✗ Se encontraron " .. _count(issues) .. " problemas:")
                for i = 1, _count(issues) do
                    DEFAULT_CHAT_FRAME:AddMessage("  |cFFFF0000- " .. issues[i] .. "|r")
                end
            end
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.4.2]|r No cargado o no disponible")
        end
    elseif m == "reapply" then
        if WCS_HotFix_v642 and WCS_HotFix_v642.Apply then
            WCS_HotFix_v642.applied = false
            WCS_HotFix_v642:Apply()
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.4.2]|r No cargado: no se puede reaplicar")
        end
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.4.2]|r Comandos disponibles:")
        DEFAULT_CHAT_FRAME:AddMessage("  |cFFFFCC00/wcshotfix642 verify|r - Verificar versiones")
        DEFAULT_CHAT_FRAME:AddMessage("  |cFFFFCC00/wcshotfix642 reapply|r - Reaplicar correcciones")
    end
end


