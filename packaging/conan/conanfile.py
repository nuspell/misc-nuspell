from conans import ConanFile, CMake, tools


class NuspellConan(ConanFile):
    name = "nuspell"
    version = "4.1.0"
    license = "LGPL-3.0"
    url = "https://github.com/nuspell/nuspell"
    homepage = "https://nuspell.github.io/"
    description = "Nuspell is a fast and safe spelling checker software program. It is designed for languages with rich morphology and complex word compounding. Nuspell is written in modern C++ and it supports Hunspell dictionaries."
    topics = ("spelling checker", "spelling corrector", "spellcheck", "spellchecker", "spellchecking")
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False]}
    default_options = {"shared": True}
    exports_sources = "CMakeLists.txt"
    generators = "cmake",
    requires = (
        "icu/67.1@",
        "boost/1.71.0@"
    )
    def cmake_flags(self):
        flags = [
            "-DBUILD_TESTING=OFF"
        ]
        return flags
   
    def source(self):
        self.run("curl -o nuspell.zip https://codeload.github.com/nuspell/nuspell/zip/v{}".format(self.version))
        self.run("unzip nuspell.zip")
        self.run("mv nuspell-{} nuspell".format(self.version))

    def build(self):
        cmake = CMake(self)
        cmake.configure(source_folder="nuspell", args=self.cmake_flags())
        cmake.build()

    def package(self):
        # WORK IN PROGRESS
        self.copy("*.hxx", dst="include/nuspell", src="src/nuspell")
        self.copy(".lib", dst="lib", keep_path=False)
        self.copy("*.dll", dst="bin", keep_path=False)
        self.copy("*.so", dst="lib", keep_path=False)
        self.copy("*.dylib", dst="lib", keep_path=False)
        self.copy("*.a", dst="lib", keep_path=False)
        cmake = self._configure_cmake()
        cmake.install()

    def package_info(self):
        self.cpp_info.libs = [self.name]
        self.cpp_info.libs = tools.collect_libs(self)

