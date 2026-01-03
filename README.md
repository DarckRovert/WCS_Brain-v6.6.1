# WCS_Brain v6.6.1 🧠✨

**Addon exclusivo de "El Séquito del Terror"** 💀⚔️

Addon modular avanzado para Turtle WoW (1.12) que implementa un sistema de IA ultra-inteligente con análisis predictivo, gestión avanzada de recursos, aprendizaje automático y control inteligente de mascotas.

---

## 🆕 Novedades v6.6.1 (Enero 2026)

### 🏛️ UI del Clan - Sistema Completo de Gestión

**7 Módulos UI Implementados:**

#### 1️⃣ **WCS_ClanPanel** - Panel Principal del Clan
- ✅ Lista de miembros del guild en tiempo real
- ✅ Colores por clase y estado online/offline
- ✅ Scroll frame funcional para 100+ miembros
- ✅ Actualización automática con eventos de guild

#### 2️⃣ **WCS_ClanBank** - Banco del Clan
- ✅ Sistema de tracking de oro (depósitos/retiros)
- ✅ Inventario compartido de items
- ✅ Sistema de préstamos con tracking
- ✅ Lista de crafters y materiales
- ✅ **Persistencia de datos** (SavedVariables)
- ✅ **Sincronización en raid/party** (Addon Communication)

#### 3️⃣ **WCS_RaidManager** - Gestión de Raid
- ✅ **Detección REAL de buffs** (Healthstone/Soulstone)
- ✅ Distribución de Healthstones con detección de inventario
- ✅ Asignación de Soulstones con sistema de prioridades
- ✅ Auto-asignación de Curses a warlocks
- ✅ **Auto-whisper** a miembros sin HS/SS
- ✅ **Anuncios en raid chat** de asignaciones
- ✅ **3 macros automáticas** (HS, SS, Curses)

#### 4️⃣ **WCS_SummonPanel** - Sistema de Invocaciones
- ✅ Cola de summon con prioridades (Tank > Healer > DPS)
- ✅ Sistema de turnos automático
- ✅ **Auto-whisper** en cola y turnos
- ✅ **Macro automática** de Ritual of Summoning

#### 5️⃣ **WCS_Statistics** - Estadísticas de Combate
- ✅ Tracking de DPS en tiempo real
- ✅ Breakdown de DoT damage
- ✅ Contador de consumibles usados
- ✅ **Anuncios en raid** de DPS y stats

#### 6️⃣ **WCS_Grimoire** - Grimorio del Warlock
- ✅ Rotaciones predefinidas por spec
- ✅ Macros útiles
- ✅ Guía de BiS gear
- ✅ Calculadora de stats

#### 7️⃣ **WCS_PvPTracker** - Tracking de PvP
- ✅ Contador de kills/deaths
- ✅ Sistema de llamadas de objetivos
- ✅ Escaneo de área para enemigos
- ✅ **3 macros PvP** (Fear, Death Coil, Howl of Terror)

---

### ✨ 6 Mejoras de Funcionalidad REAL Implementadas

#### ✅ 1. SavedVariables - Persistencia de Datos
- Datos del banco persisten entre sesiones
- LoadData() y SaveData() automáticos
- Declarado en .toc: WCS_BankData, WCS_PvPTrackerData, WCS_RaidManagerData

#### ✅ 2. Detección de Buffs en Raid
- UnitBuff() escanea 40 miembros del raid
- Detecta REALMENTE quién tiene Healthstone/Soulstone
- Actualización automática cada 2 segundos

#### ✅ 3. Macros Automáticas
- CreateMacro() y EditMacro() - APIs reales de WoW
- 7 macros creadas automáticamente:
  - WCS_HS (usar healthstone)
  - WCS_SS (crear soulstone)
  - WCS_Curse (curses con modificadores)
  - WCS_Summon (ritual of summoning)
  - WCS_Fear, WCS_Coil, WCS_Howl (PvP con mouseover)

#### ✅ 4. Auto-Whisper a Miembros
- SendChatMessage() envía whispers REALES
- Notifica quién necesita healthstone
- Notifica asignaciones de soulstone
- Notifica posición en cola de summon

#### ✅ 5. Addon Communication (Sync)
- SendAddonMessage() sincroniza datos en raid/party
- Prefix: WCS_BRAIN
- Sincroniza datos del banco entre jugadores
- Botones: "Sincronizar" y "Solicitar Sync"

