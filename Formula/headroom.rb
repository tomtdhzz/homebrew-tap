class Headroom < Formula
  desc "Per-model, rule-aware quota headroom monitor for AI coding subscriptions (Claude / Codex via omp)"
  homepage "https://github.com/tomtdhzz/headroom"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/headroom/releases/download/v0.1.1/headroom-aarch64-apple-darwin.tar.xz"
      sha256 "f20453033e17fc0f6b4c40f6d0f87c41acbee8ad2afc7bf34ad260fe62976684"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/headroom/releases/download/v0.1.1/headroom-x86_64-apple-darwin.tar.xz"
      sha256 "8a8a1a97c0f7f676f29e81fdccd10d5eee2dce695292120c247d84f12ec64c54"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/headroom/releases/download/v0.1.1/headroom-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dfe3af072a5909fafb3a12ace2a17970854c3d0b5b019cc93521b65413eec227"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/headroom/releases/download/v0.1.1/headroom-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e1d9cdee90890edf44e445a830a65e7553e1d66fcd5697155ebfe19747b52228"
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
      bin.install "headroom"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "headroom"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "headroom"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "headroom"
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
