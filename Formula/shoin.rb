class Shoin < Formula
  desc "A no-clutter terminal Markdown editor with modal editing"
  homepage "https://github.com/nol00p/Shoin"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.5/shoin-aarch64-apple-darwin.tar.xz"
      sha256 "50b56f44ff6e18c33638317762860520fe6ca34a68730c6838699a15dbe6d0d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.5/shoin-x86_64-apple-darwin.tar.xz"
      sha256 "a88626326c6ea15fbddf635def65d9223f95bf5fc58f406a1e5113242d195f86"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.5/shoin-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e153aec6ad2137da970184260667e68c6e6fe511af31ce226e5f8a7673aec372"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.5/shoin-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9bce12cc1142e83c3cead988c2ffaaccbe77ed7a443d25c6f93163b7e9c3eb34"
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