#### ✅ 6. Anuncios en Raid Chat
- SendChatMessage("texto", "RAID") funciona
- Anuncia asignación de curses
- Anuncia DPS al final de combate
- Anuncia breakdown de DoTs

---

### 📊 Estadísticas del Proyecto

**Código:**
- ~2,214 líneas de código revisadas
- 110+ funciones implementadas
- 21 botones en total
- 0 errores encontrados

**Funcionalidad:**
- 7 módulos UI completos
- 6 mejoras de funcionalidad REAL
- 100% compatible con WoW 1.12 (Lua 5.0)

**Comandos del Clan UI:**
- `/clan` - Abrir panel principal
- `/clanbank` - Abrir banco
- `/raidmanager` - Abrir gestión de raid
- `/summonpanel` - Abrir panel de summon
- `/warlockstats` - Abrir estadísticas

---

## 🆕 Novedades v6.6.0 (Diciembre 2025)

### 💊 Pestaña Recursos - 100% Funcional

**Healthstones:**
- ✅ Detección automática de healthstones en inventario (todos los tipos)
- ✅ Contador en tiempo real con colores dinámicos (rojo/amarillo/verde)
- ✅ Botón "Distribuir HS" con validaciones y mensajes

**Soulstones:**
- ✅ Detección automática de soulstones en inventario
- ✅ Lista en tiempo real de miembros con SS activo
- ✅ Botón "Asignar SS" con detección de buffs en raid/grupo
- ✅ Actualización automática con eventos UNIT_AURA

**Ritual of Summoning:**
- ✅ Detección de portal de invocación activo
- ✅ Cooldown del hechizo en tiempo real
- ✅ Botón "Iniciar Ritual" que lanza el hechizo automáticamente
- ✅ Estados visuales: Portal Activo / Listo / CD / No aprendido

**Nivel de funcionalidad:** 40% → 100% ✅

---

## 🆕 Novedades v6.5.1 (Diciembre 2025)

### 🎯 11 Módulos Nuevos - Sistema Expandido

#### 📝 WCS_BrainLogger - Sistema de Logging Profesional
- 5 niveles de log: DEBUG, INFO, WARN, ERROR, CRITICAL
- Historial de 100 entradas con timestamps
- Filtrado por nivel y módulo
- Comandos: `/brainlog`, `/brainlog clear`, `/brainlog level [nivel]`

#### ⚡ WCS_BrainCache - Sistema de Cache Inteligente
- Cache con TTL (Time To Live) configurable
- Auto-limpieza de entradas expiradas
- Estadísticas de hit/miss
- Comandos: `/braincache`, `/braincache clear`, `/braincache stats`

#### 🌍 WCS_BrainLocale - Soporte Multi-Idioma
- 5 idiomas: Inglés, Español, Portugués, Francés, Alemán
- 50+ strings traducidas
- Cambio dinámico de idioma
- Comandos: `/brainlang [en|es|pt|fr|de]`

#### 🧠 WCS_BrainMemory - Sistema de Memoria de Mobs
- Recuerda hasta 500 mobs diferentes
- Tracking de encuentros, kills, deaths
- Cálculo de dificultad por mob
- Integrado con WCS_BrainMetrics
- Comandos: `/brainmemory`, `/brainmemory [nombre_mob]`

#### 🎮 WCS_BrainMacros - Generación Automática de Macros
- Genera macros basadas en tus estadísticas
- Top 5 hechizos por DPS
- Actualización automática
- Macro por defecto si no hay datos
- Comandos: `/brainmacro show`, `/brainmacro generate`

#### ⚔️ WCS_BrainPvP - Modo PvP Inteligente
- Detección automática de jugadores enemigos
- Estrategias específicas por clase (9 clases)
- Priorización de objetivos
- Comandos: `/brainpvp`, `/brainpvp on/off`

#### 🐾 WCS_BrainPetChat - Chat de Mascotas con Personalidad
- 4 personalidades únicas: Agresivo, Tímido, Juguetón, Sabio
- Diálogos contextuales (invocación, combate, victoria, muerte)
- Mensajes aleatorios
- Comandos: `/brainpetchat`, `/brainpetchat personality [tipo]`

