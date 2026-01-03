--[[
    WCS_HotFix_v6.3.0.lua - HotFix para Nuevas Características
    Compatible con Lua 5.0 (WoW 1.12 / Turtle WoW)
    
    Responsabilidades:
    - Inicialización de nuevos módulos (Testing, Metrics, Contextual, Integrations)
    - Migración de datos de versiones anteriores
    - Correcciones de compatibilidad (delegadas a WCS_Helpers)
    - Configuración de hooks y verificación de integridad
    
    NOTA DE CONSOLIDACIÓN (Dec 2024):
    - ApplyCompatibilityFixes ahora solo asegura WCS_TableCount y table.getn
    - SetupHooks simplificado para evitar complejidad de varargs
    - Todos los helpers Lua 5.0 están centralizados en WCS_Helpers.lua
]]--

WCS_HotFix_v630 = WCS_HotFix_v630 or {}
WCS_HotFix_v630.VERSION = "6.3.0"
WCS_HotFix_v630.applied = false

-- ============================================================================
-- MIGRACIÓN DE DATOS
-- ============================================================================
function WCS_HotFix_v630:MigrateData()
    -- Inicializar nuevas SavedVariables si no existen
    if not WCS_BrainMetricsSaved then
        WCS_BrainMetricsSaved = {
            version = "6.3.0",
            metrics = {},
            combatHistory = {},
            lastMigration = GetTime()
        }
    end
    
    if not WCS_BrainContextualSaved then
        WCS_BrainContextualSaved = {
            version = "6.3.0",
            customProfiles = {},
            lastContext = "solo",
            lastMigration = GetTime()
        }
    end
    
    -- Migrar datos de métricas desde WCS_BrainSaved si existen
    if WCS_BrainSaved and WCS_BrainSaved.Metrics and not WCS_BrainMetricsSaved.migrated then
        WCS_BrainMetricsSaved.metrics = WCS_BrainSaved.Metrics
        WCS_BrainMetricsSaved.migrated = true
        self:Log("Métricas migradas desde versión anterior")
    end
    
    -- Migrar perfiles contextuales si existen
    if WCS_BrainSaved and WCS_BrainSaved.CustomProfiles and not WCS_BrainContextualSaved.migrated then
        WCS_BrainContextualSaved.customProfiles = WCS_BrainSaved.CustomProfiles
        WCS_BrainContextualSaved.migrated = true
        self:Log("Perfiles contextuales migrados desde versión anterior")
    end
end

-- ============================================================================
-- VERIFICACIÓN DE INTEGRIDAD
-- ============================================================================
function WCS_HotFix_v630:VerifyIntegrity()
    local errors = {}
    
    -- Verificar que los nuevos módulos estén cargados
    if not WCS_BrainTesting then
        table.insert(errors, "WCS_BrainTesting no cargado")
    end
    
    if not WCS_BrainMetrics then
        table.insert(errors, "WCS_BrainMetrics no cargado")
    end
    
    if not WCS_BrainContextual then
        table.insert(errors, "WCS_BrainContextual no cargado")
    end
    
    if not WCS_BrainIntegrations then
        table.insert(errors, "WCS_BrainIntegrations no cargado")
    end
    
    -- Verificar funciones críticas de Lua 5.0
    if not WCS_TableCount then
        table.insert(errors, "WCS_TableCount no disponible")
    end
    
    if WCS_TableCount(errors) > 0 then
        self:Log("ERRORES DETECTADOS:")
        for _, err in ipairs(errors) do
            self:Log("- " .. err)
        end
        return false
    end
    
    return true
end

-- ============================================================================
-- INICIALIZACIÓN DE NUEVOS MÓDULOS
-- ============================================================================
function WCS_HotFix_v630:InitializeNewModules()
    -- Inicializar Testing si no está inicializado
    if WCS_BrainTesting and not WCS_BrainTesting.initialized then
        if WCS_BrainTesting.Initialize then
            WCS_BrainTesting:Initialize()
            self:Log("Sistema de Testing inicializado")
        end
    end
    
    -- Inicializar Metrics si no está inicializado
    if WCS_BrainMetrics and not WCS_BrainMetrics.initialized then
        if WCS_BrainMetrics.Initialize then
            WCS_BrainMetrics:Initialize()
            self:Log("Sistema de Métricas inicializado")
        end
    end
    
    -- Inicializar Contextual si no está inicializado
    if WCS_BrainContextual and not WCS_BrainContextual.initialized then
        if WCS_BrainContextual.Initialize then
            WCS_BrainContextual:Initialize()
            self:Log("Sistema Contextual inicializado")
        end
    end
    
    -- Inicializar Integrations si no está inicializado
    if WCS_BrainIntegrations and not WCS_BrainIntegrations.initialized then
        if WCS_BrainIntegrations.Initialize then
            WCS_BrainIntegrations:Initialize()
            self:Log("Sistema de Integraciones inicializado")
        end
    end
