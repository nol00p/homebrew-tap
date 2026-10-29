class Shoin < Formula
  desc "No-clutter terminal Markdown editor with modal editing"
  homepage "https://github.com/nol00p/Shoin"
  version "0.2.0"
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.0/shoin-aarch64-apple-darwin.tar.xz"
      sha256 "d22b86438649a1da0a544f29c3448c44000e8d32aa1ca0b9ea7ef58c6030d914"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.0/shoin-x86_64-apple-darwin.tar.xz"
      sha256 "e721a5a484b7e2319cff47085d67be7233e9d0802eef2df1009e0f2abcc5090b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.0/shoin-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "74c623588fae6e2cc9b90add54257ab76c27f5fbba6ad9954e09ee7ffc45b59a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nol00p/Shoin/releases/download/v0.2.0/shoin-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "087b0a0766e91045d477d85da42a913b60e58dad2e0c8d7b78b3b35b4ac30d1c"
    end
  end

  def install
    bin.install "shoin"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/shoin --version")
  end
end
