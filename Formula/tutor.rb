class Tutor < Formula
  desc "Local omp tutor: a study loop, subject courses, a per-window work board, and a daily briefing"
  homepage "https://github.com/tomtdhzz/tutor"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.4.0/tutor-aarch64-apple-darwin.tar.xz"
      sha256 "b91b8dffe98a46ee7b08f9bca1eca62505decf67f8e9941dc78ba3f4a9e63d12"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.4.0/tutor-x86_64-apple-darwin.tar.xz"
      sha256 "dfe5fabb69d035358f8f1c128be3b7442bd35a76e2dc1f90fe4a01c32c62f86c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.4.0/tutor-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "525eb9808dc600c1a90a15b33490144d720dfc21b99958ae244b211c37104d28"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.4.0/tutor-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d7485f033becdf3a428429efdd565ae213e6217511da400ee6099e87af34e453"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tutor"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tutor"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tutor"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tutor"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