end

-- ============================================================================
-- CORRECCIONES DE COMPATIBILIDAD (Delegadas a WCS_Helpers)
-- ============================================================================
function WCS_HotFix_v630:ApplyCompatibilityFixes()
    -- Ensure WCS_Helpers is loaded first; fallback if needed
    if not WCS_TableCount then
        WCS_TableCount = function(t)
            if not t then return 0 end
            if table.getn then return table.getn(t) end
            local n = 0
            for _ in pairs(t) do n = n + 1 end
            return n
        end
    end
    
    -- table.getn and string functions are now delegated to WCS_Helpers
    if not table.getn then
        table.getn = WCS_TableCount
    end
    
    -- Asegurar que GetTime() funcione correctamente
    if not GetTime then
        GetTime = function()
            return time()
        end
    end
    
    self:Log("Correcciones de compatibilidad aplicadas")
end

-- ============================================================================
-- CONFIGURACIÓN DE HOOKS
-- ============================================================================
function WCS_HotFix_v630:SetupHooks()
    -- Hook para integrar métricas con combate
    if WCS_BrainMetrics and WCS_Brain then
        -- Hook para inicio de combate
        local originalStartCombat = WCS_Brain.OnCombatStart
        if originalStartCombat then
            WCS_Brain.OnCombatStart = function(...)
                WCS_BrainMetrics:StartCombat()
                -- En Lua 5.0, varargs pasan como 'arg table' o no pasan
                -- Llamar original sin copiar args (puede causar incompatibilidades)
                return originalStartCombat()
            end
        end
        
        -- Hook para fin de combate
        local originalEndCombat = WCS_Brain.OnCombatEnd
        if originalEndCombat then
            WCS_Brain.OnCombatEnd = function(result)
                WCS_BrainMetrics:EndCombat(result)
                return originalEndCombat(result)
            end
        end
    end
    
    -- Hook para integrar contexto con decisiones
    if WCS_BrainContextual and WCS_BrainAI then
        WCS_BrainContextual:HookBrainAI()
    end
    
    -- Hook para integrar addons con decisiones
    if WCS_BrainIntegrations and WCS_BrainAI then
        WCS_BrainIntegrations:HookBrainAI()
    end
    
    self:Log("Hooks configurados correctamente")
end

-- ============================================================================
-- COMANDOS DE DIAGNÓSTICO
-- ============================================================================
function WCS_HotFix_v630:RegisterDiagnosticCommands()
    -- Usar comando diferente para no sobrescribir ventana grafica de WCS_BrainDiagnostics
    SLASH_WCSHOTFIX1 = "/wcshotfix"
    SlashCmdList["WCSHOTFIX"] = function(msg)
        local args = {}
        for word in string.gfind(msg, "%S+") do
            table.insert(args, string.lower(word))
        end
        
        if not args[1] or args[1] == "help" then
            self:ShowDiagnosticHelp()
        elseif args[1] == "status" then
            self:ShowSystemStatus()
        elseif args[1] == "modules" then
            self:ShowModuleStatus()
        elseif args[1] == "integrity" then
            self:VerifyIntegrity()
        elseif args[1] == "migrate" then
            self:MigrateData()
        elseif args[1] == "reinit" then
            self:InitializeNewModules()
        else
            self:Log("Comando desconocido. Usa /wcshotfix help")
        end
    end
end

function WCS_HotFix_v630:ShowDiagnosticHelp()
    self:Log("=== COMANDOS DE DIAGNÓSTICO v6.3.0 ===")
    self:Log("/wcshotfix status - Estado general del sistema")
    self:Log("/wcshotfix modules - Estado de modulos individuales")
    self:Log("/wcshotfix integrity - Verificar integridad")
    self:Log("/wcshotfix migrate - Migrar datos manualmente")
    self:Log("/wcshotfix reinit - Re-inicializar modulos")
    self:Log("/wcsdiag - Abrir ventana grafica de diagnostico")
