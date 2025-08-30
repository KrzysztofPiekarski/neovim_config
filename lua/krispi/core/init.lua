-- Inicjalizacja podstawowej konfiguracji Neovim
-- Ładuje wszystkie komponenty core w odpowiedniej kolejności

-- Opcje Neovim (muszą być pierwsze)
require("krispi.core.options")

-- Podstawowe mapowania klawiszy
require("krispi.core.keymaps")

-- Centralne mapowania leader (muszą być po podstawowych mapowaniach)
require("krispi.core.leader-mappings")

-- Core configuration loaded silently
