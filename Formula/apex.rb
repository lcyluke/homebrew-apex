class Apex < Formula
  desc "⚡ Multi-Agent Operating System — one person, infinite capacity"
  homepage "https://github.com/lcyluke/agentark"
  url "https://github.com/lcyluke/agentark/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "ee953a9caec91bde3220c10e78ab025e0777036028ef04f1974edf638a32c955"
  license "MIT"

  depends_on "python@3.12"
  depends_on "tmux"

  def install
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv",
           "--system-site-packages", libexec
    system libexec/"bin/pip", "install", "--retries", "3",
           "--only-binary", ":all:", "."
    bin.install_symlink libexec/"bin/agentark"
  end

  def post_install
    # Quick verification (use libexec path — bin symlink may not exist yet)
    version_check = Utils.popen_read(libexec/"bin/apex", "--version").strip
    if version_check.include?("0.5.0")
      ohai "✅ Apex v0.5.0 installed successfully!"
      puts "   #{version_check}"
    else
      opoo "Install completed but version mismatch: #{version_check}"
    end
    puts ""
    puts "Quickstart:"
    puts "  apex tutorial         Interactive walkthrough"
    puts "  apex fleet init       Create profiles + launch fleet"
    puts "  apex doctor           System diagnostics"
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
