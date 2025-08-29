import moderngl_window as mglw


class App(mglw.WindowConfig):
    window_size = 1200,675
    resource_dir = "source/project_1/shader_scripts"

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        #   Creates frame about the size of the resolution
        self.quad = mglw.geometry.quad_fs()
        self.program = self.load_program(vertex_shader='vertex.glsl',
                                        fragment_shader='fragment.glsl')
        #   Uniform
        self.program['u_resolution'] = self.window_size

    def mouse_position_event(self, x: int, y: int, dx: int, dy: int):
        self.program['u_mouse'] = (x, y)
    
    def render(self, time, frame_time):
        self.ctx.clear()
        self.quad.render(self.program)
    
if __name__=='__main__':
    mglw.run_window_config(App)
    
