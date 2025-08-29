import moderngl_window as mglw

# Implementing Adding textures using Triplanar Texture Mapping.

class App(mglw.WindowConfig):
    window_size = 1200, 675
    resource_dir = 'source/project_2/shader_scripts'

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.quad = mglw.geometry.quad_fs()
        self.program = self.load_program(vertex_shader='vertex.glsl', fragment_shader='fragment.glsl')
        self.u_scroll = 2.0
        #   textures
        self.texture1 = self.load_texture_2d('../../../resources/Textures/test.png')
        # uniforms
        self.program['u_scroll'] = self.u_scroll
        self.program['u_resolution'] = self.window_size
        self.program['u_texture1'] = 1

    def render(self, time, frame_time):
        self.ctx.clear()
        self.program['u_time'] = time
        self.texture1.use(location=1)
        self.quad.render(self.program)

    def mouse_position_event(self, x: int, y: int, dx: int, dy: int):
        self.program['u_mouse'] = (x, y)
    
    def mouse_scroll_event(self, x_offset: float, y_offset: float):
        self.u_scroll = max(1.0, self.u_scroll + y_offset)
        self.program['u_scroll'] = self.u_scroll


if __name__ == '__main__':
    mglw.run_window_config(App)
