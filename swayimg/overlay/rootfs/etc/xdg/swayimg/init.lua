-- Swayimg config

swayimg.set_mode("slideshow")
swayimg.set_window_size(3840, 2160)

swayimg.imagelist.set_order("random")
swayimg.imagelist.enable_recursive(true)

swayimg.text.set_font('Play')
swayimg.text.set_size(96)
swayimg.text.set_padding(20)
swayimg.text.set_foreground(0xffeeeeee)
swayimg.text.set_timeout(0)

swayimg.slideshow.set_timeout(8)
swayimg.slideshow.set_default_scale("real")
swayimg.slideshow.set_window_background(0xff000000)
swayimg.slideshow.set_text("bottomright", { "{dir}" })
