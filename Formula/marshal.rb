class Marshal < Formula
  desc "Job manager for building, testing and releasing: a budget, a landing lane, learned deadlines"
  homepage "https://github.com/avin-lang/marshal"
  version "0.1.0"

  # macOS arm64 only: the executable is built with avin on the author's machine and links nothing
  # but the system library, so it needs no run-time dependency.
  depends_on arch: :arm64
  depends_on :macos

  url "https://github.com/avin-lang/marshal/releases/download/v#{version}/marshal-#{version}-darwin-arm64.tar.gz"
  sha256 "9461d10277506f6467e3b0109a04af42b2249b402594c1dbda9052d6575dc227"

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_match "usage: marshal", shell_output("#{bin}/marshal --help")
  end
end
