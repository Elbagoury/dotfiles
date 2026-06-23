#!/bin/sh
# Automatically launch VS Code GUI directly inside a Dev Container
code-container() {
    local abs_path=$(pwd)
    
    # 1. Dynamically read the workspaceFolder target path from your configuration
    local internal_ws=$(node -e '
        const fs = require("fs");
        let path = "";
        try {
            // Check standard directory location
            const file = fs.readFileSync(".devcontainer/devcontainer.json", "utf8");
            const json = JSON.parse(file.replace(/\/\*[\s\S]*?\*\/|([^\\:]|^)\/\/.*$/gm, ""));
            if (json.workspaceFolder) path = json.workspaceFolder;
        } catch (e) {}
        if (!path) {
            try {
                // Check fallback root file location
                const file = fs.readFileSync(".devcontainer.json", "utf8");
                const json = JSON.parse(file.replace(/\/\*[\s\S]*?\*\/|([^\\:]|^)\/\/.*$/gm, ""));
                if (json.workspaceFolder) path = json.workspaceFolder;
            } catch (e) {}
        }
        process.stdout.write(path);
    ')

    # 2. Fall back to standard folder conventions if no custom destination is found
    if [ -z "$internal_ws" ]; then
        local folder_name=$(basename "$abs_path")
        internal_ws="/workspaces/${folder_name}"
    fi

    # 3. Safely convert your host folder path to a clean hexadecimal string
    local hex_path=$(node -e 'process.stdout.write(Buffer.from(process.argv[1]).toString("hex"))' "$abs_path")
    
    # 4. Fire up VS Code explicitly targeted at the correct internal workspace file structural layer
    code --folder-uri "vscode-remote://dev-container+${hex_path}${internal_ws}"
}