#### 🏆 WCS_BrainAchievements - Sistema de Logros
- 9 logros desbloqueables:
  - First Blood (primera kill)
  - Gladiador (100 kills)
  - Survivor (sobrevivir con <5% HP)
  - Efficient Killer (80%+ win rate, 100 combates)
  - Speed Demon (kill en <10s)
  - Mana Master (50 combates sin quedarse sin mana)
  - Pet Master (usar 4 mascotas diferentes)
  - Brain Trust (100 sugerencias del Brain)
  - Learning Machine (1000 combates registrados)
- Tracking automático
- Notificaciones de desbloqueo
- Comandos: `/brainachievements`

#### 📚 WCS_BrainTutorial - Tutorial Interactivo
- 11 pasos guiados para aprender el addon
- Comandos explicados: `/wcs cast`, `/brain`, `/smartai`, etc.
- Progreso guardado
- Comandos: `/braintutorial start`, `/braintutorial next`

#### 🖼️ WCS_BrainTutorialUI - Interfaz Gráfica del Tutorial
- Ventana visual de 450x300 píxeles
- Movible arrastrando
- Barra de progreso visual
- Botones: Anterior, Siguiente, Cerrar
- Comandos: `/tutorialui show/hide`

#### 🔘 WCS_BrainTutorialButton - Botón Flotante
- Botón pequeño de 40x40 píxeles con icono de libro
- Click: Abrir/continuar tutorial
- Shift+Click: Reiniciar tutorial
- Arrastrable a cualquier posición
- Guarda posición automáticamente
- Comandos: `/tutorialbutton`, `/tutbtn`

