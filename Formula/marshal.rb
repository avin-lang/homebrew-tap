class Marshal < Formula
  desc "Job manager for building, testing and releasing: a budget, a landing lane, learned deadlines"
  homepage "https://github.com/avin-lang/marshal"
  version "0.2.12"

  # macOS arm64 only: the executable is built with avin on the author's machine and links nothing
  # but the system library. marshal's stock steps are avin programs it compiles the first time a
  # job type uses them, so avin is a run-time dependency.
  depends_on "avin-lang/tap/avin"
  depends_on arch: :arm64
  depends_on :macos

  url "https://github.com/avin-lang/marshal/releases/download/v#{version}/marshal-#{version}-darwin-arm64.tar.gz"
  sha256 "ad568f98a077d30bb7313c2c8f37806b260248502b3eaa85a4a3eff90857bbb0"

  def install
    # The tarball holds bin/marshal and share/marshal (the stock job types and steps), which the
    # executable finds at <exe>/../../share/marshal.
    bin.install "bin/marshal"
    pkgshare.install Dir["share/marshal/*"]
  end

  test do
    assert_match "usage: marshal", shell_output("#{bin}/marshal --help")
    assert_match "marshal #{version}", shell_output("#{bin}/marshal version")
  end
end
