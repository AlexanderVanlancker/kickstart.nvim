if vim.g.neovide then
    -- "pixiedust" is the cutest, most "magical" particle effect
    -- options: "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "particles"
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    
    -- Customize the particle behavior
    vim.g.neovide_cursor_vfx_opacity = 200.0   -- How visible they are
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.2 -- How long they float
    vim.g.neovide_cursor_vfx_particle_density = 10.0 -- How many particles spawn
    vim.g.neovide_cursor_vfx_particle_speed = 10.0 -- How fast they fly
    
    -- Make the cursor move smoothly
    vim.g.neovide_cursor_animation_length = 0.13
    vim.g.neovide_cursor_trail_size = 0.8

    -- Set the opacity (0.0 to 1.0). 0.8 is usually a sweet spot.
    vim.g.neovide_opacity = 0.6
    -- On macOS, this makes the window blurry like frosted glass
    vim.g.neovide_window_blurred = true
end
