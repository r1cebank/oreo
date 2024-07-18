return {
  black = 0xff45475a,
  white = 0xffbac2de,
  red = 0xfff38ba8,
  green = 0xffa6e3a1,
  blue = 0xff89b4fa,
  yellow = 0xfff9e2af,
  orange = 0xfffab387,
  magenta = 0xfff5c2e7,
  grey = 0xff7f8490,
  cyan = 0xff94e2d5,
  transparent = 0x00000000,

  bar = {
    bg = 0xf01e1e2e,
    border = 0xffb4befe,
  },
  popup = {
    bg = 0xf01e1e2e,
    border = 0xffb4befe
  },
  spaces = {
    inactive_bg = 0xff181825,
    inactive_fg = 0xffcdd6f4,
    active_bg = 0xffcba6f7,
    active_fg = 0xff11111b,
    active_border = 0xffb4befe,
    inactive_border = 0xff6c7086
  },
  
  bg1 = 0xff313244,
  bg2 = 0xff45475a,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
