class Tutor < Formula
  desc "Local omp tutor: a study loop, subject courses, a per-window work board, and a daily briefing"
  homepage "https://github.com/tomtdhzz/tutor"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.3.0/tutor-aarch64-apple-darwin.tar.xz"
      sha256 "f817e010b18aa253108f7c4f1c556e7bdc80104a2eac703874312956d0105bd3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.3.0/tutor-x86_64-apple-darwin.tar.xz"
      sha256 "d3d66ccd00494509f0c02f78f7e15bb28babef595dcc387897cb62d028eb0899"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.3.0/tutor-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7a3db7e2790b79e95d79d3cb2a78eeb1371ef263f47068885c27cb617473a0ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.3.0/tutor-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e7446d85c32322aa1ca98be9d74eafca2f25573f033c3da71db616d3c2348342"
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
