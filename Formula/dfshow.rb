class Dfshow < Formula
  desc "An open source implementation of some of the applications from Larry Kroeker's DF-EDIT"
  homepage "https://dfshow.org/"
  url "https://github.com/roberthawdon/dfshow.git", :tag => "v0.10.3-1-beta", :revision => "2a5515aac502131ee9f448fe50fa462e45507ca3"
  head "https://github.com/roberthawdon/dfshow.git", :branch => "master"

  depends_on "ncurses" => :build
  depends_on "autoconf" => :build
  depends_on "libconfig" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build

  def install
    # Find our docbook catalog
    # ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    config_path=#{etc}
    data_path="#{prefix}/share"

    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{config_path}
      --datadir=#{data_path}
    ]

    system "./bootstrap"
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
