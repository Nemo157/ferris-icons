build:
  mkdir -p dist
  fantasticon

clean:
  rm -rf dist

watch:
  watchexec --watch icons --watch fantasticonrc.js -- just build
