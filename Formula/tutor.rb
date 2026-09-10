class Tutor < Formula
  desc "Local omp tutor: a study loop, subject courses, a per-window work board, and a daily briefing"
  homepage "https://github.com/tomtdhzz/tutor"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.5.0/tutor-aarch64-apple-darwin.tar.xz"
      sha256 "9bfa8ee78a1b9b9e6846b3278011b883178c40ef246192d9372a18077775c39e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.5.0/tutor-x86_64-apple-darwin.tar.xz"
      sha256 "d24b4e41ad298fc5c2d2dcd65f812cc8d78fa598832d69f263233ea466150142"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.5.0/tutor-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fce5b28413b5a22b41daa6ff0ec3864d3802890ba02609b5c915ad79b6706959"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.5.0/tutor-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6228f0f98eddfe1cf0f9d777b0fc6188bb8a7af4a1dc6ba6115b56ec418a938e"
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
