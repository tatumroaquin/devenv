# Linux Development Environment Scripts

__What is this?__
* A set of bash scripts designed to spin up language version manager for a few programming languages.

__Why make this?__
* The goal is to create reproducible way to setup a quick development environment on Linux machines.

__What about [asdf](https://github.com/asdf-format/asdf) and [mise](https://github.com/jdx/mise)?__
* I am aware of `asdf` and `mise`, I have tried them before with relative success.
* But with `asdf` and `mise` the community users themselves manages the plugins, and not everyone is willing to maintain it.
* Features such as `dotnet tool` installations or installing language specific libraries may not work for niche languages.
* So I followed the philosophy __*special purpose tools are almost always better, than general purpose tools*__
* Because prior to the existence of `asdf` and `mise`, language version managers already exists and has significantly matured.
* By using these old solutions, configuration issues are resolved easily due to the wealth of knowledge existing documentation in the internet.

## List of programming languages and their setup scripts

<div align='center'>

| Languages    | Shell Script                                                                      |
|--------------|-----------------------------------------------------------------------------------|
| C#           | [dotnet.sh](https://raw.githubusercontent.com/tatumroaquin/devenv/main/dotnet.sh) |
| Perl         | [plenv.sh](https://raw.githubusercontent.com/tatumroaquin/devenv/main/plenv.sh)   |
| Java,Kotlin  | [sdkman.sh](https://raw.githubusercontent.com/tatumroaquin/devenv/main/sdkman.sh)  |

</div>
