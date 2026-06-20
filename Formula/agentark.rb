class Agentark < Formula
  desc "⚡ Multi-Agent Operating System — one person, infinite capacity"
  homepage "https://github.com/lcyluke/apex"
  url "https://github.com/lcyluke/apex/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "964620d4bf84438749c4b88627a8e27c8558d4181c4e4d5b1a0dba5d60582218"
  license "MIT"

  depends_on "python@3.12"
  depends_on "tmux"

  def install
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv",
           "--system-site-packages", libexec
    system libexec/"bin/pip", "install", "--retries", "3",
           "--only-binary", ":all:", "."
  end

  def post_install
    version_check = Utils.popen_read(libexec/"bin/agentark", "--version").strip
    if version_check.include?("0.5.0")
      ohai "✅ AgentArk v0.5.0 installed successfully!"
      puts "   #{version_check}"
    else
      opoo "Install completed but version mismatch: #{version_check}"
    end
    puts ""
    puts "Quickstart:"
    puts "  agentark tutorial         Interactive walkthrough"
    puts "  agentark fleet init       Create profiles + launch fleet"
    puts "  agentark doctor           System diagnostics"
    puts ""
  end

  test do
    output = shell_output("#{bin}/agentark --version 2>&1 || true")
    assert_match "AgentArk", output
  end

  def caveats
    <<~EOS
      ⚡ AgentArk — Multi-Agent Operating System

      Quickstart:
        agentark tutorial         Interactive 5-step walkthrough
        agentark fleet init       Create profiles + launch fleet (one-time)
        agentark fleet start      Start 7 dev agents in tmux windows
        agentark doctor           System diagnostics

      Works on macOS, Linux, and Windows (WSL).
      Docs: https://github.com/lcyluke/apex
    EOS
  end
end
