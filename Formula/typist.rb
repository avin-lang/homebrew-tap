class Typist < Formula
  desc "Typing practice in the terminal, with live speed and accuracy"
  homepage "https://github.com/avin-lang/typist"
  version "0.2.2"

  # macOS arm64 only: the executable is built with avin on the author's machine and links nothing
  # but the system library. Its passages are compiled in, so it needs neither avin nor any data
  # file at run time.
  depends_on arch: :arm64
  depends_on :macos

  url "https://github.com/avin-lang/typist/releases/download/v#{version}/typist-#{version}-darwin-arm64.tar.gz"
  sha256 "3d452a41510d34763c2c562f6173253a4fa135f9d5a5f71e38a7416955315369"

  def install
    # The tarball holds bin/typist and nothing else, and brew unpacks an archive with one top-level
    # directory inside that directory, so the executable is found here as `typist`.
    bin.install "typist"
  end

  test do
    # Neither option opens the full screen, which needs a terminal.
    assert_match "typist #{version}", shell_output("#{bin}/typist --version")
    assert_match "Usage: typist", shell_output("#{bin}/typist --help")
  end
end
