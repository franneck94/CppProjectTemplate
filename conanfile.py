from conan import ConanFile
from conan.tools.cmake import CMakeToolchain


class CompressorRecipe(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps"

    def requirements(self):
        self.requires("nlohmann_json/3.11.2")
        self.requires("fmt/9.1.0")
        self.requires("spdlog/1.11.0")
        self.requires("catch2/2.13.9")
        self.requires("cxxopts/3.1.1")

    def generate(self):
        tc = CMakeToolchain(self)
        tc.user_presets_path = False
        tc.generate()
