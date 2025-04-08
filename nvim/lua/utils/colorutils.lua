local M = {}

M.darken_bg = "#2d2f3f"
M.lighten_bg = "#FFFFFF"

local function is_valid_hex(hex)
  hex = hex:lower()
  local clean_hex = hex:gsub("#", "")
  if #clean_hex ~= 3 and #clean_hex ~= 6 then
    return false
  end
  return clean_hex:match("^[0-9a-f]*$") ~= nil
end

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  local r, g, b

  if #hex == 3 then
    r = hex:sub(1, 1):rep(2)
    g = hex:sub(2, 2):rep(2)
    b = hex:sub(3, 3):rep(2)
  else
    r = hex:sub(1, 2)
    g = hex:sub(3, 4)
    b = hex:sub(5, 6)
  end

  return {
    r = tonumber(r, 16),
    g = tonumber(g, 16),
    b = tonumber(b, 16),
  }
end

local function rgb_to_hex(rgb)
  return string.format("#%02X%02X%02X", rgb.r, rgb.g, rgb.b)
end

local function get_blended_colors(fg_rgb, bg_rgb, alpha)
  local r = fg_rgb.r * (1 - alpha) + bg_rgb.r * alpha
  local g = fg_rgb.g * (1 - alpha) + bg_rgb.g * alpha
  local b = fg_rgb.b * (1 - alpha) + bg_rgb.b * alpha

  -- Round and clamp values
  r = math.min(math.max(math.floor(r + 0.5), 0), 255)
  g = math.min(math.max(math.floor(g + 0.5), 0), 255)
  b = math.min(math.max(math.floor(b + 0.5), 0), 255)

  return { r = r, g = g, b = b }
end

function M.blend(primary_color_hex, secondary_color_hex, alpha)
  -- Validate inputs
  assert(is_valid_hex(secondary_color_hex), "Invalid background color")
  assert(is_valid_hex(primary_color_hex), "Invalid foreground color")
  assert(type(alpha) == "number" and alpha >= 0 and alpha <= 1, "Alpha must be between 0 and 1")

  -- Convert to RGB
  local primary_rgb = hex_to_rgb(primary_color_hex)
  local secondary_rgb = hex_to_rgb(secondary_color_hex)

  -- Perform blending
  local blended_rgb = get_blended_colors(primary_rgb, secondary_rgb, alpha)

  -- Return new hex color
  return rgb_to_hex(blended_rgb)
end

function M.darken(hex, amount)
  return M.blend(hex, M.darken_bg, amount)
end

function M.lighten(hex, amount)
  return M.blend(hex, M.lighten_bg, amount)
end

_G.colorutils = M
