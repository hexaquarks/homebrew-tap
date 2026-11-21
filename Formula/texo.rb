class Texo < Formula
  desc "A terminal workspace for LaTeX resumes with PDF preview and AI assistance"
  homepage "https://github.com/hexaquarks/texo"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hexaquarks/texo/releases/download/v0.3.0/texo-aarch64-apple-darwin.tar.gz"
      sha256 "751d6491da1ac80a1942b7f88dc06da1737284843b1e5534bf97f1765cc49b01"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hexaquarks/texo/releases/download/v0.3.0/texo-x86_64-apple-darwin.tar.gz"
      sha256 "cede96907d6bb0774116987aa89ac30cad0615fd1bdab4fb50bd68cb8011fcaa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hexaquarks/texo/releases/download/v0.3.0/texo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "83854cf3a3524a3254c38bb94b617cafd9b9ee8887a148d07e70762a27ef4cf6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hexaquarks/texo/releases/download/v0.3.0/texo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "83a050b2ec2392a1e33daf155a4b56c91c63567c621e1e8ffcc94c4cb4da1d60"
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
