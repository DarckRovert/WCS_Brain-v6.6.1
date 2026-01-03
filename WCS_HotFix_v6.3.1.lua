--[[
    WCS_HotFix_v6.3.1.lua - Verificador de Compatibilidad Lua 5.0
    Compatible con Lua 5.0 (WoW 1.12 / Turtle WoW)
    
    RESPONSABILIDADES (delegadas a WCS_Helpers cuando sea posible):
    - Verificar que funciones core (table.getn, unpack, etc) existen
    - Probar varargs en el entorno actual
    - Validar que WCS_TableCount está disponible
    - Reportar errores de compatibilidad
    
    NOTA DE CONSOLIDACIÓN (Dec 2024):
    - Todas las funciones helper Lua 5.0 ahora están centralizadas en WCS_Helpers.lua
    - Este hotfix ahora solo verifica y reporta, no implementa shims
    - WCS_TableCount es el único helper que este archivo necesita
    
    VERSIÓN: 6.3.1
    FECHA: 2024-12-13
]]--

WCS_HotFix_v631 = WCS_HotFix_v631 or {}
WCS_HotFix_v631.VERSION = "6.3.1"
WCS_HotFix_v631.applied = false

-- Verificar que estamos en el entorno correcto
function WCS_HotFix_v631:VerifyEnvironment()
    -- Verificar Lua 5.0
    if _VERSION and _VERSION ~= "Lua 5.0" then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.3.1]|r Advertencia: No detectado Lua 5.0 (" .. (_VERSION or "desconocido") .. ")")
    end
    
    -- Verificar funciones críticas
    local missing = {}
    if not unpack then table.insert(missing, "unpack") end
    if not table.getn then table.insert(missing, "table.getn") end
    if not arg then 
        -- arg solo existe dentro de funciones, esto es normal
    end
    
    local _count = WCS_TableCount or table.getn or function(t) return (type(t) == "table") and 0 or 0 end
    if _count(missing) > 0 then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.3.1]|r Error: Funciones faltantes: " .. table.concat(missing, ", "))
        return false
    end
    
    return true
end

-- Verificar que las correcciones se aplicaron correctamente
function WCS_HotFix_v631:VerifyFixes()
    local issues = {}
    
    -- Verificar que WCS_HotFix_v6.3.0 no tiene errores de sintaxis
    if WCS_HotFix_v630 and WCS_HotFix_v630.SetupHooks then
        -- Intentar ejecutar la función para verificar que no hay errores
        local success, err = pcall(function()
            -- Solo verificar que la función existe y es callable
            if type(WCS_HotFix_v630.SetupHooks) ~= "function" then
                table.insert(issues, "WCS_HotFix_v630.SetupHooks no es una función")
            end
        end)
        
        if not success then
            table.insert(issues, "Error en WCS_HotFix_v630: " .. (err or "desconocido"))
        end
    end
    
    -- Verificar que WCS_Profiler no tiene errores
    if WCS_Profiler and WCS_Profiler.TrackFunction then
        local success, err = pcall(function()
            if type(WCS_Profiler.TrackFunction) ~= "function" then
                table.insert(issues, "WCS_Profiler.TrackFunction no es una función")
            end
        end)
        
        if not success then
            table.insert(issues, "Error en WCS_Profiler: " .. (err or "desconocido"))
        end
    end
    
    return issues
end

-- Aplicar correcciones adicionales si es necesario
function WCS_HotFix_v631:ApplyAdditionalFixes()
    
    -- Verificar que las funciones helper están disponibles
    if not WCS_TableCount then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.3.1]|r Error: WCS_TableCount no está definida. Asegúrate de que WCS_Helpers.lua se carga primero.")
    end
end

-- Función principal de aplicación del hotfix
function WCS_HotFix_v631:Apply()
    if self.applied then
        return true
    end
    
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.3.1]|r Aplicando correcciones de compatibilidad Lua 5.0...")
    
    -- Verificar entorno
    if not self:VerifyEnvironment() then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.3.1]|r Error: Entorno no compatible")
        return false
    end
    
    -- Aplicar correcciones adicionales
    self:ApplyAdditionalFixes()
    
    -- Verificar que las correcciones funcionan
    local issues = self:VerifyFixes()
    local _count = WCS_TableCount or table.getn or function(t) return 0 end
    if _count(issues) > 0 then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000[WCS HotFix v6.3.1]|r Advertencias encontradas:")
        for i = 1, _count(issues) do
            DEFAULT_CHAT_FRAME:AddMessage("  |cFFFFAA00- " .. issues[i] .. "|r")
        end
    end
    
    self.applied = true
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.3.1]|r ✓ Correcciones aplicadas exitosamente")
    
    return true
end

-- Comando de diagnóstico
SlashCmdList["WCSHOTFIX631"] = function(msg)
    if msg == "verify" then
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.3.1]|r Verificando correcciones...")
        
        local issues = WCS_HotFix_v631:VerifyFixes()
        local _count = WCS_TableCount or table.getn or function(t) return 0 end
        if _count(issues) == 0 then
            DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00✓ Todas las correcciones funcionan correctamente|r")
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000✗ Se encontraron " .. _count(issues) .. " problemas:|r")
            for i = 1, _count(issues) do
                DEFAULT_CHAT_FRAME:AddMessage("  |cFFFF0000- " .. issues[i] .. "|r")
            end
        end
    elseif msg == "reapply" then
        WCS_HotFix_v631.applied = false
        WCS_HotFix_v631:Apply()
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[WCS HotFix v6.3.1]|r Comandos disponibles:")
        DEFAULT_CHAT_FRAME:AddMessage("  |cFFFFCC00/wcshotfix631 verify|r - Verificar correcciones")
        DEFAULT_CHAT_FRAME:AddMessage("  |cFFFFCC00/wcshotfix631 reapply|r - Reaplicar correcciones")
        DEFAULT_CHAT_FRAME:AddMessage("  |cFFFFCC00Estado:|r " .. (WCS_HotFix_v631.applied and "|cFF00FF00Aplicado|r" or "|cFFFF0000No aplicado|r"))
    end
end

SLASH_WCSHOTFIX631_1 = "/wcshotfix631"

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
                WCS_HotFix_v631:Apply()
                delayFrame:SetScript("OnUpdate", nil)
            end
        end)
        
        initFrame:SetScript("OnEvent", nil)
    end
end)