end

function WCS_HotFix_v630:ShowSystemStatus()
    self:Log("=== ESTADO DEL SISTEMA v6.3.0 ===")
    self:Log("Versión: " .. self.VERSION)
    self:Log("HotFix aplicado: " .. (self.applied and "SÍ" or "NO"))
    self:Log("Integridad: " .. (self:VerifyIntegrity() and "OK" or "ERROR"))
    
    -- Mostrar SavedVariables
    self:Log("WCS_BrainSaved: " .. (WCS_BrainSaved and "OK" or "MISSING"))
    self:Log("WCS_BrainMetricsSaved: " .. (WCS_BrainMetricsSaved and "OK" or "MISSING"))
    self:Log("WCS_BrainContextualSaved: " .. (WCS_BrainContextualSaved and "OK" or "MISSING"))
end

function WCS_HotFix_v630:ShowModuleStatus()
    self:Log("=== ESTADO DE MÓDULOS ===")
    
    local modules = {
        {"WCS_Brain", WCS_Brain},
        {"WCS_BrainAI", WCS_BrainAI},
        {"WCS_BrainTesting", WCS_BrainTesting},
        {"WCS_BrainMetrics", WCS_BrainMetrics},
        {"WCS_BrainContextual", WCS_BrainContextual},
        {"WCS_BrainIntegrations", WCS_BrainIntegrations}
    }
    
    for _, moduleData in modules do
        local name = moduleData[1]
        local module = moduleData[2]
        local status = module and "CARGADO" or "FALTANTE"
        local initialized = module and module.initialized and "INIT" or "NO-INIT"
        self:Log(name .. ": " .. status .. " (" .. initialized .. ")")
    end
end

-- ============================================================================
-- APLICACIÓN DEL HOTFIX
-- ============================================================================
function WCS_HotFix_v630:Apply()
    if self.applied then
        return
    end
    
    self:Log("=== APLICANDO HOTFIX v6.3.0 ===")
    
    -- 1. Migrar datos
    self:MigrateData()
    
    -- 2. Aplicar correcciones de compatibilidad
    self:ApplyCompatibilityFixes()
    
    -- 3. Inicializar nuevos módulos
    self:InitializeNewModules()
    
    -- 4. Configurar hooks
    self:SetupHooks()
    
    -- 5. Registrar comandos de diagnóstico
    self:RegisterDiagnosticCommands()
    
    -- 6. Verificar integridad final
    local integrityOK = self:VerifyIntegrity()
    
    self.applied = true
    
    if integrityOK then
        self:Log("✓ HotFix v6.3.0 aplicado exitosamente")
        self:Log("✓ Nuevas características disponibles:")
        self:Log("  - Sistema de Testing (/wcstest)")
        self:Log("  - Métricas Avanzadas (/wcsmetrics)")
        self:Log("  - Configuración Contextual (/wcscontext)")
        self:Log("  - Integración con Addons (/wcsint)")
        self:Log("  - Diagnósticos (/wcsdiag)")
    else
        self:Log("⚠ HotFix aplicado con errores. Usa /wcsdiag integrity")
    end
end

-- ============================================================================
-- UTILIDADES
-- ============================================================================
function WCS_HotFix_v630:Log(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cFF9482C9[WCS HotFix v6.3.0]|r " .. message)
end

-- ============================================================================
-- AUTO-APLICACIÓN
-- ============================================================================
local function ApplyHotFix()
    if WCS_HotFix_v630 and not WCS_HotFix_v630.applied then
        WCS_HotFix_v630:Apply()
    end
end

-- Aplicar cuando todos los módulos estén cargados
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("VARIABLES_LOADED")

local loadedAddons = 0
frame:SetScript("OnEvent", function()
    if event == "ADDON_LOADED" and arg1 == "WCS_Brain" then
        loadedAddons = loadedAddons + 1
    elseif event == "VARIABLES_LOADED" then
        -- Aplicar hotfix después de un pequeño delay para asegurar que todo esté cargado
        local delayFrame = CreateFrame("Frame")
        local startTime = GetTime()
        delayFrame:SetScript("OnUpdate", function()
            if GetTime() - startTime > 2 then -- 2 segundos de delay
                ApplyHotFix()
                delayFrame:SetScript("OnUpdate", nil)
            end
        end)
    end
end)
