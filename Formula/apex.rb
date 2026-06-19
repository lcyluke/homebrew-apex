class Apex < Formula
  include Language::Python::Virtualenv

  desc "⚡ Multi-Agent Operating System — one person, infinite capacity"
  homepage "https://github.com/lcyluke/apex"
  url "https://github.com/lcyluke/apex/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "18491031d4ee53469b4a62efd24a34736dbadfc693c4641039eebdaaa623157e"
  license "MIT"

  depends_on "python@3.12"
  depends_on "tmux"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    # Upgrade pip first to get latest wheel resolution
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    # Install purely from pre-built wheels — zero compilation
    system libexec/"bin/pip", "install", "--only-binary", ":all:", "."
  end

  def post_install
    ohai "🚀 Apex v0.5.0 installed!"
    puts "  Quickstart:"
    puts "    apex tutorial         Interactive walkthrough"
    puts "    apex fleet init       Create profiles + launch fleet"
    puts "    apex doctor           System diagnostics"
    puts ""
  end

  test do
    output = shell_output("#{bin}/apex --version 2>&1 || true")
    assert_match "Apex", output
  end

  def caveats
    <<~EOS
      ⚡ Apex — Multi-Agent Operating System
      
      Quickstart:
        apex tutorial         Interactive 5-step walkthrough
        apex fleet init       Create profiles + launch fleet (one-time)
        apex fleet start      Start 7 dev agents in tmux windows
        apex doctor           System diagnostics

      Works on macOS, Linux, and Windows (WSL).
      Docs: https://github.com/lcyluke/apex
    EOS
  end
end
