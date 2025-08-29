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
        self.texture1 = self.load_texture_2d('../../../resources/Textures/test0.png')
        self.texture2 = self.load_texture_2d('../../../resources/Textures/hex.png')
        self.texture3 = self.load_texture_2d('../../../resources/Textures/white_marble1.png')   #   walls
        self.texture4 = self.load_texture_2d('../../../resources/Textures/roof/texture3.jpg')        #   roof
        self.texture5 = self.load_texture_2d('../../../resources/Textures/black_marble1.png')        #   pedestal
        self.texture6 = self.load_texture_2d('../../../resources/Textures/green_marble1.png')        #   sphere
        self.texture7 = self.load_texture_2d('../../../resources/Textures/roof/height3.png')        #   roof bump

        # uniforms
        self.program['u_scroll'] = self.u_scroll
        self.program['u_resolution'] = self.window_size
        self.program['u_texture1'] = 1
        self.program['u_texture2'] = 2
        self.program['u_texture3'] = 3
        self.program['u_texture4'] = 4
        self.program['u_texture5'] = 5
        self.program['u_texture6'] = 6
        self.program['u_texture7'] = 7

    def render(self, time, frame_time):
        self.ctx.clear()
        self.program['u_time'] = time
        self.texture1.use(location=1)
        self.texture2.use(location=2)
        self.texture3.use(location=3)
        self.texture4.use(location=4)
        self.texture5.use(location=5)
        self.texture6.use(location=6)
        self.texture7.use(location=7)

        self.quad.render(self.program)

    def mouse_position_event(self, x: int, y: int, dx: int, dy: int):
        self.program['u_mouse'] = (x, y)
    
    def mouse_scroll_event(self, x_offset: float, y_offset: float):
        self.u_scroll = max(1.0, self.u_scroll + y_offset)
        self.program['u_scroll'] = self.u_scroll


if __name__ == '__main__':
    mglw.run_window_config(App)
