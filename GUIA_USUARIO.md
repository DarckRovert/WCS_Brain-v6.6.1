# 📖 Guía de Usuario - WCS_Brain Clan UI v6.6.1

## 🚀 Inicio Rápido

### Instalación
1. El addon ya está instalado en `E:\TurtleWow\Interface\AddOns\WCS_Brain`
2. Asegúrate de que esté activado en el menú de addons del juego
3. Haz `/reload` para cargar

### Comandos Principales
```
/sequito    - Abrir panel principal
/clan       - Alias corto
/terror     - Alias temático
```

### Accesos Directos a Módulos
```
/clanbank   - Banco del Clan
/rm         - Raid Manager
/summon     - Panel de Summon
/wstats     - Estadísticas
/grim       - Grimorio
/pvpt       - PvP Tracker
```

---

## 📋 Módulos Disponibles

### 1. 🏦 Banco del Clan (/clanbank)

**Funcionalidad:**
- Sistema de tracking de oro del clan
- Inventario compartido
- Sistema de préstamos
- Sincronización entre miembros en raid/party

**Botones:**
- **Depositar Oro**: Registra depósito (debes transferir oro manualmente al banker)
- **Retirar Oro**: Registra retiro (el banker te transfiere manualmente)
- **Ver Inventario**: Muestra items del banco con colores por calidad
- **Solicitar Préstamo**: Sistema de tracking de préstamos
- **Lista Materiales**: Materiales necesarios para crafteos
- **Sincronizar**: Comparte datos del banco con el raid
- **Solicitar Sync**: Pide datos actualizados

**⚠️ IMPORTANTE:**
El addon NO transfiere oro automáticamente (limitación de WoW API).
Hace TRACKING de transacciones. Debes transferir oro manualmente.

**Persistencia:**
Los datos se guardan automáticamente y persisten entre sesiones.

---

### 2. 👥 Raid Manager (/rm)

**Funcionalidad REAL:**
- Detecta quién tiene Healthstone/Soulstone (usando UnitBuff)
- Distribución inteligente de Healthstones
- Asignación de Soulstones con prioridades (Tank > Healer > DPS)
- Auto-asignación de Curses a warlocks
- Whispers automáticos a miembros
- Anuncios en raid chat

**Botones:**
- **Distribuir HS**: Detecta quién necesita healthstone y whisper
- **Asignar SS**: Asigna soulstones por prioridad y notifica
- **Auto Curses**: Asigna curses y anuncia en raid
- **Crear Macro HS**: Macro para usar healthstone
- **Crear Macro SS**: Macro para crear soulstone
- **Crear Macro Curse**: Macro inteligente con modificadores

**Macros Creadas:**
1. **WCS_UseHS**: Usa healthstone desde cualquier bolsa
2. **WCS_CreateSS**: Crea soulstone en el objetivo
3. **WCS_SmartCurse**: 
   - Normal: Curse of Agony
   - Shift: Curse of Shadow
   - Ctrl: Curse of Elements
   - Alt: Curse of Recklessness

---

### 3. 🔮 Summon Panel (/summon)

**Funcionalidad:**
- Cola de summon con prioridades
- Sistema de turnos automático
- Whispers automáticos a jugadores en cola
- Macro de Ritual of Summoning

**Botones:**
- **Agregar a Cola**: Añade jugador con prioridad
- **Siguiente**: Procesa siguiente en cola
- **Limpiar Cola**: Resetea la cola
- **Crear Macro Summon**: Macro para iniciar ritual

**Prioridades:**
- Alta: Tanks, Healers principales
- Media: DPS, Healers secundarios
- Baja: Resto

---

### 4. 📊 Statistics (/wstats)

**Funcionalidad REAL:**
- Tracking de DPS en tiempo real
- Breakdown de daño por DoT
- Contador de consumibles usados
- Anuncios en raid chat

**Botones:**
- **Resetear Stats**: Limpia estadísticas
- **Anunciar DPS**: Anuncia tu DPS en raid chat

**Tracking Automático:**
- Se actualiza durante combate
- Detecta inicio/fin de combate
- Cuenta Shadow Bolt, DoTs, consumibles

---

### 5. 📚 Grimoire (/grim)

**Contenido:**
- Rotaciones predefinidas por spec (Affliction, Destruction, Demonology)
- Macros útiles para warlock
- Guía de BiS gear
- Calculadora de stats

**Uso:**
Navega por las tabs para ver información.

---

### 6. ⚔️ PvP Tracker (/pvpt)

