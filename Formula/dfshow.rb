class Dfshow < Formula
  desc "An open source implementation of some of the applications from Larry Kroeker's DF-EDIT"
  homepage "https://dfshow.op-ezy.co.uk/"
  url "https://github.com/roberthawdon/dfshow.git", :tag => "v0.6.4-alpha", :revision => "bb0067fbeeb37e6ad000aa4cf08258858c619183"
  head "https://github.com/roberthawdon/dfshow.git", :branch => "master"

  depends_on "ncurses" => :build
  depends_on "autoconf" => :build
  depends_on "libconfig" => :build
  depends_on "automake" => :build

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
  end

  test do
    system bin/"show", "--version"
    system bin/"sf", "--version"
  end
end
