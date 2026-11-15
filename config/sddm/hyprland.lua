hl.monitor({
  output   = "DP-1",
  mode     = "5120x2160@165.06",
  position = "0x0",
  -- scale    = 1,
  scale    = 1.333333,
  -- scale    = 1.6,
  -- scale    = 2,
})

hl.config({
  input = {
    kb_layout  = "us",
    kb_variant = "altgr-intl",
    kb_options = "compose:ralt",
  },

  misc = {
    force_default_wallpaper  = 0,
    disable_hyprland_logo    = true,
    disable_splash_rendering = true,
    background_color         = "rgb(1e1e2e)",
  },

  animations = {
    enabled = false,
  },
})
