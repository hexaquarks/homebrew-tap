# Generated from the release candidate; the first release refreshes this formula.
class Texo < Formula
  desc "A terminal workspace for LaTeX resumes with PDF preview and AI assistance"
  homepage "https://github.com/hexaquarks/texo"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.0/texo-aarch64-apple-darwin.tar.gz"
      sha256 "e2f02de533b2c6c04fe52f10d556ff11fa1b5ec0412df9fa88dee66042e24fb9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.0/texo-x86_64-apple-darwin.tar.gz"
      sha256 "32811a8551c5abcecf0ca672748ec0457cd6d8a7dea2bc0feb402f0fa84242d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.0/texo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "30c03e302ea7722842de74660866490ab062910d9994bef5f7cd0fdea9545394"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.0/texo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8933aa911d74f61f98ed106ea9c31ad9b1142efbde2cd5fbdd0a516f1aa10613"
    end
  end
  license "MIT"
  depends_on "poppler"
  depends_on "tectonic"

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
      bin.install "texo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "texo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "texo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "texo"
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
