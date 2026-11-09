class Texo < Formula
  desc "A terminal workspace for LaTeX resumes with PDF preview and AI assistance"
  homepage "https://github.com/hexaquarks/texo"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.0/texo-aarch64-apple-darwin.tar.gz"
      sha256 "da978f60aa49f435bbb8f642887129628d7fb0eaab3dd06e1ad4b4b87d03ff05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.0/texo-x86_64-apple-darwin.tar.gz"
      sha256 "2ae9e4e469b76633a9aa8921a7598c83c604f6daf8f128bba185466588a67d21"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.0/texo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7102e6f67141891ce6f7720f84333cbe1c58030be452ce695037339db716bbdf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hexaquarks/texo/releases/download/v0.1.0/texo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "18cc2be9a0c02fa4e3d97c0aa46ce76f7a00debd3674b32c68c72f1262bb48ee"
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