**Funcionalidad:**
- Contador de kills/deaths
- Sistema de llamadas de objetivos
- Escaneo de área para detectar enemigos
- Macros PvP con mouseover

**Botones:**
- **Resetear Stats**: Limpia contador
- **Escanear Área**: Busca enemigos cercanos
- **Crear Macros PvP**: Crea 3 macros

**Macros PvP:**
1. **WCS_Fear**: Fear con mouseover
2. **WCS_Coil**: Death Coil con mouseover
3. **WCS_Howl**: Howl of Terror

---

### 7. 👥 Clan Panel

**Funcionalidad:**
- Lista de miembros del guild
- Actualización automática
- Colores por clase
- Estado online/offline

---

## ❓ FAQ - Preguntas Frecuentes

### ¿El banco transfiere oro automáticamente?
**No.** El addon hace TRACKING de transacciones. Debes transferir oro manualmente al banker del clan. El sistema registra y sincroniza los datos.

### ¿Las macros se crean automáticamente?
**Sí.** Al hacer clic en los botones "Crear Macro", el addon crea/actualiza las macros automáticamente. Límite: 18 macros globales.

### ¿La detección de Healthstone/Soulstone es real?
**Sí.** Usa UnitBuff() para escanear los 40 miembros del raid y detectar quién tiene los buffs.

### ¿Los datos se guardan entre sesiones?
**Sí.** Los datos del banco, préstamos y configuración se guardan automáticamente usando SavedVariables.

### ¿Funciona la sincronización en party/raid?
**Sí.** Usa SendAddonMessage() para sincronizar datos del banco entre jugadores que tengan el addon.

### ¿Los whispers son automáticos?
**Sí.** El addon envía whispers automáticamente cuando asignas soulstones, detectas quién necesita healthstone, o procesas la cola de summon.

---

## 🔧 Troubleshooting

### "Comando no encontrado"
**Solución:** Haz `/reload` para recargar el addon.

### "El panel no se abre"
**Solución:** Verifica que WCS_Brain esté activado en el menú de addons.

### "Las macros no se crean"
**Causa:** Límite de 18 macros globales alcanzado.
**Solución:** Elimina macros que no uses y vuelve a intentar.

### "No detecta Healthstones"
**Causa:** No estás en un raid o los miembros no tienen el buff.
**Solución:** Asegúrate de estar en raid y que los jugadores tengan healthstone en inventario (buff activo).

### "La sincronización no funciona"
**Causa:** No estás en party/raid.
**Solución:** SendAddonMessage() solo funciona en grupo. Únete a un party o raid.

### "Los datos del banco se perdieron"
**Causa:** Archivo WTF corrupto o eliminado.
**Solución:** Los datos están en `WTF\Account\TU_CUENTA\SavedVariables\WCS_Brain.lua`. Haz backup regularmente.

---

## 💡 Consejos por Tipo de Jugador

### Para Guild Masters:
- Usa /clanbank para gestionar el banco del clan
- Sincroniza datos regularmente con oficiales
- Revisa préstamos pendientes

### Para Raid Leaders:
- Usa /rm para coordinar Healthstones/Soulstones
- Auto-asigna curses antes de pulls
- Anuncia DPS al final de bosses

### Para Warlocks en Raid:
- Crea las macros de HS/SS/Curse al inicio
- Usa /wstats para trackear tu DPS
- Distribuye Healthstones antes de pulls

### Para PvP:
- Crea las macros PvP (Fear/Coil con mouseover)
- Usa /pvpt para trackear kills
- Escanea área para detectar enemigos

---

## 📊 Resumen de Funcionalidad

### ✅ Funcionalidad 100% REAL:
- Detección de buffs (UnitBuff)
- Creación de macros (CreateMacro)
- Whispers automáticos (SendChatMessage)
- Anuncios en raid (SendChatMessage)
- Sincronización de datos (SendAddonMessage)
- Persistencia de datos (SavedVariables)
- Tracking de DPS/DoTs (eventos de combate)

### ⚠️ Funcionalidad de TRACKING (no automática):
- Banco del clan (tracking de oro, no transferencia)
- Préstamos (registro, no transferencia)
- Inventario (lista, no acceso real al banco)

---

## 📞 Soporte

Si encuentras bugs o tienes sugerencias:
1. Revisa esta guía primero
2. Verifica que estés usando la versión 6.6.1
3. Haz `/reload` y prueba de nuevo
4. Reporta el error con detalles

---

**Versión:** 6.6.1
**Fecha:** Enero 2, 2026
**Autor:** DarckRovert (El Séquito del Terror)
**Tema:** Brujo/Warlock - Oscura y Demoníaca
