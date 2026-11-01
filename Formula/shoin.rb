class Shoin < Formula
  desc "A no-clutter terminal Markdown editor with modal editing"
  homepage "https://github.com/nol00p/Shoin"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.2/shoin-aarch64-apple-darwin.tar.xz"
      sha256 "79b341db84b29100c62e60b1cbce2a8cb3a5c57a8ad559f63ef951ceb8d7737d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.2/shoin-x86_64-apple-darwin.tar.xz"
      sha256 "c64a50c2c13019fe55f02d975576cac5624b76cefa5b4a2d529fd309f8472560"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.2/shoin-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f8a3d6a5659198fc1362e9e06291b81cc64843caa5d1b3f6c11d63851bd98b78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.2/shoin-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "440a27ef4a90bc4425218d8b67feb4755452c5c701c4f5c8ee019c9028a43f68"
    end
  end
  license "Apache-2.0"

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
      bin.install "shoin"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "shoin"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "shoin"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shoin"
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
