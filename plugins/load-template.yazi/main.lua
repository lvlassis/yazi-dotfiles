local template_options = dofile("/home/zenitsu/.config/yazi/plugins/load-template.yazi/template_options.lua")

local function prompt_templates()
    return ya.which {
        cands = template_options
    }
end

local function entry()
    local template_id = prompt_templates()
    local template_name = template_options[template_id].name

    ya.notify {
        title = "Return Value",
        content = template_name,
        timeout = 2,
        level = "info"
    }

    local permit = ya.hide()
    os.execute("cookiecutter ~/.templates/'"..template_name.."'")
    permit:drop()
end

return { entry = entry }

