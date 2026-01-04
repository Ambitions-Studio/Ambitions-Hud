-- ===================================================================
-- AMBITIONS HUD - CONFIGURATION
-- ===================================================================
-- This configuration file defines the behavior and default settings
-- for the Ambitions HUD system. It controls debug features, player
-- customization permissions, vehicle display preferences, and
-- keybindings for various HUD interactions.
--
-- SYSTEM FEATURES:
-- • Player status indicators (health, armor, hunger, thirst, stamina, oxygen)
-- • Vehicle HUD with speedometer, fuel gauge, and warning indicators
-- • Seatbelt system with configurable keybinding
-- • Player-customizable HUD layouts (positions, colors, visibility)
-- • Debug mode for development and testing
-- ===================================================================

hudConfig = {

  -- ===================================================================
  -- DEBUG SETTINGS
  -- ===================================================================

  --- Enable debug mode for development testing
  ---
  --- When enabled, this setting activates debug commands and logging
  --- output for testing HUD functionality during development. Debug
  --- mode should always be disabled on production servers.
  ---
  --- AVAILABLE DEBUG COMMANDS (when enabled):
  --- • /debugHealth - Test health indicator changes
  --- • /debugArmor - Test armor indicator changes
  ---
  --- BEHAVIOR:
  --- • true: Debug commands registered, verbose logging enabled
  --- • false: Debug commands hidden, minimal logging
  ---
  --- CONFIGURATION:
  --- • Default: false (production-ready setting)
  --- • Set to true only during development/testing
  debugMode = false,

  -- ===================================================================
  -- PLAYER CUSTOMIZATION PERMISSIONS
  -- ===================================================================

  --- Allow players to customize their HUD layout
  ---
  --- This setting controls whether players can access the HUD settings
  --- interface to personalize their display. When enabled, players can
  --- modify visibility, colors, positions, and sizes of HUD elements.
  ---
  --- CUSTOMIZATION OPTIONS (when enabled):
  --- • Visibility toggles for each HUD element
  --- • Color picker for status indicators
  --- • Drag-and-drop position editing
  --- • Size scaling (0.5x to 5x)
  ---
  --- ACCESS METHOD:
  --- • Command: /hud (opens settings modal)
  ---
  --- BEHAVIOR:
  --- • true: Players can use /hud command to customize their display
  --- • false: /hud command disabled, all players use default layout
  ---
  --- SERVER CONSIDERATIONS:
  --- • Player preferences are saved to the database
  --- • Settings persist across sessions and reconnections
  --- • Admins can still modify HUD via server-side commands
  ---
  --- CONFIGURATION:
  --- • Default: true (player freedom recommended)
  --- • Set to false for uniform HUD appearance across all players
  playerCanCustom = true,

  -- ===================================================================
  -- VEHICLE HUD SETTINGS
  -- ===================================================================

  --- Speed display unit for vehicle speedometer
  ---
  --- This setting determines which unit of measurement is used for
  --- the vehicle speed display. The speedometer uses a 7-segment
  --- digital display format for a realistic dashboard appearance.
  ---
  --- AVAILABLE UNITS:
  --- • 'kmh': Kilometers per hour (metric system)
  --- • 'mph': Miles per hour (imperial system)
  ---
  --- DISPLAY FORMAT:
  --- • Speed shown as 3-digit number (000-999)
  --- • Unit label displayed next to speed value
  --- • Automatic conversion applied based on selection
  ---
  --- REGIONAL RECOMMENDATIONS:
  --- • Europe, Asia, most of world: 'kmh'
  --- • United States, United Kingdom: 'mph'
  ---
  --- CONFIGURATION:
  --- • Default: 'kmh' (metric standard)
  --- • Values: 'kmh' or 'mph'
  speedUnit = 'kmh',

  -- ===================================================================
  -- KEYBINDING CONFIGURATION
  -- ===================================================================

  --- Keybind for toggling vehicle seatbelt
  ---
  --- This setting defines the keyboard key used to toggle the seatbelt
  --- on and off when inside a vehicle. The seatbelt system provides
  --- crash protection and prevents ejection during collisions.
  ---
  --- SEATBELT FEATURES:
  --- • Visual indicator on vehicle HUD (red warning when unbuckled)
  --- • Damage reduction during vehicle crashes
  --- • Blocks accidental vehicle exit during collisions
  --- • Audio feedback when buckling/unbuckling
  ---
  --- ALTERNATIVE ACCESS:
  --- • Command: /toggleSeatbelt (works alongside keybind)
  ---
  --- KEYBIND FORMAT:
  --- • Use GTA V key names (single character for letters)
  --- • Examples: 'B', 'K', 'U', 'N'
  ---
  --- COMMON CHOICES:
  --- • 'B': Belt (easy to remember)
  --- • 'K': Commonly used in other frameworks
  --- • 'U': Buckle Up
  ---
  --- CONFIGURATION:
  --- • Default: 'B' (intuitive for "Belt")
  --- • Value: Single uppercase letter
  seatbeltKey = 'B',

  -- ===================================================================
  -- SOUND SETTINGS
  -- ===================================================================

  --- Seatbelt warning sound volume
  ---
  --- This setting controls the volume of the seatbelt warning sound
  --- that plays when a player is in a vehicle without their seatbelt
  --- fastened. The sound loops until the seatbelt is buckled.
  ---
  --- BEHAVIOR:
  --- • Sound starts when entering vehicle without seatbelt
  --- • Sound stops immediately when seatbelt is fastened
  --- • Sound resumes if seatbelt is unfastened while driving
  --- • Sound stops when exiting vehicle
  ---
  --- CONFIGURATION:
  --- • Default: 0.5 (50% volume)
  --- • Values: 0.0 (muted) to 1.0 (full volume)
  seatbeltSoundVolume = 0.5,

  -- ===================================================================
  -- VOICE SYSTEM INTEGRATION
  -- ===================================================================

  --- Voice script integration for HUD voice indicators
  ---
  --- This setting defines which voice communication script is used on
  --- your server. The HUD will automatically integrate with the selected
  --- voice system to display voice mode, talking status, and radio
  --- indicators on the player HUD.
  ---
  --- SUPPORTED VOICE SCRIPTS:
  --- • 'pma': pma-voice (recommended, full feature support)
  --- • 'ambitions': Ambitions-Voice (planned)
  --- • 'none': Disable voice integration
  ---
  --- HUD FEATURES (when integrated):
  --- • Voice mode indicator (whisper, normal, shout)
  --- • Talking animation on microphone icon
  --- • Radio channel indicator when broadcasting
  --- • Dynamic icon changes based on voice state
  ---
  --- REQUIREMENTS:
  --- • The selected voice script must be running on the server
  --- • Ensure the voice resource starts before ambitions-hud
  ---
  --- CONFIGURATION:
  --- • Default: 'pma' (most common choice)
  --- • Values: 'pma', 'ambitions', or 'none'
  voiceScript = 'pma',

  -- ===================================================================
  -- FUEL SYSTEM INTEGRATION
  -- ===================================================================

  --- Fuel script integration for vehicle fuel indicator
  ---
  --- This setting defines which fuel management script is used on
  --- your server. The HUD will automatically integrate with the selected
  --- fuel system to display accurate fuel levels on the vehicle HUD.
  ---
  --- SUPPORTED FUEL SCRIPTS:
  --- • 'legacy': LegacyFuel (most common, uses exports)
  --- • 'ox': ox_fuel (planned)
  --- • 'ambitions': Ambitions-Fuel (planned)
  ---
  --- HUD FEATURES (when integrated):
  --- • Real-time fuel level display
  --- • Fuel gauge updates as you drive
  --- • Refuel detection (gauge increases at gas stations)
  ---
  --- REQUIREMENTS:
  --- • The selected fuel script must be running on the server
  --- • For LegacyFuel: Disable its built-in HUD (Config.EnableHUD = false)
  ---
  --- CONFIGURATION:
  --- • Default: 'legacy' (most common choice)
  --- • Values: 'legacy', 'ox', or 'ambitions'
  fuelScript = 'legacy',

}
