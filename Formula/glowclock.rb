class Glowclock < Formula
  desc "A gradient big-digit terminal clock (tty-clock style) with crontab-style reminders and a fat-cat popup"
  homepage "https://github.com/tomtdhzz/glowclock"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.2/glowclock-aarch64-apple-darwin.tar.xz"
      sha256 "41f36ff149d1871e8b10a7401a77c67b634020e9c44c2226aedabafb56cf1a85"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.2/glowclock-x86_64-apple-darwin.tar.xz"
      sha256 "da177e6f84c12ce3e3a9218746d0ea753720c8d31163ee34b9f94905382c7896"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.2/glowclock-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c77dabbb26a8a103eb85750416a2f491378fef66f96e7ebedef8fb9d6e6621f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.2/glowclock-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aa5af4473ab83a85745d836315c0abfe6ee8a45f8416f7363b916e204e64885c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "glowclock"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "glowclock"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "glowclock"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "glowclock"
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
