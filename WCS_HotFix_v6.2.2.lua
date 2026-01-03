--[[
    WCS_HotFix_v6.2.2.lua - Correcciones Críticas Post-Release
    Compatible con Lua 5.0 (WoW 1.12 / Turtle WoW)
    
    Responsabilidades:
    - Verificación de funciones WoW críticas (GetTime, CreateFrame, etc)
    - Fallback para WCS_LazyLoader.getTime
    - Inicialización de métodos DoT en WCS_BrainAI si faltan
    
    NOTA DE CONSOLIDACIÓN (Dec 2024):
    - Funciones helper Lua 5.0 (table.getn) ahora delegadas a WCS_Helpers.lua
    - Este archivo solo contiene correcciones específicas del módulo
    - WCS_TableCount fallback incluido como respaldo
    
    VERSIÓN: 6.2.2
]]--

-- ============================================================================
-- HOTFIX PARA ERRORES DE COMPATIBILIDAD LUA 5.0
-- ============================================================================

-- Verificar que WCS_LazyLoader tenga la función getTime correcta
if WCS_LazyLoader and not WCS_LazyLoader.getTime_Fixed then
    -- Marcar como corregido
    WCS_LazyLoader.getTime_Fixed = true
    
    -- Función auxiliar compatible
    local function getTime()
        return GetTime and GetTime() or 0
    end
    
    -- Corregir función LoadModule si existe
    if WCS_LazyLoader.LoadModule then
        local originalLoadModule = WCS_LazyLoader.LoadModule
        WCS_LazyLoader.LoadModule = function(self, moduleName)
            local module = self.Modules[moduleName]
            if not module then
                DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000WCS_LazyLoader: Módulo desconocido: " .. tostring(moduleName))
                return false
            end
            
            if module.loaded then
                return true -- Ya está cargado
            end
            
            -- Verificar condición si existe
            if module.condition and not module.condition() then
                return false -- Condición no cumplida
            end
            
            DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00Cargando módulo: " .. moduleName)
            
            -- Cargar archivos del módulo
            for i, filename in ipairs(module.files) do
                local success = self:LoadFile(filename)
                if not success then
                    DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000Error cargando: " .. filename)
                    return false
                end
            end
            
            module.loaded = true
            self.LoadedModules[moduleName] = getTime() -- Usar función local corregida
            
            DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Módulo cargado: " .. moduleName)
            return true
        end
    end
    
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00WCS HotFix v6.2.2 aplicado - LazyLoader corregido")
end

-- ============================================================================
-- CORRECCIÓN DE MÉTODOS FALTANTES EN WCS_BrainAI
-- ============================================================================

-- Verificar que WCS_BrainAI tenga el método CleanupExpiredDoTs correcto
if WCS_BrainAI and not WCS_BrainAI.DoTMethods_Fixed then
    -- Marcar como corregido
    WCS_BrainAI.DoTMethods_Fixed = true
    
    -- Verificar que existe CleanupExpiredDoTs
    if not WCS_BrainAI.CleanupExpiredDoTs then
        -- Crear método de respaldo si no existe
        WCS_BrainAI.CleanupExpiredDoTs = function(self)
            if not self.ActiveDoTs then return end
            
            local now = GetTime()
            for targetID, dots in pairs(self.ActiveDoTs) do
                for dotName, dot in pairs(dots) do
                    if dot.applied and (now - dot.applied) > 30 then
                        -- DoT expirado (30s es un tiempo seguro)
                        dots[dotName] = nil
                    end
                end
                
                -- Limpiar target si no tiene DoTs
                local hasDoTs = false
                for k, v in pairs(dots) do
                    hasDoTs = true
                    break
                end
                if not hasDoTs then
                    self.ActiveDoTs[targetID] = nil
                end
            end
        end
    end
    
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00WCS HotFix v6.2.2 aplicado - DoT methods corregidos")
end

-- ============================================================================
-- VERIFICACIONES ADICIONALES DE COMPATIBILIDAD
-- ============================================================================

-- Verificar funciones críticas de WoW 1.12
local function VerifyWoWFunctions()
    local missing = {}
    
    -- Funciones esenciales
    if not GetTime then table.insert(missing, "GetTime") end
    if not CreateFrame then table.insert(missing, "CreateFrame") end
    if not DEFAULT_CHAT_FRAME then table.insert(missing, "DEFAULT_CHAT_FRAME") end
    if not UIParent then table.insert(missing, "UIParent") end
    
    -- Funciones de UI
    if not GetScreenWidth then table.insert(missing, "GetScreenWidth") end
    if not GetScreenHeight then table.insert(missing, "GetScreenHeight") end
    
    local _wcs_count = WCS_TableCount or table.getn or function(t) return (type(t) == "table") and 0 or 0 end
    if _wcs_count(missing) > 0 then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000WCS HotFix: Funciones faltantes detectadas:")
        for i, func in ipairs(missing) do
            DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000  - " .. func)
        end
        return false
    end
    
    return true
end

-- ============================================================================
-- CORRECCIONES DE FUNCIONES GLOBALES (Delegadas a WCS_Helpers)
-- ============================================================================

-- Asegurar que WCS_Helpers está disponible
if not WCS_TableCount then
    -- Fallback inline si WCS_Helpers no se carga
    WCS_TableCount = function(t)
        if not t then return 0 end
        if table.getn then return table.getn(t) end
        local n = 0
        for _ in pairs(t) do n = n + 1 end
        return n
    end
end

-- Asegurar que table.getn existe (Lua 5.0)
if not table.getn then
    table.getn = WCS_TableCount
end

-- ============================================================================
-- VERIFICACIÓN Y REPORTE
-- ============================================================================

-- Ejecutar verificaciones
local wowFunctionsOK = VerifyWoWFunctions()

-- Reporte final
DEFAULT_CHAT_FRAME:AddMessage("|cFF9482C9=== WCS HotFix v6.2.2 ===")
DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00Funciones WoW: " .. (wowFunctionsOK and "|cFF00FF00OK" or "|cFFFF0000ERROR"))
DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00table.getn: " .. (table.getn and "|cFF00FF00OK" or "|cFFFF0000MISSING"))
DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00string.find: " .. (string.find and "|cFF00FF00OK" or "|cFFFF0000MISSING"))
DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00LazyLoader: " .. (WCS_LazyLoader and WCS_LazyLoader.getTime_Fixed and "|cFF00FF00FIXED" or "|cFFFFFF00OK"))
DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00DoT Methods: " .. (WCS_BrainAI and WCS_BrainAI.DoTMethods_Fixed and "|cFF00FF00FIXED" or "|cFFFFFF00OK"))

if wowFunctionsOK then
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00WCS Brain v6.2.2 - Todos los errores corregidos")
else
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000WCS Brain v6.2.2 - Errores de compatibilidad detectados")
end
