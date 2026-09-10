class Glowclock < Formula
  desc "A gradient big-digit terminal clock (tty-clock style) with crontab-style reminders and a fat-cat popup"
  homepage "https://github.com/tomtdhzz/glowclock"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.3/glowclock-aarch64-apple-darwin.tar.xz"
      sha256 "17c8f4fbb4a2320d06e39f57244570be0b4bce5ca796e11b161cf0fea608b06a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.3/glowclock-x86_64-apple-darwin.tar.xz"
      sha256 "a55db6e8e035fbabaa43ba15baa93908a030e9a2e3708d9a827a906f51704248"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.3/glowclock-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e530a3d441275d09ac703aab1ca6d11a3b8346729858a23ec21d3530e91e9c4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.3/glowclock-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a9b180c4ca7348e72dba51bea5679659201b99f02385caf5615a71d516a5b75"
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
