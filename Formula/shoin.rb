class Shoin < Formula
  desc "A no-clutter terminal Markdown editor with modal editing"
  homepage "https://github.com/nol00p/Shoin"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.3/shoin-aarch64-apple-darwin.tar.xz"
      sha256 "4c5ed5dc4ac8e76c58e04c9d9115b6ce84fdd0af628487a40934c4e214420ab3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.3/shoin-x86_64-apple-darwin.tar.xz"
      sha256 "e0addc561e656009209c489d72516a78bcb41292c4ceb19eac26d24961e92a62"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.3/shoin-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3b666f9bb1baa24d9601d59f62f983c323c850585bb029d024070f1dc29ccd61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.3/shoin-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9460156964d88e756022c1daec9373b7611e4fcfd59552e2461a6244b0fcc79a"
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
