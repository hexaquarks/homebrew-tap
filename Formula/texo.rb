class Texo < Formula
  desc "A terminal workspace for LaTeX resumes with PDF preview and AI assistance"
  homepage "https://github.com/hexaquarks/texo"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.1/texo-aarch64-apple-darwin.tar.gz"
      sha256 "eab407bc5e94ac82b90fba98b28738a34da7ce5425b51ae0b3ce52ee3a37dd91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.1/texo-x86_64-apple-darwin.tar.gz"
      sha256 "e221086479bafa4755a624d3627b58553d3cbde173fadac7a8b24a59ba4d9e8d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.1/texo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6a2092454f8d9618f23c902d6e643628a3a65fad483bd9af15ec885a211f5289"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.1/texo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "02e1b84b37dc57411b0434e39dedd565342e880ea17041c4ba50d6ac772bd772"
    end
  end
  license "MIT"
  depends_on "poppler"
  depends_on "tectonic"

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
