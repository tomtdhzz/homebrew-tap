class Tutor < Formula
  desc "Local omp tutor: an auto-mined study loop, subject courses (LLM-drafted roadmaps), a per-window work board, and a daily briefing"
  homepage "https://github.com/tomtdhzz/tutor"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.2.0/tutor-aarch64-apple-darwin.tar.xz"
      sha256 "32ef56ce32fa934f9ce5a1c1cb9da02f30ff30102ffb78e959d009845cb97299"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.2.0/tutor-x86_64-apple-darwin.tar.xz"
      sha256 "b6ace34df3c2ac5819c19af86edf2e15d62c8b55df23473f2f8b68f93af2e662"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.2.0/tutor-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3351c862c5e4f544ee1f4802f1879694335f82758dfee94229ecccbff98c005a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tomtdhzz/tutor/releases/download/v0.2.0/tutor-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dbb5e19337edf87abff232bb4858d5c3bd002f6f980ec0ad1113bb244afa205b"
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
