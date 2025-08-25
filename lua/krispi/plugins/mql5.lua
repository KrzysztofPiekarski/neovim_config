return {
  -- MQL5/MQL4 Support - Manual configuration since specific plugins may not be available
  {
    -- Manual MQL filetype configuration
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    config = function()
      -- Set up MQL file detection and basic configuration
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.mq4", "*.mq5" },
        callback = function()
          local filename = vim.fn.expand("%:e")
          
          -- Map MQL4 to C and MQL5 to C++
          if filename == "mq4" then
            vim.bo.filetype = "c"
          elseif filename == "mq5" then
            vim.bo.filetype = "cpp"
          end
          
          -- MQL-specific settings
          vim.opt_local.commentstring = "// %s"
          vim.opt_local.tabstop = 3
          vim.opt_local.shiftwidth = 3
          vim.opt_local.expandtab = true
          
          -- Enable folding for functions
          vim.opt_local.foldmethod = "syntax"
          vim.opt_local.foldlevel = 99
          
          -- Add comprehensive MQL keywords highlighting
          vim.cmd([[
            " MQL4/MQL5 Keywords
            syntax keyword mqlKeyword input sinput extern property version copyright
            syntax keyword mqlKeyword strict show_inputs show_confirm script_show_inputs
            syntax keyword mqlKeyword library import
            
            " MQL Types
            syntax keyword mqlType color datetime string uchar ushort uint ulong
            syntax keyword mqlType MqlDateTime MqlTick MqlRates MqlBookInfo
            syntax keyword mqlType ENUM_TIMEFRAMES ENUM_APPLIED_PRICE
            
            " MQL Constants
            syntax keyword mqlConstant PERIOD_M1 PERIOD_M5 PERIOD_M15 PERIOD_M30 PERIOD_H1 PERIOD_H4 PERIOD_D1 PERIOD_W1 PERIOD_MN1
            syntax keyword mqlConstant MODE_OPEN MODE_HIGH MODE_LOW MODE_CLOSE MODE_VOLUME MODE_TIME
            syntax keyword mqlConstant OP_BUY OP_SELL OP_BUYLIMIT OP_SELLLIMIT OP_BUYSTOP OP_SELLSTOP
            syntax keyword mqlConstant INIT_SUCCEEDED INIT_FAILED INIT_PARAMETERS_INCORRECT
            syntax keyword mqlConstant DRAW_LINE DRAW_SECTION DRAW_HISTOGRAM DRAW_ARROW
            
            " MQL Functions
            syntax keyword mqlFunction OnInit OnDeinit OnTick OnStart OnCalculate OnTimer OnTester
            syntax keyword mqlFunction OrderSend OrderClose OrderModify OrderSelect OrdersTotal
            syntax keyword mqlFunction iMA iRSI iBands iMACD iStochastic iADX
            syntax keyword mqlFunction MarketInfo AccountBalance AccountEquity AccountFreeMargin
            syntax keyword mqlFunction Print Alert Comment ObjectCreate ObjectDelete
            syntax keyword mqlFunction ArraySize ArrayResize ArrayCopy ArrayFill
            syntax keyword mqlFunction StringLen StringFind StringSubstr StringReplace
            syntax keyword mqlFunction MathAbs MathMax MathMin MathRand MathSrand
            syntax keyword mqlFunction TimeCurrent TimeLocal TimeGMT TimeToStr StrToTime
            
            " Highlight groups
            highlight link mqlKeyword Keyword
            highlight link mqlType Type
            highlight link mqlConstant Constant
            highlight link mqlFunction Function
          ]])
        end,
      })
    end,
  },
  
  {
    -- MQL compilation support - manual implementation
    "nvim-lua/plenary.nvim",
    config = function()
      -- Create MQL compilation commands with cross-platform support
      local function compile_mql()
        local filepath = vim.fn.expand("%:p")
        local filetype = vim.fn.expand("%:e")
        
        if filetype ~= "mq4" and filetype ~= "mq5" then
          vim.notify("Not an MQL file", vim.log.levels.WARN)
          return
        end
        
        -- Detect operating system
        local os_name = vim.loop.os_uname().sysname
        local is_windows = os_name == "Windows_NT"
        local is_linux = os_name == "Linux"
        local is_mac = os_name == "Darwin"
        
        -- Define compiler paths for different systems
        local compiler_paths = {}
        
        if is_windows then
          -- Native Windows paths
          compiler_paths = {
            "C:/Program Files/MetaTrader 5/metaeditor64.exe",
            "C:/Program Files (x86)/MetaTrader 5/metaeditor64.exe", 
            "C:/Program Files/MetaTrader 4/metaeditor.exe",
            "C:/Program Files (x86)/MetaTrader 4/metaeditor.exe",
            -- Alternative Windows paths
            "D:/Program Files/MetaTrader 5/metaeditor64.exe",
            "D:/Program Files (x86)/MetaTrader 5/metaeditor64.exe",
            -- Portable installations
            vim.fn.expand("~/AppData/Roaming/MetaQuotes/Terminal/*/metaeditor64.exe"),
            vim.fn.expand("~/Desktop/MetaTrader*/metaeditor*.exe"),
          }
        elseif is_linux then
          -- Linux with Wine paths
          local home = os.getenv("HOME") or ""
          local wine_prefix = os.getenv("WINEPREFIX") or (home .. "/.wine")
          
          compiler_paths = {
            -- Wine default prefix paths
            wine_prefix .. "/drive_c/Program Files/MetaTrader 5/metaeditor64.exe",
            wine_prefix .. "/drive_c/Program Files (x86)/MetaTrader 5/metaeditor64.exe",
            wine_prefix .. "/drive_c/Program Files/MetaTrader 4/metaeditor.exe", 
            wine_prefix .. "/drive_c/Program Files (x86)/MetaTrader 4/metaeditor.exe",
            -- Alternative Wine prefixes
            home .. "/.wine/drive_c/Program Files/MetaTrader 5/metaeditor64.exe",
            home .. "/.wine/drive_c/Program Files (x86)/MetaTrader 5/metaeditor64.exe",
            home .. "/.wine/drive_c/Program Files/MetaTrader 4/metaeditor.exe",
            home .. "/.wine/drive_c/Program Files (x86)/MetaTrader 4/metaeditor.exe",
            -- PlayOnLinux paths
            home .. "/.PlayOnLinux/wineprefix/MetaTrader*/drive_c/Program Files*/MetaTrader*/metaeditor*.exe",
            -- Lutris paths
            home .. "/Games/metatrader*/drive_c/Program Files*/MetaTrader*/metaeditor*.exe",
            -- Bottles paths  
            home .. "/.local/share/bottles/bottles/MetaTrader*/drive_c/Program Files*/MetaTrader*/metaeditor*.exe",
          }
        elseif is_mac then
          -- macOS with Wine/CrossOver paths
          local home = os.getenv("HOME") or ""
          
          compiler_paths = {
            -- Wine on macOS
            home .. "/.wine/drive_c/Program Files/MetaTrader 5/metaeditor64.exe",
            home .. "/.wine/drive_c/Program Files (x86)/MetaTrader 5/metaeditor64.exe",
            home .. "/.wine/drive_c/Program Files/MetaTrader 4/metaeditor.exe",
            home .. "/.wine/drive_c/Program Files (x86)/MetaTrader 4/metaeditor.exe",
            -- CrossOver paths
            home .. "/Library/Application Support/CrossOver/Bottles/*/drive_c/Program Files*/MetaTrader*/metaeditor*.exe",
            -- Parallels paths (if running Windows VM)
            "/Applications/Parallels Desktop.app/Contents/MacOS/prl_client_app",
          }
        end
        
        -- Find available compiler
        local compiler = nil
        local found_paths = {}
        
        for _, path in ipairs(compiler_paths) do
          -- Handle wildcard paths
          if path:match("%*") then
            local expanded = vim.fn.glob(path)
            if expanded ~= "" then
              for expanded_path in expanded:gmatch("[^\n]+") do
                if vim.fn.filereadable(expanded_path) == 1 then
                  table.insert(found_paths, expanded_path)
                end
              end
            end
          else
            if vim.fn.filereadable(path) == 1 then
              table.insert(found_paths, path)
            end
          end
        end
        
        if #found_paths > 0 then
          compiler = found_paths[1] -- Use first found compiler
        end
        
        if not compiler then
          local system_info = string.format("System: %s", os_name)
          local suggestions = {}
          
          if is_linux then
            table.insert(suggestions, "Install MetaTrader via Wine:")
            table.insert(suggestions, "1. Install Wine: sudo apt install wine")
            table.insert(suggestions, "2. Download MetaTrader from broker website")
            table.insert(suggestions, "3. Install: wine MetaTrader-setup.exe")
            table.insert(suggestions, "4. Or use PlayOnLinux/Lutris/Bottles")
          elseif is_mac then
            table.insert(suggestions, "Install MetaTrader on macOS:")
            table.insert(suggestions, "1. Use Wine: brew install wine")
            table.insert(suggestions, "2. Or use CrossOver")
            table.insert(suggestions, "3. Or run Windows VM (Parallels/VMware)")
          else
            table.insert(suggestions, "Install MetaTrader from your broker's website")
          end
          
          local message = "MetaTrader compiler not found!\n" .. system_info .. "\n\nSuggestions:\n" .. table.concat(suggestions, "\n")
          vim.notify(message, vim.log.levels.ERROR)
          return
        end
        
        -- Prepare compilation command based on OS
        local cmd
        local wine_cmd = ""
        
        if is_linux or is_mac then
          -- Check if Wine is available
          if vim.fn.executable("wine") == 1 then
            wine_cmd = "wine "
          else
            vim.notify("Wine not found! Install Wine to run MetaTrader on Linux/macOS", vim.log.levels.ERROR)
            return
          end
        end
        
        -- Convert filepath for Wine if needed
        local wine_filepath = filepath
        if (is_linux or is_mac) and wine_cmd ~= "" then
          -- Convert Unix path to Windows path for Wine
          wine_filepath = filepath:gsub("^" .. os.getenv("HOME"), "Z:")
          wine_filepath = wine_filepath:gsub("/", "\\")
        end
        
        -- Build compilation command
        if is_windows then
          cmd = string.format('"%s" /compile:"%s"', compiler, filepath)
        else
          cmd = string.format('%s"%s" /compile:"%s"', wine_cmd, compiler, wine_filepath)
        end
        
        vim.notify(string.format("Compiling MQL file with %s...", compiler:match("([^/\\]+)$") or "compiler"), vim.log.levels.INFO)
        
        -- Run compilation in background
        vim.fn.jobstart(cmd, {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("MQL compilation successful!", vim.log.levels.INFO)
            else
              vim.notify("MQL compilation failed!", vim.log.levels.ERROR)
            end
          end,
          on_stderr = function(_, data)
            if data and #data > 0 then
              for _, line in ipairs(data) do
                if line ~= "" then
                  vim.notify("Compiler error: " .. line, vim.log.levels.ERROR)
                end
              end
            end
          end,
        })
      end
      
      -- Helper function to open MetaTrader folder
      local function open_mt_folder()
        local os_name = vim.loop.os_uname().sysname
        local is_windows = os_name == "Windows_NT"
        local is_linux = os_name == "Linux"
        
        local mt_paths = {}
        
        if is_windows then
          mt_paths = {
            "C:/Program Files/MetaTrader 5",
            "C:/Program Files (x86)/MetaTrader 5",
            "C:/Program Files/MetaTrader 4",
            "C:/Program Files (x86)/MetaTrader 4",
          }
        elseif is_linux then
          local home = os.getenv("HOME") or ""
          local wine_prefix = os.getenv("WINEPREFIX") or (home .. "/.wine")
          mt_paths = {
            wine_prefix .. "/drive_c/Program Files/MetaTrader 5",
            wine_prefix .. "/drive_c/Program Files (x86)/MetaTrader 5",
            wine_prefix .. "/drive_c/Program Files/MetaTrader 4",
            wine_prefix .. "/drive_c/Program Files (x86)/MetaTrader 4",
          }
        end
        
        for _, path in ipairs(mt_paths) do
          if vim.fn.isdirectory(path) == 1 then
            if is_windows then
              vim.fn.jobstart(string.format('explorer "%s"', path))
            elseif is_linux then
              vim.fn.jobstart(string.format('xdg-open "%s"', path))
            end
            vim.notify("Opened MetaTrader folder: " .. path, vim.log.levels.INFO)
            return
          end
        end
        
        vim.notify("MetaTrader folder not found", vim.log.levels.WARN)
      end
      
      -- Helper function to check system requirements
      local function check_requirements()
        local os_name = vim.loop.os_uname().sysname
        local is_windows = os_name == "Windows_NT"
        local is_linux = os_name == "Linux"
        local is_mac = os_name == "Darwin"
        
        local status = {}
        table.insert(status, "=== MQL5 System Check ===")
        table.insert(status, "Operating System: " .. os_name)
        
        if is_windows then
          table.insert(status, "✅ Native Windows support")
        elseif is_linux then
          local wine_available = vim.fn.executable("wine") == 1
          table.insert(status, wine_available and "✅ Wine available" or "❌ Wine not installed")
          
          if not wine_available then
            table.insert(status, "Install Wine: sudo apt install wine")
          end
          
          -- Check Wine prefix
          local wine_prefix = os.getenv("WINEPREFIX") or (os.getenv("HOME") .. "/.wine")
          local prefix_exists = vim.fn.isdirectory(wine_prefix) == 1
          table.insert(status, prefix_exists and "✅ Wine prefix exists" or "❌ Wine prefix not found")
          
        elseif is_mac then
          local wine_available = vim.fn.executable("wine") == 1
          table.insert(status, wine_available and "✅ Wine available" or "❌ Wine not installed")
          
          if not wine_available then
            table.insert(status, "Install Wine: brew install wine")
          end
        end
        
        -- Check for MetaTrader installation
        local compiler_found = false
        local home = os.getenv("HOME") or ""
        local wine_prefix = os.getenv("WINEPREFIX") or (home .. "/.wine")
        local search_paths = {}
        
        if is_windows then
          search_paths = {
            "C:/Program Files/MetaTrader 5",
            "C:/Program Files (x86)/MetaTrader 5",
            "C:/Program Files/MetaTrader 4",
            "C:/Program Files (x86)/MetaTrader 4",
          }
        else
          search_paths = {
            wine_prefix .. "/drive_c/Program Files/MetaTrader 5",
            wine_prefix .. "/drive_c/Program Files (x86)/MetaTrader 5",
            wine_prefix .. "/drive_c/Program Files/MetaTrader 4",
            wine_prefix .. "/drive_c/Program Files (x86)/MetaTrader 4",
          }
        end
        
        for _, path in ipairs(search_paths) do
          if vim.fn.isdirectory(path) == 1 then
            table.insert(status, "✅ MetaTrader found: " .. path)
            compiler_found = true
            break
          end
        end
        
        if not compiler_found then
          table.insert(status, "❌ MetaTrader not found")
          table.insert(status, "Download from your broker's website")
        end
        
        vim.notify(table.concat(status, "\n"), vim.log.levels.INFO)
      end
      
      -- Create user commands
      vim.api.nvim_create_user_command("MqlCompile", compile_mql, {
        desc = "Compile current MQL file"
      })
      
      vim.api.nvim_create_user_command("MqlCheck", check_requirements, {
        desc = "Check MQL development environment"
      })
      
      vim.api.nvim_create_user_command("MqlOpen", open_mt_folder, {
        desc = "Open MetaTrader installation folder"
      })
      
      -- Set up keymaps for MQL files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp" },
        callback = function()
          local filename = vim.fn.expand("%:t")
          if filename:match("%.mq[45]$") then
            local keymap = vim.keymap
            local opts = { buffer = true, silent = true }
            
            -- Compilation keymaps
            keymap.set("n", "<leader>mc", "<cmd>MqlCompile<CR>", 
              vim.tbl_extend("force", opts, { desc = "Compile MQL file" }))
            
            keymap.set("n", "<leader>mq", "<cmd>copen<CR>", 
              vim.tbl_extend("force", opts, { desc = "Open quickfix list" }))
            
            -- System management keymaps
            keymap.set("n", "<leader>ms", "<cmd>MqlCheck<CR>", 
              vim.tbl_extend("force", opts, { desc = "Check MQL system requirements" }))
            
            keymap.set("n", "<leader>mo", "<cmd>MqlOpen<CR>", 
              vim.tbl_extend("force", opts, { desc = "Open MetaTrader folder" }))
            
            -- Navigation keymaps
            keymap.set("n", "]m", "<cmd>cnext<CR>", 
              vim.tbl_extend("force", opts, { desc = "Next MQL error" }))
            keymap.set("n", "[m", "<cmd>cprev<CR>", 
              vim.tbl_extend("force", opts, { desc = "Previous MQL error" }))
            
            -- Quick templates for MQL
            keymap.set("n", "<leader>mt", function()
              local templates = {
                "EA Template (Expert Advisor)",
                "Indicator Template", 
                "Script Template",
                "Include File Template"
              }
              
              vim.ui.select(templates, {
                prompt = "Select MQL Template:",
              }, function(choice)
                if choice then
                  local template_content = ""
                  
                  if choice:match("EA Template") then
                    template_content = [[//+------------------------------------------------------------------+
//|                                                                  |
//|                           Expert Advisor                         |
//|                                                                  |
//+------------------------------------------------------------------+

#property copyright "Your Name"
#property version   "1.00"
#property strict

// Input parameters
input double Lots = 0.1;
input int TakeProfit = 100;
input int StopLoss = 100;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   
}
]]
                  elseif choice:match("Indicator Template") then
                    template_content = [[//+------------------------------------------------------------------+
//|                                                                  |
//|                           Custom Indicator                       |
//|                                                                  |
//+------------------------------------------------------------------+

#property copyright "Your Name"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_plots   1

// Input parameters
input int Period = 14;

// Indicator buffers
double Buffer[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
   SetIndexBuffer(0, Buffer);
   SetIndexStyle(0, DRAW_LINE);
   SetIndexLabel(0, "Custom");
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   
   return(rates_total);
}
]]
                  elseif choice:match("Script Template") then
                    template_content = [[//+------------------------------------------------------------------+
//|                                                                  |
//|                              Script                              |
//|                                                                  |
//+------------------------------------------------------------------+

#property copyright "Your Name"
#property version   "1.00"
#property script_show_inputs

// Input parameters
input string Message = "Hello World";

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
   Print(Message);
}
]]
                  else -- Include File Template
                    template_content = [[//+------------------------------------------------------------------+
//|                                                                  |
//|                           Include File                           |
//|                                                                  |
//+------------------------------------------------------------------+

#property copyright "Your Name"
#property version   "1.00"

// Function declarations
double CalculateValue(double input);
bool ValidateInput(double value);

//+------------------------------------------------------------------+
//| Calculate value function                                          |
//+------------------------------------------------------------------+
double CalculateValue(double input)
{
   return input * 2.0;
}

//+------------------------------------------------------------------+
//| Validate input function                                           |
//+------------------------------------------------------------------+
bool ValidateInput(double value)
{
   return value > 0.0;
}
]]
                  end
                  
                  -- Insert template at cursor position
                  local lines = vim.split(template_content, "\n")
                  vim.api.nvim_put(lines, "l", true, true)
                  vim.notify("Template inserted!", vim.log.levels.INFO)
                end
              end)
            end, vim.tbl_extend("force", opts, { desc = "Insert MQL template" }))
          end
        end,
      })
    end,
  },
  
  -- Note: Removed vim-scripts/MQL4 plugin due to repository access issues
  -- The manual configuration above provides comprehensive MQL4/MQL5 support
}
