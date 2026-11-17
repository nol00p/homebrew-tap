class Shoin < Formula
  desc "A no-clutter terminal Markdown editor with modal editing"
  homepage "https://github.com/nol00p/Shoin"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.4/shoin-aarch64-apple-darwin.tar.xz"
      sha256 "1a3d53e1f83ad9c2da9e3f7cc696a26d8cc0c1f626b21708d2b99f4522d4b4d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.4/shoin-x86_64-apple-darwin.tar.xz"
      sha256 "e06f533569c43d26c7618afb4b7dc0eb21e6274e30511e581ac9f254a166855b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.4/shoin-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e0f8d53f77a582c9daec297d7aeed00031134ff209368699baffb094dfcfe39d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.4/shoin-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6d68cdea950666c50d4a1c735c075c9a96c702939ccd753b5023533a75ab8138"
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
