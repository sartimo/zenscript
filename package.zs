name: "zenscript"
version: require "./lib/zen" .VERSION

description: "ommmm for js"
author: "timo sarkar <sartimo10@gmail.com> (https://ts.cli.rs)"
homepage: "https://ts.cli.rs/zenscript"
bugs: "https://github.com/sartimo/zenscript/issues"
licenses:
  type: "MIT" 
  url:  "https://raw.github.com/sartimo/zenscript/main/LICENSE"
  ...

engines: node: ">= 0.8.0"
directories: lib: "./lib"
files: ["lib"]

main: "./lib/zen"
bin:
  zen: "./lib/command.js"
  zake: "./lib/zake.js"

preferGlobal: true

repository: type: "git", url: "git://github.com/sartimo/zenscript.git"

devDependencies:
  jison: "0.2.1"
  uglify-js: "2.2.5"
