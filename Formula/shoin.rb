class Shoin < Formula
  desc "A no-clutter terminal Markdown editor with modal editing"
  homepage "https://github.com/nol00p/Shoin"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.1/shoin-aarch64-apple-darwin.tar.xz"
      sha256 "c6806a998948ab8e3faddb917c416b90471f1bfb8cb1125ba2322676d447c393"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.1/shoin-x86_64-apple-darwin.tar.xz"
      sha256 "a19229bf472c53bbdc3d2594c9aaea4234733b384b7e76a9f35583d2f6a13adf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.1/shoin-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b30c10ff61a094d7088ea6f52b691572874e910bc9ff88ce37b50705d7a03299"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.1/shoin-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "97c2389886dbb41472ce121d419883e95a2a6d85fb9651456b7b12c14c3536f3"
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
