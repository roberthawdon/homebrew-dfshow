class DfshowRc < Formula
  desc "An open source implementation of some of the applications from Larry Kroeker's DF-EDIT (Release Candidate)"
  homepage "https://dfshow.org/"
  url "https://github.com/roberthawdon/dfshow/releases/download/v1.0.0-rc2/dfshow-v1.0.0-rc2.tar.gz"
  version "1.0.0-rc2"

  depends_on "ncurses" => :build
  depends_on "libconfig" => :build
  depends_on "libacl" => :build
  depends_on "gettext" => :build

  conflicts_with "dfshow", :because => "both install the same binaries"

  def install
    config_path = etc
    data_path = "#{prefix}/share"

    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{config_path}
      --datadir=#{data_path}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"

    bash_completion.install "misc/auto-completion/bash/show-completion.bash"
    bash_completion.install "misc/auto-completion/bash/sf-completion.bash"
    zsh_completion.install "misc/auto-completion/zsh/_show"
    zsh_completion.install "misc/auto-completion/zsh/_sf"
  end

  test do
    system bin/"show", "--version"
    system bin/"sf", "--version"
  end
end

