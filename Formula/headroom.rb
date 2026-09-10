class Headroom < Formula
  desc "Per-model, rule-aware quota headroom monitor for AI coding subscriptions (Claude / Codex via omp)"
  homepage "https://github.com/tomtdhzz/headroom"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/headroom/releases/download/v0.2.0/headroom-aarch64-apple-darwin.tar.xz"
      sha256 "14af96afacc025bd980f0cf1a8089a99b6f6e4c9d3737afa9c893b7de3ea0414"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/headroom/releases/download/v0.2.0/headroom-x86_64-apple-darwin.tar.xz"
      sha256 "2d4869f24f7fd77ffa6c4d1edb69862d2b8fe562bc62b0e30bbd628e266e19f4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/headroom/releases/download/v0.2.0/headroom-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ccefccc75b14d306a8835c9a795c200e48d8cf0d61ed0ef194e3386cc56b2926"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/headroom/releases/download/v0.2.0/headroom-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4fb299f5a377758d9db6da0913a956a582e3fd65668089b1fbdb84af4c610424"
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
