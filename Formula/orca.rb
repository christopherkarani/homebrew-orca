class Orca < Formula
  desc "Local runtime firewall for AI agents"
  homepage "https://github.com/christopherkarani/Orca"
  version "1.1.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/christopherkarani/Orca/releases/download/v#{version}/orca-v#{version}-darwin-arm64.tar.gz"
      sha256 "70347d586956830da1b6df5373a43f521b7f63c78f27141dbc6b560e414471df"
    else
      url "https://github.com/christopherkarani/Orca/releases/download/v#{version}/orca-v#{version}-darwin-amd64.tar.gz"
      sha256 "7f05cdd98c5cac73d3726df0de7a099897e6549671c5a4fc7fc55ee4827a9d40"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/christopherkarani/Orca/releases/download/v#{version}/orca-v#{version}-linux-arm64.tar.gz"
      sha256 "c07be4ef37d62ec831fc588047dc1c4d432355b881f9dfd5b6561ae6fb894c4e"
    else
      url "https://github.com/christopherkarani/Orca/releases/download/v#{version}/orca-v#{version}-linux-amd64.tar.gz"
      sha256 "98054c41f4e78b473846753b71b07050f1842c171ccea8f7739fabdc54cdab77"
    end
  end

  def install
    bin.install "bin/orca"
    prefix.install "orca-dashboard-ui/dist" => "orca-dashboard-ui/dist"
    pkgshare.install "fixtures"
    # manifest status: exists — (exists) runtime assets and plugin manifest hermes verified at packaging time
  end

  def post_install
    ENV["ORCA_RESOURCE_ROOT"] = pkgshare.to_s
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/orca --version")
    system "#{bin}/orca", "plugin", "manifest", "hermes"
  end
end