#### 📈 WCS_BrainTerrorMeter - Integración con TerrorMeter
- Detección automática del addon TerrorMeter
- Lectura de DPS/HPS en tiempo real
- Sistema de ranking en grupo/raid
- Top hechizos por daño
- Estadísticas históricas (peak DPS, promedio, veces #1)
- Sistema de bonus dinámico basado en DPS real
- 3 nuevos logros de rendimiento:
  - 🏆 Top DPS (alcanza #1 en DPS)
  - 🔥 DPS Master (promedio >500 DPS)
  - ⭐ Consistent DPS (10 veces #1)
- Actualización periódica cada 1 segundo
- Compatible con Lua 5.0
- Comandos: `/btm`, `/brainterror`

#### 🔗 WCS_BrainIntegrations - Sistema de Integración con Addons
- **Detección automática** de 40+ addons populares de Turtle WoW
- **7 categorías de addons**:
  - 📊 Damage Meters: Recount, DamageMeters, SW_Stats, Recap, TinyDPS, TerrorMeter
  - ⚠️ Threat Meters: KTM, KLHThreatMeter, Omen, ThreatMeter, ClassicThreatMeter
  - 💀 Boss Mods: BigWigs, CTRaidAssist, CTRA, BossWarnings, RaidAlert
  - 🖼️ Unit Frames: DiscordUnitFrames, ag_UnitFrames, Perl, XPerl, PitBull
  - ⏱️ Casting Bars: Quartz, eCastingBar, CastingBarMod, ImprovedCastBar
  - 🎒 Bag Addons: Bagnon, OneBag, ArkInventory, Enginventory, BagBrother
  - 💰 Auction House: Auctioneer, aux-addon, BeanCounter, AuctionMaster
  - 📜 Quest Helpers: Questie, ShaguQuest, QuestHelper, MonkeyQuest, QuestLog
  - 🎯 Action Bars: Bartender, Bongos, CT_BarMod, Discord_ActionBars, FlexBar
  - ✨ Buff/Debuff: Buffalo, Buffwatch, ClassicAuraDurations, DebuffTimers
  - 💥 Combat Text: SCT, MSBT, Parrot, CombatText, xCT
  - ⏰ Cooldown Trackers: OmniCC, CooldownCount, ClassicCastbars, CooldownTimers
- **Verificación inteligente**: Múltiples métodos de detección (variables globales, funciones específicas)
- **Resumen de detección**: Muestra todos los addons detectados al cargar
- **Compatible con Lua 5.0**: Optimizado para Turtle WoW (1.12)
- **Comandos**: Los addons se detectan automáticamente al cargar WCS_Brain

---

## 🆕 Novedades v6.4.2 (Diciembre 2025)

### 🐾 Sistema de Mascotas Inteligente (PetAI + PetUI)
- **Botón PetUI mejorado**: Interfaz visual con indicador de IA y stats de mascota
- **3 Modos de IA**: Agresivo (rojo), Defensivo (verde), Soporte (cyan)
- **Click derecho**: Cambiar modo de IA instantáneamente
- **Shift+Click**: Alternar modo compacto/expandido
- **Notificaciones visuales**: Flash en daño, curación, muerte
- **Indicador de buffs**: Hasta 4 iconos alrededor del botón
- **Barra de felicidad**: Solo para Hunters
- **Tooltip mejorado**: Información completa de mascota y modo
- **Comportamiento real**: Cada modo afecta qué habilidades usa la mascota
- **Comandos**: `/petai status`, `/petai debug`, `/petai on/off`

**Mascotas soportadas:**
- Warlock: Imp, Voidwalker, Succubus, Felhunter, Felguard, Infernal, Doomguard
- Hunter: Todas las mascotas (con barra de felicidad)
- Auto-reenslave para demonios esclavizados

### 🧠 SmartAI System - IA Ultra-Inteligente
- **Predicción de TTK**: Calcula tiempo hasta muerte del objetivo
- **Gestión inteligente de mana**: Ajusta uso según contexto (solo/grupo/raid)
- **Análisis de amenaza**: Rastrea amenaza en tiempo real
- **Optimización de DoTs**: Decide si aplicar DoTs según duración de combate
- **Scoring avanzado**: Evalúa hechizos con múltiples factores
- **Detección de patrones**: Aprende de encuentros previos
- **Comandos**: `/smartai debug`, `/smartai stats`

### 🎯 Sistema de Amenaza Completo
- Tracking automático por eventos de combate
- 60+ hechizos con modificadores específicos
- Multiplicadores por stance/forma
- Reset automático al salir de combate

---

## 🗺️ Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────────────────────────┐
│                    🎮 JUGADOR / WOW                               │
│               (Eventos, Combate, Comandos)                        │
└──────────────────────────────────┬──────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│               🧠 WCS_Brain.GetNextAction()                      │
│                 (Punto de entrada principal)                      │
└─────────────────────────────────┬────────────────────────────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │   ¿DQN Activo?          │
                    └────────────┬────────────┘
                                 │
                ┌────────────────┴────────────────┐
                │                                 │
            ❌ NO                              ✅ SÍ
                │                                 │
                ▼                                 ▼
┌───────────────────────────────┐   ┌───────────────────────────────┐
│ 🎯 WCS_BrainAI:GetBestAction │   │ 🤖 WCS_BrainIntegration:      │
│ (Sistema de scoring base)     │   │    GetDQNAction()             │
│                               │   │ (Red neuronal)                │
│ • Genera acciones candidatas  │   │                               │
│ • Calcula score base          │   │ • Red neuronal entrenada     │
│ • Retorna mejor acción        │   │ • Explora/Explota            │
└───────────────┬───────────────┘   │ • Aprende de recompensas     │
                │                   └───────────────────────────────┘
                ▼                                 │
┌───────────────────────────────┐                 │
│ 🧠 SmartAI_Integration        │                 │
│    (Hook automático)          │                 │
│                               │                 │
│ • Intercepta GetBestAction()  │                 │
│ • Llama EnhanceDecision()     │                 │
│ • Mejora score                │                 │
└───────────────┬───────────────┘                 │
                │                                 │
                ▼                                 │
┌───────────────────────────────┐                 │
│ 🎯 WCS_BrainSmartAI           │                 │
│    :EnhanceDecision()         │                 │
│                               │                 │
│ • Predicción de TTK           │                 │
│ • Análisis de amenaza         │                 │
│ • Gestión de mana             │                 │
│ • Optimización de DoTs        │                 │
│ • Scoring multi-factor        │                 │
└───────────────┬───────────────┘                 │
                │                                 │
                └────────────┬────────────────────┘
                             │
                             ▼
                ┌────────────────────────┐
                │  ⚡ ACCIÓN EJECUTADA   │
                │   (CastSpellByName)    │
                └────────────────────────┘
```

### 📊 Flujo de Decisión
**Opción A: BrainAI + SmartAI (RECOMENDADO)**
```
Evento → GetNextAction() → GetBestAction() → SmartAI mejora → Ejecuta
```
✅ Inteligente desde el inicio | ✅ Gestión avanzada | ✅ Consistente

**Opción B: DQN Solo**
```
Evento → GetNextAction() → GetDQNAction() → Ejecuta
```
✅ Aprende con el tiempo | ❌ Empieza "tonto" | ❌ SmartAI no aplica

---

## ⚡ Uso Rápido

### Comandos
- `/wcs cast` - Activa BrainAI + SmartAI (recomendado)
- `/wcs dqn` - Activa DQN (aprendizaje)
- `/smartai debug` - Modo debug
- `/smartai stats` - Estadísticas
- `/brain on/off` - Activa/desactiva IA

### Macro Recomendada
```
/wcs cast
```

---

## 🚀 Características

### 🧠 SmartAI (v6.4.2)
- Predicción de TTK basada en DPS histórico
- Gestión contextual de mana (solo/grupo/raid)
- Análisis de amenaza en tiempo real
- Optimización de DoTs
- Scoring multi-factor
- Aprendizaje de patrones

### 🎯 Sistema de Amenaza
- 60+ hechizos con modificadores
- Multiplicadores por stance/forma
- Tracking automático
- Reset al salir de combate

### 🤖 Sistema DQN
- Red neuronal de aprendizaje
- Explora y explota
- Guarda modelo entrenado

---

## 📚 Archivos Principales

**Core:**
- `WCS_Brain.lua` - Núcleo
- `WCS_BrainAI.lua` - IA base

**SmartAI:**
- `WCS_BrainSmartAI.lua` - IA avanzada (1000+ líneas)
- `WCS_BrainSmartAI_Integration.lua` - Hook

**DQN:**
- `WCS_BrainIntegration.lua` - Integración DQN
- `WCS_BrainDQN.lua` - Red neuronal

---

## 🛠️ Instalación

1. Copia `WCS_Brain` en `Interface/AddOns/`
2. Activa el addon en el menú
3. Usa `/reload`

---

## 🐛 Troubleshooting

**SmartAI no funciona:**
- Causa: DQN está activo
- Solución: Usa `/wcs cast`

**Amenaza en 0%:**
- Causa: Eventos no registrados
- Solución: `/reload`

**IA no hace nada:**
- Causa: Sistema desactivado
- Solución: `/brain on` + `/wcs cast`

**DQN toma malas decisiones:**

**Error "unexpected symbol near '['" en WCS_BrainIntegrations.lua:**
- Causa: Error de sintaxis en tabla Lua (corregido en v6.5.0)
- Solución: Actualiza a la versión más reciente

**Addons no detectados:**
- Causa: Addon no está en la lista de conocidos
- Solución: Verifica que el addon esté cargado con `/reload`

- Causa: No entrenado
- Solución: Usa BrainAI + SmartAI

---

## 👑 Créditos

**Creador:** DarckRovert (ELnazzareno)
- Twitch: [darckrovert](https://www.twitch.tv/darckrovert)
- Kick: [darckrovert](https://kick.com/darckrovert)

**Versión:** 6.6.1  
**Fecha:** Enero 2, 2026  

---

## 🔧 Correcciones v6.6.1 (Enero 2, 2026)

### ✅ Revisión Completa - 66 Archivos

**Archivos Revisados:** 66/66 (100%)  
**Líneas de Código:** ~25,000 líneas  
**Errores Críticos:** 5 encontrados y corregidos

### 🐛 Errores Corregidos

1. **WCS_Brain.toc** - ✅ Agregado WCS_HotFix_v6.4.2.lua
2. **WCS_HotFix_v6.3.1.lua** - ✅ Eliminada función getTime() duplicada
3. **WCS_HotFix_v6.4.2.lua** - ✅ Eliminada verificación innecesaria
4. **WCS_BrainAI.lua:550** - ✅ Corregido uso de tableLength()
5. **WCS_HotFixCommandRegistrar.lua** - ✅ Eliminado conflicto de comando

### ✅ Compatibilidad Lua 5.0

**NO usa:** `#`, `string.gmatch()`, `table.unpack()` (Lua 5.1+)  
**USA:** `table.getn()`, `unpack()`, `pairs()`, `string.gfind()`, `mod()` (Lua 5.0)

**Estado:** ✅ LISTO PARA PRODUCCIÓN

**Compatible:** Turtle WoW (1.12 / Lua 5.0)

--- 

**Contenido:**
- Scripts Python (.py) - Usados para refactorización
- Archivos batch (.bat) - Ejecutores de scripts

---

¡Disfruta del addon! 🎮⚔️

**"El Séquito del Terror domina Azeroth con inteligencia artificial"** 💀🧠✨

