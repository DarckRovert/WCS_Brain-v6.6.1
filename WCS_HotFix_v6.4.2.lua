--[[
    WCS_HotFix_v6.4.2.lua - Correcciones y Mejoras v6.4.2
    Compatible con Lua 5.0 (WoW 1.12 / Turtle WoW)
    
    RESPONSABILIDADES:
    - Verificar compatibilidad de todos los módulos con versión 6.4.2
    - Migración de datos de versiones anteriores
    - Correcciones de compatibilidad Lua 5.0
    - Validación de integridad del sistema
    
    VERSIÓN: 6.4.2
    FECHA: 2024-12-23
]]--

WCS_HotFix_v642 = WCS_HotFix_v642 or {}
WCS_HotFix_v642.VERSION = "6.4.2"
WCS_HotFix_v642.applied = false

-- Verificar que estamos en el entorno correcto
function WCS_HotFix_v642:VerifyEnvironment()
    -- Verificar Lua 5.0
    if _VERSION and _VERSION ~= "Lua 5.0" then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.4.2]|r Advertencia: No detectado Lua 5.0 (" .. (_VERSION or "desconocido") .. ")")
    end
    
    -- Verificar funciones críticas
    local missing = {}
    if not unpack then table.insert(missing, "unpack") end
    if not table.getn then table.insert(missing, "table.getn") end
    
    local _count = WCS_TableCount or table.getn or function(t) return (type(t) == "table") and 0 or 0 end
    if _count(missing) > 0 then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.4.2]|r Error: Funciones faltantes: " .. table.concat(missing, ", "))
        return false
    end
    
    return true
end

-- Migrar datos de versiones anteriores
function WCS_HotFix_v642:MigrateData()
    -- Actualizar SavedVariables si existen
    if WCS_BrainSaved and WCS_BrainSaved.version then
        local oldVersion = WCS_BrainSaved.version
        WCS_BrainSaved.version = "6.4.2"
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.4.2]|r Datos migrados de " .. oldVersion .. " a 6.4.2")
    end
    
    if WCS_BrainMetricsSaved and WCS_BrainMetricsSaved.version then
        WCS_BrainMetricsSaved.version = "6.4.2"
    end
    
    if WCS_BrainContextualSaved and WCS_BrainContextualSaved.version then
        WCS_BrainContextualSaved.version = "6.4.2"
    end
end

-- Verificar versiones de módulos
function WCS_HotFix_v642:VerifyModuleVersions()
    local issues = {}
    
    -- Verificar módulos core
    if WCS_Brain and WCS_Brain.VERSION ~= "6.4.2" then
        table.insert(issues, "WCS_Brain versión incorrecta: " .. (WCS_Brain.VERSION or "desconocida"))
    end
    
    if WCS_BrainCore and WCS_BrainCore.VERSION ~= "6.4.2" then
        table.insert(issues, "WCS_BrainCore versión incorrecta: " .. (WCS_BrainCore.VERSION or "desconocida"))
    end
    
    if WCS_Helpers and WCS_Helpers.VERSION ~= "6.4.2" then
        table.insert(issues, "WCS_Helpers versión incorrecta: " .. (WCS_Helpers.VERSION or "desconocida"))
    end
    
    return issues
end

-- Aplicar correcciones adicionales
function WCS_HotFix_v642:ApplyAdditionalFixes()
    
    -- Verificar que las funciones helper están disponibles
    if not WCS_TableCount then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.4.2]|r Error: WCS_TableCount no está definida. Verifica WCS_Helpers.lua")
    end
end

-- Función principal de aplicación del hotfix
function WCS_HotFix_v642:Apply()
    if self.applied then
        return true
    end
    
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.4.2]|r Aplicando correcciones y actualizaciones...")
    
    -- Verificar entorno
    if not self:VerifyEnvironment() then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.4.2]|r Error: Entorno no compatible")
        return false
    end
    
    -- Migrar datos
    self:MigrateData()
    
    -- Aplicar correcciones adicionales
    self:ApplyAdditionalFixes()
    
    -- Verificar versiones de módulos
    local issues = self:VerifyModuleVersions()
    local _count = WCS_TableCount or table.getn or function(t) return 0 end
    if _count(issues) > 0 then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFFAA00[WCS HotFix v6.4.2]|r Advertencias de versión:")
        for i = 1, _count(issues) do
            DEFAULT_CHAT_FRAME:AddMessage("  |cFFFFAA00- " .. issues[i] .. "|r")
        end
    end
    
    self.applied = true
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.4.2]|r ✓ Actualización completada exitosamente")
    
    return true
end

-- Comando de diagnóstico
SlashCmdList["WCSHOTFIX642"] = function(msg)
    if msg == "verify" then
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.4.2]|r Verificando versiones...")
        
        local issues = WCS_HotFix_v642:VerifyModuleVersions()
        local _count = WCS_TableCount or table.getn or function(t) return 0 end
        if _count(issues) == 0 then
            DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00✓ Todas las versiones son correctas (6.4.2)|r")
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000✗ Se encontraron " .. _count(issues) .. " problemas:|r")
            for i = 1, _count(issues) do
                DEFAULT_CHAT_FRAME:AddMessage("  |cFFFF0000- " .. issues[i] .. "|r")
            end
        end
    elseif msg == "reapply" then
        WCS_HotFix_v642.applied = false
        WCS_HotFix_v642:Apply()
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.4.2]|r Comandos disponibles:")
        DEFAULT_CHAT_FRAME:AddMessage("  |cFFFFCC00/wcshotfix642 verify|r - Verificar versiones")
        DEFAULT_CHAT_FRAME:AddMessage("  |cFFFFCC00/wcshotfix642 reapply|r - Reaplicar correcciones")
        DEFAULT_CHAT_FRAME:AddMessage("  |cFFFFCC00Estado:|r " .. (WCS_HotFix_v642.applied and "|cFF00FF00Aplicado|r" or "|cFFFF0000No aplicado|r"))
    end
end

SLASH_WCSHOTFIX642_1 = "/wcshotfix642"

-- Auto-aplicar al cargar
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "WCS_Brain" then
        -- Esperar un poco para que otros módulos se carguen
        local delayFrame = CreateFrame("Frame")
        local elapsed = 0
        delayFrame:SetScript("OnUpdate", function(self, delta)
            elapsed = elapsed + (delta or 0)
            if elapsed >= 2 then -- 2 segundos de delay
                WCS_HotFix_v642:Apply()
                delayFrame:SetScript("OnUpdate", nil)
            end
        end)
        
        initFrame:SetScript("OnEvent", nil)
    end
end)


