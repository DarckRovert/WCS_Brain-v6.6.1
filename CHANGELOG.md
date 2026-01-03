# Changelog - WCS_Brain

Todas las versiones notables de este proyecto serán documentadas en este archivo.

---

## [6.6.1] - Enero 2, 2026

### 🔧 Correcciones

#### Errores Críticos Corregidos
1. **WCS_Brain.toc** - Agregado WCS_HotFix_v6.4.2.lua faltante en el orden de carga
2. **WCS_HotFix_v6.3.1.lua** - Eliminada función getTime() duplicada que causaba conflictos
3. **WCS_HotFix_v6.4.2.lua** - Eliminada verificación innecesaria que generaba warnings
4. **WCS_BrainAI.lua:550** - Corregido uso incorrecto de tableLength() para compatibilidad Lua 5.0
5. **WCS_HotFixCommandRegistrar.lua** - Eliminado conflicto de comando duplicado

#### Limpieza de Código
- Eliminada carpeta UI/ con versiones antiguas de archivos
- Sincronizada versión en todos los archivos (6.6.1)
- Actualizadas fechas a Enero 2026
- Verificada compatibilidad Lua 5.0 en todos los módulos

### ✅ Verificaciones
- **66/66 archivos revisados** (100% del código)
- **~25,000 líneas de código** analizadas
- **0 errores de sintaxis** encontrados
- **Compatibilidad Lua 5.0** confirmada

### 📝 Notas
- NO usa características de Lua 5.1+ (#, string.gmatch, table.unpack)
- USA: table.getn(), unpack(), pairs(), string.gfind(), mod()
- Compatible con Turtle WoW (1.12)

---

## [6.6.0] - Diciembre 2025

### ✨ Nuevas Características

#### Pestaña Recursos - 100% Funcional
- **Healthstones:** Detección automática en inventario con contador en tiempo real
- **Soulstones:** Lista de miembros con SS activo y actualización automática
- **Ritual of Summoning:** Detección de portal activo y cooldown en tiempo real

#### UI del Clan - 7 Módulos Completos
1. **WCS_ClanPanel** - Panel principal con lista de miembros del guild
2. **WCS_ClanBank** - Sistema de tracking de oro con sincronización
3. **WCS_RaidManager** - Gestión de HS/SS/Curses con detección real de buffs
4. **WCS_SummonPanel** - Cola de invocaciones con prioridades
5. **WCS_Statistics** - Tracking de DPS y DoTs en tiempo real
6. **WCS_Grimoire** - Rotaciones, macros y guía de BiS gear
7. **WCS_PvPTracker** - Contador de kills/deaths y macros PvP

#### Funcionalidad REAL Implementada
- ✅ Detección de buffs con UnitBuff() en 40 miembros de raid
- ✅ Creación automática de 7+ macros (CreateMacro/EditMacro)
- ✅ Whispers automáticos (SendChatMessage)
- ✅ Anuncios en raid chat
- ✅ Sincronización de datos (SendAddonMessage)
- ✅ Persistencia entre sesiones (SavedVariables)

### 📊 Estadísticas
- **~2,214 líneas** de código añadidas
- **110+ funciones** implementadas
- **21 botones** en total
- **7 módulos UI** completos

---

## [6.5.1] - Diciembre 2025

### ✨ 11 Módulos Nuevos

1. **WCS_BrainLogger** - Sistema de logging profesional (5 niveles)
2. **WCS_BrainCache** - Cache inteligente con TTL
3. **WCS_BrainLocale** - Soporte multi-idioma (5 idiomas)
4. **WCS_BrainMemory** - Sistema de memoria de mobs (500 mobs)
5. **WCS_BrainMacros** - Generación automática de macros
6. **WCS_BrainPvP** - Modo PvP inteligente
7. **WCS_BrainPetChat** - Chat de mascotas con personalidad
8. **WCS_BrainAchievements** - Sistema de logros (9 logros)
9. **WCS_BrainTutorial** - Tutorial interactivo (11 pasos)
10. **WCS_BrainTutorialUI** - Interfaz gráfica del tutorial
11. **WCS_BrainTutorialButton** - Botón flotante del tutorial

### 🔗 Integraciones
- **WCS_BrainTerrorMeter** - Integración con TerrorMeter
- **WCS_BrainIntegrations** - Detección de 40+ addons populares

---

## [6.4.2] - Diciembre 2025

### 🐾 Sistema de Mascotas Inteligente
- Botón PetUI mejorado con indicador de IA
- 3 Modos de IA: Agresivo, Defensivo, Soporte
- Notificaciones visuales y barra de felicidad
- Soporte para Warlock y Hunter

### 🧠 SmartAI System
- Predicción de TTK (Time To Kill)
- Gestión inteligente de mana
- Análisis de amenaza en tiempo real
- Optimización de DoTs
- Scoring multi-factor

### 🎯 Sistema de Amenaza
- 60+ hechizos con modificadores
- Multiplicadores por stance/forma
- Tracking automático
- Reset al salir de combate

---

## Formato

Este changelog sigue el formato de [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/)
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

### Tipos de Cambios
- **Añadido** para nuevas características
- **Cambiado** para cambios en funcionalidad existente
- **Obsoleto** para características que serán removidas
- **Eliminado** para características removidas
- **Corregido** para corrección de bugs
- **Seguridad** para vulnerabilidades
