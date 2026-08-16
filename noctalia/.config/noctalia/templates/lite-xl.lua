local style = require("core.style")
local common = require("core.common")

-- UI
style.background = { common.color("{{ colors.surface.default.hex }}") }
style.background2 = { common.color("{{ colors.surface_container.default.hex }}") }
style.background3 = { common.color("{{ colors.surface_container_high.default.hex }}") }

style.text = { common.color("{{ colors.on_surface.default.hex }}") }
style.caret = { common.color("{{ colors.primary.default.hex }}") }
style.accent = { common.color("{{ colors.primary.default.hex }}") }
style.dim = { common.color("{{ colors.on_surface_variant.default.hex }}") }
style.divider = { common.color("{{ colors.outline.default.hex }}") }

style.selection = { common.color("{{ colors.secondary_container.default.hex }}") }

style.line_number = { common.color("{{ colors.outline.default.hex }}") }
style.line_number2 = { common.color("{{ colors.primary.default.hex }}") }

style.line_highlight = { common.color("{{ colors.surface_container.default.hex }}") }

style.scrollbar = { common.color("{{ colors.outline_variant.default.hex }}") }
style.scrollbar2 = { common.color("{{ colors.outline.default.hex }}") }
style.scrollbar_track = { common.color("{{ colors.surface_container_low.default.hex }}") }

-- Syntax
style.syntax["normal"] = { common.color("{{ colors.on_surface.default.hex }}") }
style.syntax["symbol"] = { common.color("{{ colors.secondary.default.hex }}") }
style.syntax["comment"] = { common.color("{{ colors.on_surface_variant.default.hex }}") }

style.syntax["keyword"] = { common.color("{{ colors.primary.default.hex }}") }
style.syntax["keyword2"] = { common.color("{{ colors.tertiary.default.hex }}") }

style.syntax["number"] = { common.color("{{ colors.tertiary.default.hex }}") }
style.syntax["literal"] = { common.color("{{ colors.secondary.default.hex }}") }
style.syntax["string"] = { common.color("{{ colors.primary.default.hex }}") }
style.syntax["operator"] = { common.color("{{ colors.primary.default.hex }}") }
style.syntax["function"] = { common.color("{{ colors.primary.default.hex }}") }
