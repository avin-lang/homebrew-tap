class Marshal < Formula
  desc "Job manager for building, testing and releasing: a budget, a landing lane, learned deadlines"
  homepage "https://github.com/avin-lang/marshal"
  version "0.3.16"

  # macOS arm64 only: the executable is built with avin on the author's machine and links nothing
  # but the system library. marshal's stock steps are avin programs it compiles the first time a
  # job type uses them, so avin is a run-time dependency.
  depends_on "avin-lang/tap/avin"
  depends_on arch: :arm64
  depends_on :macos

  url "https://github.com/avin-lang/marshal/releases/download/v#{version}/marshal-#{version}-darwin-arm64.tar.gz"
  sha256 "dc00c88dc3d5c01bd67de9ec5e98ffa30a9d0c3617adcad2b2895b656084fd03"

  def install
    # The tarball holds bin/marshal and share/marshal (the stock job types and steps), which the
    # executable finds at <exe>/../../share/marshal.
    bin.install "bin/marshal"
    pkgshare.install Dir["share/marshal/*"]
  end

  test do
    assert_match "usage: marshal", shell_output("#{bin}/marshal --help")
    assert_match "marshal #{version}", shell_output("#{bin}/marshal version")
    # the stock job types and steps sit where the executable looks for them
    assert_path_exists pkgshare/"types/train.job"
    assert_path_exists pkgshare/"steps/git/main.avin"
  end
end
