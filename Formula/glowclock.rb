class Glowclock < Formula
  desc "A gradient big-digit terminal clock (tty-clock style) with crontab-style reminders and a fat-cat popup"
  homepage "https://github.com/tomtdhzz/glowclock"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.0/glowclock-aarch64-apple-darwin.tar.xz"
      sha256 "1a5ccdcaf99bfce7d52ebf313ad2e5b41fb821b995a851b8f2ca0e8bb3e682c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.0/glowclock-x86_64-apple-darwin.tar.xz"
      sha256 "c0c02680bd503756770d59ba7cf8a448773ef0078d42401fda656fb836396cbd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.0/glowclock-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a19a36a62dca0ae36e56964a71146c51de864ba9d91cc01678a155c0ec3c86df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/glowclock/releases/download/v0.1.0/glowclock-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "684957d9e214485e47b17aec02aab8821cc37929c2f72437d1cae0f4a7f839d1"
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
